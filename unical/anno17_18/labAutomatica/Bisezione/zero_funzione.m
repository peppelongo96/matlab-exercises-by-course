clear; close all;

% Assegno la funzione (parabola) su cui operare la bisezione.
%f = inline('x.*x-4*x+3');
f = @(x) x.*x-4*x+3; % modalità handle
% Assegno i parametri rimanenti della funzione di bisezione.
tol = 1e-3;
x_sx = 0;
x_dx = 1;

% Calcolo lo zero della funzione mediante la function creata.
[zero,seq] = bisez(f,x_sx,x_dx,tol);

ascisse = linspace(x_sx,x_dx,500);
plot(ascisse,f(ascisse),'k',seq,f(seq),'+r',zero,f(zero),'og');
grid;
xlabel('x'); ylabel('f(x)');
title('Esempio di algoritmo di bisezione su parabola');
legend('Parabola','Sequenza punti medi','Zero approssimato');