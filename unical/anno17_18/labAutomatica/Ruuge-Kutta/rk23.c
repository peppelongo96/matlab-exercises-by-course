/*
 *  Sintassi: [t, x] = rg23 (@funzione_generatrice, [t0 tf], x0, h)
 */

#include "mex.h"
#include "stdlib.h"
#include "math.h"

#define FUN_GEN prhs[0]
#define T_SPAN  prhs[1]
#define X0      prhs[2]
#define H       prhs[3]

#define T_OUT   plhs[0]
#define X_OUT   plhs[1]

void rungekutta23 (double *t, double *x, mxArray *funGen, double t0, 
                   double tf, double *x0, int nstati, double h) {
    // Vettori di Runge-Kutta
    double *k1, *k2, *k3, *k4, *ktemp;
    double *tact, *xact, *xprec, tcorr;
    // La chiamata è ris = feval(@f,t,x)
    mxArray *ris[1]; mxArray *args[3];
    int i = 0;
    // Inizializzo alcune variabili.
    tcorr = t0;
    xprec = (double *) calloc(nstati, sizeof(double));
    for(j = 0; j < nstati; j++)
        xprec[j] = x0[j];
    // Assegno le variabili in ingresso alla funzione.
    args[0] = (mxArray *) funGen;
    args[1] = mxCreateDoubleMatrix(1,1,mxREAL);
    args[2] = mxCreateDoubleMatrix(nstati,1,mxREAL);
    ris[0] = mxCreateDoubleMatix(nstati,1,mxREAL);
    
    tact = mxGetPr(args[1]);
    tact[0] = tcorr;
    
    xact = mxGetPr(args[2]);
    for(j = 0; j < nstati; j++)
        xact[j] = x0[j];
    
    // Assegno le variabili in uscita alla funzione.
    t[i] = t0;
    for(j = 0; j < nstati; j++)
        x[j + nstati*i] = x0[j];
    
    k1 = (double *) calloc(nstati, sizeof(double));
    k2 = (double *) calloc(nstati, sizeof(double));
    k3 = (double *) calloc(nstati, sizeof(double));
    k4 = (double *) calloc(nstati, sizeof(double));
    
    ktemp = mxGetPr(ris[0]);
    
    while((t0 + i*h) < tf) {
        // Calcolo k1 = f(t_k,x_k).
        mexCallMATLAB(1, ris, 3, (mxArray **) args, "feval");
        // Faccio puntare il risultato.
        for(j = 0; j <nstati; j++)
            k1[j] = ktemp[j];
        
        // Calcolo k2 = f(t_k + h/2, x_k +(h/2)*k1)
        tact[0] = tcorr + h/2;
        for(j = 0; j < nstati; j++)
            xact[j] = xprec[j] + (h/2) * k1[j];
        mexCallMATLAB(1, ris, 3, (mxArray **) args, "feval");
        // Faccio puntare il risultato.
        for(j = 0; j <nstati; j++)
            k2[j] = ktemp[j];
        
        // Calcolo k3 = f(t_k + h/2, x_k +(h/2)*k2)
        for(j = 0; j < nstati; j++)
            xact[j] = xprec[j] + (h/2) * k2[j];
        mexCallMATLAB(1, ris, 3, (mxArray **) args, "feval");
        // Faccio puntare il risultato.
        for(j = 0; j <nstati; j++)
            k3[j] = ktemp[j];
        
        // Calcolo k4 = f(t_k + h, x_k + h*k3)
        tact[0] = tcorr + h;
        for(j = 0; j < nstati; j++)
            xact[j] = xprec[j] + h * k3[j];
        mexCallMATLAB(1, ris, 3, (mxArray **) args, "feval");
        // Faccio puntare il risultato.
        for(j = 0; j <nstati; j++)
            k4[j] = ktemp[j];
        
        // 
        i = i + 1;
        for(j = 0; j < nstati; j++)
            x[j + nstati*i] = xprec[j] + h/6*(k1[j] + 2*k2[j] + 2*k3[j] + k4[j]);
        
        // Riassegno xprec.
        for(j = 0; j < nstati; j++) {
            xprec[j] = x[j + nstati*i];
            xact[j] = xprec[j];
        }
        tact[0] = tcorr;
    }
}//rougekutta23

void mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
   // Variabili e puntatori "locali" utilizzati da C.
   double *x0, t0, tf, h, *time, *x, *t;
   mxArray *arg = (mxArray *) FUN_GEN;
   int npassi, nstati;
   // Ottengo il numero di stati del modello.
   nstati = mxGetM(X0);
   if(mxGetN(X0) != 1)
       mexErrMsgTxt("Le condizioni iniziali devono essere un vettore colonna!");
   // Inizializzo le variabili create.
   x0 = mxGetPr(X0);
   h = (double) mxGetScalar(H);
   time = mxGetPr(T_SPAN);
   t0 = time[0];
   tf = time[1];
   npassi = (int) (floor((tf-t0)/h)) + 1;
   // Allocazione dei risultati.
   T_OUT = mxCreateDoubleMatrix(1, npassi, mxREAL);
   X_OUT = mxCreateDoubleMatrix(nstati, npassi, mxREAL);
   t = mxGetPr(T_OUT);
   x = mxGetPr(X_OUT);
   // Chiamo il metodo locale.
   rungekutta23(t, x, arg, t0, tf, x0, nstati, h);
}//mexFunction    