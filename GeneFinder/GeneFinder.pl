#!/usr/bin/perl
sub get_complement($){
		$new_string = shift;
      $reverse_string = reverse $new_string;
		$reverse_string =~ tr/ACGTacgt/TGCAtgca/;
		return $reverse_string;
}

sub get_orf($){
	my $dna = shift;
	my @list;
	while ($dna =~ m/((ATG)(([ATGC]{3})+?)(TAA|TAG|TGA))/g){
		push @list, $1;
	}
	return \@list;
}

sub get_gene(@) {
   my $sequence = shift;
   my $result_list = shift;
   for ( my $k = 0 ; $k < 3 ; $k++ ) {
      my $list = get_orf($sequence);
      foreach my $i (@$list) {
         push @$result_list, $i;
      }
   }
}

sub uniq{ #removing duplicate 
   my %seen;
   grep !$seen{$_}++, @_;
}

sub main() {
	my(%genetic_code) = (
"UCA" => "S", # Serine
"UCC" => "S", # Serine
"UCG" => "S", # Serine
"UCU" => "S", # Serine
"UUC" => "F", # Phenylalanine
"UUU" => "F", # Phenylalanine
"UUA" => "L", # Leucine
"UUG" => "L", # Leucine
"UAC" => "Y", # Tyrosine
"UAU" => "Y", # Tyrosine
"UAA" => "_", # Stop
"UAG" => "_", # Stop
"UGC" => "C", # Cysteine
"UGU" => "C", # Cysteine
"UGA" => "_", # Stop
"UGG" => "W", # Tryptophan
"CUA" => "L", # Leucine
"CUC" => "L", # Leucine
"CUG" => "L", # Leucine
"CUU" => "L", # Leucine
"CCA" => "P", # Proline
"CAU" => "H", # Histidine
"CAA" => "Q", # Glutamine
"CAG" => "Q", # Glutamine
"CGA" => "R", # Arginine
"CGC" => "R", # Arginine
"CGG" => "R", # Arginine
"CGU" => "R", # Arginine
"AUA" => "I", # Isoleucine
"AUC" => "I", # Isoleucine
"AUU" => "I", # Isoleucine
"AUG" => "M", # Methionine
"ACA" => "T", # Threonine
"ACC" => "T", # Threonine
"ACG" => "T", # Threonine
"ACU" => "T", # Threonine
"AAC" => "N", # Asparagine
"AAU" => "N", # Asparagine
"AAA" => "K", # Lysine
"AAG" => "K", # Lysine
"AGC" => "S", # Serine
"AGU" => "S", # Serine
"AGA" => "R", # Arginine
"AGG" => "R", # Arginine
"CCC" => "P", # Proline
"CCG" => "P", # Proline
"CCU" => "P", # Proline
"CAC" => "H", # Histidine
"GUA" => "V", # Valine
"GUC" => "V", # Valine
"GUG" => "V", # Valine
"GUU" => "V", # Valine
"GCA" => "A", # Alanine
"GCC" => "A", # Alanine
"GCG" => "A", # Alanine
"GCU" => "A", # Alanine
"GAC" => "D", # Aspartic Acid
"GAU" => "D", # Aspartic Acid
"GAA" => "E", # Glutamic Acid
"GAG" => "E", # Glutamic Acid
"GGA" => "G", # Glycine
"GGC" => "G", # Glycine
"GGG" => "G", # Glycine
"GGU" => "G"  # Glycine
);
my ($amino_acid) = "";
	print "Please enter the string: ";
	my $DNAseq = <STDIN>;
	@array = ($DNAseq =~ m/A|T|C|G/g);
	$dna_string = join("",@array);
	my @list;
    $complementary = get_complement($dna_string);
	get_gene($complementary, \@list);
	print "The complementary strand: $complementary\n";
   my @new_list = uniq(@list);
	foreach (@new_list) {
      print "The length of the gene is: " . length($_) . "\n" . "The gene is: $_\n";
      $_ =~ tr/tT/uU/;
      print "Transcription to mRNA: $_\n";
      for(my $i=0;$i<length($_)-2;$i+=3)
	  {
		$codon = substr($_,$i,3);
		$amino_acid .= $genetic_code{$codon};
	  }
	  print "Translated amino acid sequence is $amino_acid\n";

    }

} 
main();