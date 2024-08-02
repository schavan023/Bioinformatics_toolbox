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

    # States
    states = sections[2].strip().split()

    # Transition matrix
    transition_matrix = {}
    transition_lines = sections[3].strip().split('\\n')
    state_names = transition_lines[0].strip().split()

    for line in transition_lines[1:]:
        parts = line.strip().split()
        state = parts[0]
        transition_matrix[state] = {}
        for i, prob in enumerate(parts[1:]):
            transition_matrix[state][state_names[i]] = float(prob)

    # Emission matrix
    emission_matrix = {}
    emission_lines = sections[4].strip().split('\\n')
    symbols = emission_lines[0].strip().split()

    for line in emission_lines[1:]:
        parts = line.strip().split()
        state = parts[0]
        emission_matrix[state] = {}
        for i, prob in enumerate(parts[1:]):
            emission_matrix[state][symbols[i]] = float(prob)

    return emitted_sequence, alphabet, states, transition_matrix, emission_matrix

def viterbi_algorithm(emitted_sequence, states, transition_matrix, emission_matrix):
    # Initialization
    V = [{}]
    path = {}

    # Initialize the starting probabilities
    for state in states:
        V[0][state] = emission_matrix[state][emitted_sequence[0]]
        path[state] = [state]

    # Recursion
    for t in range(1, len(emitted_sequence)):
        V.append({})
        new_path = {}

        for y in states:
            (prob, state) = max(
                (V[t - 1][y0] * transition_matrix[y0][y] * emission_matrix[y][emitted_sequence[t]], y0)
                for y0 in states
            )
            V[t][y] = prob
            new_path[y] = path[state] + [y]

        path = new_path

    # Termination
    n = len(emitted_sequence) - 1
    (prob, state) = max((V[n][y], y) for y in states)
    return ''.join(path[state])

# Get the input file path from command line arguments
input_file = sys.argv[1]

# Parse the input
emitted_sequence, alphabet, states, transition_matrix, emission_matrix = parse_input(input_file)

# Find the most probable path
most_probable_path = viterbi_algorithm(emitted_sequence, states, transition_matrix, emission_matrix)

# Print the result
print(most_probable_path)
END

