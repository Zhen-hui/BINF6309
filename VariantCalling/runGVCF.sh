#!/bin/bash
# Run GenotypeGVCFs on all 211 VCF files to produce a merged VCF representing all samples

vcf="$(ls -q vcf/*.vcf)"
#echo $vcf
inPath='vcf/'
replacement='--variant vcf/'
vcfParam="${vcf//$inPath/$replacement}"
#echo $vcfParam

baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'
$baseCommand -T GenotypeGVCFs -R vShiloni.fasta $vcfParam -nt 16 -o genotype.vcf \
1>gvcf.log 2>gvcf.err 
