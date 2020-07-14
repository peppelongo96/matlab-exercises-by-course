clear; close all;
% Coefficienti del sistema a tempo continuo.
b0 = 0; b1 = 0; b2 = 1000;
a1 = 1000; a2 = 1001;

% Definisco il tempo di campionamento. (f = 10 Hz)
Tc = .001;

% Calcolo i coefficienti del sistema digitale.
alfa1 = -2 + a1*Tc;
alfa2 = 1 - a1*Tc + a2*Tc^2;
beta0 = b0;
beta1 = -2*b0 + b1*Tc;
beta2 = b0 - b1*Tc + b2*Tc^2;

% Tempo finale.
tfin = 4;
% Calcolo il numero dei passi.
Npassi = floor(tfin/Tc);

i = 0;

% Variabili temporanee (condizioni iniziali del sistema).
y1p = 0; y2p = 0;
u1p = 0; u2p = 0;

% Definisco una variabile nella quale conservare le uscite.
yseq = [];

% Definisco una variabile nella quale conservare i tempi.
tseq = [];

% u è il gradino unitario.
ucorr = 1;

while i <= Npassi
    ycorr = - alfa1*y1p - alfa2*y2p + beta0*ucorr + beta1*u1p + beta2*u2p;
    yseq = [yseq ycorr];
    tseq = [tseq i*Tc];
    y2p = y1p;
    y1p = ycorr;
    u2p = u1p;
    u1p = ucorr;
    i = i + 1;
end

plot(tseq,yseq,'-r',tseq,yseq,'ob');
title('Risposta di un sistema a tempo discreto al gradino unitario [f = 1 kHz]');
xlabel('time [sec]');
ylabel('y(t)');