#!/bin/bash

####################################################################################
# Using trimALL.sh as an example, write a shell script to run gsnap for every paired
# trimmed file and output the sam files to the sam directory
####################################################################################

# Initialize variable to contain the directory of un-trimmed fastq files 
fastqPath = "/scratch/AiptasiaMiSeq/fastq/"
# Initialize variable to contain the suffix for the left and right reads 
leftSuffix = ".R1.fastq"
rightSuffix = ".R2.fastq"
# Initialize variables with the desired output for the paired trimmed reads
pairedOutPath = "Paired/"
unpairedOutPath = "Unpaired/"
# Loop through all the left-read fastq files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do 
	# Remove the path from the filenmae and assign to pathRemoved 
	pathRemoved = "${leftInFile/$fastqPath/}"
	# Remove the left-read suffix from $pathRemoved and assign to suffixRemoved
	sampleName = "${pathRemoved/$leftSuffix/}"
	
	echo $sampleName
Done 
