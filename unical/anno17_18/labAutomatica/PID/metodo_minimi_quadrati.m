clear; close all;

% Valore di inizializzazione dell'algoritmo.
X0 = [.4 .3 .5]';
% Trovo il minimo della funzione.
X_min_ls = fminsearch(@scarto_tre_parametri,X0);

k_ls = X_min_ls(1);
tau_ls = X_min_ls(2);
Tt_ls = X_min_ls(3);

s = zpk('s');
G0_m_ls = k_ls*exp(-s*tau_ls)/(1+s*Tt);

load datisperimentali.mat
plot(T,Y);
hold on;
step(G0_m_ls);