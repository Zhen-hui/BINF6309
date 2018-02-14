#!/usr/bin/sh

# Initialize variable to contain the directory of un-trimmed fastq files 
fastqPath = "/scratch/AiptasiaMiSeq/fastq/"

# Initialize variable to contain the suffix for the left reads 
leftSuffix = ".R1.fastq"
     #rightSuffix = ".R2.fastq"

# Initialize varables with the desired output path for the paired trimmed reads

#pairedOutPath = "Paired/"
#unpairedOutPath = "Unpaired/" 

# Loop through all the left-read fastq files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do 
	# Remove the path from the filenmae and assign to pathRemoved 
	pathRemoved = "${leftInFile/$fastqPath/}"
	# Remove the left-read suffix from $pathRemoved and assign to suffixRemoved
	sampleName = "${pathRemoved/$leftSuffix/}"

	echo $sampleName	

<<COMMENT2
	echo nice -n 19 java /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
	-threads 1 -phred33 \
	$fastqPath$sampleName$leftSuffix \
	$fastqPath$sampleName$rightSuffix \
	$pairedOutPath$sampleName$leftSuffix \
	$unpairedOutPath$sampleName$leftSuffix \
	$pairedOutPath$sampleName$rightSuffix \
	$unpairedOutPath$sampleName$rightSuffix \
	HEADCROP:0 \
	ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adaptors/TruSeq3-PE.fa:2:30:10 \
	LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
	1>Aip02.trim.log 2>Aip02.trim.err
COMMENT2
 
done
