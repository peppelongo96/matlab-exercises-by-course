clear; close all;

% Carica il file .wav.
%[y, Fs] = audioread('violin.wav');
%sound(y);

% Genero il segnale chirp.
Fs = 1000; %Hz
t = 0 : 1/Fs : 60;
f0 = 400; f1 = 800; t1 = 4;
y = chirp(t,f0,t1,f1);
sound(y);

% Costruisco lo spettrogramma del file audio.
spectrogram(y, 1024, 1000, 1024, Fs, 'yaxis');
title('Spettrogramma di un segnale chirp');