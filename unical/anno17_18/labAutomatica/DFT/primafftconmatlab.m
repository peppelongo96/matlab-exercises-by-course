clear; close all;
% Simulazione del comando fft di MATLAB

% Scelgo la lunghezza della sequenza come una potenza di 2. Gli angoli in
% cui sarà suddiviso il cerchio sono multipli di 2*pi/N, ovvero approssimo
% la circonferenza con un poligono regolare di N lati. Se N è pari allora
% un vertice giace in corrispondenza dell'angolo pi.
N = 128;

% Passo di campionamento T (frequenza f = 1/T).
T = 1;

% Costruiamo il segnale periodico (ampiezza, sfasamento iniziale, ecc.).
A = 1;
phi1 = 20*pi/180;
phi2 = 15*pi/180;
f1 = 2+1/(T*N)*4;
f2 = 1/(T*N)*4;

% Indice di campionamento.
k = 0:N-1;
% Estrazione della sequenza finita del segnale.
x = A*cos(2*pi*f1*k*T + phi1) ;%+ (A/2)*sin(2*pi*f2*k*T + phi2);

% Calcolo della DFT del segnale per tramite del comando fft di Matlab.
Xtemp = fft(x);
% Simmetrizzo lo spettro.
X = fftshift(Xtemp);

% Genero l'asse delle ascisse [-fs/2, fs/2).
f = (-N/2:N/2-1)*(1/(T*N));
% Un primo grafico "grezzo" del diagramma delle ampiezze simmetrizzato.
figure(1);
subplot(3,1,1);
stem(f,abs(X));
title('Diagramma delle ampiezze');
subplot(3,1,2);
fase = atan2(imag(X),real(X))*180/pi;
stem(f,fase);
title('Diagramma delle fasi grezzo');
subplot(3,1,3);
% Soglia di tolleranza per azzerare la fase di un numero complesso.
sogliafasi = max(abs(X))/1e6;
X2 = X;
X2(abs(X) < sogliafasi) = 0;
fase = atan2(imag(X2),real(X2))*180/pi;
stem(f,fase);
title('Diagramma delle fasi');

% Disegno il segnale analogico su una finestra temporale di 3 secondi.
t = 0:0.001:128;
figure(2);
plot(t,A*cos(2*pi*f1*t + phi1) + (A/2)*sin(2*pi*f2*t + phi2));
xric = ifft(Xtemp);
tk = 0:T:(N-1)*T;
hold on;
plot(tk,xric,'or')


figure(3);
xric = ifft(Xtemp);
tk = 0:T:(N-1)*T;
plot(tk(1:10),xric(1:10),'or');
hold on;
tanalog = 0:0.001:9;
plot(tanalog,A*cos(2*pi*f1*tanalog + phi1),'b');
plot(tanalog,A*cos(2*pi*(f1-2)*tanalog + phi1),'g');

