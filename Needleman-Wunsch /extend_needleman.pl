#!/usr/bin/perl


sub generate_random_string
{
	my $length_of_randomstring=shift;# the length of 
			 # the random string to generate

	my @chars=('A','T','C','G');
	my $random_string;
	foreach (1..$length_of_randomstring) 
	{
		# rand @chars will generate a random 
		# number between 0 and scalar @chars
		$random_string.=$chars[rand @chars];
	}
	return $random_string;
}

#This is the Needleman-Wunsch global alignment algorithm without gaps 
#in the model and
#with match value = 1, and mismatch and indel value = -1.
#dg

print "Please enter the length of generating string: ";
$line = <>;
chomp $line;
@string1 =  split(//, &generate_random_string($line));  
@string2 =  split(//, &generate_random_string($line));
$n = @string1;             
$m = @string2;

print "The lengths of the two strings are $n, $m \n";   # Just to make sure this works.

$value = 1;

$cost = 0;

$indel_cost = 0;


$V[0][0] = 0;                  

for ($i = 1; $i <= $n; $i++){
   $V[$i][0] = $indel_cost * -$i;
}

for ($j = 1; $j <= $m; $j++){
   $V[0][$j] = $indel_cost * -$j;
}

for ($i = 1; $i <= $n; $i++) {     
 for ($j = 1; $j <= $m; $j++) {
#   print OUT "$string1[$i-1], $string2[$j-1]\n"; # This is here  for debugging purposes.
   if ($string1[$i-1] eq $string2[$j-1]) {
     $t = $value; 
   }
   else {
   $t = 0-$cost;
   }

  $max = $V[$i-1][$j-1] + $t;  
  if ($max < $V[$i][$j-1] - $indel_cost) {
    $max = $V[$i][$j-1] - $indel_cost;
  }

  if ($V[$i-1][$j] - $indel_cost > $max) {
    $max = $V[$i-1][$j] - $indel_cost;
  }
  $V[$i][$j] = $max;
  }
}

print "\nThe LCS length is: $V[$n][$m]\n";
