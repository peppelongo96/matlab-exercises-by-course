clear; close all;

% Campiono il segnale per ottenere la curva di processo. I valori dei
% campioni saranno contenuti nel vettore Y, mentre gli istanti di
% campionamento nel vettore T. 
% Scelgo come tempo di campionamento Tc = 0.05.
s = zpk('s');
G = 0.65/((150*s + 1)^3*(250*s+1)^3);
Tc = 0.1;
%sim('genera_dati');
load datiMIO.mat;

% Visualizzo la curva di processo.
%plot(T,Y);
%title('Curva di processo')

% Ottengo i parametri K, tau e Tt mediante una stima grafica.
K = Y(end);
dY = diff(Y); ddY = diff(dY);
ind = find(ddY > 0 & min(ddY));
Tflesso = T(ind(end)); Yflesso = Y(ind(end));
m = dY(ind(end))/Tc;
tau = (m*Tflesso - Yflesso)/m;
Tt = (tau*K)/(abs(-m*Tflesso + Yflesso));

% % Ottengo i parametri K, tau e Tt mediante il metodo delle aree.
%K = Y(end);
%A1 = sum((repmat(K,length(Y),1) - Y)*Tc);
%i = find(T < A1/K);
%A2 = sum(Y(i)*Tc);
%Tt = A2*exp(1)/K;
%tau = A1/K - Tt;
% 
% % Ottengo i parametri K, tau e Tt mediante il metodo dei minimi quadrati.
%sol = fminsearch(@scarto_tre_parametri,[0.4 0.3 0.5]);
%K = sol(1); tau = sol(2); Tt = sol(3);
% 
% % Ottengo il margine di fase della fdt e il periodo.
%[k_cr,Phi_m,omega_pi,omega_c] = margin(G);
%T_cr = 2*pi/omega_pi;
% 
% % Confronto i dati sperimentali con la riposta al gradino del sistema
% %                             e^-(s*tau)
% %                   G(s) = K ------------
% %                              1 + s*Tt
s = zpk('s'); Gsper = K*exp(-tau*s)/(1 + s*Tt);
hold on;
nn = (K*tau)/Tt;
plot(Tflesso,Yflesso,'ro');
plot(tau,0,'bo');
plot(Tt+tau,K,'ko');
plot(0,-nn,'mo');
plot ([Tt+tau 0],[K -nn],'c');
plot(T,Y,'k'); 
step(Gsper,'k--');
title('Metodo per ispezione grafica');



%title('Metodo dei minimi quadrati')
% 
% % Costruisco un regolatore P.
%[kP,Ti,Td] = parZN("P",Tt,K,tau);
%[kP,Ti,Td] = parFreq("P",k_cr,T_cr);
%C_P = kP;
%uB = 1/K;
%W_P = feedback(series(C_P,G),1);
%step(W_P); hold on;
% 
% % Costruisco un regolatore PI.
%[kP,Ti,Td] = parZN("PI",Tt,K,tau);
%[kP,Ti,Td] = parFreq("PI",k_cr,T_cr);
%C_PI = kP*(1 + 1/(s*2.18*Ti)); 
%W_PI = feedback(series(C_PI,G),1);
%step(W_PI);stepinfo(W_PI)
%hold on; title('Risposta al gradino in feddback con regolatore PI (1)')
% 
% % Costruisco un regolatore PID.
%[kP,Ti,Td] = parZN("PID",Tt,K,tau);
% % [kP,Ti,Td] = parFreq("PID",k_cr,T_cr);
%N = 10;
%C_PID = kP*(1 + 1/(s*Ti) + s*Td/(1 + (Td/N)*s));
%W_PID = feedback(series(C_PID,G),1);
%step(W_PID);hold on;
% 
% % Costruisco un regolatore PI-D.
%[kP,Ti,Td] = parZN("PID",Tt,K,tau);
% %[kP,Ti,Td] = parFreq("PID",k_cr,T_cr);
%N = 10;
%C_PI_D_PI = kP*(1 + 1/(s*Ti));
%C_PI_D_PID = kP*(1 + 1/(s*Ti) + s*Td/(1 + (Td/N)*s));
%W_PI_D = series(C_PI_D_PI,feedback(G,C_PI_D_PID));
%step(W_PI_D);hold on;
%stepinfo(W_PI_D)
% 
%figure(2);
 %Tc=50;
 %a1 = 0; a2 = 1;
 %b1 = 1 - N*Tc/Td; b2 = -N*kP;
 %sim('simula_PI_D_discreto');
 %plot(tout,Y); hold on;
 %a1 = 1; a2 = 0;
 %b1 = Td/(N*Tc+Td); b2 = -(N*kP*Td)/(N*Tc+Td);
 %sim('simula_PI_D_discreto');
 %plot(tout,Y); hold on;
 %a1 = .5; a2 = .5;
 %b1 = (Td - 2*N*Tc)/(Td + 2*N*Tc); b2 = -(2*kP*Td*N)/(Td+2*N*Tc);
 %sim('simula_PI_D_discreto');
 %plot(tout,Y);