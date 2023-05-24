function yout = RK4Step(fun,dt,tk,yk)
f1 = fun(tk,yk);
f1 = f1';
f2 = fun(tk + dt/2, yk + (dt/2) * f1);
f2 = f2';
f3 = fun(tk + dt/2, yk + (dt/2) * f2);
f3 = f3';
f4 = fun(tk + dt, yk + dt*f3);
f4 = f4';

yout = yk + (dt/6)*(f1 + 2*f2 + 2*f3 + f4);
end