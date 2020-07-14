 clear; close all;
% Esperimento di un regolatore PID: 
% C(s) = kP(1 + 1/(s*Ti) + s*Td).
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
    % definisco il sistema retroazionato
    W = feedback(series(C_PID,G),1);
    % rappresento la risposta al gradino
    step(W);
end
grid;

figure(2); hold on;  
for Td = 0.1:0.2:2
    % Variabile per il PI.
    C_PID = kP*(1 + 1/(s*Ti) + s*Td);
    % Rappresento il diagramma di Bode del controllore.
    bode(C_PID); 
end
grid;



