/* 
 * mcd.c (MCD con il metodo di Euclide)
 * Sintassi: ris = mcd(a,b)
 */
 
#include "mex.h"

/* Macro per avere gli indirizzi degli argomenti in ingresso  e del 
 * risultato */
#define A_IN prhs[0]
#define B_IN prhs[1]
#define MCD_OUT plhs[0]

#if !defined(MAX)
#define MAX(A, B) ((A) > (B)? (A) : (B))
#endif

/* Metodo che implementa l'algoritmo di Euclide (e che risulta essere 
 * separato dal metodo di interfacciamento con Matlab) */
void gcd(double *a, double *b, double *ris) {
    int dividendo, divisore, resto;
    // Verifica che a e b siano positivi.
    if(a[0] <= 0 || b[0] <= 0)
        mexErrMsgTxt('I numeri devono essere positivi!');
    // Assegna dividendo e divisore iniziale.
    if(a[0] > b[0]) {
        dividendo = (int) a[0]; divisore = (int) b[0];
    } else {
        dividendo = (int) b[0]; divisore = (int) a[0];
    }
    // Calcolo il primo resto.
    resto = dividendo % divisore;
    // Esegui le eventuali iterazioni dell'algoritmo.
    while (resto != 0) {
        dividendo = divisore;
        divisore = resto;
        resto = dividendo % divisore;
    }
    // Assegna il risultato.
    *ris = (double) divisore;
    return;
}//gcd

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    // Puntatori locali.
    double *res, *a, *b;
    // Verifichiamo che a e b siano scalari.
    mwSize m_a, n_a, m_b, n_b;
    m_a = mxGetM(A_IN); n_a = mxGetN(A_IN);
    m_b = mxGetM(B_IN); n_b = mxGetN(B_IN);
    if(MAX(m_a,m_b) >= 1 || MAX(n_a,n_b) >= 1 || mxIsComplex(A_IN) || 
       mxIsComplex(B_IN) || !mxIsDouble(A_IN) || !mxIsDouble(B_IN))
        mexErrMsgTxt('In ingresso due numeri scalari!');
    // Genera il risultato della funzione mex.
    MCD_OUT = mxCreateDoubleMatrix(1,1,mxREAL);
    // Carica le locazioni di memoria degli argomenti e del risultato nei
    // puntatori.
    a = mxGetPr(A_IN); b = mxGetPr(B_IN); res = mxGetPr(MCD_OUT);
    // Invoca il metodo locale.
    gcd(a,b,res);
    return;
}//mexFunction