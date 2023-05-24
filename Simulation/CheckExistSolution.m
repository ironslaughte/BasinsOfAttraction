function exist = CheckExistSolution(y)
counter = 0;
checkVal = zeros(1,3);
for i = 1:5
    if(y(i,:) == checkVal)
        counter = counter + 1;
    end
end
if(counter == 5)
    exist = false;
else
    nanElements = find(isnan(y(:,1)));
    if(~isempty(nanElements))
        exist = false;
    else
        exist = true;
    end
end
end