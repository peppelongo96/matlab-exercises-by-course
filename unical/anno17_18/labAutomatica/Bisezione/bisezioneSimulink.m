clear; close all;

% Impostiamo il valore delle variabili iniziali
a = -3; b = 5;
tol = 1e-3;

% Eseguiamo il foglio Simulink.
sim('bisezione');

% Calcoliamo i punti della funzione su cui stiamo operando.
ascissa = linspace(a,b,100);
ordinata = ascissa.^3-27;

% Visualizziamo l'andamento del metodo di bisezione.
plot(xm,fm,'x',ascissa,ordinata);
title('Metodo di bisezione su f(x) = x^3-27 in x = [-3,5]');
xlabel('asse X');
ylabel('asse Y');