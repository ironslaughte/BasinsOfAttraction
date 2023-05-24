function yout = caseB1(t,x,param)
a = 1;
b = param;
yout = zeros(3,1);
yout(1) = x(2)*x(3);
yout(2) = a*(x(1) - x(2));
yout(3) = b - x(1)*x(2);
end