#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

const int BLOCK = 512;

int main(int argc, char *argv[])
{
    //open card.raw file with argv
    FILE *card = fopen(argv[1], "r");
    if (card == NULL || argc != 2)
    {
        //in case of NULL print usage and return 1
        printf("Usage: ./recover IMAGE\n");

        return 1;
    }

    uint8_t buffer[512];
    FILE *recovery ;
    char *FILENAME = (char *)malloc(sizeof(char) * 8);
    int i = 0;

    while (fread(buffer, 1, BLOCK, card) == BLOCK)
    {
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
            {
                sprintf(FILENAME, "%03i.jpg", i);
                recovery = fopen(FILENAME, "w");

                fwrite(buffer, BLOCK, 1, recovery);
                i++;
            }
            else
            {
                fclose(recovery);
            }
        }
        else
        {
            if (i > 0)
            {
                fwrite(buffer, BLOCK, 1, recovery);
            }
        }
    }
    fclose(card);
    fclose(recovery);
    free(FILENAME);
}