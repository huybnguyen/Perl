#!/usr/bin/perl
#FASTA TO FASTQ
open IN, 'fastq_to_fasta.fasta';
open OUT, '>fasta_to_fastq.fastq';
while($line1 = <IN>){
	$line1 =~ tr/>/@/;
	print OUT "$line1";
	$line2 = <IN>;
	print OUT "$line2";
	$line3 = '+Bioformatics is great!';
	print OUT "$line3 \n";
	$line4 = $line2;
	$line4 =~ tr/ATCG/B/;
	print OUT "$line4";
}
close (IN);
close (OUT);
