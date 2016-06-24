#!/usr/bin/perl -w
#
use List::Util qw[min max];
#This is the Needleman-Wunsch global alignment algorithm without gaps 
#in the model and
#with match value = 1, and mismatch and indel value = -1.
#dg
open (OUT, '> outer');         #Open a file called 'outer' for outputing.
print "Input string 1 \n";
$line = <>;
chomp $line;
@string1 =  split(//, $line);  
print "Input string 2 \n";
$line = <>;
chomp $line;
@string2 =  split(//, $line);
$n = @string1;             
$m = @string2;

print "The lengths of the two strings are $n, $m \n";   # Just to make sure this works.

print "Please input the match value, V:";
$value = <STDIN>;

print "Please input the mismatch cost, Cm: ";
$cost = <STDIN>;

print "Please input the indel cost, is: ";
$indel_cost = <STDIN>;

$GAP = $indel_cost;
$result = 0;
$capcount = 0;
for($r=0; $r<=$n ;$r++){
	$value1 =1;
	$value2=1;
	$value3=1;
	$value4=1;
	for($e=$n; $e>0; $e--){
  		$value1 *= $e; #n!
	}
        
	
	for($b=$r; $b>0; $b--){
		$value2 *= $b; #r!
	}
	
	for($c=($n+$r); $c>0; $c--){ 
  		$value3 *= $c; #(n+r)!
	}

	for($d=($n-$r); $d>0; $d--){
		$value4 *= $d; #(n-r)!
	}
	
	if($r==0){
		$r=1;
	}
 	#print OUT "$value1  $value2  $value3  $value4\n";
        $partial = ($value3/($value1*$value2))*($value1/($value2*$value4));
	$result += $partial;
}
#print OUT "$value1  $value2  $value3  $value4\n";
$V[0][0] = 0;                  
$V2[0][0] = 0;
$V3[0][0] = 0;
$V4[0][0]= 0;
$V5[0][0] = 0;

for ($i = 1; $i <= $n; $i++){
   $V[$i][0] = $indel_cost * -$i;
   $V2[$i][0] = $indel_cost * -$i;
   $V3[$i][0] = $indel_cost * -$i;
   $V4[$i][0] = $indel_cost * -$i;
   $V5[$i][0] = $indel_cost * -$i;;
   print OUT "$string1[$i-1]"; 
}
   print OUT "\n\n";

for ($j = 1; $j <= $m; $j++){
   $V[0][$j] = $indel_cost * -$j;
   $V2[0][$j] = $indel_cost * -$j;
   $V3[0][$j] = $indel_cost * -$j;
   $V4[0][$j] = $indel_cost * -$j;
   $V5[0][$j] = $indel_cost * -$j;
   print OUT "$string2[$j-1]";
}
   print OUT "\n\n";
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
  $max2 = $V2[$i-1][$j-1] + $t;
  $max3 = $V3[$i-1][$j-1] + $t;
  $max4 = $V[$i-1][$j-1] + $t;
  $max5 = $V[$i-1][$j-1] + $t;
  $V[$i][$j] = max($max, $max2, $max3, $max4, $max5);
  $V2[$i][$j] = max($V[$i-1][$j] - $indel_cost, $V4[$i-1][$j] - $indel_cost, $V5[$i-1][$j] - $indel_cost);
  $V3[$i][$j] = max($V2[$i-1][$j]+$indel_cost - $GAP, $V3[$i-1][$j]);
  $V4[$i][$j] = max($V[$i][$j-1] - $indel_cost, $V2[$i][$j-1] - $indel_cost, $V5[$i][$j-1] - $indel_cost);
  $V5[$i][$j] = max($V2[$i][$j-1] + $indel_cost -$GAP, $V5[$i][$j-1]);
  if ($max < $V[$i][$j-1] - $indel_cost) {
    $max = $V[$i][$j-1] - $indel_cost;
  }

  if ($V[$i-1][$j] - $indel_cost > $max) {
    $max = $V[$i-1][$j] - $indel_cost;
  }

#   if ($max2 < $V2[$i][$j-1] - $indel_cost) {
#    $max2 = $V2[$i][$j-1] - $indel_cost;
 # }

 # if ($V2[$i-1][$j] - $indel_cost > $max2) {
 #   $max2 = $V2[$i-1][$j] - $indel_cost;
 # }

  # if ($max3 < $V3[$i][$j-1] - $indel_cost) {
   # $max3 = $V3[$i][$j-1] - $indel_cost;
 # }

  #if ($V3[$i-1][$j] - $indel_cost > $max3) {
  #  $max3 = $V3[$i-1][$j] - $indel_cost;
  #}

   #if ($max4 < $V4[$i][$j-1] - $indel_cost) {
   # $max4 = $V4[$i][$j-1] - $indel_cost;
 # }

  #if ($V4[$i-1][$j] - $indel_cost > $max4) {
   # $max4 = $V4[$i-1][$j] - $indel_cost;
  #}

   #if ($max5 < $V5[$i][$j-1] - $indel_cost) {
   # $max5 = $V5[$i][$j-1] - $indel_cost;
  #}

  #if ($V5[$i-1][$j] - $indel_cost > $max5) {
   # $max5 = $V5[$i-1][$j] - $indel_cost;
  #}
  $Best_score[$i][$j] = max($V[$i][$j], $V2[$i][$j], $V3[$i][$j], $V4[$i][$j], $V5[$i][$j]);
  $capcount++;
  print OUT "V[$i][$j] has value $Best_score[$i][$j]\n";
  print "$Best_score[$i][$j] ";
  if($capcount % $n == 0){
 	print "\n";
	$capcount =0;
  }
  }
}

print OUT "\n The similarity value of the two strings is $V[$n][$m]\n";
print OUT "The maximum value of any possible alignments is: $result\n";
close(OUT);
