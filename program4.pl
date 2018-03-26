#!/usr/bin/perl -w
# File: CGI-program4
use CGI qw(:standard);
use CGI::Carp qw/fatalsToBrowser/;

#Name of file - program4.pl
#Name         - Vaishnavi 
#Date         - November 27 2017
my $url = "http://binf.gmu.edu/vmethuku/cgi-bin/program4.pl";

#Based in part of Dr. Jeff Solka's lectures, bookcode, examplecode and
#programming assignment 1 - cpg.pl

print header;
print start_html('CGI for a FASTA file'),
    h2('Nucleotide and CpG dinucleotide Statisitcs Report'),            #prints the form's header
    start_multipart_form, p,
    "Upload a FASTA file:",                                             #lets the user choose the file 
    br, filefield(-name=>'filename'), p,
    reset, submit('submit','Submit File'), hr;  

if (param()) 
{                                   # this part is executes after user clicks SUBMIT button
   my $filehandle = upload('filename');
    

   # variable declarations:
   my @header = ();		            # array of headers
   my @sequence = ();		        # array of sequences
   my $count = 0;	                # number of sequences

   # reads FASTA file
   my $n = -1;			            # index of current sequence
   while (my $line = <$filehandle>) 
   {
    chomp $line;		            # removes training \n from line
    if ($line =~ /^>/) 
	   { 	                        # line starts with a ">"
	     $n++;			            # this starts a new header
	     $header[$n] = $line;	    # saves header line
	     $sequence[$n] = "";	    # starts a new (empty) sequence
       }
    else 
	   {
	     next if not @header;	    # ignores data before first header
	     $sequence[$n] .= $line     # appends to end of current sequence
       }
   }
   $count = $n+1;			        # set count to the number of sequences
   close INFILE;

   # removes white space from all sequences
   for (my $i = 0; $i < $count; $i++) 
         {
           $sequence[$i] =~ s/\s//g;
         }

   
   print h4("File uploaded:  $filehandle<br>");
   print p, hr; 
   
   #########to count the number of sequences in the input file
   print ("There are $count sequences in the file<br>");           #<br> is used instead of \n, it simply provides a new line

   my $total_length = 0;
   my $max_length = 0; 
   my $min_length = 0;
   my $avg_length = 0;
   my $seq_length = 0;
   for (my $i = 0; $i < $count; $i++)
         {
	        $seq_length = length($sequence[$i]);                   #finds the total length of all sequences
            $total_length = $total_length + $seq_length;    
      if ($i == 0) 
	        {
	         $max_length = $seq_length;                            #finds the Maximum sequence length
             $min_length = $seq_length;                            #finds the Minimum sequence length   
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
	 print ("Total sequence length = $total_length<br>");
	 print ("Maximum sequence length = $max_length<br>");
	 print ("Minimum sequence length = $min_length<br>");
	 
     $avg_length = $total_length / $count;                         #finds the Average sequence length
     print ("Average sequence length = $avg_length<br>");
	 print p;

     ## For each sequence

     for (my $i = 0; $i < $count; $i++) 
       {
	      my $count_A = 0;
          my $count_G = 0;
          my $count_C = 0;
          my $count_T = 0;
	      my $count_CpG = 0;
	      $seq_length = length($sequence[$i]);
	  
          print ("$header[$i]<br>");                                #prints the header line
	      print ("Length:", length $sequence[$i],"<br>");   	    #finds out the length of each sequence
	      for (my $position = 0; $position < length $sequence[$i]; $position++)
	      {
	         my $base = substr ($sequence[$i], $position, 1);       #finds out the count of each nucleotide in the sequence
		     my $bases = substr ($sequence[$i], $position, 2);      #finds out the count of CpG dinucleotides in the sequence
	         if ($base =~ /a/ig) {$count_A++;}
             elsif ($base =~ /g/ig) {$count_G++;}
             elsif ($base =~ /c/ig) {$count_C++;}
             elsif ($base =~ /t/ig) {$count_T++;}
             if ($bases =~ /cg/ig) {$count_CpG++;}   ###the variable $bases will consider two values and check if its CpG 
	      }                                             ###if(condition) is yes then counts CpG, 
	                                                    #if(condition) is false goes to the start of for loop 
	  
	     my $fraction_A = 0;                            
	     my $fraction_G = 0;                            
	     my $fraction_C = 0;                            
	     my $fraction_T = 0;                            
	     my $fraction_CpG = 0;                          
	 
	     $fraction_A = ($count_A / $seq_length);		#finds out the fraction of A nucleotide in sequence
	     $fraction_C = ($count_C / $seq_length);		#finds out the fraction of G nucleotide in sequence
	     $fraction_G = ($count_G / $seq_length);		#finds out the fraction of C nucleotide in sequence
	     $fraction_T = ($count_T / $seq_length);		#finds out the fraction of T nucleotide in sequence
	     $fraction_CpG = ($count_CpG / $seq_length );	#finds out the fraction of CpG nucleotide in sequence
	 
         printf ("A:%4d %1.2f<br>", $count_A, $fraction_A);         #prints the count and fraction of A nucleotide in sequence
         printf ("C:%4d %1.2f<br>", $count_C, $fraction_C);         #prints the count and fraction of C nucleotide in sequence
         printf ("G:%4d %1.2f<br>", $count_G, $fraction_G);         #prints the count and fraction of G nucleotide in sequence
         printf ("T:%4d %1.2f<br>", $count_T, $fraction_T);         #prints the count and fraction of T nucleotide in sequence
         printf ("CpG:%4d %1.2f<br>", $count_CpG, $fraction_CpG);   #prints the count and fraction of CpG nucleotide in sequence
		 print p;

         }
	print address( a({href=>$url},"Click here to submit another file."));
}
endform;
print end_html;
exit;
