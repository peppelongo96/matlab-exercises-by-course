 clear; close all;
% Esperimento di un regolatore PI: C(s) = kP(1 + 1/(s*Ti)).
% Mantengo costante kP = 1.
% Ipotizzo che Ti sia variabile all'interno della fascia 0.7:0.1:1.5.
% Modello dell'impianto:
%                      1
%           G(s) = ---------
%                   (s+1)^3

% Definisco la fdt del modello.
s = tf('s');
G = 1/(s + 1)^3;

% Considero il tempo integrale Ti variabile e, per ciascun suo valore, 
% rappresento la risposta al gradino unitario.
figure(1); hold on; 
kP = 1.2684;
for Ti = 0.7:0.1:1.5
    % Variabile per il PI.
    C_PI = kP*(1 + 1/(s*Ti));
    % definisco il sistema retroazionato
    W = feedback(series(C_PI,G),1);
    % rappresento la risposta al gradino
    step(W);
end
grid;

% Rappresento i diagrammi di Bode del controllore al variare di Ti.
figure(2); hold on; 
bode(G); 
for Ti = 0.7:0.1:1.5
    C_PI = kP*(1 + 1/(s*Ti));
    bode(C_PI); 
end
grid;

% Rappresento i diagrammi di Bode della funzione d'anello al variare di Ti.
figure(3); hold on;  
for Ti = 0.7:0.1:1.5
    C_PI = kP*(1 + 1/(s*Ti));
    W = feedback(series(C_PI,G),1);
    bode(W); 
end
grid;