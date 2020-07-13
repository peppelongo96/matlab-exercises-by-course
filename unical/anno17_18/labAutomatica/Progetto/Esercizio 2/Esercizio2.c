/*  
 * 2 - DATO UN VETTORE NUMERICO, RESTITUIRE LA MEDIA ARITMETICA E LA DEVIAZIONE STANDARD.
 * NEL CASO DI IN CUI LA FUNZIONE VENGA CHIAMATA CON UN UNICO ARGOMENTO, RESTITUIRE SOLAMENTE LA MEDIA ARITMETICA.
 *
 */

#include "mex.h"
#include "math.h"

/* Macro che assegna i puntatori dei risultati */
#define MEDIA_ARIT_RIS plhs[0]
#define DEVIAZ_STD_RIS plhs[1]

/* Funzione che implementa la media aritmetica */
static void media_arit(double *risultato, double *vettore, int num_righe, int num_colonne) {
    int i,length;
    if (num_righe==1)
        length = num_colonne;
    else
        length = num_righe;
    for (i=0; i<length; i++) {
        *(risultato) = *(risultato) + *(vettore+i);
    }
    *(risultato) = *(risultato)/length;
    return;
}//media aritmetica

/* Funzione che implementa la deviazione standard */
static void deviaz_std(double *risultato, double *media_arit, double *vettore, int num_righe, int num_colonne) {
    double temp = 0.0;
    int i,length;
    if (num_righe==1)
        length = num_colonne;
    else
        length = num_righe;
    for (i=0; i<length; i++) {
        temp = temp + pow((*(vettore+i)-*(media_arit)),2);
    }
    *(risultato) = sqrt(temp/length);
    return;
}//deviazione standard

/* Funzione di interfacciamento con l'ambiente Matlab */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    // Puntatori locali agli argomenti della funzione e al risultato
    double *media_arit_ris, *deviaz_std_ris;
    double *vettore; 
    // Controllo su numero argomenti in uscita e in entrata
    if(nrhs != 1)
        mexErrMsgTxt("E' richiesto un vettore numerico come argomento.");
    if(nlhs > 2)
        mexErrMsgTxt("Lo script ritorna due soli risultati.");
    // Verifica sull'argomento in input, che deve essere un vettore
    mwSize num_righe = mxGetM(prhs[0]);
    mwSize num_colonne = mxGetN(prhs[0]);
    if (num_righe>1 && num_colonne>1)
        mexErrMsgTxt("L'argomento in input non può essere una matrice.");
    // Allocazione dei puntatori in uscita definiti nella macro iniziale
    MEDIA_ARIT_RIS = mxCreateDoubleMatrix(1,1,mxREAL);
    DEVIAZ_STD_RIS = mxCreateDoubleMatrix(1,1,mxREAL);
    // Le variabili locali in uscita vengono fatte puntare alle locazioni di memoria precedentemente definite
    media_arit_ris = mxGetPr(MEDIA_ARIT_RIS);
    deviaz_std_ris = mxGetPr(DEVIAZ_STD_RIS);
    // La variabile locale in entrata viene fatta puntare alla locazione di memoria in input
    vettore = mxGetPr(prhs[0]);
    // Esecuzione delle funzioni interne di media aritmetica e deviazione standard
    media_arit(media_arit_ris,vettore,num_righe,num_colonne);
    deviaz_std(deviaz_std_ris,media_arit_ris,vettore,num_righe,num_colonne);
    return;
}//mexFunction