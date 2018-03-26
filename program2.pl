#!/usr/bin/perl 
use strict;
use warnings;
use List::Util qw(shuffle);
use File::Basename;

#Name of file - program2.pl
#Name         - Vaishnavi 
#Date         - October 06 2017

#Based in part on fasta.pl by Dr. Jeff Solka

#Reads the sequences from a FASTA format file
if (scalar @ARGV < 1)
{
die "usage: assignment2.pl filename\n" 
}
#Step_1
####### command line input
my $filename = $ARGV[0];
my ($name,$path,$suffix) = fileparse($filename,".fsa");

#Step_2
####### read FASTA file  - Subroutine call
my ($headerRef,$sequenceRef) = read_fasta ($filename);

#Step_3
####### stat FASTA - Subroutine call 
my ($ref_acount, $ref_ccount, $ref_gcount, $ref_tcount, $ref_cgcounts,
$ref_aprops, $ref_cprops, $ref_gprops, $ref_tprops, $ref_cgprops) = stat_fasta ("$name.ot", $headerRef, $sequenceRef); 
print ("\nCounts of A: ", join (" ", @$ref_acount), "\n");                                            #dereferencing
print ("Counts of C: ", join (" ", @$ref_ccount), "\n");
print ("Counts of G: ", join (" ", @$ref_gcount), "\n");
print ("Counts of T: ", join (" ", @$ref_tcount), "\n");
print ("Counts of CG: ",join (" ", @$ref_cgcounts), "\n");
print ("\nProportions of A: ",join (" ", @$ref_aprops), "\n");
print ("Proportions of C: ",join (" ", @$ref_cprops), "\n");
print ("Proportions of G: ",join (" ", @$ref_gprops), "\n");
print ("Proportions of T: ",join (" ", @$ref_tprops), "\n");
print ("Proportions of CG: ",join (" ", @$ref_cgprops), "\n\n");

 
#Step_4 
####### permute FASTA - Subroutine call
for (my $i = 0; $i < scalar @$sequenceRef; $i++) {
#print " Actual String: @$sequenceRef[$i] \n";
@$sequenceRef[$i]=permute_fasta (@$sequenceRef[$i]);
#print " Change String: @$sequenceRef[$i] \n";
}

#Step_5
####### write FASTA - Subroutine call
write_fasta ("$name"."_permute.fsa", $headerRef, $sequenceRef);

#Step_6
####### stat FASTA - Subroutine call
stat_fasta ("$name"."_permute.ot", $headerRef, $sequenceRef);

#print (@$headerRef);                 #dereferencing 
#print (@$sequenceRef);               #dereferencing

#Subroutine definition
sub read_fasta
{
my ($filename) = @_;
open(INFILE, $filename) or die "Can't open $filename\n";
my @header = ();		              # array of headers
my @sequence = ();		       		  # array of sequences
my $count = 0;	         			  # number of sequences

my $n = -1;			    			  # index of current sequence`
while (my $line = <INFILE>) {
    chomp $line;		  			  # removes training \n from line
    if ($line =~ /^>/) { 		      # lines starting with a ">"
	$n++;			    			  # starts a new header
	$header[$n] = $line;	          # saves header line
	$sequence[$n] = "";	   			  # starts a new (empty) sequence
    }
    else {
	next if not @header;		      # ignores data before first header
	$sequence[$n] .= $line 		      # appends to end of current sequence
    }
}
$count = $n+1;			 			  # sets count to the number of sequences
close INFILE;

# removes white space from all sequences
for (my $i = 0; $i < $count; $i++) 
    {
     $sequence[$i] =~ s/\s//g;
    }
return (\@header, \@sequence);        #refers to @header and @sequence
}

#Subroutine definition
sub write_fasta
{
my ($write_filename, $array_headerRef, $array_sequenceRef) = @_;
open (my $fh, '>', $write_filename) or die "Could not open file '$write_filename' $!";          
for (my $i = 0; $i < scalar @$array_headerRef; $i++)
   {
    print $fh @$array_headerRef[$i], "\n";          #prints each header followed by its sequence
    print $fh @$array_sequenceRef[$i], "\n";
   }
close $fh;
}

#Subroutine definition
sub stat_fasta
{
my ($write_filename, $array_headerRef, $array_sequenceRef) = @_; 
open (my $file, '>', $write_filename) or die "cannot open file '$write_filename' $!";

## For each sequence
my (@a_counts, @c_counts, @g_counts, @t_counts, @cg_counts);
my (@a_props, @c_props, @g_propts, @t_props, @cg_props);

print ($file "There are ", scalar @$array_headerRef, " sequences in the file");          #finds the number of sequences in the given file
      
	  my $total_length = 0;
      my $max_length = 0; 
      my $min_length = 0;
      my $avg_length = 0;
      
for (my $i = 0; $i < scalar @$array_headerRef; $i++)
    {
	  my $seq_length = length (@$array_sequenceRef[$i]);
	  $total_length = $total_length + $seq_length;    
      if ($i == 0) 
	  {
	  $max_length = $seq_length;   					  # to find the Maximum sequence length
      $min_length = $seq_length;          	          # to find the Minimum sequence length   
	  }
	  else
	  { 
	    if ($max_length < $seq_length)
		{
		  $max_length = $seq_length; 
	    }
		
		if ($min_length > $seq_length)
		{
		   $min_length = $seq_length;
		}
	  }
	  
    }
	 print ($file "\nTotal sequence length = $total_length\n");
	 print ($file "Maximum sequence length = $max_length\n");
	 print ($file "Minimum sequence length = $min_length\n");
	 
$avg_length = $total_length / scalar @$array_headerRef;                         # to find the Average sequence length
print ($file "Ave sequence length = $avg_length\n");


for (my $i = 0; $i < scalar @$array_headerRef; $i++) 
    {
	  my $acounts = 0;
      my $ccounts = 0;
      my $gcounts = 0;
      my $tcounts = 0;
	  my $cgcounts = 0;
	  my $seq_length = length (@$array_sequenceRef[$i]);
	  print ($file @$array_headerRef[$i], "\n");                   			    # to print the header line
	  print ($file "Length:", $seq_length, "\n");   							# to find the length of each sequence
	  
	  	  
	  

    for (my $position = 0; $position < $seq_length; $position++)
	  {
	       my $base = substr (@$array_sequenceRef[$i], $position, 1);           # to find the count of each nucleotide in the sequence
		   my $bases = substr (@$array_sequenceRef[$i], $position, 2);          # to find the count of CpG dinucleotides in the sequence
	       if ($base =~ /a/ig) {$acounts++;}
           elsif ($base =~ /c/ig) {$ccounts++;}
           elsif ($base =~ /g/ig) {$gcounts++;}
           elsif ($base =~ /t/ig) {$tcounts++;}
           if ($bases =~ /cg/ig) {$cgcounts++;}         ###the variable $bases will consider two values and check if its CpG 
	  }                                           		###if(condition) is yes then counts CpG, if(condition) is false goes to the start of for loop 
	
      my $aprops = 0;                         		    
	  my $cprops = 0;									
	  my $gprops = 0;									
	  my $tprops = 0;									
	  my $cgprops = 0;                          		
	 
	  $aprops = ($acounts / $seq_length);				# to find the proportion of nucleotide A in sequence
	  $cprops = ($ccounts / $seq_length);				# to find the proportion of nucleotide C in sequence
	  $gprops = ($gcounts / $seq_length);				# to find the proportion of nucleotide G in sequence
	  $tprops = ($tcounts / $seq_length);				# to find the proportion of nucleotide T in sequence
	  $cgprops = ($cgcounts / $seq_length );			# to find the proportion of CpG composition in sequence
	  
	  
	  $a_counts[$i] = $acounts;     			#  $a_counts[$i] gets the count of A's found in each sequence. 
	  $c_counts[$i] = $ccounts;                 #  $c_counts[$i] gets the count of C's found in each sequence.
	  $g_counts[$i] = $gcounts;                 #  $g_counts[$i] gets the count of G's found in each sequence.
	  $t_counts[$i] = $tcounts;                 #  $t_counts[$i] gets the count of T's found in each sequence.
	  $cg_counts[$i] = $cgcounts;               #  $cg_counts[$i] gets the count of CG's found in each sequence.
	 
	  $a_props[$i] = $aprops;                   #  $a_props[$i] gets the proportions of A's found in each sequence.
	  $c_props[$i] = $cprops;                   #  $c_props[$i] gets the proportions of C's found in each sequence.
      $g_propts[$i] = $gprops;                  #  $g_props[$i] gets the proportions of G's found in each sequence.
	  $t_props[$i] = $tprops;                   #  $t_props[$i] gets the proportions of T's found in each sequence.
      $cg_props[$i] = $cgprops;                 #  $cg_props[$i] gets the proportions of CG's found in each sequence.
	 
      printf $file ("A:%4d %1.2f\n", $acounts, $aprops);	# prints the counts and proportions of nucleotide A
      printf $file ("C:%4d %1.2f\n", $ccounts, $cprops);	# prints the counts and proportions of nucleotide C
      printf $file ("G:%4d %1.2f\n", $gcounts, $gprops);	# prints the counts and proportions of nucleotide G
      printf $file ("T:%4d %1.2f\n", $tcounts, $tprops);	# prints the counts and proportions of nucleotide T
      printf $file ("CG:%4d %1.2f\n", $cgcounts, $cgprops); # prints the counts and proportions of CG  
    }
	close $file;
	 return (\@a_counts, \@c_counts, \@g_counts, \@t_counts, \@cg_counts, \@a_props, \@c_props, \@g_propts, \@t_props, \@cg_props);
}


#Subroutine definition
sub permute_fasta
{ 
my ($array_string) = @_;
my @array = split('', $array_string);           #explodes the string into separate elements
my @shuffled = shuffle(@array);                 #shuffles the elements in an array
my $string = join('', @shuffled);               #joins them back to form a string
return $string;
}