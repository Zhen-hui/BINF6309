#!/bin/bash
mkdir -p vcf
findVariants(){
for bam in noDup/*.bam
do
vcfOut="${bam/noDup/vcf}"
vcfOut="${vcfOut/bam/vcf}"
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T HaplotypeCaller --emitRefConfidence GVCF -R vShiloni.fasta -I $bam --genotyping_mode DISCOVERY \
-variant_index_type LINEAR -variant_index_parameter 128000 \
-stand_call_conf 30 -nct 16 -o $vcfOut
done
}
findVariants 1>findVariants.log 2>findVariants.err &
