// Implements a dictionary's functionality

#include <cs50.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// TODO: Choose number of buckets in hash table
const unsigned int N = 8788;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    node *check_word = table[hash(word)];

    while (check_word != NULL)
    {
        if (strcasecmp(check_word->word, word) == 0)
        {
            return true;
        }
        check_word = check_word->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    int word_size = strlen(word);
    int first_word = 0;
    int last_word = 0;


    if (islower(word[0]))
    {
        first_word = word[0] - 96;
    }
    else if (isupper(word[0]))
    {
        first_word = word[0] - 64;
    }

    if (islower(word[word_size - 1]))
    {
        last_word = word[word_size - 1] - 96;
    }
    else if (isupper(word[word_size - 1]))
    {
        last_word = word[word_size - 1] - 64;
    }


    if (word_size > 3 && word_size < 17)
    {
        return first_word * last_word * word_size;
    }
    else if (word_size > 16 || (word_size < 4 && word_size != 1))
    {
        return first_word * last_word;
    }
    else if (word_size == 1)
    {
        return first_word;
    }

    return 0;

}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO

    //Open dictionary FILE
    FILE *readw = fopen(dictionary, "r");
    if (readw == NULL)
    {
        printf("could not open dictionary\n");
        return false;
    }

    //Read words from the dictonary
    char wbyw[46];
    while (fscanf(readw, "%s", wbyw) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            return false;
        }
        strcpy(n->word, wbyw);
        n->next = table[hash(wbyw)];
        table[hash(wbyw)] = n;
        n = NULL;
    }

    fclose(readw);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    int total_words = 0;
    node *tmp = NULL;
    node *move = NULL;
    for (int i = 0; i < N; i++)
    {
        move = table[N - i];

        while (move != NULL)
        {
            tmp = move;
            move = tmp->next;
            total_words++;
        }
    }

    return total_words;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    node *tmp = NULL;
    node *move = NULL;
    for (int i = 0; i < N; i++)
    {
        move = table[N - i];

        while (move != NULL)
        {
            tmp = move;
            move = tmp->next;
            free(tmp);
        }
    }

    return true;
}
