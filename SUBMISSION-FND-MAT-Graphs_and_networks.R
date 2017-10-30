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

igraphToRIgraph <- function(G){
  # Make a random graph of same degree as an input igraph G
  # Parameters:
  #   G: an igraph
  #
  # Value: an undirected igraph with same degree as G

  myDegree <- as.vector(degree(myG))
  return(sample_degseq(myDegree, method = "vl"))
}

#Create an igraph object from scCCnet
set.seed(12543)
myG <- graph_from_edgelist(as.matrix(scCCnet[-3]), directed = F)

#Plot the scCCnet network according to community membership
#Modified from the FND-MAT-Graphs_and_networks.R Version 1.0

comms <- cluster_infomap(myG)
myGxy <- layout_with_graphopt(myG, charge = 0.0017, mass=100, spring.constant = .5)

oPar <- par(mar= rep(0,4)) # Turn margins off
plot(myG,
     layout = myGxy,
     rescale = F,
     xlim = c(min(myGxy[,1]) * 0.99, max(myGxy[,1]) * 1.01),
     ylim = c(min(myGxy[,2]) * 0.99, max(myGxy[,2]) * 1.01),
     vertex.color=rainbow(max(membership(comms)+1))[membership(comms)+1],
     vertex.size = 700 + (90 * degree(myG)),
     vertex.label = NA)
par(oPar)

#Size of a node increases with degree, colour is dictated by community membership.
#We can see that there are several fairly well connected nodes with high degree.
#These nodes tend to be members of larger communities - this makes sense biologically,
#we could expect a protein in a group of many interacting proteins shares many interactions.
#There are two distinctly large and well connected communities.

#What is the size gap in our scCCnet based graph between the 1st and 2nd
#largest communities?
set.seed(1234765)
igraphToSize(myG)

#The size gap is 9. How does this compare to a randomly generated graph?

rG <- igraphToRIgraph(myG)

#Produce 1000 results
rGSamples <- replicate(1000, igraphToSize(rG))

#Create a histogram of size gaps
#Modified from the FND-MAT-Graphs_and_networks.R Version 1.0
brk <- seq(min(rGSamples)-0.5, max(rGSamples)+0.5, by=1)
hist(rGSamples, breaks = brk, col="red",
     xlim = c(-1,max(rGSamples)), xaxt = "n",
     main = "1000 samples of randomly generated graph",
     xlab = "Size difference between largest and second largest community", ylab = "Frequency")
axis(side = 1, at = 0:max(rGSamples))

#Histogram of the 1000 samples shows 9 is a relativly common size gap. Lets compare
#with a histogam of 1000 samples of the scCCnet generated graph

myGSamples <- replicate(1000, igraphToSize(myG))

brk <- seq(min(myGSamples)-0.5, max(myGSamples)+0.5, by=1)
hist(myGSamples, breaks = brk, col="cornflowerblue",
     xlim = c(-1,max(myGSamples)), xaxt = "n",
     main = "1000 samples of scCCnet generated graph",
     xlab = "Size difference between largest and second largest community", ylab = "Freqency")
axis(side = 1, at = 0:max(myGSamples))


#Box plot of community structures to see these side to side
samples <- cbind(rGSamples, myGSamples)
boxplot.matrix(samples, col = c("red", "cornflowerblue"),
               main = "Community structure of 1000 samples",
               ylab = "Size difference between largest and second largest community",
               xlab = "Origin")

#There doesn't seem to be any real difference in the size gap between 1st and 2nd
#largest community in the scCCnet graph and randomly generated graph with the same degree.
#They likely share a similar community structure. Since the edges in the scCCnet graph are
#based on a high confidence interaction score, this indicates that the community
#structure is likely not related to the biological function of these genes, but rather
#to the degree of distribution of the graph.

#[END]
