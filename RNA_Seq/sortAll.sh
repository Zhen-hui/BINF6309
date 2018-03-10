#!/bin/sh

# Initialize variable to contain the directory of untrimmed fastq files and left read suffix
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"
samPath="SAM/"  
bamOutPath="BAM/"

# Loop through all the sam files in the $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
	# Remove the path from filename and assign to pathRemoved
	pathRemoved="${leftInFile/$fastqPath/}"
	# Remove the suffix from $pathRemoved and assign to $sampleName
	sampleName="${pathRemoved/$leftSuffix/}"
	#echo $sampleName
	samtools sort \
	$samPath$sampleName.sam \
	-o $bamOutPath$sampleName.sorted.bam \
	1>$bamOutPath$sampleName.sort.log 2>$bamOutPath$sampleName.sort.err 
done
