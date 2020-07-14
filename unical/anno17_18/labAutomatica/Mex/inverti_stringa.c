/* 
 * inverti_stringa.c (inversione di una stringa)
 * Sintassi: stringa_out = inverti_stringa(stringa in)
 */
 
#include <mex.h>
#include <stdio.h>

void inverti(char *stringa_ingresso, int lunghezza, char *stringa_uscita) {
    int i;
    // Ciclo for per invertire la stringa.
    for(i = 0; i < lunghezza - 1; i++)
        //stringa_uscita[i] = stringa_ingresso[lunghezza - i - 2];
        *(stringa_uscita + i) = *(stringa_ingresso + lunghezza - i - 2);
}//inverti

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    char *input_buffer, *output_buffer;
    int lunghezza;
    // Ottieni la grandezza della stringa (non so se questa variabile è un 
    // vettore di caratteri 'riga' o di caratteri 'colonna').
    lunghezza = (mxGetM(prhs[0])*mxGetN(prhs[0])) + 1; // 1 tiene conto di \0
    
    // Alloco la memoria per la stringa in ingresso.
    input_buffer = mxCalloc(lunghezza,sizeof(char));
    // Alloco la memoria per la stringa in uscita.
    output_buffer = mxCalloc(lunghezza, sizeof(char));
    // Travaso della stringa in ingresso.
    mxGetString(prhs[0],input_buffer,lunghezza);
    
    // Chiamata del metodo locale.
    inverti(input_buffer, lunghezza, output_buffer);
    // Fai puntare la variabile plhs[0] all'indirizzo di output_buffer.
    plhs[0] = mxCreateString(output_buffer);
}//mexFunction