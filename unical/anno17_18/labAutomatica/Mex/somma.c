/* 
 * somma.c (sommo due numeri interi)
 * Sintassi: y = somma(a,b)
 */

#include "mex.h"

/* Macro che aggancia il puntatore del risultato */

#define RES_OUT plhs[0]

/* Funzione che implementa la somma */

static void sum(double risultato[], double a[], double b[]) {
    int addendo1, addendo2;
    int ris;
    
    addendo1 = (int) a[0];
    addendo2 = (int) b[0];
    if((a[0]-(double)addendo1) != 0 ||(b[0]-(double)addendo2) != 0)
        mexErrMsgTxt("Gli argomenti in ingresso devono essere interi!");
    ris = addendo1 + addendo2;
    risultato[0] = (double) ris;
}//sum

/* Funzione di interfacciamento con l'ambiente Matlab */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    // Puntatori locali agli argomenti della funzione ed il risultato
    double *result;
    double *a, *b;
    // Variabili che dimensionano gli argomenti in ingresso alla funzione
    mwSize m_a,n_a,m_b,n_b;
    // Verifichiamo che il numero di argomenti in ingresso e in uscita sia corretto
    if(nrhs != 2)
        mexErrMsgTxt("Gli argomenti in ingresso della funzione somma.c sono due!");
    else if(nlhs > 1)
        mexErrMsgTxt("Viene restituito un solo risultato!");
    // Verifichiamo che a e b siano scalari
    m_a = mxGetM(prhs[0]);
    n_a = mxGetN(prhs[0]);
    m_b = mxGetM(prhs[1]);
    n_b = mxGetN(prhs[1]);
    if(m_a != 1 || n_a != 1 || m_b != 1 || n_b != 1)
        mexErrMsgTxt("Gli argomenti devono essere due scalari!");
    // Alloca il puntatore in uscita della funzione somma.c
    RES_OUT = mxCreateDoubleMatrix(1,1,mxREAL);
    // Fai puntare la variabile result alla locazione di memoria generata
    // dall'istruzione precedente
    result = mxGetPr(RES_OUT);
    // Esegui la stessa operazione per gli argomenti in ingresso
    a = mxGetPr(prhs[0]);
    b = mxGetPr(prhs[1]);
    // Svolgi la somma mediante il metodo scritto sopra
    sum(result,a,b);
    return;
}//mexFunction