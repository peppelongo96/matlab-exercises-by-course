#include "mex.h";

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    // Puntatore al risultato restituito da Matlab.
    mxArray **risultato;
    // Puntatore al risultato effettivo.
    double *result;
    // Puntatore intermedio.
    double *finale;
    
    // Chiamata della funzione feval(f,x).
    mexCallMATLAB(1,risultato,2,prhs,"feval"); //0, null se senza output
    // Scarico il risultato.
    result = mxGetPr(risultato[0]);
    // Creo il puntatore in uscita.
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
    // Copio il valore sull'uscita.
    finale = mxGetPr(plhs[0]);
    finale[0] = result[0];
}//mexFunction