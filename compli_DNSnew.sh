#!/bin/bash

# Load the Python module
module load Python3/3.7

# Run the Python script
python3 - <<END
def reverse_complement(dna):
    # Create a dictionary for complementing DNA bases
    complement = {'A': 'T', 'T': 'A', 'C': 'G', 'G': 'C'}

    # Reverse the DNA string
    reversed_dna = dna[::-1]

    # Generate the complement for the reversed DNA string
    reversed_complement = ''.join(complement[base] for base in reversed_dna)

    return reversed_complement

def read_dna_sequence(file_path):
    with open(file_path, 'r') as file:
        dna_sequence = file.read().strip()
    return dna_sequence

def write_reverse_complement(file_path, reverse_complement):
    with open(file_path, 'w') as file:
        file.write(reverse_complement)

# File paths
input_file = 'dna_sequence.txt'
output_file = 'reverse_complement.txt'

# Read the DNA sequence from the input file
dna_sequence = read_dna_sequence(input_file)

# Get the reverse complement of the DNA sequence
result = reverse_complement(dna_sequence)

# Write the reverse complement to the output file
write_reverse_complement(output_file, result)

print(f"Reverse complement has been written to {output_file}")
END

