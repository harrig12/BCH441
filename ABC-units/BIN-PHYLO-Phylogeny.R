library(msa)
library(tictoc)
library(beepr)
source("../makeProteinDB.R")

if (!require(Rphylip, quietly=TRUE)) {
  install.packages("Rphylip")
  library(Rphylip)
}

# Align all sequences in the database + KILA_ESSCO
mySeq <- myDB$protein$sequence
names(mySeq) <- myDB$protein$name
mySeq <- c(mySeq,
           "IDGEIIHLRAKDGYINATSMCRTAGKLLSDYTRLKTTQEFFDELSRDMGIPISELIQSFKGGRPENQGTWVHPDIAINLAQ")
names(mySeq)[length(mySeq)] <- "KILA_ESCCO"

mySeqMSA <- msaClustalOmega(AAStringSet(mySeq)) # too many sequences for MUSCLE

# get the sequence of the SACCE APSES domain
sel <- myDB$protein$name == "MBP1_SACCE"
proID <- myDB$protein$ID[sel]

sel <- myDB$feature$ID[myDB$feature$name == "APSES fold"]
fanID <- myDB$annotation$ID[myDB$annotation$proteinID == proID &
                              myDB$annotation$featureID == sel]
start <- myDB$annotation$start[fanID]
end   <- myDB$annotation$end[fanID]

SACCEapses <- substring(myDB$protein$sequence[proID], start, end)

# extract the APSES domains from the MSA
APSESmsa <- fetchMSAmotif(mySeqMSA, SACCEapses)

#------------------------------------------------------------------------------
# Produce the phylogenetic tree ...

# inspect the alignment.
writeALN(APSESmsa)

#there are a lot of messy gaps. Prepare the data by removing columns with
#data for less than 1/3rd of the data set, as in BIN-PHYLO-Data_preparation.R
#(with some modifications)

# get the length of the alignment
(lenAli <- APSESmsa@ranges@width[1])

# initialize a matrix that can hold all characters
# individually
msaMatrix <- matrix(character(length(APSESmsa) * lenAli),
                    ncol = lenAli)

# assign the correct rownames
rownames(msaMatrix) <- APSESmsa@ranges@NAMES
for (i in 1:length(APSESmsa)) {
  msaMatrix[i, ] <- unlist(strsplit(as.character(APSESmsa[i]), ""))
}

# inspect the result
msaMatrix[1:7, 1:14]
msaMatrix[47:52, 1:14]

# initialize a mask
colMask <- logical(ncol(msaMatrix))

# define the threshold for rejecting a column
limit <- round(length(APSESmsa) * (2/3))

# iterate over all columns, and write TRUE if there are less-or-equal to "limit"
# hyphens, FALSE if there are more - i.e. TRUE columns will be used fr analysis
# and FALSE columns will be rejected.
for (i in 1:ncol(msaMatrix)) {
  count <- sum(msaMatrix[ , i] == "-")
  colMask[i] <- count <= limit # TRUE if less-or-equal to limit, FALSE if not
}

# Inspect the mask
colMask

# How many positions are being kept?
sum(colMask)

cat(sprintf("We are masking %4.2f %% of alignment columns.\n",
            100 * (1 - (sum(colMask) / length(colMask)))))


# Next, we use colMask to remove the masked columns from the matrix
# in one step:
maskedMatrix <- msaMatrix[ , colMask]

# check:
ncol(maskedMatrix)

# ... then collapse each row of single characters back into a string ...
allAPSESphyloSet <- character()
for (i in 1:nrow(maskedMatrix)) {
  allAPSESphyloSet[i] <- paste(maskedMatrix[i, ], collapse="")
}
names(allAPSESphyloSet) <- rownames(maskedMatrix)

# inspect ...
writeALN(allAPSESphyloSet)

#looks good

# We save the aligned, masked domains to a file in multi-FASTA format.
writeMFA(allAPSESphyloSet, myCon = "allAPSESphyloSet.mfa")

#------------------------------------------------------------------------------
#Build the tree, as in BIN-PHYLO-Tree_building.R (with some modifications)

PROTPARSPATH <- "/Applications/phylip-3.695/exe/protpars.app/Contents/MacOS"

# Confirm that the settings are right.
PROTPARSPATH                # returns the path
list.dirs(PROTPARSPATH)     # returns the directories in that path
list.files(PROTPARSPATH)    # lists the files [1] "proml"   "proml.command"

#read in alignment
apsIn <- read.protein("ABC-units/allAPSESphyloSet.mfa")

#build the tree
tic()
apsTreeFast <- Rprotpars(apsIn, path=PROTPARSPATH)
toc()
save(apsTreeFast, file = "allAPSEStreeRprotpars.RData")


plot(apsTreeFast)
