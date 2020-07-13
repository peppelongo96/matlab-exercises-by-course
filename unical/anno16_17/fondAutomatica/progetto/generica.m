function [tau1,tau2]=generica(wc,m,phi)
%
% Calcola i parametri di una rete correttrice generica
%    
%    1+s*tau1
%    --------
%    1+s*tau2
%
% La funzione richiede una verifica ex-post in merito al segno
% di tau1 e tau2 (devono NECESSARIAMENTE essere entrambe positivi)
%
% I parametri della funzione sono:
% wc  : pulsazione di attraversamento desiderata
% m   : reciproco del modulo della funzione di anello non-compensata |L(j wc)|
% phi : incremento (o decremento) sulla fase desiderato in gradi
%


tau1 = (m-cos(phi*pi/180))/(wc*sin(phi*pi/180));

tau2 =  (m*cos(phi*pi/180) - 1)/(wc*m*sin(phi*pi/180));
