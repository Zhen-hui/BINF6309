#!/usr/bin/perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality; 

# Creating a seqIO object for Sample.R1.fastq
my $seqio_obj_R1 = Bio::SeqIO->new(-file => 'Sample.R1.fastq',
						    	-format => 'fastq'); 

my $left = $seqio_obj_R1 -> next_seq;
					    	

# Creating a seqIO object for Sample.R2.fastq
my $seqio_obj_R2 = Bio::SeqIO->new(-file => 'Sample.R2.fastq',
						    	-format => 'fastq'); 

my $right = $seqio_obj_R2 -> next_seq;	

# setting quality threshold
#my $qual_threshold -> threshold(20); 

# Getting longest subsequence that has quality values above the threshold
my $leftTrimmed = $left ->get_clear_range(20);
my $rightTrimmed = $right ->get_clear_range(20);

# Copying description from one Bio::Seq to another
$leftTrimmed ->desc($left->desc());
$rightTrimmed ->desc($right->desc());

# Writing the result to an interleaved fastq file
                         
my $interleaved = Bio::SeqIO->new(-file => '>Interleaved.fastq',
						    	-format => 'fastq'); 

$interleaved  ->write_seq($leftTrimmed); 
$interleaved  ->write_seq($rightTrimmed); 



