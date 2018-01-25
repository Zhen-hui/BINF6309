#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Bio::SeqIO;

my $seqio_obj = Bio::SeqIO->new(
	-file   => 'dmel-all-chromosome-r6.17.fasta',
	-format => 'fasta'
);

my %kMerHash = ();

my %last12Counts = ();

my $seq_obj;

sub seq_returned {

	# receive the sequence
	my ($seqio_obj) = @_;

	# pass while-loop in here
	while ( $seq_obj = $seqio_obj->next_seq ) {
		print $seq_obj ->seq, "\n";
	}

	my $windowSize = 21;
	my $stepSize   = 1;
	my $seqLength  = length($seqio_obj);    # sequence passed
	for (
		my $windowStart = 0 ;
		$windowStart <= ( $seqLength - $windowSize ) ;
		$windowStart += $stepSize
	  )
	{
		my $crisprSeq = substr( $seqio_obj, $windowStart, $windowSize );

		if ( $crisprSeq =~ /([ATGC]{9}([ATGC]{10}GG))$/ ) {
			$kMerHash{$2} = $1;
			$last12Counts{$2}++;
		}
	}

}

my $crisprCount = 0;

$seqio_obj = Bio::SeqIO->new(
	-file   => '>crisprs1.fasta',
	-format => 'fasta'
);


for my $last12Seq ( sort ( keys %last12Counts ) ) {

# read from hash
	seq_returned($seqio_obj);
	if ( $last12Counts{$last12Seq} == 1 ) {
		$crisprCount++;

		my $seq_obj = Bio::Seq->new(
			-seq        => "$kMerHash{$last12Seq}\n",
			-display_id => ">crispr_$crisprCount CRISPR\n",
			-alphabet   => "dna"
		);

		$seqio_obj->write_seq($seq_obj);
	}
}
