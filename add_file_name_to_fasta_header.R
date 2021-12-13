#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

### author: "Constantinos Yeles (Konstantinos Geles)"
### Initial Commit: 10/12/2021

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n
       Usage: Rscript add_filename_to_fasta_header.R 'path/to/contigs  path/to/write/all/contigs/fasta'", call.=FALSE)
}

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
if (!requireNamespace("Biostrings", quietly = TRUE))
  BiocManager::install("Biostrings", ask = FALSE)

library(Biostrings, verbose = TRUE, quietly = TRUE)
consensus_files <- list.files(path = args[1], pattern = "consensus", full.names = TRUE, recursive = TRUE)

#consensus_files <- consensus_files[grep(consensus_files, pattern="intermediate_contigs|all_contigs", invert=TRUE)]

names(consensus_files) <- gsub(x=basename(consensus_files), pattern="_filtered.vcf.fa", replacement="")

my_fasta <- lapply(consensus_files, Biostrings::readDNAStringSet)

my_named_fasta <- unlist(Biostrings::DNAStringSetList(my_fasta))

Biostrings::writeXStringSet(x = my_named_fasta, filepath = args[2])
