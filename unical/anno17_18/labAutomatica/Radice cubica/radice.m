clear; close all;

% Assegno le variabili di inizializzazione.
a = 50;
tol = 1e-3;
% Eseguo il foglio Simulink.
sim("radice_cubica");

% Visualizzo la successione delle soluzioni.
stem(xn);