/*
 *  Sintassi: [sequenza, zero] = bisezmex(f, a, b, tol)
 *  tol è un parametro in ingresso opzionale, se non presente tol = 1e-3.
 */

#include "mex.h"
#include "math.h"

#define SEQUENZA    plhs[0]
#define ZERO        plhs[1]

#define FUNZIONE    prhs[0]
#define A           prhs[1]
#define B           prhs[2]
#define TOL         prhs[3]

#define MAXITER     100

#if !defined(MAX)
#define MAX(A,B)    ((A) > (B) ? (A) : (B))
#endif

#if !defined(MIN)
#define MIN(A,B)    ((A) < (B) ? (A) : (B))
#endif

/* Metodo locale che implementa il metodo di bisezione */
void calcolazero (double *sequenza, 
                  double *zero,
                  int *lunghezza,
                  mxArray *f,
                  double a,
                  double b,
                  double tol) {
    // Indice necessario per l'iterazione.
    int i;
    // Puntatori alle variabili all'interno della feval.
    mxArray *args[2]; mxArray *y[1];
    // Variabili necessarie per i passi dell'algoritmo.
    double *x;
    double xl, xr;
    double fl, fr, fm;
    // Inizializzazione delle variabili per la feval.
    args[0] = (mxArray *) f;
    args[1] = mxCreateDoubleMatrix(1,1,mxREAL);
    x = mxGetPr(args[1]);
    // Calcolo dei primi valori per la bisezione.
    xl = MIN(a,b); xr = MAX(a,b);
    *x = xl; mexCallMATLAB(1,y,2,args,"feval");
    fl = (double) mxGetScalar(*y);
    *x = xr; mexCallMATLAB(1,y,2,args,"feval");
    fr = (double) mxGetScalar(*y);
    // Il valore della funzione nei due punti deve essere discorde.
    if(fl*fr > 0) {
        *lunghezza = 0; return;
    }   
    // Applichiamo le iterazioni di bisezione.
    while(fabs(xr - xl) > tol && i < MAXITER) {
        //
        *x = (xr + xl)/2; 
        *(sequenza + i) = *x;
        //
        mexCallMATLAB(1,y,2,args,"feval");
        fm = (double) mxGetScalar(*y);
        //
        if(fl*fm > 0) {
            xl = *x; fl = fm;
        } else {
            xr = *x; fr = fm;
        }
        //
        lunghezza[0]++;
        i = i + 1;
    }
    // Forniamo la soluzione finale.
    *zero = (xr + xl)/2;
}//calcolazero

/* Metodo di interfacciamento con Matlab */
void mexFunction (int nlhs,
                  mxArray *plhs[],
                  int nrhs,
                  const mxArray *prhs[]) {
    // Creo i puntatori alle variabili. 
    double *a, *b, *tol, *seq, *zero;
    mxArray *f = (mxArray *) FUNZIONE;
    double *seq_finale, *zero_finale;
    int m_a, n_a, m_b, n_b;
    int i, *lunghezza;
    // Verifico quanti siano gli argomenti in ingresso.
    if(nrhs == 3) {
        tol = (double *) mxCalloc(1,sizeof(double));
        *tol = 1e-3;
    } else
        tol = mxGetPr(TOL);
    // Controllo e prelevo gli estremi dell'intervallo.
    m_a = mxGetM(A); n_a = mxGetN(A);
    m_b = mxGetM(B); n_b = mxGetN(B);
    if(m_a != 1 || m_b != 1 || n_a != 1 || n_b != 1)
        mexErrMsgTxt("Gli estremi devono essere scalari.");
    a = mxGetPr(A);
    b = mxGetPr(B);
    // Alloco le aree dati per le uscite. Bisogna fare attenzione alla 
    // dimensione del vettore sequenza, non noto a priori.
    seq = (double *) calloc(MAXITER, sizeof(double));
    zero = (double *) calloc(1, sizeof(double));
    lunghezza = (int *) calloc(1, sizeof(int));
    // Invoco il metodo locale.
    calcolazero(seq,zero,lunghezza,f,a[0],b[0],tol[0]);
    // Collego i puntatori al risultato.
    if(*lunghezza != 0) {
        SEQUENZA = mxCreateDoubleMatrix(lunghezza[0],1,mxREAL);
        ZERO = mxCreateDoubleMatrix(1,1,mxREAL);
        // Fai puntare seq_finale e zero_finale ai risultati.
        seq_finale = mxGetPr(SEQUENZA);
        zero_finale = mxGetPr(ZERO);
        *zero_finale = *zero;
        for(i = 0; i < *lunghezza; i++)
            *(seq_finale + i) = *(seq + i);
    } else {
        SEQUENZA = mxCreateDoubleMatrix(1,1,mxREAL);
        ZERO = mxCreateDoubleMatrix(1,1,mxREAL);
        // Fai puntare seq_finale e zero_finale ai risultati.
        seq_finale = mxGetPr(SEQUENZA);
        zero_finale = mxGetPr(ZERO);
        *seq_finale = mxGetNaN();
        *zero_finale = mxGetNaN();
    }
    return;     
}//mexFunction