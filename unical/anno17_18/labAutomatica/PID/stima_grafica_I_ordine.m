clear; close all;

% Identifica un modello del primo ordine dai dati sperimentali.
load dati.mat;

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
G = 0.8/((150*s + 1)^3*(40*s+1)^2);
figure(2); hold on;
step(feedback(C_P*G,1));
step(feedback(C_PI*G,1));
step(feedback(C_PID*G,1));
regolatore = [kP*(1+1/(s*tI)), (kP*(1 + 1/(s*tI) + s*tD/(1+(tD/N*s))))];
W = series(regolatore(1),feedback(G,regolatore(2)));
step(W);
