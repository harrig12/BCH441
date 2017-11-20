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
if (! require(beepr, quietly=TRUE)) {
  install.packages("beepr")
  library(beepr)
}
if (! require(tictoc, quietly=TRUE)) {
  install.packages("tictoc")
  library(tictoc)
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
  wtPeptide <- as.character(translate(DNAString(paste0(wt, collapse="")),
                                      genetic.code=code))
  mutantPeptide <- as.character(translate(DNAString(paste0(mutant, collapse="")),
                                          genetic.code=code))

  if (sum(adist(wtPeptide, mutantPeptide)) < 1){ #no mutation in peptide
    return("Silent")
  }

  if (length(unlist(strsplit(mutantPeptide, "\\*"))) > 1){ #premature STOP in peptide
    return("Nonsense")
  }

  return("Missense") #if there is a mutant amino acid and it isn't a STOP, it is missense
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
table(KRasMutants)/N
table(OR1A1Mutants)/N
table(PTPN11Mutants)/N

#save since it took so long to get these results
#save(KRasMutants, OR1A1Mutants, PTPN11Mutants, file = "ABC-INT_Mutation_impact_1e5Mutants.R")

#Mutation frequencies by type retrieved from IntOGen November 20 2017
KRasIntOGenN <- 542
OR1A1IntOGenN <- 51
PTPN11IntOGenN <- 82

#Prepare IntOGen mutation frequencies
mutTypes <- c("Missense", "Silent", "Nonsense")

KRasIntOGenFreq <- c(537, 5, 0)
KRasIntOGenPercent <- KRasIntOGenFreq / KRasIntOGenN
names(KRasIntOGenPercent) <- mutTypes

OR1A1IntOGenFreq <- c(30, 18, 3)
OR1A1IntOGenPercent <- OR1A1IntOGenFreq / OR1A1IntOGenN
names(OR1A1IntOGenPercent) <- mutTypes

PTPN11IntOGenFreq <- c(67, 12, 3)
PTPN11IntOGenPercent <- PTPN11IntOGenFreq / PTPN11IntOGenN
names(PTPN11IntOGenPercent) <- mutTypes


#Ensure columns from Random Mutants are in same order as IntOGen data

orderMutationTable <- function(mutationTable){
  #order columns of passed table such that left to right they read Missense, Silent, Nonsense
  orderedMutants <- c(mutationTable[names(mutationTable) == "Missense"],
                      mutationTable[names(mutationTable) == "Silent"],
                      mutationTable[names(mutationTable) == "Nonsense"])
  return(orderedMutants)
}

test_file("test_orderMutationTable.R")

#add generated frequencies
KRasData <- rbind(KRasIntOGenPercent, orderMutationTable(table(KRasMutants)/N))
OR1A1Data <- rbind(OR1A1IntOGenPercent, orderMutationTable(table(OR1A1Mutants)/N))
PTPN11Data <- rbind(PTPN11IntOGenPercent, orderMutationTable(table(PTPN11Mutants)/N))


#Create barplots for each gene
barplot(KRasData,
        beside = T,
        main = "KRas mutation types",
        col = c("green4", "greenyellow"),
        legend = c("IntOGen Data", "Random Mutant")
)


barplot(OR1A1Data,
        beside = T,
        main = "OR1A1 mutation types",
        col = c("blue", "dodgerblue1"),
        legend = c("IntOGen Data", "Random Mutant")
)

barplot(PTPN11Data,
        beside = T,
        main = "PTPN11 mutation types",
        col = c("brown1", "firebrick4"),
        legend = c("IntOGen Data", "Random Mutant")
)

