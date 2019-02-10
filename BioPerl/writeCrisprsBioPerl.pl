#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Bio::Seq;
use Bio::SeqIO;
use Getopt::Long;
use Pod::Usage;

# This script reads in the dmel-all-chromosome.r6.02.fasta file, and save all 21-mers ending in GG form into a hash, where the key is the last 12 positions of the k-mer, and the value is the k-mer.
# It also creates a second hash to count how many times each 12-mer occurs in the genome.
# For each 12-mer that only occur once, the corresponding 21-mer is a potential CRISPR, so the program will write the CRISPR to a file.

# Globals
my $fastaIn = '';
my $usage = "\n$0 [Options] \n
Options: 
	- fastaIn          Sequence to be read
	- help             Show this message
\n";

# Check if fasta file exists 
unless (-e $fastaIn) {
		print "Specify file for reading\n";
	} else {
	die "Missing required options\n";
}

my %kMerHash = ();

my %last12Counts = ();


my $seqio_obj = Bio::SeqIO->new(
	-file   => "$ARGV[0]",
	-format => 'fasta'
);

# Iterating over sequences using next_seq()
while (my $seq_obj = $seqio_obj -> next_seq) {
	
	# Get the seq attribute from the Bio::Seq object
	my $seq = $seq_obj -> seq;
	
	# Pass a reference to the sequence 
	seq_returned (\$seq);
}

# Find k-mers within seq using a sliding window
sub seq_returned {
	
	# Get the arguments passes to this subroutine
	my ($seq_ref) = @_;

	my $windowSize = 21;
	my $stepSize   = 1;
	
	# $seq_ref is a reference, so de-reference as a scalar with $
	my $seqLength  = length($$seq_ref);    
	
	for (
		my $windowStart = 0 ;
		$windowStart <= ( $seqLength - $windowSize ) ;
		$windowStart += $stepSize
	  )
	{
		my $crisprSeq = substr( $$seq_ref, $windowStart, $windowSize );

		if ( $crisprSeq =~ /([ATGC]{9}([ATGC]{10}GG))$/ ) {
			$kMerHash{$2} = $1;
			$last12Counts{$2}++;
		}
	}
}

# Open a Bio::SeqIO to write out the CRISPRs 
my $seqio_crisprs = Bio::SeqIO -> new(
	#-file   => '>crisprs1.fasta',
	#-format => 'fasta'
);

my $crisprCount = 0;

# loop through the hash of last 12 counts
for my $last12Seq ( sort ( keys %last12Counts ) ) {

	# check if count == 1 for this sequence
	if ( $last12Counts{$last12Seq} == 1 ) {
		
		# The last 12 seq of this CRISPR is unique in the genome.
		# Increment the CRISPR count
		$crisprCount++;

		# Create a new Bio::Seq for the CRISPR
		my $seq_obj = Bio::Seq->new(
			-seq        => "$kMerHash{$last12Seq}\n",
			-desc       => "CRISPR",
			-display_id => ">crispr_$crisprCount CRISPR\n",
			-alphabet   => "dna"
		);

		$seqio_crisprs->write_seq($seq_obj);
	}
}
