#!/bin/bash
module load Python3/3.7
module list 
# Check if the file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <dna_sequence_file>"
    exit 1
fi

# Execute Python code
python3 - << END
import sys

def reverse_complement(dna_string):
    complement = {'A': 'T', 'T': 'A', 'C': 'G', 'G': 'C'}
    reverse_complement_string = ''.join(complement[nucleotide] for nucleotide in reversed(dna_string))
    return reverse_complement_string

# Debugging: Print the number of command-line arguments
print("Number of command-line arguments:", len(sys.argv))

# Read the DNA string from the file
file_name = sys.argv[1]
with open(file_name, "r") as file:
    dna_string = file.read().strip()

# Find the reverse complement
reverse_complement_string = reverse_complement(dna_string)

# Print the reverse complement
print(reverse_complement_string)
END

