# Create list of 3 sequence IDs
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")
# Load the rentrez package into current environment
library(rentrez)
# Fetch sequences from NCBI & store w/in variable
Bburg <- entrez_fetch(db = "nuccore", # use NCBI core nucleotide database
                      id = ncbi_ids,  # use IDs as written above
                      rettype = "fasta") # Retrieval format set to FASTA

# Splitting the string by FASTA sequence using double newline as sep
Sequences <- strsplit(Bburg, split = "\n\n")

# Transforming Sequences --> dataframe
Sequences <- unlist(Sequences)

# Isolate Headers (FASTA label) from sequences
header <- gsub("(^>.*sequence)\\n[ATCG].*", "\\1", Sequences)
# Isolate Sequences from FASTA label
seq <- gsub("^>.*sequence\\n([ATCG].*)", "\\1", Sequences)
# Create new dataframe from composition of the two
Sequences <- data.frame(Name = header, Sequence = seq)

# Remove newline characters from Sequences dataframe
Sequences$Sequence <- gsub("\\n", "", Sequences$Sequence)

# Write Sequences to File
write.csv(Sequences, row.names = F, file = "./Sequences.csv")