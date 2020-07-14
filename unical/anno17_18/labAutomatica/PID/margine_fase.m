clear; close all;

% Implementazione del metodo Ziegler-Nichols a ciclo chiuso (metodo del
% margine di ampiezza).

load datisperimentali.mat
s = zpk('s');
G = 0.8/((10*s+1)^3*(25*s+1)^2);

% Calcolo del margine di ampiezza.
[k_cr,Phi_m,omega_pi,omega_c] = margin(G);

% Determino il periodo critico.
T_cr = 2*pi/omega_pi;

% Implemento il PI.
k_PI = 0.45*k_cr; Ti_PI = 0.85*T_cr;
C_PI = k_PI*(1+1/(s*Ti_PI));
W_PI = feedback(series(C_PI,G),1);

% Implemento il PID.
k_PID = 0.6*k_cr; Ti_PID = 0.5*T_cr; Td_PID = 0.12*T_cr; N = 5;
C_PID = k_PID*(1+1/(s*Ti_PID)+s*Td_PID/(1+s*(Td_PID/N)));
W_PID = feedback(series(C_PID,G),1);

% Implemento il PI-D.
k_PID = 0.6*k_cr; Ti_PID = 0.5*T_cr; Td_PID = 0.12*T_cr; N = 5;
C_PID_PI = k_PID*(1+1/(s*Ti_PID)); 
W_PI_D = series(C_PID_PI,feedback(G,C_PID)); % stessi poli di W_PID, ma diversi zeri

% Risposte al gradino.
hold on;
step(W_PI);
step(W_PID);
step(W_PI_D);