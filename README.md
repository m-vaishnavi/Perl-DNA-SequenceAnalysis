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

___
### Program: *program3.pl*
___

The program *program3.pl* explores parsing a small set of PubMed records and uses the file *paraneuroplastic_syndrome_result.txt*. Here is the first record in the file.

    PMID- 19840554
    OWN - NLM
    STAT- In-Process
    DA  - 20091020
    IS  - 1097-4199 (Electronic)
    VI  - 64
    IP  - 1
    DP  - 2009 Oct 15
    TI  - Innate and adaptive autoimmunity directed to the central nervous system.
    PG  - 123-32
    AB  - The immune system has two major components, an innate arm and an adaptive arm.
          Certain autoimmune diseases of the brain represent examples of disorders where
          one of these constituents plays a major role. Some rare autoimmune diseases
          involve activation of the innate arm and include chronic infantile neurologic,
          cutaneous, articular (CINCA) syndrome. In contrast, adaptive immunity is
          prominent in multiple sclerosis, neuromyelitis optica, and the paraneoplastic
          syndromes where highly specific T cell responses and antibodies mediate these
          diseases. Studies of autoimmune brain disorders have aided in the elucidation of 
          distinct neuronal roles played by key molecules already well known to
          immunologists (e.g., complement and components of the major histocompatibility
          complex). In parallel, molecules known to neurobiology and sensory physiology,
          including toll-like receptors, gamma amino butyric acid and the lens protein
          alpha B crystallin, have intriguing and distinct functions in the immune system, 
          where they modulate autoimmunity directed to the brain.
    AD  - Beckman Center for Molecular Medicine, B002, Stanford University, Stanford, CA
          94305, USA.
    FAU - Bhat, Roopa
    AU  - Bhat R
    FAU - Steinman, Lawrence
    AU  - Steinman L
    LA  - eng
    PT  - Journal Article
    PL  - United States
    TA  - Neuron
    JT  - Neuron
    JID - 8809320
    SB  - IM
    EDAT- 2009/10/21 06:00
    MHDA- 2009/10/21 06:00
    CRDT- 2009/10/21 06:00
    PHST- 2009/09/09 [accepted]
    AID - S0896-6273(09)00697-7 [pii]
    AID - 10.1016/j.neuron.2009.09.015 [doi]
    PST - ppublish
    SO  - Neuron. 2009 Oct 15;64(1):123-32.

The *program3.pl* will extract the title, TI field, and abstract, AB field from each record in the file and computes word counts on each abstract field. Each abstract will have its own set of word counts, and the program writes these word counts out to a file called *word_counts.txt*. Here are the example word counts for the first abstract.

    (CINCA) 1
    (e.g., 1
    B 1
    Certain 1
    In 2
    Some 1
    Studies 1
    T 1
    The 1
    a 1
    acid 1
    activation 1
    adaptive 2
    aided 1
    alpha 1
    already 1
    amino 1
    an 2
    and 8
    antibodies 1
    arm 2
    arm. 1
    articular 1
    autoimmune 3
    autoimmunity 1
    brain 2
    brain. 1
    butyric 1
    by 1
    cell 1
    chronic 1
    complement 1
    complex). 1
    components 1
    components, 1
    constituents 1
    contrast, 1
    crystallin, 1
    cutaneous, 1
    directed 1
    diseases 2
    diseases. 1
    disorders 2
    distinct 2
    elucidation 1
    examples 1
    functions 1
    gamma 1
    has 1
    have 2
    highly 1
    histocompatibility 1
    immune 2
    immunity 1
    immunologists 1
    in 3
    include 1
    including 1
    infantile 1
    innate 2
    intriguing 1
    involve 1
    is 1
    key 1
    known 2
    lens 1
    major 3
    mediate 1
    modulate 1
    molecules 2
    multiple 1
    neurobiology 1
    neurologic, 1
    neuromyelitis 1
    neuronal 1
    of 7
    one 1
    optica, 1
    parallel, 1
    paraneoplastic 1
    physiology, 1
    played 1
    plays 1
    prominent 1
    protein 1
    rare 1
    receptors, 1
    represent 1
    responses 1
    role. 1
    roles 1
    sclerosis, 1
    sensory 1
    specific 1
    syndrome. 1
    syndromes 1
    system 1
    system, 1
    the 8
    these 2
    they 1
    to 3
    toll-like 1
    two 1
    well 1
    where 3

___
### Program: *program4.pl* - Nucleotide and CpG dinucleotide Statistics Report
___

The *program4.pl* allows the user to interact via CGI interface to get the "Nucleotide and CpG dinucleotide Statistics Report "	and successfully displays the statistics report back to the user in the same window as the uploaded browser window/popup window.
___
