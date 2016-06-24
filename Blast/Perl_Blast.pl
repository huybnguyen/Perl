#!/usr/bin/perl -w
use warnings;
no warnings "uninitialized";
print "Please input the query file name: ";
$query = <>;
open(INFO, "$query");
open(DATA, "perlblastdata.txt");
print "Input the length of the window: "; 
$k = <>;
chomp $k;
print "Input Threshhold: ";
$n = <>;
chomp $n;
%kmer = ();                      # This initializes the hash called kmer.
$i = 1;
$queryString = 0;
$/="";
while($reading = <INFO>){
	$queryString = $reading;
	@myquery = split(//,$queryString);
	while (length($reading) >= $k) {
 		 $reading =~ m/(.{$k})/;
  		if (! defined $kmer{$1}) {     
    			$kmer{$1} = $i;       
  		}
 		else{
			push(@{$kmer{$1}},$i);
 	 	}
		$i++;
  		$reading = substr($reading, 1, length($reading) -1);
	}
}

@arrayS = "";
@string1= "";
@string2= "";
$/ = "";
while($reading2 = <DATA>){
	$temp = $reading2;
	$x = 1;
	$pos = 1;
	@mydata = split(//,$temp);
	while(length($reading2) >= $k){
		$reading2 =~ m/(.{$k})/;
		if(defined $kmer{$1}){
			$positionQ = $kmer{$1};
			$hspCounter = $k;
			while(1){ #scan left
				if($myquery[$positionQ-$x-1] eq $mydata[$pos-$x-1]){
					push @arrayS,$myquery[$positionQ-$x];
					$x++;
					$hspCounter++;
	
				}
				else{
					push @string1 , join("",@arrayS);	
					last;
				}
			}
			@arrayS = ();
			$y=0;
			while(1){ #scan right
				if($myquery[$positionQ+$y-1] eq $mydata[$pos+$y-1]){
					push @arrayS, $myquery[$positionQ+$y-1];
					$hspCounter++;
					$y++;
				}
				else{
					push @string2 ,join("",@arrayS);
					last;
				}
			}
		}
		$pos++;
		$reading2 = substr($reading2, 1,length($reading2)-1);
	}
}


$array_size = @string1;
$array_size2 = @string2;
for($u=0; $u<$array_size; $u++){ #combining left and right array into one.
	for($p=0; $p<$array_size2; $p++){
		push @wholeHSP,join($string1[$u],"", $string2[$p]);
	}
}

sub uniq{ #removing duplicate HSP
	my %seen;
	grep !$seen{$_}++, @_;
}

my @filtered = uniq(@wholeHSP);

foreach $t (@filtered){
	if($t ne ""){
		$matches = index($queryString, $t);
		$matches2 = index($temp, $t);
		$length = length($t);
		$string = substr($temp,$matches2,length($t));
		if($length >= $n && $string !~/^\s*$/){
			print "The HSP $string with length $length is found at position $matches in the database.\n";
		}	
	}	
}

close(INFO);
close (DATA);
