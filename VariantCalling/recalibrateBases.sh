#!/bin/bash

# Store all bam files in bamFiles 
bamFiles="$(ls -q noDup/*.bam)"
#echo $bamFiles

inPath='noDup/'
# Put an -I in front of each bam file
replacement='-I noDup/'
bam="${bamFiles//$inPath/$replacement}"
#echo $bam

# Step 1: Analyze patterns of covariation in the sequence dataset
# This will create a table containing the covariation data that will be used in a later step to recalibrate the base qualities of the sequence data.
baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'

$baseCommand -T BaseRecalibrator \
	     -R vShiloni.fasta \
 	     $bam \
	     -knownSites filteredSnps.vcf \
	     -o recal.table \
1>recalibrateBases.log 2>recalibrateBases.err &&

# Step 2: do a second pass to analyze covariation remaining after recalibration 
# This creates another GATKReport file to be used for plotting. -BQSR parameter tells GATK engine to perform on-the-fly recalibration based on the first recalibration data table
$baseCommand -T BaseRecalibrator \
	     -R vShiloni.fasta \
	     $bam \
	     -knownSites filteredSnps.vcf \
	     -BQSR recal.table \
	     -o post_recal.table \
1>post.log 2>post.err &&

# Step 3: Generate before/after plots
$baseCommand -T AnalyzeCovariates \
	     -R vShiloni.fasta \
	     -before recal.table \
	     -after post_recal.table \
	     -plots test_plots.pdf \
1>plot.log 2>plot.err &
 
 
