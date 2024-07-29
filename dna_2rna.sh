#!/bin/bash

# Load Python3/3.7
module load Python3/3.7

# Check is the file exists
if [ ! -f "$1" ]; then
	echo "Error: Provide missing file"
	exit 1
fi
# Read the input file
dna_string=$(<"$1")

# Transcribe DNA to RNA
python3 << END
def transcribe_dna_to_rna(dna_string):
	rna_string = dna_string.replace('T', 'U')
	return rna_string

dna_string = "$dna_string"
rna_string = transcribe_dna_to_rna(dna_string)
print(rna_string)
END
