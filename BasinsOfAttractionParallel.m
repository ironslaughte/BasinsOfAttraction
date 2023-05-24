function BasinsOfAttractionParallel(fun,xSection,ySection,step, paramVal)
%   BasinsOfAttraction displays attraction pools for a specific system
%   Input:
%   fun is a function handle ODEFUN(T,Y, param)
%   xSection is a vector containing the minimum and maximum values of X 
%   ySection is a vector containing the minimum and maximum values of Y 
%   step - the step of changing X and Y
%   paramVal Passed to the fun(T,Y, param)
%   Example: BasinsOfAttraction(@Lorenz, [-10,10], [-15,15], 0.1, 2)
%% Init params
T = 150; %overall time
h = 0.01; %time step
tspan = 0:h:T; %time span
Tt = 100; %transient time
Nt = ceil(Tt/h); %transient samples
x = xSection(1):step:xSection(2);
y = ySection(1):step:ySection(2);
f = @(t,x)fun(t,x,paramVal);
[X,Y] = meshgrid(x,y);
idxAttractors = gpuArray(zeros(length(x),length(x)));
%% Find attractors
[Attractors, ~] = FindAttractors(f, ...
     [xSection(1) - 5,xSection(2) + 5],[ySection(1) - 5,ySection(2) + 5],...
     [0,0],70,false);
gpuAttractors = gpuArray(Attractors);
L = length(x);
%% Main alg
for i = 1:L
    parfor j = 1:L
        [y1, y2, y3]= SimulateSystem(f,tspan,[X(i,j),Y(i,j),0],Nt);
        if(length(y1) > 3)
            [peaksy3, idx] = FindPeaks(y3,y2);
            if(~isempty(peaksy3))
                peaksy1 = y1(idx);
                peaksy2 = y2(idx);
                Peaks = [];
                Peaks = cat(1,Peaks,[peaksy1, peaksy2, peaksy3]);
                gpuPeaks = gpuArray(Peaks);
                diff = pdist2(gpuAttractors(:,1:3), gpuPeaks);
                [m,~] = min(diff);
                [m1, idx] = min(m);
                [row, ~] = find((diff(:,idx) - m1) < 0.0001,1);
                idxAttractors(i,j) =  gpuAttractors(row,4);
            end
       end
    end
end
figBasins = FindMaxNumFig(); 
figure(figBasins);
hold on;
contourf(X,Y,idxAttractors,'edgecolor','none',"FaceAlpha",0.5);
title('Basins of attraction');
xlabel('x');
ylabel('y');
drawnow;
end