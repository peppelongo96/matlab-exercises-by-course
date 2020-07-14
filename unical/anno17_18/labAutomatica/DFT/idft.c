/*
 *  Sintassi: f = idft(F)
 *  Ottenere la trasformata inversa di Fourier veloce a partire da uno spettro.
 */

#include <mex.h>
#include <math.h>

#define PI atan2(1,1)*4

/* Metodo per calcolare la IDFT dellao spettro, spacchettando il calcolo
 * nella parte reale e nella parte immaginaria. */

void calcoladft (double seq_r[],
                 double seq_i[],
                 double spettro_r[], 
                 double spettro_i[],
                 int N) {
    // Accumulatori e indici di somma per la parte reale e immaginaria.
    double temp_r, temp_i;
    int i,k;
    for(i = 0; i < N; i++) { // Indice della componente spettrale
        temp_r = 0.0; temp_i = 0.0;
        for(k = 0; k < N; k++) { // Indice temporale
            temp_r += *(spettro_r + k)*cos((2*PI/N)*k*i) - *(spettro_i + k)*sin((2*PI/N)*k*i);
            temp_i += *(spettro_r + k)*sin((2*PI/N)*k*i) + *(spettro_i + k)*cos((2*PI/N)*k*i);
        }
        *(seq_r + i) = temp_r / N;
        *(seq_i + i) = temp_i / N;
    }
    return;
}//calcoladft

/* Metodo di interfacciamento con Matlab. */

void mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double *idft_r, *idft_i, *spettro_r, * spettro_i;
    // Controllo vettore in ingresso.
    mwSize righe_spettro, colonne_spettro;
    righe_spettro = mxGetM(prhs[0]); colonne_spettro = mxGetN(prhs[0]);
    if(righe_spettro != 1)
        mexErrMsgTxt("Lo spettro deve essere un vettore riga.");
    spettro_r = mxGetPr(prhs[0]);
    if(mxIsComplex(prhs[0]))
        spettro_i = mxGetPi(prhs[0]);
    else
        spettro_i = (double *) calloc((int) colonne_spettro, sizeof(double));
    // Alloco la porzione di spazio in output.
    plhs[0] = mxCreateDoubleMatrix(1,(int) colonne_spettro,mxCOMPLEX);
    idft_r = mxGetPr(plhs[0]); idft_i = mxGetPi(plhs[0]);
    // Invoco il metodo locale.
    calcoladft(idft_r,idft_i,spettro_r,spettro_i,(int)colonne_spettro);
}//mexFunction