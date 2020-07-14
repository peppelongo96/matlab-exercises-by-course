function varargout = bisez(f,xi,xs,varargin)
if (nargin == 3)
    tolleranza = 1e-2;
else
    tolleranza = varargin{1};
end

zero = [];
seq_medi = [];

% Verifico che i due estremi dell'intervallo siano discordi.
if (f(xi)*f(xs) > 0)
   error('La funzione ha segno concorde agli estremi dell''intervallo');
end

% Calcolo il punto medio dell'intervallo.
xmedio = (xi + xs) / 2;
xsinistro = xi;
xdestro = xs;

% Applico l'algoritmo di bisezione mediante il ciclo while.
while(abs(xdestro - xsinistro) > tolleranza)
   if(f(xmedio)*f(xdestro) > 0)
       xdestro = xmedio;
   else
       xsinistro = xmedio;
   end
   xmedio = (xsinistro + xdestro) / 2;
   seq_medi = [seq_medi; xmedio];
end

% Assegno il valore finale alla variabile di output.
zero = xmedio;
varargout{1} = zero;
if(nargout > 1)
    varargout{2} = seq_medi;
end
end