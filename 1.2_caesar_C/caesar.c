#include <cs50.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>


bool only_digits(string s);
char rotate(char c, int n);
int main(int argc, string argv[])
{
    if (argc == 1 || argc > 2)
    {
        printf("Usage: ./caesar key\n");

        return 1;
    }

    bool check = only_digits(argv[1]);
    {
        if (check == false)
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }

    }

    int r = atoi(argv[1]);
    string text = get_string("plaintext: ");

    //start to code the text word by word
    printf("ciphertext: ");
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        if (islower(text[i]))
        {
            int l = (text[i] + r - 96) % 26 + 96;
            printf("%c", l);
        }
        else if (isupper(text[i]))
        {
            int l = (text[i] + r - 64) % 26 + 64;
            printf("%c", l);
        }
        else
        {
            printf("%c", text[i]);
        }
    }
    printf("\n");
}

bool only_digits(string s)
{
    int i = 0;
    while (isdigit(s[i]))
    {
        i++;
    }

    int n = strlen(s);
    if (n == i)
    {
        return true;
    }
    else
    {
        return false;
    }
}




