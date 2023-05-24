function answer = Lorenz(t,x,b)
alpha = 4;
rho = 29;
answer = [0;0;0];
answer(1) = alpha * x(2) - alpha* x(1);
answer(2) = x(1) * (rho-x(3)) - x(2);
answer(3) = x(1)*x(2) - b*x(3);
end