#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <cs50.h>
#include <string.h>

int main(int argc, string argv[])
{
    int n;
    float table[46];
    for (int i = 0; i < 46; i++)
    {
        table[i] = 0;
    }

    FILE *readw = fopen(argv[1], "r");

    char wbyw[46];
    while(fscanf(readw, "%s", wbyw) != EOF)
    {
        n = strlen(wbyw);
        table[strlen(wbyw)]++;
    }

    for (int i = 0; i < 46; i++)
    {
        printf("%i: %f\n", i, (table[i]*100)/143091);
    }
    float sum = 0;
    for (int i = 4; 16 >= i; i++)
    {
        sum = table[i] + sum;
        printf("%i\n", i);
    }
    printf("Total percentage words from 4 to 16 letters: %f\n", (sum*100)/143091);


}