# ABC-INT-Mutation_impact.R
#
# Purpose:  A Bioinformatics Course:
#              R code accompanying the ABC-INT-Mutation_impact unit.
#              A Short Report submission has been prepared to accompany this script.
#
# Note:    This script lives on Github:
#          https://github.com/harrig12/BCH441
#
# Version:  1.0
#
# Date:     2017  11 09
# Author:   Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# Versions:
#           1.0    First code
#
# Task:
#           1) Open the RStudio course project.
#           2) Begin a new R script to explore KRas, PTPN11 and OR1A1 mutations.
#           3) Load the data file of mRNAs I have prepared for you. This will
#              create the three R objects, KRascodons, PTPN11codons, and
#              OR1A1codons
#           4) Write code that executes a loop N times (for N <- 100000) to
#              create a point mutation randomly in each of the three genes.
#              Keep track of the number of missense, silent ("synonymous"),
#              and nonsense ("truncating") mutations you find.
#           5) Contrast that with the relative frequency of the mutations in
#              each category reported on the IntOGen Web page for each of the
#              three genes.
#           6) Establish if there is a significant difference between the
#              expected categories of mutations (i.e. the stochastic background
#              that you simulated), and categories of mutations that were
#              observed in cancer genomes.
#           7) Write a short report that interprets your results against the
#              context outlined above: what would you expect if any of these
#              genes were cancer drivers, what do you observe, what can you
#              conclude from your observation? Include a histogram of the
#              expected distribution and the observed values.
# ==============================================================================

load(file = "./data/ABC-INT-Mutation_impact.RData")

if (! require(Biostrings, quietly=TRUE)) {
  if (! exists("biocLite")) {
    source("https://bioconductor.org/biocLite.R")
  }
  biocLite("Biostrings")
  library(Biostrings)
}

if (! require(testthat, quietly=TRUE)) {
  install.packages("testthat")
  library(testthat)
}

pointMutate <- function(gene){
  # Create a single point mutation in passed gene
  # Parameters:
  #   gene: a caracter vector of codons
  #
  # Value: a caracter vector of codons, differing by one letter from the passed gene

  iCodon <- sample(length(gene), 1) #choose a codon
  iNT <- sample(3, 1) #choose a nucleotide within the codon to mutate

  myCodon <- unlist(strsplit(gene[iCodon], ""))
  myNT <- myCodon[iNT]
  nts <- c("A", "T", "C", "G")

  mutantNT <- sample(nts[nts != myNT], 1) #choose a nucleotide to mutate to
  myCodon[iNT] <- mutantNT #mutate codon

  myCodon <- paste0(myCodon, collapse = "")
  gene[iCodon] <- myCodon #place mutant codon in gene
  return(gene)

}

test_file("../test_pointMutate.R")

detectMutationType <- function(wt, mutant, code=GENETIC_CODE){
  # Return whether a mutated sequence is missense, silent, or nonsense
  # Parameters:
  #   wt: a character vector of DNA codons
  #   mutant: a chracter vector of codons
  #   code: an optional reference genetic code
  #
  # Value: a string indicating the type of mutation
  #

  if (length(wt) != length(mutant)){
    stop("input lengths may not differ")
  }

  if (all(wt == mutant)){
    stop("strings match, no mutant found")
  }

  #translate the input DNA sequences
  wtPeptide <- as.character(translate(DNAString(paste0(wt, collapse = "")),
                                      genetic.code = code))
  mutantPeptide <- as.character(translate(DNAString(paste0(mutant, collapse = "")),
                                          genetic.code = code))

  if (sum(adist(wtPeptide, mutantPeptide)) < 1){ #no mutation in peptide
    return("silent")
  }

  if (length(unlist(strsplit(mutantPeptide, "\\*"))) > 1){ #premature STOP in peptide
    return("nonsense")
  }

  return("missense") #if there is a mutant amino acid and it isn't a STOP, it is missense
}

test_file("../test_detectMutationType.R")

N <- 100000

#create result vectors for the three genes
KRasMutants <- character()
OR1A1Mutants <- character()
PTPN11Mutants <- character()

tic()
for (i in seq(to=N)){
  #mutate each gene
  KRasMutant <- pointMutate(KRascodons)
  OR1A1Mutant <- pointMutate(OR1A1codons)
  PTPN11Mutant <- pointMutate(PTPN11codons)

  #track the type of mutation that arises
  KRasMutants[i] <- detectMutationType(KRascodons, KRasMutant)
  OR1A1Mutants[i] <- detectMutationType(OR1A1codons, OR1A1Mutant)
  PTPN11Mutants[i] <- detectMutationType(PTPN11codons, PTPN11Mutant)
}
toc()
beep(2)

#See relative frequency of each mutation type when mutations induced stochastically
table(KRasMutants)
table(OR1A1Mutants)
table(PTPN11Mutants)



