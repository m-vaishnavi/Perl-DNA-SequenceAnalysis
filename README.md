# Perl-DNA-SequenceAnalysis


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
