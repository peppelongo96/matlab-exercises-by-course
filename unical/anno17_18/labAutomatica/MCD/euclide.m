function mcd = euclide(a,b)
% Inizializzo l'argout alla variabile nulla.
mcd = [];

% Verifico che gli argin delle funzione siano due numeri naturali.
% Se si verifica un errore, l'output avrà l'ultimo valore assegnato.
if (floor(a) ~= a || floor(b) ~= b)
    error('Non hai inserito due numeri interi.');
elseif (a < 0 || b < 0)
    error('Non hai inserito due numeri naturali.');
end

% Creo delle variabili locali, facendo una castizzazione a intero.
dividendo = uint32(max([a b]));
divisore = uint32(min([a b]));
% Ottengo il resto della divisione mediante la funzione 'rem'.
resto = rem(dividendo,divisore);

% Applico l'algoritmo di Euclide mediante il ciclo while.
while(resto ~= 0)
    dividendo = divisore;
    divisore = resto;
    resto = rem(dividendo,divisore);
end

% Assegno alla variabile in output il valore finale.
mcd = divisore;
end