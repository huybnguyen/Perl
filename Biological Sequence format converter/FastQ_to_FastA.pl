#!/usr/bin/perl
#FASTQ TO FASTA
open IN, 'sample.fastq';
open OUT, '>fastq_to_fasta.fasta';
while($line1 = <IN>){
    $line1 =~ tr/@/>/;
    print OUT "$line1";
    $line2 = <IN>;
    print OUT "$line2";
    $line3 = <IN>;
    $line4 = <IN>;
}
close (IN);
close (OUT);
