#!/usr/bin/perl
use warnings;
use strict;
# This script creates a subset of the transcriptome assembly to test Blast2Go

use Bio::Seq;
use Bio::SeqIO;
use Getopt::Long;
use Pod::Usage;

# Define global varaibles to contain input and output fasta files 
my $fastaIn    = 'Trinity-GG.fasta.transdecoder.pep';
my $fastaOut   = 'subset.pep';

# Define sampleRate at 1000 so that every 1000th sequence will be written to the output file 
my $sampleRate = 1000;


# Make the codes flexible by providing usage options 
my $usage      = "\n$0 [options] \n
Options:
	-fastaIn       FASTA input file [$fastaIn]
	-fastaOut      FASTA Output Prefix [$fastaOut]
	-sampleRate    Number of output files [$sampleRate]
	-help          Show this message 
\n"; 
# Add variables in the user options, and asign default values to them so the program can run without options
# Put the variables in the usage message so that -help will display the default values in square brackts

# Call GetOptions to retrieve the three options user needs to provide 
# Or call pod2usage if the user enters the -help option
GetOptions(
	'fastaIn=s'    => \$fastaIn,
	'fastaOut=s'   => \$fastaOut,
	'sampleRate=i' => \$sampleRate,
	help           => sub { pod2usage($usage); },
) or pod2usage($usage);


# Check if the fasta input file exist, if not, terminate the program 
if (not (-e $fastaIn)) {
	die "The input file $fastaIn specified by -fastaIn does not exist\n";
}

# Instantiate a Bio::SeqIO object to read the fasta input file
my $input = Bio::SeqIO->new(
	-file   => $fastaIn,
	-format => 'fasta'
);

# Instantiate a Bio::SeqIO object to write the fasta output file 
my $output = Bio::SeqIO->new(
	-file   => ">$fastaOut",
	-format => 'fasta'
);

# Initialize a counter variable to keep track of the number of sequences 
my $seqCount = 0;

# Loop through the sequences using next_seq
while (my $seq = $input->next_seq) {
	
	# Increment the counter for each sequence 
	$seqCount++;
	
	# % = modulus operator, to get the remainder after dividing the sequence count by the sample rate 
	# If the remainder is 0, it's a multiple of the sample rate
	if (( $seqCount % $sampleRate ) == 0 ) {
		
		# Write the output file if the remainder equals to 0
		$output->write_seq($seq);
	}
}