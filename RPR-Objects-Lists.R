# RPR-Objects-Lists
#
# Purpose: Practice the basics of R syntax, writing a script under
#          verision control
#
# Note:    This script lives on Github:
#          https://github.com/harrig12/BCH441
#
# Version: 0.1
#
# Date:    2017  10
# Author:  Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# V 0.1    First code

pUC19 <- list(size=2686, marker="ampicillin", ori="ColE1", accession="L01397", BanI=c(235, 408, 550, 1647) )

objectInfo(pUC19)
pUC19[[1]]
pUC19[[2]]
pUC19$ori
pUC19$BanI[2]

pACYC184 <- list(size=4245, marker="Tet, Cam", ori="p15A")
plasmidDB <- list()
plasmidDB[["pUC19"]] <- pUC19
plasmidDB[["pACYC184"]] <- pACYC184

plasmidDB[["pBR322"]]<- pBR322 <- list(size=4361, marker="Amp, Tet", ori="ColE1")
plasmidDB$pBR322

min(unlist(lapply(plasmidDB, function(x) {return (x$size)})))

# [END]
