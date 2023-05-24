function [t,y] = RK4(fun,tspan,y0)
N = length(tspan); 
h = tspan(2) - tspan(1); % step
t = tspan;
y = zeros(N,length(y0));
y(1,:) = y0';
yin = y0';

for i= 2:N
    yout = RK4Step(fun,h,tspan(i),yin);
    y(i,:) = yout;
    yin = yout;
end
end