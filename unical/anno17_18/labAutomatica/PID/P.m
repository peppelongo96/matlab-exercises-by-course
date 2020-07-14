 clear; close all;
% Esperimento di un regolatore puramente proporzionale: C(s) = kP.
% Ipotizzo che kP sia variabile all'interno della fascia 0.1:0.1:1.
% Modello dell'impianto:
%                      1
%           G(s) = ---------
%                   (s+1)^3

% Definisco la fdt del modello.
s = tf('s'); G = 1/(s + 1)^3;

% Considero il guadagno kP variabile e, per ciascun suo valore, rappresento
% la risposta al gradino unitario.
for kP = 0.1:0.1:1
    % definisco il sistema retroazionato
    W = feedback(kP*G,1);
    % rappresento la risposta al gradino
    step(W); hold on; 
end

% Vediamo la posizione dei poli del sistema retroazionato al variare di kP.
figure(2);
rlocus(G,[0 15]);