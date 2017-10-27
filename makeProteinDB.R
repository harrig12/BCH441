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

setwd("./ABC-units")
source("./scripts/ABC-createRefDB.R")

myDB <- dbAddProtein(    myDB, fromJSON("/Users/cait/Documents/BCH441/data/MBP1_CLACA.json"))
myDB <- dbAddTaxonomy(   myDB, fromJSON("/Users/cait/Documents/BCH441/data/CLACAtaxonomy.json"))

#[END]
