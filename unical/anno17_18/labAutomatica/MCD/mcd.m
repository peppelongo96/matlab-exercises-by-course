a = input('Immetti il valore a: ');
b = input('Immetti il valore b: ');

ris = euclide(a,b);

if (ris ~= [])
    fprintf('Il massimo comun divisore � %d\n',ris);
end