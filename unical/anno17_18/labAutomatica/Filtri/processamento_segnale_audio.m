clear; close all;

% Acquisisco un segnale audio: registro per 5 secondi la mia voce.
recObj = audiorecorder;
disp('Inizia a parlare.'); recordblocking(recObj,5); disp('Stop!');
% Per riprodurre l'audio si usa il comando play(recObj).
% load voce;
% Prelevo il segnale audio e lo visualizzo in funzione del tempo [0-5 sec].
y = getaudiodata(recObj);
t = 0 : 1/8000 : 5-1/8000;
plot(t,y);

% Parametri della FFT del segnale audio: faccio il padding del segnale fino
% alla potenza di 2 più vicina.
Fc = 8000; N = 2^nextpow2(length(y));
y = [y; zeros(2^nextpow2(length(y))-length(y),1)];
% Calcolo della FFT del segnale audio.
Y = fftshift(fft(y)); freq = -Fc/2 : Fc/N : Fc/2-Fc/N;
figure(2); plot(freq,abs(Y));

% Taglio il segnale vocale con un passa-basso a 2500 Hz di banda. Definisco
% le specifiche del filtro (butterworth).
specifiche_filtro = fdesign.lowpass('N,F3dB',5,500,Fc);
% Disegna il filtro.
H = design(specifiche_filtro,'butter');
% Analizzo il filtro ottenuto.
% fvtool(H);

% Processo il segnale vocale col filtro.
yf = filter(H,y); Yf = fftshift(fft(yf));
hold on; plot(freq,abs(Yf));

playerObj = audioplayer(y,Fc);
play(playerObj);