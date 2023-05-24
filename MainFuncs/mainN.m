%start Case N
%% Initialization params system
h = 0.01; %time step
tspan = 0:h:300; %time span
Tt = 200; %transient time
Nt = ceil(Tt/h); %transient samples
y0 = [3, 2, 2]; %initial cond
Y0 = [y0; -3, -2, -2];
%% Initializing a system parameter change
dp = 0.001;%parameter change step
pspan = 1:dp:3; %parameter span
%% Solve system whith param = 1
f = @(t,y0)caseN(t,y0, 1);
[t,Y] = RK4(f,tspan,Y0(1,:)'); %solve system
%% Plot phase
figure(6);
hold on
plot3(Y(:,1),Y(:,2),Y(:,3),'b'); %plot 3D phase portrait

%% Solve system whith param = 1
% f = @(t,y0)caseN(t,y0, 1);
% [t,Y1] = RK4(f,tspan,Y0(2,:)'); %solve system
% %% Plot phase
% figure(6);
% hold on
% plot3(Y1(:,1),Y1(:,2),Y1(:,3),'r'); %plot 3D phase portrait


%% Bifurcation
Bifurcation(@caseN,Y0,pspan); %plot bifurcation diagram on which the values of x from the change of parameter b
%% Find multistability for system N
%FindAttractors(@caseN,-10,10,-10, 10,-10, 10, 100, 1.3, true);
%% Lyapunov exponents
%lyapspectrum(f1,tspan,y0, 'disp', '2d'); %calculate lyapunov exponents

%end case N