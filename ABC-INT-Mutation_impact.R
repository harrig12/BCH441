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
  # Value: The index of the mutated codon, and the new mutant, as a list

  iCodon <- sample(length(gene), 1) #choose a codon
  iNT <- sample(3, 1) #choose a nucleotide within the codon to mutate

  myCodon <- unlist(strsplit(gene[iCodon], ""))
  myNT <- myCodon[iNT]
  nts <- c("A", "T", "C", "G")

  mutantNT <- sample(nts[nts != myNT], 1) #choose a nucleotide to mutate to
  myCodon[iNT] <- mutantNT #mutate codon
  myCodon <- paste0(myCodon, collapse = "")

  ret <- c(iCodon, myCodon)
  names(ret) <- c("mutantIndex", "mutant")

  return(ret)

}

test_file("../test_pointMutate.R")

detectMutationType <- function(wtGene, iMutant, mutantCodon, code=GENETIC_CODE){
  # Return whether a mutated sequence is missense, silent, or nonsense
  # Parameters:
  #   wt: a character vector of DNA codons
  #   mutant: a chracter vector of codons
  #   code: an optional reference genetic code
  #
  # Value: a string indicating the type of mutation
  #

  if (wtGene[iMutant] == mutantCodon){
    stop("no mutant found")
  }

  #translate the wt and mutant codon
  wtAA <- as.character(translate(DNAString(wtGene[iMutant]), genetic.code=code))
  mutantAA <- as.character(translate(DNAString(mutantCodon), genetic.code=code))

  if (wtAA == mutantAA){ #no mutation in peptide
    return("Silent")
  }

  if (iMutant != length(wtGene) & mutantAA == "*"){ #premature STOP in peptide
    return("Nonsense")
  }

  if (iMutant == length(wtGene) & mutantAA != "*"){ #final STOP codon missing
    return("Nonsense")
  }

  return("Missense") #if there is a mutant amino acid and it isn't nonsense, it is missense
}

test_file("../test_detectMutationType.R")

set.seed(122234)
N <- 1e5

#create result vectors for the three genes
KRasMutants <- c(0,0,0)
OR1A1Mutants <- c(0,0,0)
PTPN11Mutants <- c(0,0,0)
names(KRasMutants) <- names(OR1A1Mutants) <- names(PTPN11Mutants) <- c("Missense", "Silent", "Nonsense")

tic()
for (i in seq(to=N)){
  #mutate each gene
  KRasMutant <- pointMutate(KRascodons)
  OR1A1Mutant <- pointMutate(OR1A1codons)
  PTPN11Mutant <- pointMutate(PTPN11codons)

  #track the type of mutation that arises
  KRasMutantType <- detectMutationType(KRascodons, as.integer(KRasMutant["mutantIndex"]),
                                       KRasMutant["mutant"])
  OR1A1MutantType <- detectMutationType(OR1A1codons, as.integer(OR1A1Mutant["mutantIndex"]),
                                        OR1A1Mutant["mutant"])
  PTPN11MutantType <- detectMutationType(PTPN11codons, as.integer(PTPN11Mutant["mutantIndex"]),
                                         PTPN11Mutant["mutant"])
  #increase counters
  KRasMutants[KRasMutantType] <- KRasMutants[KRasMutantType] + 1
  OR1A1Mutants[OR1A1MutantType] <- OR1A1Mutants[OR1A1MutantType] + 1
  PTPN11Mutants[PTPN11MutantType] <- PTPN11Mutants[PTPN11MutantType] + 1

}
toc()
beep(2)

#See relative frequency of each mutation type when mutations induced stochastically
table(KRasMutants)/N
table(OR1A1Mutants)/N
table(PTPN11Mutants)/N

#save results
#save(KRasMutants, OR1A1Mutants, PTPN11Mutants, file = "ABC-INT_Mutation_impact_1e5Mutants.RData")

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

#add generated frequencies
KRasData <- rbind(KRasIntOGenPercent, (table(KRasMutants)/N))
OR1A1Data <- rbind(OR1A1IntOGenPercent, (table(OR1A1Mutants)/N))
PTPN11Data <- rbind(PTPN11IntOGenPercent, (table(PTPN11Mutants)/N))

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

#Look for significance between groups
chisq.test(rbind(KRasIntOGenFreq, table(KRasMutants))) #significant difference
chisq.test(rbind(OR1A1IntOGenFreq, table(OR1A1Mutants))) #significant difference
chisq.test(rbind(PTPN11IntOGenFreq, table(PTPN11Mutants))) #significant difference

chisq.test(rbind(KRasIntOGenFreq, OR1A1IntOGenFreq)) #significant difference
chisq.test(rbind(OR1A1IntOGenFreq, PTPN11IntOGenFreq)) #no significant difference
chisq.test(rbind(KRasIntOGenFreq, PTPN11IntOGenFreq)) #significant difference


#Compare PTPN11 to OR1A1 and KRas directly
IntOGenData <- rbind(KRasIntOGenPercent, OR1A1IntOGenPercent, PTPN11IntOGenPercent)

barplot(IntOGenData,
        beside = T,
        main = "IntOGen alone",
        legend = c("KRas", "OR1A1", "PTPN11")
)


