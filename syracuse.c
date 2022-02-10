#include <stdio.h>
#include <stdlib.h>

//on va devoir retourner le minimum et le maximum

int main(int argc, char **argv){

    int dureealtitude=0;
    int altimax=0;
    int dureealtituddemax=0;
    
    char *nom_fichier= argv[2];
    char *nb_fichier= argv[1];

    altimax=atoi(nb_fichier);

    FILE* fichier = fopen(nom_fichier,"w+");


    if(argv[1]<0){
        return EXIT_FAILURE;
    }
    long Un = atoi(argv[1]); 
    int i;// pour savoir on est à combien d'occurence de la fonction main
    i=0;
    fprintf(fichier,"n Un\n");// ecriture dans le fichier
    fprintf(fichier,"%d %ld\n", i,Un);
    i=1;
    while(Un!=1){
        if(Un%2==0){
            Un=Un/2;
            fprintf(fichier,"%d %ld\n", i ,Un );
        }
        else{
            Un=Un*3+1;
            fprintf(fichier,"%d %ld\n", i ,Un);
        }
        i=i+1;
        if(altimax<Un){
            altimax=Un;
        }

        if(Un>=atoi(argv[1])){//on incrémente quand on est au dessus de U0
            dureealtitude++;  
        }
        else{
            if(dureealtituddemax<dureealtitude){
                dureealtituddemax=dureealtitude;
                }
        dureealtitude=0;
        }


    }//on est doit avoir les Un et n en tableaux Un||n
    fprintf(fichier, "dureevol= %d\n", i-1);
    fprintf(fichier, "altimax= %d\n", altimax);
    fprintf(fichier, "dureealtitude= %d\n",dureealtituddemax);
    fclose(fichier);
    return 0;
}
