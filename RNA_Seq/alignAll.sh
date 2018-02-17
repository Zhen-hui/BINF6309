#!/bin/sh

<<Comment
Using trimALL.sh as an example, write a shell script to run gsnap for every paired
trimmed file and output the sam files to the sam directory
Comment

# Initialize variable to contain the directory of trimmed fastq files
FastqPath="Paired/"

# Initialize variable to contain the suffic for the left and right reads 
leftSuffix=".R1.paired.fastq"
rightSuffix=".R2.paired.fastq"

# Initialize variables with the desired output path for the sam files
samOutPath="SAM/"

# Loop through all the paired trimmed files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix  
do 
	# Remove the path from filename and assign to pathRemoved
	pathRemoved="${leftInFile/$fastqPath/}"
	# Remove the left-read suffix from $pathRemoved and assign to suffix removed
	sampleName="${pathRemoved/$leftSuffix}"
	echo $sampleName
	echo nice -n 19 gsnap \
	-A sam \
	-s AiptasiaGmapIIT.iit \
	-D . \
	-d AiptasiaGmapDb \
	$fastqPath$sampleName$leftSuffix \
	$fastqPath$sampleName$rightSuffix \
	#1>$sampleName.sam 2>$sampleName.err &

done 
