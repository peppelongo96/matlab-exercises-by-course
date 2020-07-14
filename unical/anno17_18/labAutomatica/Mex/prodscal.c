/*
 *  Sintassi: risultato = prodscal(v1,v2)
 *  Metodo che effettua il prodotto scalare tra due vettori.
 */

#include "mex.h"

#define V1  prhs[0]
#define V2  prhs[1]
#define RIS plhs[0]

/* Metodo locale per il calcolo del prodotto scalare */
void prodottoScalare (double *ris,
                      double *vet1,
                      double *vet2,
                      int length) {
    double temp = 0.0;
    int i;
    for(i = 0; i < length; i++)
        temp = temp + (*(vet1 + i))*(*(vet2 + i));
    *ris = temp;
}//prodottoScalare

/* Metodo di interfacciamento con MatLab */
void mexFunction (int nlhs, 
                  mxArray *plhs[], 
                  int nrhs,
                  const mxArray *prhs[]) {
    double *ris, *v1, *v2;
    // Controllo sulle dimensioni dei vettori.    
    int m_1, n_1, m_2, n_2;
    m_1 = mxGetM(V1); n_1 = mxGetN(V1);
    m_2 = mxGetM(V2); n_2 = mxGetN(V2);
    if(m_1 != m_2 || n_1 != 1 || n_2 != 1)
        mexErrMsgTxt("I vettori devono essere in colonna e della stessa dimensione!");
    // Assegnamento dei puntatori ai vettori.
    v1 = mxGetPr(V1);
    v2 = mxGetPr(V2);
    // Creazione della locazione del risultato.
    RIS = mxCreateDoubleMatrix(1,1,mxREAL);
    ris = mxGetPr(RIS);
    // Chiamo il metodo locale.
    prodottoScalare(ris,v1,v2,m_1);
}//mexFunction