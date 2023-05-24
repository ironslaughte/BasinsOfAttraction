function PlotClusters(X,Y, idx, varargin)
figClusters = FindMaxNumFig(); 
figure(figClusters);
hold on;
gscatter(X,Y,idx);
if(~isempty(varargin))
    title(varargin{1});
else
title('DBSCAN Using Euclidean Distance Metric');
end
xlabel('z');
ylabel('y');
drawnow;
end