
clear; close all;

% Parametri di funzionamento del sistema.
m = 0.2; b = 0.1; km = 19.62;
R = 50; L0 = 0.5; g = 9.81;
% Tensione di alimentazione.
ueq = 5;

xeq = [ueq/R*sqrt(km/m/g) 0 ueq/R];

par = [m,km,R,L0,b,g];


% s = zpk('s');
% a = 1;
% [zeriG,poliG,kG]=zpk(G1,'v');
% i = find(abs(imag(poliG)) < eps);
% p = poliG(i);
% i = find(abs(imag(poliG)) >= eps);
% q1 = -2*real(poliG(i(1)));
% q2 = abs(poliG(i(1)))^2;
% 
% Manca la definizione di C(s) da Maple.
