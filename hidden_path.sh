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

    # Hidden path
    hidden_path = sections[0].strip()

    # States
    states = sections[1].strip().split()

    # Transition matrix
    transition_matrix = {}
    matrix_lines = sections[2].strip().split('\\n')
    state_names = matrix_lines[0].strip().split()

    for line in matrix_lines[1:]:
        parts = line.strip().split()
        state = parts[0]
        transition_matrix[state] = {}
        for i, prob in enumerate(parts[1:]):
            transition_matrix[state][state_names[i]] = float(prob)

    return hidden_path, states, transition_matrix

def calculate_path_probability(hidden_path, states, transition_matrix):
    num_states = len(states)
    initial_prob = 1 / num_states

    path_prob = initial_prob
    for i in range(1, len(hidden_path)):
        prev_state = hidden_path[i - 1]
        curr_state = hidden_path[i]
        path_prob *= transition_matrix[prev_state][curr_state]

    return path_prob

# Get the input file path from command line arguments
input_file = sys.argv[1]

# Parse the input
hidden_path, states, transition_matrix = parse_input(input_file)

# Calculate the probability of the hidden path
probability = calculate_path_probability(hidden_path, states, transition_matrix)

# Print the result
print(f"{probability:.12e}")
END

