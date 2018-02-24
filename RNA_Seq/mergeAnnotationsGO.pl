#!/bin/perl
use strict;
use warnings;

# Add a filehandle to read spToGo.tsv
open (SP_TO_GO, "<", "spToGo.tsv") or die $!;

# Initialize a hash to store SwissProt IDs and GO terms
my %spToGo;

# Loop through the filehandle and chomp each line
while (<SP_TO_GO>) {
	chomp;
	# Split each line one tabs, and assign the results to $swissProt and $go
	my ($swissProt, $go) = split("\t",$_);
	
	# Store both $swissProt and $go as keys
	# Increment a counter to be stored as the value for this 2-dimensional hash
	$spToGo{$swissProt}{$go}++;
}

=cut (codes not needed)
# To test the hash, iterate over the first key, $swissProt with foreach loop
# sort the keys of the hash to make sure everyone gets the output in the same order
foreach my $swissProt(sort keys %spToGo){
	
	# Iterate over the second key, $go with foreach loop
	foreach my $go ( sort keys %{$spToGo{$swissProt}} ) {
		
		# Print both keys in tab-separated format using join
		print join("\t",$swissProt,$go),"\n";
	}
}
=cut

# Open a filehandle to read the aipSwissProt.tsv created with mergeAnnotations.pl
open (SP, "<", "aipSwissProt.tsv") or die $!;

# Loop through the filehandle line by line
while (<SP>) {
	# chomp each line
	chomp;
	# Split on tabs, assign the four columns in the file to four variables 
	my ($trinity, $swissProt, $description, $eValue) = split("\t",$_);
	# If $swissProt ID is defined in the hash, loop through the keys 
	if (defined $spToGo{$swissProt}) {
		
		# Get the GO keys for the SwissProt IDs in the aipSwissProt annotation file 
		foreach my $go (sort keys %{$spToGo{$swissProt}}){
			print join("\t",$trinity,$description,$swissProt,$go),"\n";
		}
	}
}

# Open a filehandle to read bioProcess.tsv
open (IN, "<", "bioProcess.tsv") or die $!;

# Initialize a hash to store SwissProt IDs and GO terms
my %bioProcess;

# Loop through the filehandle 
while (<IN>) {
	# chomp each line
	chomp;
	# Split on tabs, assign the two columns in IN to two variables $go_id and $go_name
	my ($go_id, $go_name) = split("\t",$_);	
	# Store $go_id as key and $go_name as value
	$bioProcess{$go_id} = [$go_name];
}