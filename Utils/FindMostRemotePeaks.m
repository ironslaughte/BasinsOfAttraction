function mostRemotePeaks = FindMostRemotePeaks(Clusters, currPeaks)
 diff = pdist2(Clusters(:,1:3), currPeaks);
 mostRemotePeaks = [];
     for i = 1:length(diff(:,1))
         for j = 1:length(diff(1,:))
             if(diff(i,j) < 0.05)
                 mostRemotePeaks = cat(1, mostRemotePeaks, currPeaks(j,:));
             end
         end
     end
end