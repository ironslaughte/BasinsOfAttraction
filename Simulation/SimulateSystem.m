function [y1,y2,y3, t] = SimulateSystem(f, tspan, y0, Nt)
[t,Y] = RK4(f,tspan,y0');
if (CheckExistSolution(Y))
    y1 = Y(Nt:end,1);
    y2 = Y(Nt:end,2);
    y3 = Y(Nt:end,3);
    t = t(Nt:end);
else
    y1 = zeros(1,3);
    y2 = zeros(1,3);
    y3 = zeros(1,3);
end
end