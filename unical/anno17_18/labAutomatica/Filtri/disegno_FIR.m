clear; close all;

% Disegna un filtro FIR che, nota la Fs del segnale (Fs = 44 kHz), taglia
% le armoniche a 4 kHz.

% Carica il segnale audio.
[y, fs] = audioread('violino.wav');
y = y(:,1);

% Parametri di disegno del FIR.
D = fdesign.lowpass('Fp,Fst,Ap,Ast', 4000, 5000, 3, 60, fs);
% Implementa il filtro con le specifiche imposte.
Hd = design(D,'equiripple');
% Filtriamo il segnale con il FIR creato.
yf = filter(Hd, y);

% Rappresentiamo i due spettrogrammi.
figure(1);
spectrogram(y, 1024, 1000, 1024, fs, 'yaxis');
title('Spettrogramma del segnale originale');
figure(2);
spectrogram(yf, 1024, 1000, 1024, fs, 'yaxis');
title('Spettrogramma del segnale filtrato');

% Ascoltiamo il segnale filtrato.
sound(yf, fs);