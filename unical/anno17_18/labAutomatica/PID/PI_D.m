 clear; close all;
% Esperimento di un regolatore PI-D: 
% Y(s) = kP(1 + 1/(s*Ti))*(R(s)-Y(s)) - kP*s*Td*Y(s).
% Mantengo costante kP = 1 e Ti = 1.
% Ipotizzo che Td sia variabile all'interno della fascia 0.1:0.2:2.
% Modello dell'impianto:
%                      1
%           G(s) = ---------
%                   (s+1)^3

% Definisco la fdt del modello.
s = tf('s');
G = 1/(s + 1)^3;

% Considero il tempo derivativo Td variabile e, per ciascun suo valore, 
% rappresento la risposta al gradino unitario.
figure(1); hold on; 
kP = 1; Ti = 1;
for Td = 0.1:0.2:2
    % Variabile per il PID.
    C_PID = kP*(1 + 1/(s*Ti) + s*Td);
    % Definisco il PI.
    C_PI = kP*(1 + 1/(s*Ti));
    % definisco il sistema retroazionato
    W = series(feedback(G,C_PID), C_PI);
    % rappresento la risposta al gradino
    step(W);
end
grid;

figure(2); hold on; 
W_PID = feedback(series(G,C_PID),1);
step(W_PID);
W_PI_D = series(feedback(G,C_PID), C_PI);
step(W_PI_D);