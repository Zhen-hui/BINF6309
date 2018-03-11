#!/bin/bash

<<Comment
Using trimALL.sh as an example, write a shell script to run gsnap for every paired
trimmed file and output the sam files to the sam directory
Comment

# Initialize variable to contain the directory of trimmed fastq files
fastqPath="Paired/"

# Initialize variable to contain the suffic for the left and right reads 
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"

# Initialize variables with the desired output path for the sam files
samOutPath="sam/"
mkdir -p $samOutPath
# Loop through all the paired trimmed files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix  
do 
	# Remove the path and left-read suffix from filename and assign to sampleName
	rightInFile="${leftInFile/$leftSuffix/$rightSuffix}"
	samOutFile="${leftInFile/$leftSuffix/.sam}"
	samOutFile="${samOutFile/$fastqPath/sam/}"

	nice -n 19 gsnap \
	-A sam \
	-s AiptasiaGmapIIT.iit \
	-D . \
	-d AiptasiaGmapDb -0 -t 4\
	$leftInFile \
	$rightInFile \
	1>$samOutFile 2>$samOutFile.err
 
done 
