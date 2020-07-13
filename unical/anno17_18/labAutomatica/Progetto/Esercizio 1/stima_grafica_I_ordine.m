clear; close all;

% Identifica un modello del primo ordine dai dati sperimentali.
load dati.mat;

K = Y(end);
A1 = sum((repmat(K,length(Y),1) - Y)*Tc);
i = find(T < A1/K);
A2 = sum(Y(i)*Tc);
Tt = A2*exp(1)/K;
tau = A1/K - Tt;

% Confronto i dati sperimentali con la riposta al gradino del sistema
%                             e^-(s*tau)
%                   G(s) = K ------------
%                              1 + s*Tt
s = zpk('s'); G = K*exp(-tau*s)/(1 + s*Tt);
hold on; step(G,'k--'); plot(T,Y);

% Costruisco un regolatore P.
[kP, tI, tD] = parZN("P",Tt,K,tau);
C_P = kP;
[kP, tI, tD] = parZN("PI",Tt,K,tau);
C_PI = kP*(1 + 1/(s*tI));
[kP, tI, tD] = parZN("PID",Tt,K,tau);
N = 30;
C_PID = kP*(1 + 1/(s*tI) + s*tD/(1+(tD/N*s)));
C_PID_PI = kP*(1 + 1/(s*tI));
G = 0.8/((150*s + 1)^3*(40*s+1)^2);
figure(2); hold on;
step(feedback(C_P*G,1));
step(feedback(C_PI*G,1));
step(feedback(C_PID*G,1));
step(series(C_PID_PI,feedback(G,C_PID)));