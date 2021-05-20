clear all
close all

%% Initialization
Fs = 600; % Nyquist theorem (fc = 100Hz)
time = 0:1/Fs:0.2;
v = 0.1; % speed

L = 6e-3; % width of the membrane
X = 0:1e-4:2*L;
Z = -2e-3; % depth of the mechanoreceptors

x1 = 0.002;
t1 = 0.1;
dx = 10e-4; % width of the bump
DC = 0.6; % duty cycle of the wheel
Ts = dx/DC; % spatial period
x2 = x1+Ts;
t2 = t1+Ts/v;

% % Pressure in surface
Amp = 2;
P1 = @(x,t) rect_function(x-v*t,dx,x1-v*t1).*rect_function(t,dx/v,t1);
P2 = @(x,t) rect_function(x-v*t,dx,x1+Ts-v*t1).*rect_function(t,dx/v,t1+Ts/v);
P = @(x,t) Amp*(P1(x,t)+P2(x,t));

figure(1);
p = contour(X,time,P(X,time'));
% set(p,'edgecolor','none','facecolor','interp')
shading flat
ax=gca;
ax.YDir = 'reverse';
title('Surface pressure distribution')
xlabel('X (m)')
ylabel('t (s)')

% % Skin parameters
E = 1.1*10^6;   % Young's modulus
fc = 100;
visco = E/fc;   % viscosity
nu = 0.49;      % Poisson's ratio

%% Stress diffusion
sigma_x = @(x,t) -2/pi*Z.*integral(@(s) P(s,t).*(x-s).^2./((x-s).^2+Z.^2).^2,0,L,'ArrayValued',true);
sigma_z = @(x,t) -2/pi*Z.^3.*integral(@(s) P(s,t)./((x-s).^2+Z.^2).^2,0,L,'ArrayValued',true);
tau = @(x,t) -2/pi*Z.^2.*integral(@(s) P(s,t).*(x-s).^2./((x-s).^2+Z.^2).^2,0,L,'ArrayValued',true);


Zv = (-8e-3:1e-4:-1e-4)';
[Xq,Zq]=meshgrid(X,Zv);
stress_x = -2/pi*Zq.*integral(@(s) P(s,t1).*(Xq-s).^2./((Xq-s).^2+Zq.^2).^2,0,L,'ArrayValued',true);
stress_z = -2/pi*Zq.^3.*integral(@(s) P(s,t1)./((Xq-s).^2+Zq.^2).^2,0,L,'ArrayValued',true);
figure(2);
subplot 121
pcolor(Xq.*1e3,Zq.*1e3,stress_x)
title('Tangential stress')
shading flat
xlabel('x (mm)')
ylabel('z (mm)')
subplot 122
pcolor(Xq.*1e3,Zq.*1e3,stress_z)
title('Normal stress')
shading flat
xlabel('x (mm)')
ylabel('z (mm)')

%% Teporal attenuation of strain
f = @(t,eps) 1/visco*([sigma_x(X,t)-nu*sigma_z(X,t);...
    -nu*sigma_x(X,t)+sigma_z(X,t)]-E*eps);

% initial conditions 
eps = zeros(2,length(X),length(time));
eps(:,:,1) = 1/E*[sigma_x(X,time(1))-nu*sigma_z(X,time(1));...
    -nu*sigma_x(X,time(1))+sigma_z(X,time(1))];
dt = 1/Fs;
for t=2:length(time)
    
    %%RK4 fct = Hx
    k1 = f(t*dt,eps(:,:,t-1));
    k2 = f((t+0.5)*dt,eps(:,:,t-1)+0.5*dt*k1);
    k3 = f((t+0.5)*dt,eps(:,:,t-1)+0.5*dt*k2);
    k4 = f((t+1)*dt,eps(:,:,t-1)+dt*k3);
    eps(:,:,t) = eps(:,:,t-1)+ dt/6*(k1+2*k2+2*k3+k4);
    
end
for i=1:length(X)
    for j=1:length(time)
        strain_x(i,j) = eps(1,i,j);
        strain_z(i,j) = eps(2,i,j);
    end
end

figure(3);
subplot 121
pcolor(X.*1e3,time,strain_x)
ax=gca; ax.YDir = 'reverse';
title('Tangential strain')
shading flat
xlabel('x (mm)')
ylabel('time (s)')
subplot 122
pcolor(X.*1e3,time,strain_z)
ax=gca; ax.YDir = 'reverse';
title('Normal strain')
shading flat
xlabel('x (mm)')
ylabel('time (s)')
