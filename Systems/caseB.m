function yout = caseB(t,x,param)
a = param;
b = 1;
yout = zeros(3,1);
yout(1) = x(2)*x(3);
yout(2) = a*(x(1) - x(2));
yout(3) = b - x(1)*x(2);
end