clear; close all;

% Identifica un modello del primo ordine dai dati sperimentali.
load datisperimentali.mat;

% Valutiamo l'istante finale e il valore di regime del dato sperimentale.
Tfin = T(end); K = Y(end);

% Calcolo per approssimazione le derivate prima e seconda.
dY = diff(Y); ddY = diff(dY);

% Determino l'indice del vettore ddY in corrispondenza del quale ho un
% cambio di segno (ddY contiene una stima della concavità).
ind = find(ddY > 0 & min(ddY));
% Calcolo del tempo di flesso e della sua ordinata.
Tflesso = T(ind(end)); Yflesso = Y(ind(end));

% Stimo il coefficiente angolare della retta tangente al flesso.
m = dY(ind(end))/Tc;

% Determiniamo l'intercetta con l'asse delle ascisse della retta
%  y - yf = m (t - tf) -> -yf = m (tau - tf) -> tau = (m*tf - yf) / m
tau = (m*Tflesso - Yflesso)/m;

% Stimo la costante di tempo del modello del I ordine.
%                   eta = |-m*tf + yf|
Tt = (tau*K)/(abs(-m*Tflesso + Yflesso));

% Stimo i parametri del PI-D e lo costruisco.
[kP,Ti,Td] = parZN("PID",K,tau,Tt); N = 10;
s = zpk('s');
G = 0.8/((10*s+1)^3*(25*s+1)^2);
C_PID_PI = kP*(1+1/(s*Ti));
C_PID_PID = kP*(1+1/(s*Ti)+s*Td/(1+Td/N*s));
W_PI_D = series(C_PID_PI,feedback(G,C_PID_PID));

parametri_risposta = stepinfo(W_PI_D);
% Scegliamo il tempo di campionamento in funzione del tempo di salita.
Tc_sup = parametri_risposta.RiseTime/10;
Tc_inf = parametri_risposta.RiseTime/20;
Tc = 1.5; % (1.3174, 2.6348)

% Implementiamo il PID discreto con il primo metodo (e(t) = e(k), D(t) =
% D(k)).
% a1 = 0; a2 = 1;
% b1 = 1 - N*Tc/Td; b2 = -N*kP;

% a1 = 1; a2 = 0;
% b1 = Td/(N*Tc+Td); b2 = -(N*kP*Td)/(N*Tc+Td);

a1 = .5; a2 = .5;
b1 = (Td - 2*N*Tc)/(Td + 2*N*Tc); b2 = -(2*kP*Td*N)/(Td+2*N*Tc);