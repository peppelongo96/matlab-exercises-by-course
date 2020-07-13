clear; close all;

% Carico il segnale campionato.
load segnale_16;

% Visualizzo il suo andamento temporale.
%figure(1);
Tc = 1/Fc;
t = 0 : Tc : (length(x) - 1)*Tc;
%plot(t,x); xlim([0 t(end)]);
%xlabel('Time (seconds)'); ylabel('Amplitude');
%title('Andamento temporale del segnale non filtrato');

% Costruisco il diagramma dei moduli dello spettro del segnale.
%figure(2);
N = 2^nextpow2(length(x));
x = [x; zeros(N - length(x),1)];
freq = -Fc/2 : Fc/N : Fc/2 - Fc/N;
Y = fftshift(fft(x));
%stem(freq,abs(Y)*2/N);
%xlabel('Frequency (Hz)'); ylabel('Amplitude');
%title('Diagramma dei moduli');

% Costruisco un filtro di Butterworth.
%specifiche_filtro = fdesign.lowpass('N,F3dB',10,600,Fc);
%H = design(specifiche_filtro,'butter');
% Costruisco un filtro di .
%specifiche_filtro = fdesign.lowpass('Fp,Fst,Ap,Ast',600,650,3,60,Fc);
%H = design(specifiche_filtro,'cheby1');
% Costruisco un filtro FIR.
specifiche_filtro = fdesign.lowpass('Fp,Fst,Ap,Ast',600,650,2,60,Fc);
H = design(specifiche_filtro,'equiripple');
%fvtool(H);

% Analizzo l'operazione di filtraggio.
y_fb = filter(H,x); Y_fb = fftshift(fft(y_fb));
%figure(4); hold on;
%stem(freq,abs(Y)*2/N);
%stem(freq,abs(Y_fb)*2/N);
%xlabel('Frequency (Hz)'); ylabel('Amplitude');
%title('Diagramma dei moduli filtrato');
%figure(5); hold on;
y = ifft(fftshift(Y_fb));
%plot(t,x,t,y); xlim([0 t(end)]);
%xlabel('Time (seconds)'); ylabel('Amplitude');
%title('Andamento temporale del segnale filtrato');

% Rappresento quanto descritto prima mediante uno spettrogramma.
%figure(6);
%spectrogram(x, 256, 200, 256, Fc, 'yaxis');
%title('Spettrogramma del segnale campionato');
figure(7);
spectrogram(y, 256, 200, 256, Fc, 'yaxis');
title('Spettrogramma del segnale filtrato con FIR ');