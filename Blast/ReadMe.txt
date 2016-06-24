Perl_Blast.pl:
_ This program is based on the principles of BLAST for finding seed words first (k-meres) and then extending them to find potential alignments. 
* Here is the structure of how the program works:
	+ Take in a query file.
	+ Find the first location of each different k-mer in the provided query.
	+ Read in the data file and scan through its 4-mers.
	+ Whenever a 4-mer in a string of the data file is determined to be in the query, extract the location of the first occurence of the 4-mer in the query. Then put the characters of the query and the string of the data file in arrays to examine individual characters. Then scan left from the k-mer in the query and in the string of the data file for matching characters. Repeat to the right. Then report the highest scoring pair.
