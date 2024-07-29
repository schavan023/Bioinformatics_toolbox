#! /bin/bash

module load Python3/3.7

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: DNA sequence file '$1' not found."
    exit 1
fi

# Read the DNA sequence from the file
dna_string=$(<"$1")

# Execute Python code to count nucleotides
python3 << END
def count_nucleotides(dna_string):
    counts = {'A': 0, 'C': 0, 'G': 0, 'T': 0}
    for nucleotide in dna_string:
        counts[nucleotide] += 1
    return counts

counts = count_nucleotides("$dna_string")
print(counts['A'], counts['C'], counts['G'], counts['T'])
END

