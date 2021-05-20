clear; close all;
s=tf('s');

% Mechanical model of the fin actuator
% 固有角周波数20Hz,減衰係数0.7
delta_max=10; %deg
K=89.76;
T=0.0057;
G1=K/(s*(T*s+1));

% Aerodynamic properties of rocket
lda=50; %pitching moment coefficient for Aileron
G2=lda/s;

% Disturbance
d=1;

% Controller design
Kp=0.1;
Kphi=2;

% Closed loop transfer function
G_angle=(G1*G2*Kp*Kphi)/((G1*G2*Kp+G1+1)*s+G1*G2*Kp*Kphi);
G_rate=(G1*G2*Kp*Kphi)*s/((1+G1+G1*G2*Kp)*s+G1*G2*Kp*Kphi);

% Simulation
opt = stepDataOptions('InputOffset',0,'StepAmplitude',1);
step(G_angle,opt);
hold on;
step(G_rate,opt);
legend('\phi','p');

big;

