# FND-Genetic_code.R
#
# Purpose:  A Bioinformatics Course:
#              R code accompanying the FND-Genetic_code unit.
#
# Version:  1.0.1
#
# Date:     2017  10  12
# Author:   Boris Steipe (boris.steipe@utoronto.ca)
#
# Versions:
#           1.0.1  Comment on "incomplete final line" warning in FASTA
#           1.0    First live version
#
# TODO:
#
#
# == DO NOT SIMPLY  source()  THIS FILE! =======================================
#
# If there are portions you don't understand, use R's help system, Google for an
# answer, or ask your instructor. Don't continue if you don't understand what's
# going on. That's not how it works ...
#
# ==============================================================================


#TOC> ==========================================================================
#TOC>
#TOC>   Section  Title                                      Line
#TOC> ----------------------------------------------------------
#TOC>   1        Storing the genetic code                     47
#TOC>   1.1      Genetic code in Biostrings                   65
#TOC>   2        Working with the genetic code                97
#TOC>   2.1      Translate a sequence.                       126
#TOC>   3        An alternative representation: 3D array     208
#TOC>   3.1      Print a Genetic code table                  241
#TOC>   4        Tasks                                       267
#TOC>
#TOC> ==========================================================================


# =    1  Storing the genetic code  ============================================

# The genetic code maps trinucleotide codons to amino acids. To store it, we
# need some mechanism to associate these two informattion items. The most
# convenient way to do that is a "named vector" which holds the maino acid
# code and assigns the codons as names to its elements.

x <- c("M", "*")
names(x) <- c("ATG", "TAA")
x

# Then we can access the vector by the codon as name, and retrieve the
# amino acid.

x["ATG"]
x["TAA"]


# ==   1.1  Genetic code in Biostrings  ========================================

# Coveniently, the standard genetic code as well as its alternatives are
# available in the Bioconductor "Biostrings" package:


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
# Package information:
#  library(help = Biostrings)       # basic information
#  browseVignettes("Biostrings")    # available vignettes
#  data(package = "Biostrings")     # available datasets


# The standard genetic code vector
GENETIC_CODE

# The table of genetic codes. This information corresponds to this page
# at the NCBI:
# https://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes
GENETIC_CODE_TABLE

# Most of the alternative codes are mitochondrial codes. The id of the
# Alternative Yeast Nuclear code is "12"
getGeneticCode("12")  # Alternative Yeast Nuclear


# =    2  Working with the genetic code  =======================================

# GENETIC_CODE is a "named vector"

str(GENETIC_CODE)

# ... which also stores the alternative initiation codons TTG and CTG in
# an attribute of the vector. (Alternative initiation codons sometimes are
# used instead of ATG to intiate translation, if if not ATG they are translated
# with fMet.)

attr(GENETIC_CODE, "alt_init_codons")

# But the key to use this vector is in the "names" which we use for subsetting
# the list of amino acids in whatever way we need.
names(GENETIC_CODE)

# The translation of "TGG" ...
GENETIC_CODE["TGG"]

# All stop codons
names(GENETIC_CODE)[GENETIC_CODE == "*"]

# All start codons
names(GENETIC_CODE)[GENETIC_CODE == "M"] # ... or
c(names(GENETIC_CODE)[GENETIC_CODE == "M"],
  attr(GENETIC_CODE, "alt_init_codons"))


# ==   2.1  Translate a sequence.  =============================================


# I have provided a gene sequence in the data directory:
# S288C_YDL056W_MBP1_coding.fsa is the yeast Mbp1 FASTA sequence.

# read it
mbp1 <- readLines("./data/S288C_YDL056W_MBP1_coding.fsa")

# You will notice that this generates a Warning message:
#      Warning message:
#        In readLines("./data/S288C_YDL056W_MBP1_coding.fsa") :
#        incomplete final line found on './data/S288C_YDL056W_MBP1_coding.fsa'

# The reason for this is that the last character of the file is the letter "A"
# and not a "\n" line break. This file is exactly how it was sent from the
# server; I think good, defensive programming practice would have been to
# include some kind of an end-marker in the file, like a final "\n". This helps
# us recognize an incomplete transmission. Let's parse the actual sequence from
# the file, and then check for completeness.


head(mbp1)

# drop the first line (header)
mbp1 <- mbp1[-1]
head(mbp1)

# concatenate it all to a single string
mbp1 <- paste(mbp1, sep = "", collapse = "")

# how long is it?
nchar(mbp1)

# how many codons?
nchar(mbp1)/3

# That looks correct for the 833 aa sequence plus 1 stop codon. This gives us a
# first verification that the file we read is complete, the nucleotides of a
# complete ORF should be divisible by 3.

# Extract the codons. There are many ways to split a long string into chunks
# of three characters. Here we use the Biostrings  codons()  function. codons()
# requires an object of type DNAstring - a special kind of string with
# attributes that are useful for Biostrings. Thus we convert the sequence first
# with DNAstring(), then split it up, then convert it into a plain
# character vector.
mbp1Codons <- as.character(codons(DNAString(mbp1)))

head(mbp1Codons)

# now translate each codon

mbp1AA <- character(834)
for (i in seq_along(mbp1Codons)) {
  mbp1AA[i] <- GENETIC_CODE[mbp1Codons[i]]
}

head(mbp1Codons)
head(mbp1AA)

tail(mbp1Codons)
tail(mbp1AA) # Note the stop!

# The TAA "ochre" stop codon is our second verification that the nucleotide
# sequence is complete: a stop codon can't appear internally in an ORF.

# We can work with the mbp1AA vector, for example to tabulate the
# amino acid frequencies:
table(mbp1AA)
sort(table(mbp1AA), decreasing = TRUE)

# Or we can paste all elements together into a single string. But let's remove
# the stop, it's not actually a part of the sequence. To remove the last element
# of a vector, re-assign it with a vector minus the index of the last element:
mbp1AA <- mbp1AA[-(length(mbp1AA))]
tail(mbp1AA) # Note the stop is gone!

# paste it together, collapsing the elements without separation-character
(Mbp1 <- paste(mbp1AA, sep = "", collapse = ""))


# =    3  An alternative representation: 3D array  =============================


# We don't use 3D arrays often - usually just 2D tables and data frames, so
# here is a good opportunity to review the syntax with a genetic code cube:

# Initialize, using A C G T as the names of the elements in each dimension
cCube <- array(data     = character(64),
               dim      = c(4, 4, 4),
               dimnames = list(c("A", "C", "G", "T"),
                               c("A", "C", "G", "T"),
                               c("A", "C", "G", "T")))

# fill it with amino acid codes using three nested loops
for (i in 1:4) {
  for (j in 1:4) {
    for (k in 1:4) {
      myCodon <- paste(dimnames(cCube)[[1]][i],
                       dimnames(cCube)[[2]][j],
                       dimnames(cCube)[[3]][k],
                       sep = "",
                       collapse = "")
      cCube[i, j, k] <- GENETIC_CODE[myCodon]
    }
  }
}

# confirm
cCube["A", "T", "G"] # methionine
cCube["T", "T", "T"] # phenylalanine
cCube["T", "A", "G"] # stop (amber)


# ==   3.1  Print a Genetic code table  ========================================


# The data structure of our cCube is well suited to print a table. In the
# "standard" way to print the genetic code, we write codons with the same
# second nucleotide in columns, and arrange rows in blocks of same
# first nucleotide, varying the third nucleotide fastest. This maximizes the
# similarity of adjacent amino acids in the table if we print the
# nucleotides in the order T C A G. It's immidiately obvious that the code
# is not random: the universal genetic code is exceptionally error tolerant in
# the sense that mutations (or single-nucleotide translation errors) are likely
# to result in an amino acid with similar biophysical properties as the
# original.

nuc <- c("T", "C", "A", "G")

for (i in nuc) {
  for (k in nuc) {
    for (j in nuc) {
      cat(sprintf("%s%s%s: %s   ", i, j, k, cCube[i, j, k]))
    }
    cat("\n")
  }
}


# =    4  Tasks  ===============================================================


# Task: What do you need to change to print the table with U instead
#         of T? Try it.

nuc <- c("T", "C", "A", "G")

for (i in nuc) {
  for (k in nuc) {
    for (j in nuc) {
      cat(gsub("T", "U", sprintf("%s%s%s: %s   ", i, j, k, cCube[i, j, k])))
    }
    cat("\n")
  }
}

# Task: Point mutations are more often transitions (purine -> purine;
#         pyrimidine -> pyrimidine) than transversions (purine -> pyrimidine;
#         pyrimidine -> purine), even though twice as many transversions
#         are possible in the code. This is most likely due a deamination /
#         tautomerization process that favours C -> T changes. If the code
#         indeed minimizes the effect of mutations, you would expect that
#         codons that differ by a transition code for more similar amino acids
#         than codons that differ by a transversion. Is that true? List the set
#         of all amino acid pairs that are encoded by codons with a C -> T
#         transition. Then list the set of amino acid pairs with a C -> A
#         transversion. Which set of pairs is more similar?

#only want to substitute one C - only examining the case of a single point mutation
allPointMutants <- function(codon, initialNT, mutantNT){
  #return all possible codons where initialNT is replaced with mutant NT
  mutants <- character()
  codonAsVector <- unlist(strsplit(codon, ""))
  for (i in seq_along(codonAsVector)) {
    if (codonAsVector[i] == initialNT) {
      substr(codon, i, i) <- mutantNT
      mutants <- c(mutants, codon)
      codon <- paste(codonAsVector, collapse = "")
    }
  }
  return (mutants)
}

test_file("./test_allPointMutants.R")


#list all codons with a C
CCodons <- GENETIC_CODE[grepl("C", names(GENETIC_CODE))]

#in each sub a C for a mutant nt
TmutantCodons <- character()
AmutantCodons <- character()

for (i in seq_along(names(CCodons))){
  TmutantCodons <- c(TmutantCodons, allPointMutants(names(CCodons)[i], "C", "T"))
}

for (i in seq_along(names(CCodons))){
  AmutantCodons <- c(AmutantCodons, allPointMutants(names(CCodons)[i], "C", "A"))
}

#for each C-containing codon, repeat in in the list the number of times C appears
#(this will line up the initial codon with its (possibly) mutated counterparts)
extendedCCodons <- character()

for (i in seq_along(names(CCodons))){
  nC <- sum(unlist(strsplit(names(CCodons)[i], ""))=="C")
  extendedCCodons <- c(extendedCCodons, rep(names(CCodons)[i], nC))
}

#score similarity of initial and subsequent amino acids
CTSimilarities <- GENETIC_CODE[extendedCCodons] == GENETIC_CODE[TmutantCodons]
CASimilarities <- GENETIC_CODE[extendedCCodons] == GENETIC_CODE[AmutantCodons]

(sum(CTSimilarities))
(sum(CASimilarities))

#C:T mutations have more similarites to the initial codon (18) than C:A mutation (11)

# Task: How many stop codons do the two mbp1-gene derived amino acid sequences
#         have if you translate them in the 2. or the 3. frame?

#shift the reading frame
#remove the unreadable nt's from the end of the string (make it a multiple of 3)
mbp1_2frame <- substr(mbp1, 2, (nchar(mbp1) - 2))
mbp1_3frame <- substr(mbp1, 3, (nchar(mbp1) - 1))

mbp1_2frameCodons <- as.character(codons(DNAString(mbp1_2frame)))
mbp1_3frameCodons <- as.character(codons(DNAString(mbp1_3frame)))

table(GENETIC_CODE[mbp1Codons])
table(GENETIC_CODE[mbp1_2frameCodons])
table(GENETIC_CODE[mbp1_3frameCodons])

(sum(GENETIC_CODE[mbp1_2frameCodons] == "*"))
(sum(GENETIC_CODE[mbp1_3frameCodons] == "*"))

# Task: How does the amino acid composition change if you translate the mbp1
#         gene with the Alternative Yeast Nuclear code that is used by the
#         "GTC clade" of fungi?
#         (cf. https://en.wikipedia.org/wiki/Alternative_yeast_nuclear_code )

AYN_CODE <- getGeneticCode("12")  # Alternative Yeast Nuclear

classicAA <- unlist(strsplit(as.character(translate(DNAString(mbp1))), ""))
alternativeAA <- unlist(strsplit(as.character(translate(DNAString(mbp1),
                                                 genetic.code = AYN_CODE)), ""))
table(classicAA)
table(alternativeAA)

altSimilarities <- classicAA == alternativeAA
sum(altSimilarities)

#there are 825 amino acids in common (out of 834) when translating the mbp1
#gene with the standard genetic code vs the alternative yeast nuclear code
#there is no premature STOP when using the alternative yeast nuclear code

# Solution:

          # Fetch the code
          GENETIC_CODE_TABLE
          GENETIC_CODE_TABLE$name[GENETIC_CODE_TABLE$id == "12"]

          altYcode <- getGeneticCode("12")

          # what's the difference?
          (delta <- which(GENETIC_CODE != altYcode))

          GENETIC_CODE[delta]
          altYcode[delta]

          # translate
          altYAA <- character(834)
          for (i in seq_along(mbp1Codons)) {
            altYAA[i] <- altYcode[mbp1Codons[i]]
          }

          table(mbp1AA)
          table(altYAA)

# Task: The genetic code has significant redundacy, i.e. there are up to six
#         codons that code for the same amino acid. Write code that lists how
#         many amino acids are present how often i.e. it should tell you that
#         two amino acids are encoded only with a single codon, three amino
#         acids have six codons, etc. Solution below, but don't peek. There
#         are many possible ways to do this.
#
#

table(GENETIC_CODE)


# Solution:
table(table(GENETIC_CODE))


# [END]
