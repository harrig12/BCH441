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

#test_file("../test_pointMutate.R")

detectMutationType <- function(wt, mutant){
  # Return whether a mutated sequence is missense, silent, or nonsense
  # Parameters:
  #   wt: a character vector of codons
  #   mutant: a chracter vector of codons
  #
  # Value: a string indicating the type of mutation

}

N <- 100000

