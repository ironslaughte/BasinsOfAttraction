function [peaks, idx] = FindPeaks(y1,y2)
M = length(y2); %samples of signal
peaks = [];
idx = [];
for t = 2:M
     if sign(y2(t-1))*sign(y2(t)) <= 0 && sign(y1(t)) > 0
         peaks = [peaks; y1(t)]; %remember value of y1
         idx = [idx, t];
     end
end
if(isempty(peaks))
    [peaks, idx] = findpeaks(y1); %find peaks X
end
end