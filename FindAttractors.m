function [Clusters, numClusters] = FindAttractors(fun, xSection, ySection, zSection, N, plot)
%   Bifurcation draws a bifurcation diagram for a specific system
%   Input:
%   fun is a function handle ODEFUN(T,Y, param)
%   xSection - is a vector containing the minimum and maximum values of X  
%   ySection - is a vector containing the minimum and maximum values of Y
%   zSection - is a vector containing the minimum and maximum values of Z
%   N - num of random points
%   paramVal - the value of the system parameter
%   plot - if true, it will draw a graph of peak values of attractors with markup
%   Example: FindAttractors(@Lorenz,[-50,50],[-50,50],[-50,50],100,2, true)

%% Init Params for find attractors
T = 600; % overall time
h = 0.01; % time step
tspan = 0:h:T; % time span
Tt = 500; % transient time
Nt = ceil(Tt/h); % transient samples
% random values for three coordinates
x = (xSection(2)-xSection(1)).*rand(N,1) + xSection(1);
y = (ySection(2)-ySection(1)).*rand(N,1) + ySection(1);
z = (zSection(2)-zSection(1)).*rand(N,1) + zSection(1);
Peaks = [];
%% Find attractors
for i=1:N
    y0 = [x(i), y(i), z(i)];
    [y1, y2, y3] = SimulateSystem(fun,tspan,y0,Nt);
    [peaks, idx] = FindPeaks(y3,y2); % find peaks Z
    if(~isempty(peaks))
    Peaks = cat(1,Peaks,[y1(idx), y2(idx), y3(idx)]);
    end
end
%% DBscan part
variance = CalculateVariance(Peaks(:,2));
if(variance > 1)
    eps = 0.28*variance;
else 
    eps = 0.41;
end
idx = dbscan(Peaks,eps,5);
%% Plot clusters
if(plot)
    PlotClusters(Peaks(:,3),Peaks(:,2),idx,'DBSCAN');
end
%% Formation of an array of attractors without noise
[Clusters, numClusters] = CreateClusters(Peaks, idx); % removing noise data
%% clustering evaluation
eva = evalclusters(Clusters, 'kmeans', 'DaviesBouldin',...
    'KList', 1:(length(numClusters) + 1));
if(eva.OptimalK ~= length(numClusters))
   % if the number of clusters differs, we trust the result of the metric
   idx = kmeans(Clusters,eva.OptimalK);
   PlotClusters(Clusters(:,3),Clusters(:,2),...
       idx,'AFTER KMEANS Using Euclidean Distance Metric');
   [Clusters, numClusters] = CreateClusters(Clusters, idx);
end
%% Init simulation time
T = 50; % overall time
tspan = 0:h:T; % time span
colormap lines;
m = colormap;
%% Post processing clusterisation
for currCluster = 1: length(numClusters)
    % selecting the current cluster (may be empty in subsequent iterations)
     cluster = Clusters(Clusters(:,4) == currCluster,1:3);
     if(isempty(cluster))
         continue;
     end
     % number of points to model from the current cluster
     numPoints = fix(length(cluster(:,1)) / 100) + 1; 
     Peaks = [];
     for currPoint = 1: numPoints
         % random point from the current cluster
         pointIdx = fix(1 + (length(cluster(:,1)) - 1)*rand());
         clusterPoint = cluster(pointIdx,:);
         [y1, y2, y3] = SimulateSystem(fun,tspan,clusterPoint,1);  
         % figure(11);
         % hold on
         % plot3(y1,y2,y3,'Color', m(currCluster,:));
         % xlabel('x');
         % ylabel('y');
         % zlabel('z');
         % drawnow;
         [~, idx] = FindPeaks(y3,y2);
         Peaks = cat(1,Peaks,[y1(idx),y2(idx),y3(idx)]);
     end
     if(isempty(Peaks))
         continue
     end
     % select all clusters except the ones passed
     anotherClusters = SelectClusters(Clusters, currCluster);
     % if there are no clusters left besides the current one, exit
     if(isempty(anotherClusters))
         break;
     end
     % find the closest unique points to other clusters
     mostRemotePeaks = FindMostRemotePeaks(anotherClusters, Peaks);
     mostRemotePeaks = unique(mostRemotePeaks, 'rows');

     if(~isempty(mostRemotePeaks))
         nearest = FindNearestPoints(Clusters,mostRemotePeaks);
         if(~isempty(nearest))
             idxClusters = unique(nearest(:,4)); % indexes of the nearest clusters
             for i = 1:length(idxClusters)
                 % the number of closest points to the cluster(i)
                 numNearestClustPoint = length(... 
                     find(nearest(:,4) == idxClusters(i))); 
                 % total number of points in the cluster(i)
                 numPointsClust = length(Clusters...
                     (Clusters(:,4) == idxClusters(i),1));
                 % if the number of neighbors of the most remote
                 % points exceeds 50%, then we combine clusters
                 if(numNearestClustPoint > numPointsClust * 0.5)
                     Clusters(Clusters(:,4) == idxClusters(i),4) = currCluster;
                 end
             end
         end
     end
end
%% Renumbering clusters
numClusters = unique(Clusters(:,4));
for i = 1:length(numClusters)
  Clusters(Clusters(:,4) == numClusters(i),4) = i;
end
%% Plot attractors after edits
if(plot)
    PlotClusters(Clusters(:,3),Clusters(:,2),Clusters(:,4),'ATTRACTORS');
end
end
