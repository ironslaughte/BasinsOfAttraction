function yout = caseA(t,x, param)
yout = zeros(3,1);
yout(1) = param*x(2);
yout(2) = -x(1) + x(3)*x(2);
yout(3) = 1 - x(2)*x(2);
end