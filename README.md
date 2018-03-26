## Nucleotide Composition and Analysis of DNA Sequences

### Program: *cpg.pl*
___

#### Description:
    A dinucleotide is a sequence of two nucleotides in DNA or RNA. For example, the dinucleotide CpG occurs in "islands" of 300-30,000 base pairs in and near approximately 40% of promoters of mammalian genes (and about 70% in human promoters). The "p" in CpG notation refers to the phosphodiester bond between the cytosine and the guanine. CG suppression is a term for the phenomenon that CpG dinucleotides are very uncommon in most portions of vertebrate genomes. In human and mouse, CpGs are the least frequent dinucleotide, making up less than 1% of all dinucleotides, so the CpG islands are actually pretty strong signals for a nearby gene.
  
*cpg.pl* reports the nucleotide and CpG composition of a set of DNA sequences.

##### *INPUT*:
  The program takes one command line argument: the name of a DNA sequence file in FASTA format. 
    *(The command line to run the program is % cpg.pl sequence_file)*

##### *OUTPUT*:
  The program prints the following to the terminal. First, prints a report on the entire set of sequences consisting of:
  
    - the number of sequences in the input file
    - the total length of all sequences
    - the maximum sequence length
    - the minimum sequence length
    - the average length of the sequences

  And for each sequence it prints:
  
    - the header line
    - the length of the sequence
    - the count and the fraction of the nucleotides A, C, G, T in the sequence with 2 decimal places for the fractions.
    - the count and fraction of the CpG dinucleotide for the sequence.

___
### Program: *program2.pl*
___

*program2.pl* Functionalizes the code from *cpg.pl* and is an extension of its capabilities.

1 – Created a function *read_fasta*, which takes the name of a FASTA file and will open it and read the headers into an array @header and the sequences into an array @sequence. This function will use references to “send” the @header and @sequence array back to the user’s main program.

2 – Created a function *write_fasta*, which takes a filename ($filename) as input and writes @header and @sequence information out to the file $filename.

3- Created a function *stat_fasta*, which takes @sequence, @header, $filename and will use references to send the arrays @acounts, @ccounts, @gcounts, @tcounts, @cgcounts, @aprops, @cprops, @gprops, @tpropos, @cgprops back to the user. This function will also write out the same report file as in *cpg.pl* to the file *$filename.ot*. 

4 -  Created a function *permute_fasta*, which takes the array of sequences @sequence as input and returns a new sequences array where each entry in the array is a string that is merely a random permutation of the original string. 

5 – The program *program2.pl* performs the following:

    Reads in a filename from the command line.
    Calls read_fasta (let’s assume the  name is genes.fsa)
    Calls stat_fasta (this will write genes.ot)
    Calls permute_fasta
    Calls write_fasta with a name like this assuming the original name was genes.fsa, genes_permute.fsa.
    Calls stat_fasta with this new file to write out genes_permute.fsa.

6 – If the program *program2.pl* is correctly configured then the a,c,g, and t couts and proportions should be identical to the program *cpg.pl*. 



