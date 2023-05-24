function yout = caseN(t,x, param)
yout = zeros(3,1);
yout(1) =  -2*x(2);
yout(2) = param*(x(1) + x(3)*x(3));
yout(3) = 1 + x(2) - 2*x(3);%2
end