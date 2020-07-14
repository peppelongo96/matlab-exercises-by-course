clear; close all;

% Impostiamo il valore delle variabili iniziali.
x0 = -3; x1 = 5;
tol = 1e-3;

% Eseguiamo il foglio Simulink.
sim('secante');

% Generiamo la funzione su cui stiamo operando.
ascisse = linspace(x0,x1,100);
ordinate = ascisse.^3-27;

% Osserviamo l'andamento del metodo di bisezione.
plot(x,y,'or',ascisse,ordinate);
grid;
title('Metodo di bisezione su f(x) = x^3-27 in x = [-3,5]');
xlabel('asse X');
ylabel('asse Y');