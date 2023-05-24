function yout = caseC1(t,x,param)
yout = zeros(3,1);
a = param;
b = 10;
c = -2;
yout(1) = a*(x(2) - x(1));
yout(2) = -c*x(2) - x(1)*x(3);
yout(3) = x(2)*x(2) - b;
end
