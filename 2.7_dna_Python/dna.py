import csv
import sys


def main():

    # TODO: Check for command-line usage
    if len(sys.argv) != 3:
        sys.exit("Usage: python dna.py data.csv sequence.txt")

    # TODO: Read database file into a variable
    database = open(sys.argv[1], "r")
    people = csv.DictReader(database)

    # TODO: Read DNA sequence file into a variable
    sequences = open(sys.argv[2], "r")
    dna = sequences.read()

    # TODO: Find longest match of each STR in DNA sequence
    str = ('AGATC', 'TTTTTTCT', 'AATG', 'TCTAG', 'GATA', 'TATC', 'GAAA', 'TCTG')

    count_str = {}

    for row in people:
        check_keys = row.keys()
        break
    database.close()

    database = open(sys.argv[1], "r")
    people = csv.DictReader(database)

    count_csv = 0
    str_csv = []

    for i in range(0, len(str), 1):
        if str[i] in check_keys:
            str_csv.append(str[i])
            count_csv += 1

    for i in range(0, len(str_csv), 1):
        count_str[str_csv[i]] = longest_match(dna, str_csv[i])

    # TODO: Check database for matching profiles
    while True:
        for row in people:
            name = row["name"]
            match = 0
            for i in range(0, count_csv, 1):
                check_dna = count_str[str_csv[i]]
                check_row = int(row[str_csv[i]])
                if check_dna == check_row:
                    match += 1
                if match == (len(row) - 1):
                    print(name)
                    exit()
        print("No match")
        exit()

    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
