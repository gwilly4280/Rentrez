# Load the rentrez package into current environment
library(rentrez)
# Fetch sequences from NCBI & store w/in variable
cov_fasta <- entrez_fetch(db = "nucleotide", # use NCBI nucleotide database
                      id = "NC_045512.2",  # Fetch the Supplied Accesscion No.
                      rettype = "fasta") # Retrieval format set to FASTA
# Remove header
cov_seq <- gsub("^>.*genome\\n([ATCG].*)", "\\1", cov_fasta)
# Remove line breaks
cov_seq <- gsub("\\n", "", cov_seq)

# Create a sub-string from index 21563 - 25384, inclusive
spike_seq <- substr(cov_seq, 21563, 25384)

# Blast results found 100% identity, or near 100%, for the top 100 searches.
# The 4 weakest matches ranged from 99.92% - 99.97% identity. 
# Graphic summary shows all matches with equivalent alignment size and score.
# Alignments are largely ungapped, long, and near 100% identity.
# From this I conclude that the SARS-CoV-2 spike protein is highly conserved
# and an unlikely candidate for rapid evolution.