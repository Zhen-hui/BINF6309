#!/bin/bash
#This script retrieve the genome fasta files with accession number from NCBI

# Create an array of accession numbers 
array=(NZ_CP018308.1 NZ_CP018309.1 NZ_CP018310.1)
# Iterate over the array and get accessions from NCBI
for acc in "${array[@]}"
do
	bp_download_query_genbank.pl --query $acc --format fasta > ${acc}.fasta
done


