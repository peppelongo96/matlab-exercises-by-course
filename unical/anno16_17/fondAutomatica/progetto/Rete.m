clear; close all;

% Inserisco le funzioni di trasferimento G(s) e definisco la funzione di
% anello non compensata L(s).

G = tf([1,6],[6/169,6/13,6,0]);
C = 52;
L = series(C,G);

% Disegno il diagramma di Bode della funzione di anello non compensata.
figure(1);
margin(L);

% Determino lo smorzamento relativo al massimo picco di risonanza.
Mr = 3;
delta = smorz_Mr(Mr);

% Calcolo la funzione d'anello sulla nuova pulsazione di attraversamento.
wc_new = 47.9;
[mag,phase] = bode(L, wc_new);

% Progetto la rete correttrice che andrà a compensare la funzione d'anello.
m = 1/mag;
theta = 48;
[tau_1,tau_2] = generica(wc_new,m,theta);
C_reteAnt = tf([tau_1,1],[tau_2,1]);

% Ottengo la nuova funzione di anello. Per verificare che siano rispettate 
% le specifiche di progetto, disegno il diagramma di Bode.
L_new = series(L,C_reteAnt);
figure(3);
[mag_new,phase_new] = bode(L_new,wc_new);
margin(L_new);

% Calcolo la funzione di trasferimento del sistema con feedback e ne vado a
% fare il diagramma di Bode, verificando così le specifiche richieste.
T = (L_new)/(1+L_new);
figure(4);
margin(T);