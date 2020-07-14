clear; close all;

% Setto la frequenza di campionamento e il passo di campionamento.
Fc = 1000; Tc = 1/Fc;
% Setto il numero di frequenze discrete della FFT.
N = 2048;
% Indice che caratterizza il numero di campioni.
n = 0:N-1;

% Genero un rumore gaussiano bianco di 2048 campioni.
noise = randn(1,N);
% Filtro il rumore gaussiano in alta frequenza, tagliando le armoniche al
% di sotto dei 200Hz.
load filtri;
noiseh = filter(Hhf,noise);

% Segnale corrotto da rumore.
x = cos(2*pi*60*n*Tc) + sin(2*pi*120*n*Tc) + noiseh;
% Analizzo lo spettro del segnale corrotto da rumore attraverso la FFT.
X = fft(x); X = fftshift(X);
% Genero l'asse dell'ascisse frequenziali.
freq = -Fc/2 : Fc/N : Fc/2-Fc/N;
plot(freq,2/N*abs(X));

% Processo il segnale con il passa basso a 200Hz.
xfiltrato = filter(Hlf,x);
Xf = fft(xfiltrato); Xf = fftshift(Xf);
hold on
plot(freq,2/N*abs(Xf));
xlabel('Frequency'); ylabel('Amplitude');
title('Spettro del segnale analizzato');
grid minor