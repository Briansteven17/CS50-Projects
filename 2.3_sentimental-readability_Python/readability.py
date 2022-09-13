import cs50
# TODO

text = cs50.get_string("Text: ")

letters = 0
words = 1
sentences = 0
check_sentence = (".", "?", "!")

# Count all the lleters, words and senteces in the text
for i in range(0, len(text), 1):
    if text[i].isalpha():
        letters += 1
    if text[i] == " ":
        words += 1
    if ((text[i] in check_sentence) == True):
        sentences += 1

# Average of letters and sentences per 100 words
avg_letters = (letters * 100) / words
avg_sentences = (sentences * 100) / words

coleman_index = (0.0588 * avg_letters) - (0.296 * avg_sentences) - 15.8
grade = (round(coleman_index))

# Check the grade according to the coleman_index
if grade < 1:
    print("Before Grade 1\n")
elif grade >= 16:
    print("Grade 16+\n")
else:
    print(f"Grade {grade}")

