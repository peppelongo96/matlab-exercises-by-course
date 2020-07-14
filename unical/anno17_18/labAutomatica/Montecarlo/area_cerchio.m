clear; close all;

N_lanci = input('Numero di lanci: ');
[area, punti_in, punti_out] = montecarlo(N_lanci);

% Determino le coordinate dei punti della la circonferenza.
alpha = linspace(0,2*pi,4000);
xcirc = cos(alpha); ycirc = sin(alpha);

plot(xcirc,ycirc,'k',punti_in(:,1),punti_in(:,2),'xr',punti_out(:,1),punti_out(:,2),'og');
grid;
% Per ridurre l'aspect ractio della finestra:
axis square;

% Per visualizzare l'area del cerchio:
disp(area);