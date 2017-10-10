# BIN-Storing Data
#
# Purpose: Create a protein database from json files
#
# Note:    This script lives on Github:
#          https://github.com/harrig12/BCH441
#
# Version: 0.1
#
# Date:    2017  10 09
# Author:  Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# V 0.1    First code

source("./scripts/ABC-createRefDB.R")

myDB <- dbAddProtein(    myDB, fromJSON("MBP1_CALCA.json"))
myDB <- dbAddTaxonomy(   myDB, fromJSON("CALCAtaxonomy.json"))

#[END]
