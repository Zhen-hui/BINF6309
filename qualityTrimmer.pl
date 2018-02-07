#!/usr/bin/perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality; 
use Getopt::Long;
use Pod::Usage;

# Globals
my $left       = '';
my $right      = '';
my $qual       = 0;
my $interleaved = '';
my $usage      = "\n$0 [Options] \n
Options: 
	-left             Left reads
	-right 			  Right reads
	-qual             Quality score minimum
	-interleaved      Filename for interleaved output
	-help             Show this message
\n";

GetOptions (
	'left=s'            => \$left,
	'right=s'           => \$right,
	'-interleaved=s'    => \$interleaved,
	'-qual=i'           => \$qual,
	'help'                   => sub {pod2usage($usage);}, 
) or pod2usage($usage);

unless (-e $left and -e $right and $qual and $interleaved) {
	unless (-e $left) {
		print "Specify file for left reads\n";
	}
		
 	unless (-e $right) {
 		print "Specify filr for right reads\n";
 	}
 	
 	unless ($interleaved) {
 		print "Specify file for interleaved output\n"
 	}
 	unless ($qual) {
 		print "Specify quality score cutoff\n, $usage"
 	}
	die "Missing required options\n";

}
# Creating a seqIO object for Sample.R1.fastq
my $seqio_obj_R1 = Bio::SeqIO->new(-file => "$ARGV[0]",
						    	-format => 'fastq'); 

$left = $seqio_obj_R1 -> next_seq;
					    	

# Creating a seqIO object for Sample.R2.fastq
my $seqio_obj_R2 = Bio::SeqIO->new(-file => "$ARGV[1]",
						    	-format => 'fastq'); 

$right = $seqio_obj_R2 -> next_seq;	

# setting quality threshold
#my $qual_threshold -> threshold(20); 

# Getting longest subsequence that has quality values above the threshold
my $leftTrimmed = $left ->get_clear_range("$ARGV[2]");
my $rightTrimmed = $right ->get_clear_range("$ARGV[2]");

# Copying description from one Bio::Seq to another
$leftTrimmed ->desc($left->desc());
$rightTrimmed ->desc($right->desc());

# Writing the result to an interleaved fastq file
                         
$interleaved = Bio::SeqIO->new(-file =>">$ARGV[3]",
						    	-format => 'fastq'); 

$interleaved  ->write_seq($leftTrimmed); 
$interleaved  ->write_seq($rightTrimmed);