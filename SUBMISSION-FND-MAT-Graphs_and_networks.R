# SUBMISSION-FND-MAT-Graphs_and_networks.R
#
# Purpose:  A Bioinformatics Course:
#              R code accompanying the FND-MAT-Graphs_and_networks unit.
#
# Version:  1.0
#
# Date:     2017  10  27
# Author:   Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# Versions:
#           1.0    First code
#
#Task:
#           Assess the community structure of scCCnet by comparing it with random
#           graphs with the same distribution degree. In particular:
#           1) Write a function that takes an igraph graph as input and outputs the
#              size difference between the largest and the second largest community,
#              as defined by cluster_infomap().
#           2) Write a function that takes an igraph graph as input and returns a
#              random graph with the same degree distribution. Use the sample_degseq()
#              function internally, with the "vl" method.
#           3) Write a script that produces a vector of 1,000 results from your
#              first function, calculated for a graph produced by your second
#              function using the scCCnet graph as input.
#           4) Plot and interpret the result.
# ==============================================================================

#load data prepared from STRING database
load("./data/scCCnet.RData")

if (!require(igraph)) {
  install.packages("igraph")
  library(igraph)
}

#create an igraph object from scCCnet
myG <- graph_from_edgelist(as.matrix(scCCnet[-3]), directed = F)

igraphToSize <- function(G){
  # Find the difference in sizes between the largest and second largest communities
  # in graph G
  # Parameters:
  #   G: an igraph
  #
  # Value: an integer

  #get cluster sizes
  sizes <- sizes(cluster_infomap(myG))
  #order sizes as a vector
  sizesOrdered <- as.vector(sizes)
  #find difference between first and second largest community
  return(sizesOrdered[1] - sizesOrdered[2])
}

igraphToSize(myG)

igraphToRIgraph <- function(G){
  # Make a random graph of same degree as an input igraph G
  # Parameters:
  #   G: an igraph
  #
  # Value: an undirected graph with same degree as G

  myDegree <- as.vector(degree(myG))
  return(sample_degseq(myDegree, method = "vl"))
}

#[END]
