clear; close all;

% Identifica un modello del primo ordine dai dati sperimentali.
load datisperimentali.mat;

% Valutiamo l'istante finale e il valore di regime del dato sperimentale.
Tfin = T(end); K = Y(end);

% Calcolo dell'area sottesa fra il valore di regime e la curva di processo.
A1 = sum((repmat(K,length(T),1) - Y).*Tc);
i = find(T < A1/K);
A2 = sum(Y(i).*Tc);

Tt = A2*exp(1)/K;
tau = (A1-exp(1)*A2)/K;

s = zpk('s');
G = K*exp(-s*tau)/(1+s*Tt);
hold on;
plot(T,Y);
step(G);