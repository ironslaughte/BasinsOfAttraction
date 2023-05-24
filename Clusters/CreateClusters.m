function [attractorsPeaks, numAttractors] = CreateClusters(Peaks, indexes)
numAttractorsWithNoise = unique(indexes);
noise = find(numAttractorsWithNoise == -1);

if(~isempty(noise))
    numAttractors = numAttractorsWithNoise(2:end); 
else
    numAttractors = numAttractorsWithNoise(1:end);
end
attractorsPeaks = [];
for i = 1:length(numAttractors)
    idxRowsAtrr = find(indexes == numAttractors(i));
    idxAtrr = numAttractors(i) + zeros(length(idxRowsAtrr),1);
    attractorPeaks = [Peaks(idxRowsAtrr,1:3), idxAtrr];
    attractorsPeaks = cat(1,attractorsPeaks, attractorPeaks);
end
end