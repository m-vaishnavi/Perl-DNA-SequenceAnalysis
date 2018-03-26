#!/usr/bin/perl 
use strict;
use warnings;
#Name of file - cpg.pl
#Name         - Vaishnavi Methuku (G01029508)
#Date         - 18 September  2017

#Based in part on fasta.pl by Dr. Jeff Solka

# Purpose: Read sequences from a FASTA format file

# the argument list should contain the file name
if (scalar @ARGV < 1)
{
die "usage: cpg.pl filename\n" 
}

# get the filename from the argument list
my ($filename) = @ARGV;
$filename = $ARGV[0];


# Open the file given as the first argument on the command line
open(INFILE, $filename) or die "Can't open $filename\n";

# variable declarations:
my @header = ();		    		# array of headers
my @sequence = ();		    		# array of sequences
my $count = 0;	                    # number of sequences

# read FASTA file
my $n = -1;			   				# index of current sequence
while (my $line = <INFILE>) {
chomp $line;		            
if ($line =~ /^>/) { 	            # if the line starts with a ">"
$n++;			           			# starts a new header
$header[$n] = $line;	            # saves header line
$sequence[$n] = "";	            	# starts a new (empty) sequence
}
else {
next if not @header;	            # ignores data before first header
$sequence[$n] .= $line              # appends to end of current sequence
}
}
$count = $n+1;			    		# sets the count to the number of sequences
close INFILE;

# remove white space from all sequences
for (my $i = 0; $i < $count; $i++) 
{
$sequence[$i] =~ s/\s//g;
}

#########the number of sequences in the input file
print ("\nThere are $count sequences in the file\n");       

my $total_length = 0;
my $max_length = 0; 
my $min_length = 0;
my $avg_length = 0;
my $seq_length = 0;
for (my $i = 0; $i < $count; $i++)
{
$seq_length = length($sequence[$i]);                # Calculates the total length of all sequences
$total_length = $total_length + $seq_length;    
if ($i == 0) 
{
$max_length = $seq_length;                          # Calculates the Maximum sequence length
$min_length = $seq_length;                          # Calculates the Minimum sequence length   
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
print ("Total sequence length = $total_length\n");
       	  	  	  	    				  	    								   			  	      	 	 
print ("Maximum sequence length = $max_length\n");
     	  	  	    				  	    								   			  	      	 	 	 
print ("Minimum sequence length = $min_length\n");
    	  	      				  	    								   			  	      	 	 	 	 
$avg_length = $total_length / $count;                # Calculates the Average sequence length
       	  	    				  	    								   			  	      	 	 	 	 
print ("Ave sequence length = $avg_length\n");
        			        		                     	            	  	        	  	  	  	    				  	    
## For each sequence  	  	  	      								   			  	      	 	 	 	 
for (my $i = 0; $i < $count; $i++)             	  	   								   			  	      	 	 	 	     
{     	    				  	    								   			  	      	 	 	 	     	  
my $count_A = 0;			      								   			  	      	 	 	 	     	       
my $count_G = 0;
my $count_C = 0;		  	    						   			  	      	 	 	 	     	                    
my $count_T = 0;   	    								   			  	      	 	 	 	     	                    	  
my $count_CpG = 0;   									  	      	 	 	 	     	                    	  	  
$seq_length = length($sequence[$i]);
            	  					   			  	      	 	 	 	     	                    	  	  	        
print ("$header[$i]\n");                    		# Prints the header line                  	 	 	 	     	                    	  	  	        	  
print ("Length:", length $sequence[$i],"\n");   	# Calculates  length of each sequence                 	                    	  	  	        	  	  
for (my $position = 0; $position < length $sequence[$i]; $position++)        			       	         	  	  	        	  	  	  
{		  	    					 	 	 	     	                    	  	  	        	  	  	  	       
my $base = substr ($sequence[$i], $position, 1);    #Calculates the count of each nucleotide in the sequence	 	                   	      		   
my $bases = substr ($sequence[$i], $position, 2);   #Calculates  the count of CpG dinucleotides in the sequence       			      	            	  		
if ($base =~ /a/ig) {$count_A++;}                 	              	 	 	 	     	        	  	  	  	       		   	                  
elsif ($base =~ /g/ig) {$count_G++;}
elsif ($base =~ /c/ig) {$count_C++;}        			        		            				  	    						 
elsif ($base =~ /t/ig) {$count_T++;}
if ($bases =~ /cg/ig) {$count_CpG++;}               #the variable $bases will consider two values and check if its CpG         				   			      
}                                                   #if(condition) is yes then counts CpG, if(condition) is false goes to the start of for loop   								   			  	      	 	 	  	  	  	       		   	                                                   	  	  	  
my $fraction_A = 0;                                        	                                             	  	  	  	  
my $fraction_G = 0;  	  	  	         	 	 	       		   	                                                   	  	  	  	  	  
my $fraction_C = 0;		  	    	               	  	  	        	  	                                   	  	  	  	  	  	  
my $fraction_T = 0;       	  	      	     		
my $fraction_CpG = 0;       	                                       	  	  
	  	  	  	  	  	 	  
$fraction_A = ($count_A / $seq_length);  	  	  		#Calculates the fraction of nucleotide A in sequence  	       		   	                	  	  	  	  	  	  	 	  	  
$fraction_C = ($count_C / $seq_length);		        	#Calculates the fraction of nucleotide G in sequence            	  	  	  	  	  	  	  	 	  	  	  
$fraction_G = ($count_G / $seq_length);		        	#Calculates the fraction of nucleotide C in sequence             	  	  	  	  	  	  	  	  	 	  	  	  	  
$fraction_T = ($count_T / $seq_length);      			#Calculates the fraction of nucleotide T in sequence   	                                                    	  	  	 	  	  	  	  	  
$fraction_CpG = ($count_CpG / $seq_length );			#Calculates the fraction of CpG composition in sequence 
             	  	  	  	  	  	  	  	 	  	  	  	  	  	       
printf ("A:%4d %1.2f\n", $count_A, $fraction_A);    	#Prints the count and fraction of nucleotide A in sequence   	  	        	           	 	 	  	  	  	  	  	             
printf ("C:%4d %1.2f\n", $count_C, $fraction_C);  		#Prints the count and fraction of nucleotide C in sequence     	                                                   	  	  	                   
printf ("G:%4d %1.2f\n", $count_G, $fraction_G);   		#Prints the count and fraction of nucleotide G in sequence        	  	  	  	  	  	  	  	 	  	                      
printf ("T:%4d %1.2f\n", $count_T, $fraction_T);		#Prints the count and fraction of nucleotide T in sequence                 	  	  	 	  	  	  	  	  	                               
printf ("CpG:%4d %1.2f\n", $count_CpG, $fraction_CpG); 	#Prints the count and fraction of CpG composition in sequence                                           	 	  	  	  	  	  	                               	
}       	  	  	             	  	  	  	  	  	  	  	 	  	  	  	  	  	                               	
exit;
