/* 
 * prodmat.c (prodotto tra due matrici di double)
 * Sintassi: C = prodmat(A,B)
 */
 
#include "mex.h"

/* Macro che assegna il puntatore del risultato */

#define PRODOTTO plhs[0]

/* Macro che assegna il puntatore degli argomenti */

#define A prhs[0]
#define B prhs[1]

/* Metodo locale che implementa il prodotto tra matrici */

void prodotto(double *c, 
              double *a, 
              double *b, 
              int righe_a, 
              int colonne_a,
              int righe_b,
              int colonne_b)
{
    int i, j, k;
    double temp = 0.0;
    
    for(j = 0; j < colonne_b; j++)
        for(i = 0; i < righe_a; i++) {
            for (k = 0; k < colonne_a; k++)
                temp += (*(a+i+righe_a*k))*(*(b+k+righe_b*i));
            *(c+i+righe_a*j) = temp;
            temp = 0.0;
        }
    return;
}//prodotto

/* Metodo di interfaccia con Matlab */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    // Puntatori locali al risultato degli argomenti
    double *a, *b, *c;
    // Numero di righe e colonne degli argomenti
    int n_righeA, n_colonneA, n_righeB, n_colonneB;
    // Check sulla correttezza del numero di argomenti in ingresso
    if(nrhs != 2)
        mexErrMsgTxt("Sono richiesti due argomenti in ingresso");
    if(nlhs > 1)
        mexErrMsgTxt("Al più un risultato!");
    // Verifica di correttezza sulla cardinalità delle matrice A e B
    n_righeA = mxGetM(A);
    n_colonneA = mxGetN(A);
    n_righeB = mxGetM(B);
    n_colonneB = mxGetN(B);
    if(n_colonneA != n_righeB)
        mexErrMsgTxt("Hai inserito due matrici non conformi al prodotto");
    // Alloca la cella di memoria per il risultato
    PRODOTTO = mxCreateDoubleMatrix(n_righeA,n_colonneB,mxREAL);
    // Assegna i puntatori locali alla locazioni di memoria degli argomenti 
    // e dei risultati
    a = mxGetPr(A);
    b = mxGetPr(B);
    c = mxGetPr(PRODOTTO);
    // Calcolo il prodotto con il metodo locale
    prodotto(c,a,b,n_righeA,n_colonneA,n_righeB,n_colonneB);
    return;
}//mexFunction