function variance = CalculateVariance(x)
meanX = mean(x);
squareDiff = (x - meanX).^2;
sumDiff = sum(squareDiff);
variance = sqrt(sumDiff/(length(x)-1));
end