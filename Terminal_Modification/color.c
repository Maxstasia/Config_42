#include <stdio.h>

int main(void)
{
    // Couleurs de texte (basique)
    printf("\n=== Couleurs de texte (basique) ===\n");
    printf("\033[30mNoir\033[0m\n");
    printf("\033[31mRouge\033[0m\n");
    printf("\033[32mVert\033[0m\n");
    printf("\033[33mJaune\033[0m\n");
    printf("\033[34mBleu\033[0m\n");
    printf("\033[35mMagenta\033[0m\n");
    printf("\033[36mCyan\033[0m\n");
    printf("\033[37mBlanc\033[0m\n");

    // Couleurs de texte (haute intensité)
    printf("\n=== Couleurs de texte (haute intensité) ===\n");
    printf("\033[90mGris foncé\033[0m\n");
    printf("\033[91mRouge clair\033[0m\n");
    printf("\033[92mVert clair\033[0m\n");
    printf("\033[93mJaune clair\033[0m\n");
    printf("\033[94mBleu clair\033[0m\n");
    printf("\033[95mMagenta clair\033[0m\n");
    printf("\033[96mCyan clair\033[0m\n");
    printf("\033[97mBlanc vif\033[0m\n");

    // Couleurs d'arrière-plan (basique)
    printf("\n=== Couleurs d'arrière-plan (basique) ===\n");
    printf("\033[40mNoir\033[0m\n");
    printf("\033[41mRouge\033[0m\n");
    printf("\033[42mVert\033[0m\n");
    printf("\033[43mJaune\033[0m\n");
    printf("\033[44mBleu\033[0m\n");
    printf("\033[45mMagenta\033[0m\n");
    printf("\033[46mCyan\033[0m\n");
    printf("\033[47mBlanc\033[0m\n");

    // Couleurs d'arrière-plan (haute intensité)
    printf("\n=== Couleurs d'arrière-plan (haute intensité) ===\n");
    printf("\033[100mGris foncé\033[0m\n");
    printf("\033[101mRouge clair\033[0m\n");
    printf("\033[102mVert clair\033[0m\n");
    printf("\033[103mJaune clair\033[0m\n");
    printf("\033[104mBleu clair\033[0m\n");
    printf("\033[105mMagenta clair\033[0m\n");
    printf("\033[106mCyan clair\033[0m\n");
    printf("\033[107mBlanc vif\033[0m\n");

    // Exemple avec gras
    printf("\n=== Exemple avec texte gras ===\n");
    printf("\033[1;31mRouge gras\033[0m\n");
    printf("\033[1;94mBleu clair gras\033[0m\n");
    printf("\033[1;95mMagenta clair gras\033[0m\n");

    return (0);
}
