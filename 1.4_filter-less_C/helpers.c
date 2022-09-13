#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    float avg;
    for (int i = 0; i < height; i++)
    {
        for (int n = 0; n < width; n++)
        {
            avg = (image[i][n].rgbtRed + image[i][n].rgbtGreen + image[i][n].rgbtBlue) / 3.0;

            image[i][n].rgbtRed = round(avg);
            image[i][n].rgbtGreen = round(avg);
            image[i][n].rgbtBlue = round(avg);
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    //declare sepia of each RGB
    float Sr, Sg, Sb;
    for (int i = 0; i < height; i++)
    {
        for (int n = 0; n < width; n++)
        {
            Sr = .393 * image[i][n].rgbtRed + .769 * image[i][n].rgbtGreen + .189 * image[i][n].rgbtBlue;
            Sg = .349 * image[i][n].rgbtRed + .686 * image[i][n].rgbtGreen + .168 * image[i][n].rgbtBlue;
            Sb = .272 * image[i][n].rgbtRed + .534 * image[i][n].rgbtGreen + .131 * image[i][n].rgbtBlue;

            if (Sr > 255)
            {
                Sr = 255;
            }
            if (Sg > 255)
            {
                Sg = 255;
            }
            if (Sb > 255)
            {
                Sb = 255;
            }

            image[i][n].rgbtRed = round(Sr);
            image[i][n].rgbtGreen = round(Sg);
            image[i][n].rgbtBlue = round(Sb);
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    //declare temp of each RGB
    int tempR[height][width];
    int tempG[height][width];
    int tempB[height][width];
    width--;
    for (int i = 0; i < height; i++)
    {
        //reflect half of the image
        for (int n = 0; n < (width + 1) / 2; n++)
        {
            tempR[i][n] = image[i][n].rgbtRed;
            tempG[i][n] = image[i][n].rgbtGreen;
            tempB[i][n] = image[i][n].rgbtBlue;

            image[i][n].rgbtRed = image[i][width - n].rgbtRed;
            image[i][n].rgbtGreen = image[i][width - n].rgbtGreen;
            image[i][n].rgbtBlue = image[i][width - n].rgbtBlue;

            image[i][width - n].rgbtRed = tempR[i][n];
            image[i][width - n].rgbtGreen = tempG[i][n];
            image[i][width - n].rgbtBlue = tempB[i][n];
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    float tempR[height][width];
    float tempG[height][width];
    float tempB[height][width];
    int limit_height = height - 1;
    int limit_width = width - 1;
    for (int i = 0; i < height; i++)
    {
        for (int n = 0; n < width; n++)
        {
            //check everything different from corners and sides
            if (i > 0 && i < limit_height && n > 0 && n < limit_width)
            {
                tempR[i][n] = (image[i - 1][n - 1].rgbtRed + image[i - 1][n].rgbtRed + image[i - 1][n + 1].rgbtRed +
                               image[i][n - 1].rgbtRed + image[i][n].rgbtRed + image[i][n + 1].rgbtRed +
                               image[i + 1][n - 1].rgbtRed + image[i + 1][n].rgbtRed + image[i + 1][n + 1].rgbtRed) / 9.0;
                tempG[i][n] = (image[i - 1][n - 1].rgbtGreen + image[i - 1][n].rgbtGreen + image[i - 1][n + 1].rgbtGreen +
                               image[i][n - 1].rgbtGreen + image[i][n].rgbtGreen + image[i][n + 1].rgbtGreen +
                               image[i + 1][n - 1].rgbtGreen + image[i + 1][n].rgbtGreen + image[i + 1][n + 1].rgbtGreen) / 9.0;
                tempB[i][n] = (image[i - 1][n - 1].rgbtBlue + image[i - 1][n].rgbtBlue + image[i - 1][n + 1].rgbtBlue +
                               image[i][n - 1].rgbtBlue + image[i][n].rgbtBlue + image[i][n + 1].rgbtBlue +
                               image[i + 1][n - 1].rgbtBlue + image[i + 1][n].rgbtBlue + image[i + 1][n + 1].rgbtBlue) / 9.0;
            }

            //check onde side
            if (i == 0 && n != 0 && n != limit_width)
            {
                tempR[i][n] = (image[i][n - 1].rgbtRed + image[i][n].rgbtRed + image[i][n + 1].rgbtRed +
                               image[i + 1][n - 1].rgbtRed + image[i + 1][n].rgbtRed + image[i + 1][n + 1].rgbtRed) / 6.0;
                tempG[i][n] = (image[i][n - 1].rgbtGreen + image[i][n].rgbtGreen + image[i][n + 1].rgbtGreen +
                               image[i + 1][n - 1].rgbtGreen + image[i + 1][n].rgbtGreen + image[i + 1][n + 1].rgbtGreen) / 6.0;
                tempB[i][n] = (image[i][n - 1].rgbtBlue + image[i][n].rgbtBlue + image[i][n + 1].rgbtBlue +
                               image[i + 1][n - 1].rgbtBlue + image[i + 1][n].rgbtBlue + image[i + 1][n + 1].rgbtBlue) / 6.0;
            }

            //check another side
            if (n == 0 && i != 0 && i != limit_height)
            {
                tempR[i][n] = (image[i - 1][n].rgbtRed + image[i][n].rgbtRed + image[i + 1][n].rgbtRed +
                               image[i - 1][n + 1].rgbtRed + image[i][n + 1].rgbtRed + image[i + 1][n + 1].rgbtRed) / 6.0;
                tempG[i][n] = (image[i - 1][n].rgbtGreen + image[i][n].rgbtGreen + image[i + 1][n].rgbtGreen +
                               image[i - 1][n + 1].rgbtGreen + image[i][n + 1].rgbtGreen + image[i + 1][n + 1].rgbtGreen) / 6.0;
                tempB[i][n] = (image[i - 1][n].rgbtBlue + image[i][n].rgbtBlue + image[i + 1][n].rgbtBlue +
                               image[i - 1][n + 1].rgbtBlue + image[i][n + 1].rgbtBlue + image[i + 1][n + 1].rgbtBlue) / 6.0;
            }

            //check another side
            if (n == limit_width && i != limit_height && i != 0)
            {
                tempR[i][n] = (image[i - 1][n - 1].rgbtRed + image[i][n - 1].rgbtRed + image[i + 1][n - 1].rgbtRed +
                               image[i - 1][n].rgbtRed + image[i][n].rgbtRed + image[i + 1][n].rgbtRed) / 6.0;
                tempG[i][n] = (image[i - 1][n - 1].rgbtGreen + image[i][n - 1].rgbtGreen + image[i + 1][n - 1].rgbtGreen +
                               image[i - 1][n].rgbtGreen + image[i][n].rgbtGreen + image[i + 1][n].rgbtGreen) / 6.0;
                tempB[i][n] = (image[i - 1][n - 1].rgbtBlue + image[i][n - 1].rgbtBlue + image[i + 1][n - 1].rgbtBlue +
                               image[i - 1][n].rgbtBlue + image[i][n].rgbtBlue + image[i + 1][n].rgbtBlue) / 6.0;
            }

            //check another side
            if (i == limit_height && n != limit_width && n != 0)
            {
                tempR[i][n] = (image[i - 1][n - 1].rgbtRed + image[i - 1][n].rgbtRed + image[i - 1][n + 1].rgbtRed +
                               image[i][n - 1].rgbtRed + image[i][n].rgbtRed + image[i][n + 1].rgbtRed) / 6.0;
                tempG[i][n] = (image[i - 1][n - 1].rgbtGreen + image[i - 1][n].rgbtGreen + image[i - 1][n + 1].rgbtGreen +
                               image[i][n - 1].rgbtGreen + image[i][n].rgbtGreen + image[i][n + 1].rgbtGreen) / 6.0;
                tempB[i][n] = (image[i - 1][n - 1].rgbtBlue + image[i - 1][n].rgbtBlue + image[i - 1][n + 1].rgbtBlue +
                               image[i][n - 1].rgbtBlue + image[i][n].rgbtBlue + image[i][n + 1].rgbtBlue) / 6.0;
            }

            //check corner
            if (i == 0 && n == 0)
            {
                tempR[i][n] = (image[i][n].rgbtRed + image[i][n + 1].rgbtRed + image[i + 1][n].rgbtRed + image[i + 1][n + 1].rgbtRed) / 4.0;
                tempG[i][n] = (image[i][n].rgbtGreen + image[i][n + 1].rgbtGreen + image[i + 1][n].rgbtGreen + image[i + 1][n + 1].rgbtGreen) / 4.0;
                tempB[i][n] = (image[i][n].rgbtBlue + image[i][n + 1].rgbtBlue + image[i + 1][n].rgbtBlue + image[i + 1][n + 1].rgbtBlue) / 4.0;
            }

            //check corner
            if (i == limit_height && n == 0)
            {
                tempR[i][n] = (image[i - 1][n].rgbtRed + image[i - 1][n + 1].rgbtRed + image[i][n].rgbtRed + image[i][n + 1].rgbtRed) / 4.0;
                tempG[i][n] = (image[i - 1][n].rgbtGreen + image[i - 1][n + 1].rgbtGreen + image[i][n].rgbtGreen + image[i][n + 1].rgbtGreen) / 4.0;
                tempB[i][n] = (image[i - 1][n].rgbtBlue + image[i - 1][n + 1].rgbtBlue + image[i][n].rgbtBlue + image[i][n + 1].rgbtBlue) / 4.0;
            }

            //check corner
            if (i == limit_height && n == limit_width)
            {
                tempR[i][n] = (image[i - 1][n - 1].rgbtRed + image[i - 1][n].rgbtRed + image[i][n - 1].rgbtRed + image[i][n].rgbtRed) / 4.0;
                tempG[i][n] = (image[i - 1][n - 1].rgbtGreen + image[i - 1][n].rgbtGreen + image[i][n - 1].rgbtGreen + image[i][n].rgbtGreen) / 4.0;
                tempB[i][n] = (image[i - 1][n - 1].rgbtBlue + image[i - 1][n].rgbtBlue + image[i][n - 1].rgbtBlue + image[i][n].rgbtBlue) / 4.0;
            }

            //check corner
            if (i == 0 && n == limit_width)
            {
                tempR[i][n] = (image[i][n - 1].rgbtRed + image[i][n].rgbtRed + image[i + 1][n - 1].rgbtRed + image[i + 1][n].rgbtRed) / 4.0;
                tempG[i][n] = (image[i][n - 1].rgbtGreen + image[i][n].rgbtGreen + image[i + 1][n - 1].rgbtGreen + image[i + 1][n].rgbtGreen) / 4.0;
                tempB[i][n] = (image[i][n - 1].rgbtBlue + image[i][n].rgbtBlue + image[i + 1][n - 1].rgbtBlue + image[i + 1][n].rgbtBlue) / 4.0;
            }
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int n = 0; n < width; n++)
        {
            image[i][n].rgbtRed = round(tempR[i][n]);
            image[i][n].rgbtGreen = round(tempG[i][n]);
            image[i][n].rgbtBlue = round(tempB[i][n]);
        }
    }
    return;
}


