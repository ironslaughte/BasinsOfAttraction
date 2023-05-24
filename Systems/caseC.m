function yout = caseC(t,x,param)
yout = zeros(3,1);
a = 10;
b = 10;
c = param;
yout(1) = a*(x(2) - x(1));
yout(2) = -c*x(2) - x(1)*x(3);
yout(3) = x(2)*x(2) - b;
end
