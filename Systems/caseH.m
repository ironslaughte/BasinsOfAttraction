function yout = caseH(t,x, param)
yout = zeros(3,1);
yout(1) = -x(2) + x(3)*x(3);
yout(2) = 1*(x(1) + 0.5*x(2));
yout(3) = param*(x(1) - x(3));
end