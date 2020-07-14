/*
 *  Sintassi: F = dft(f)
 *  Ottenere la trasformata di Fourier veloce a partire da una sequenza.
 */

#include <mex.h>
#include <math.h>

#define PI atan2(1,1)*4

/* Metodo per calcolare la DFT della sequenza, spacchettando il calcolo
 * nella parte reale e nella parte immaginaria. */

void calcoladft (double spettro_r[], 
                 double spettro_i[],
                 double seq_r[],
                 double seq_i[],
                 int N) {
    // Accumulatori e indici di somma per la parte reale e immaginaria.
    double temp_r, temp_i;
    int i,k;
    for(i = 0; i < N; i++) { // Indice della componente spettrale
        temp_r = 0.0; temp_i = 0.0;
        for(k = 0; k < N; k++) { // Indice temporale
            temp_r += *(seq_r + k)*cos((2*PI/N)*k*i) + *(seq_i + k)*sin((2*PI/N)*k*i);
            temp_i += -*(seq_r + k)*sin((2*PI/N)*k*i) + *(seq_i + k)*cos((2*PI/N)*k*i);
        }
        *(spettro_r + i) = temp_r;
        *(spettro_i + i) = temp_i;
    }
    return;
}//calcoladft

/* Metodo di interfacciamento con Matlab. */

void mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double *dft_r, *dft_i, *sequenza_r, * sequenza_i;
    // Controllo vettore in ingresso.
    mwSize righe_sequenza, colonne_sequenza;
    righe_sequenza = mxGetM(prhs[0]); colonne_sequenza = mxGetN(prhs[0]);
    if(righe_sequenza != 1)
        mexErrMsgTxt("La sequenza deve essere un vettore riga.");
    sequenza_r = mxGetPr(prhs[0]);
    if(mxIsComplex(prhs[0]))
        sequenza_i = mxGetPi(prhs[0]);
    else
        sequenza_i = (double *) calloc((int) colonne_sequenza, sizeof(double));
    // Alloco la porzione di spazio in output.
    plhs[0] = mxCreateDoubleMatrix(1,(int) colonne_sequenza,mxCOMPLEX);
    dft_r = mxGetPr(plhs[0]); dft_i = mxGetPi(plhs[0]);
    // Invoco il metodo locale.
    calcoladft(dft_r,dft_i,sequenza_r,sequenza_i,(int)colonne_sequenza);
}//mexFunction