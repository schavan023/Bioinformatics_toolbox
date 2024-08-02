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
import numpy as np

def parse_input(file_path):
    with open(file_path, 'r') as file:
        content = file.read().strip().split('--------')
    
    threshold = float(content[0].strip())
    alphabet = content[1].strip().split()
    alignment = [line.strip() for line in content[2].strip().split('\n')]
    
    return threshold, alphabet, alignment

def build_profile_hmm(alignment, threshold):
    m = len(alignment)
    n = len(alignment[0])
    
    match_positions = []
    for j in range(n):
        column = [alignment[i][j] for i in range(m)]
        if column.count('-') / m < threshold:
            match_positions.append(j)
    
    num_states = 3 * len(match_positions) + 3
    state_labels = ['S', 'I0'] + [f'{x}{i}' for i in range(1, len(match_positions) + 1) for x in 'MDI'] + ['E']
    state_idx = {state: i for i, state in enumerate(state_labels)}
    
    transition_matrix = np.zeros((num_states, num_states))
    emission_matrix = {state: {char: 0 for char in alphabet} for state in state_labels}
    
    for seq in alignment:
        current_state = 'S'
        
        for j in range(n):
            if j in match_positions:
                match_idx = match_positions.index(j) + 1
                if seq[j] == '-':
                    next_state = f'D{match_idx}'
                else:
                    next_state = f'M{match_idx}'
                    emission_matrix[next_state][seq[j]] += 1
            else:
                if seq[j] != '-':
                    next_state = f'I{len([k for k in match_positions if k < j]) + 1}'
                    emission_matrix[next_state][seq[j]] += 1
                else:
                    continue
            
            transition_matrix[state_idx[current_state]][state_idx[next_state]] += 1
            current_state = next_state
        
        transition_matrix[state_idx[current_state]][state_idx['E']] += 1
    
    for state in state_labels:
        total = sum(transition_matrix[state_idx[state]])
        if total > 0:
            transition_matrix[state_idx[state]] /= total
    
    for state in emission_matrix:
        total = sum(emission_matrix[state].values())
        if total > 0:
            for char in emission_matrix[state]:
                emission_matrix[state][char] /= total
    
    return transition_matrix, emission_matrix, state_labels

def print_matrices(transition_matrix, emission_matrix, state_labels, alphabet):
    print("Transition Matrix:")
    print("\t" + "\t".join(state_labels))
    for i, state in enumerate(state_labels):
        print(state + "\t" + "\t".join(f"{prob:.3f}" for prob in transition_matrix[i]))
    
    print("\nEmission Matrix:")
    print("\t" + "\t".join(alphabet))
    for state in state_labels:
        print(state + "\t" + "\t".join(f"{emission_matrix[state][char]:.3f}" for char in alphabet))

# Get the input file path from command line arguments
input_file = sys.argv[1]

# Parse the input
threshold, alphabet, alignment = parse_input(input_file)

# Build the profile HMM
transition_matrix, emission_matrix, state_labels = build_profile_hmm(alignment, threshold)

# Print the transition and emission matrices
print_matrices(transition_matrix, emission_matrix, state_labels, alphabet)
END

