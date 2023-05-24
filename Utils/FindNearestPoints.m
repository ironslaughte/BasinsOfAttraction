function nearest = FindNearestPoints(Clusters, mostRemotePeaks)
k = fix(length(Clusters(:,1))*0.05); % number of neighbors
idx = knnsearch(Clusters(:,1:3), mostRemotePeaks, 'K', k);
nearest = Clusters(idx,:);
nearest = unique(nearest,'rows');% only unique
end