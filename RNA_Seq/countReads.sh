#!/bin/bash
# Write header lines dor the csv files 
echo "PairsOut,Sample" > pairsOut.csv
echo "PairsIn,Sample" > pairsIn.csv 
# Set variables for the inPath, outPath, and left read suffix 
outPath="Paired/"
inPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"
# 1. Use grep to find all the lines starting with @MO in all the R1.fastq files
# 2. Pipe the output to cut, and separate columns on :. Get the first column
# 3. Pipe the outout to sort
# 4. Pipe the output to uniq to collapse the repeating sample names 
# 5. Use the -c option to provide a count of lines collapsed
# 6. Use sed to replace spaces with commas and remove path and suffix from filenames
grep "\@MO*" $outPath*$leftSuffix|\
cut -d':' -f1|\
sort|\
uniq -c|\
sed -e "s|^ *||;s| |,|;s|$outPath||;s|$leftSuffix||" >> pairsOut.csv
grep "\@MO*" $inPath*$leftSuffix|\
cut -d':' -f1|\
sort|\
uniq -c|\
sed -e "s|^ *||;s| |,|;s|$inPath||;s|$leftSuffix||" >> pairsIn.csv
