# Simulate a sports tournament

import csv
import sys
import random

# Number of simluations to run
N = 1000


def main():

    # Ensure correct usage
    if len(sys.argv) != 2:
        sys.exit("Usage: python tournament.py FILENAME")

    teams = []
    # TODO: Read teams into memory from file
    with open(sys.argv[1], "r") as f:
        readr = csv.DictReader(f)
        for row in readr:
            points = row["rating"]
            teams_names = row["team"]
            points = int(points)
            teams.append({"team": teams_names,"rating": points})
        print(teams[0]["team"])

if __name__ == "__main__":
    main()
