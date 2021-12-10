#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

### author: "Constantinos Yeles (Konstantinos Geles)"
### Initial Commit: 10/12/2021

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n
       Usage: Rscript add_filename_to_fasta_header.R 'path/to/contigs  path/to/write/all/contigs/fasta'", call.=FALSE)
}
library(Biostrings,quietly = TRUE)
contig_files <- list.files(path = args[1], pattern = "contigs", full.names = TRUE, recursive = TRUE)

contig_files <- contig_files[grep(contig_files, pattern="intermediate_contigs|all_contigs", invert=TRUE)]

names(contig_files) <- gsub(x=basename(contig_files), pattern=".contigs.fa", replacement="")

my_fasta <- lapply(contig_files, Biostrings::readDNAStringSet)

my_named_fasta <- unlist(Biostrings::DNAStringSetList(my_fasta))

Biostrings::writeXStringSet(x = my_named_fasta, filepath = args[2])
