function [area_cerchio,N_dentro,N_fuori] = montecarlo(N_lanci)
% Inizializzo i risultati della funzione.
area_cerchio = []; N_dentro = []; N_fuori = [];

% Generiamo una freccetta mediante la funzione 'rand(n)'.
x = 2 * rand(1) - 1;
y = 2 * rand(1) - 1;
% Generiamo delle variabili che contino il numero di lanci effettuati
% e di quelli andati a buon fine.
if (N_lanci < 1)
    error();
end
contatore = 1;
successi = 0;

% Applichiamo il metodo Montecarlo al sistema in esame.
while (contatore <= N_lanci)
   if (x^2+y^2 < 1)
       successi = successi + 1;
       N_dentro = [N_dentro; [x y]];
   else
       N_fuori = [N_fuori; [x y]];
   end
   x = 2 * rand(1) - 1;
   y = 2 * rand(1) - 1;
   contatore = contatore + 1;   
end

% Stimiamo l'area del cerchio.
area_cerchio = (successi / N_lanci) * 4;
end