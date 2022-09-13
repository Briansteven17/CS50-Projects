#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <math.h>

int count_letters(string text);
float words = 1;
float sentence = 0;
int main(void)
{
    //request for text to be evaluated
    string text = get_string("Text: ");

    int grade = count_letters(text);

    if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (grade >= 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", grade);
    }
}

int count_letters(string text)
{
    float count = 0;
    int i = 0;

    //start to review the criteria
    while (text[i] != '\0')
    {
        if (isalpha(text[i]))
        {
            count++;
        }
        if (isspace(text[i]))
        {
            words++;
        }
        if (text[i] == '.' || text[i] == '?' || text[i] == '!')
        {
            sentence++;
        }

        i++;
    }
    //calculate letter and senctences based on current words
    float l = (count * 100) / words;
    float s = (sentence * 100) / words;

    //calculate the level of the text depending of the criteria
    float index = (0.0588 * l) - (0.296 * s) - 15.8;

    return round(index);

}


