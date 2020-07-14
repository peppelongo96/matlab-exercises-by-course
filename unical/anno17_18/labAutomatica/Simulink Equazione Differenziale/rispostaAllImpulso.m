clear; close all;

% Condizioni iniziali.
xInitial = [0; 0];
% Tempo finale e passo di campionamento.
tfin = 4;
Tc = 0.01;

Npassi = round(tfin/Tc);
k = 0;

% Variabili nelle quali immagazzinare lo stato del modello, l'uscita e il
% tempo di simulazione.
tfin = [];
xfin = [];
yfin = [];
ufin = [];

% Si esegue il foglio Simulink.
while (k < Npassi)
    t = k*Tc;
    % Valore dell'ingresso u(k*Tc). Si genera un segnale costante a tratti.
    if(k == 0)
        u = 1/Tc;
    else
        u = 0;
    end
    % Lancio il foglio nell'ipotesi che t0 = k*Tc e tf = (k+1)*Tc.
    sim('equazione');
    tfin = [tfin; tout];
    xfin = [xfin; xout];
    yfin = [yfin; yout];
    ufin = [ufin; ones(length(tout),1)];
    xInitial = xFinal;
    k = k + 1;
end

% Plot delle variabili del sistema.
subplot(3,1,1);
plot(tfin,yfin,'r');
grid;
xlabel('t [sec]');
ylabel('y(t)');
title('Risposta del sistema all''impulso');

subplot(3,1,2);
plot(tfin,xfin(:,1),'r');
grid;
xlabel('t [sec]');
ylabel('x_1(t)');
title('Stato del primo integratore');

subplot(3,1,3);
plot(tfin,xfin(:,2),'r');
grid;
xlabel('t [sec]');
ylabel('x_2(t)');
title('Stato del secondo integratore');