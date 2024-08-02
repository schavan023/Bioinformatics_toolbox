#!/bin/bash

# Load the Python module
module load Python3/3.7

# Check if an input file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Input file containing the dataset
input_file="$1"

# Run the Python script
python3 - "$input_file" <<END
import sys

def parse_input(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    sections = content.strip().split('--------')

    # Emitted sequence x
    emitted_sequence = sections[0].strip()

    # Alphabet Σ
    alphabet = sections[1].strip().split()

    # Hidden path π
    hidden_path = sections[2].strip()

    # States
    states = sections[3].strip().split()

    # Emission matrix
    emission_matrix = {}
    matrix_lines = sections[4].strip().split('\\n')
    symbols = matrix_lines[0].strip().split()

    for line in matrix_lines[1:]:
        parts = line.strip().split()
        state = parts[0]
        emission_matrix[state] = {}
        for i, prob in enumerate(parts[1:]):
            emission_matrix[state][symbols[i]] = float(prob)

    return emitted_sequence, alphabet, hidden_path, states, emission_matrix

def calculate_emission_probability(emitted_sequence, hidden_path, emission_matrix):
    probability = 1.0
    for i in range(len(emitted_sequence)):
        symbol = emitted_sequence[i]
        state = hidden_path[i]
        probability *= emission_matrix[state][symbol]
    return probability

# Get the input file path from command line arguments
input_file = sys.argv[1]

# Parse the input
emitted_sequence, alphabet, hidden_path, states, emission_matrix = parse_input(input_file)

# Calculate the probability of the emitted sequence given the hidden path
probability = calculate_emission_probability(emitted_sequence, hidden_path, emission_matrix)

# Print the result
print(f"{probability:.12e}")
END

