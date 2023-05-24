%start Case A
%% Initialization params system
h = 0.01; %time step
tspan = 0:h:300; %time span
Tt = 200; %transient time
Nt = ceil(Tt/h); %transient samples
y0 = [-3, -2, 2]; %initial cond
Y0 = [y0; 3, 2, 2];
%% Initializing a system parameter change
dp = 0.01;%parameter change step
pspan = 1:dp:3; %parameter span
%% Solve system whith param = 1
f = @(t,y0)caseA(t,y0, 1);
[t,Y] = RK4(f,tspan,Y0(1,:)'); %solve system
%% Plot phase
PlotPhase(Y,Nt,1);
%% Solve system whith param = 1
f = @(t,y0)caseA(t,y0, 1);
[t,Y1] = RK4(f,tspan,Y0(2,:)'); %solve system
PlotPhase(Y1,Nt,2);
%% Plot phase
% figure(6);
% hold on
% plot3(Y1(:,1),Y1(:,2),Y1(:,3),'r'); %plot 3D phase portrait
% xlabel('x');
% ylabel('y');

%% Bifurcation
Bifurcation(@caseA,Y0,pspan); %plot bifurcation diagram on which the values of x from the change of parameter b
%% Find multistability for system N
%FindAttractors(@caseA,-10,10,-10, 10,-10, 10, 100, 1, true);
%% Lyapunov exponents
%lyapspectrum(f1,tspan,y0, 'disp', '2d'); %calculate lyapunov exponents

%end case A