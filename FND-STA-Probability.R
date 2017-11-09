# FND-STA-Probability.R
#
# Purpose:  A Bioinformatics Course:
#              R code accompanying the FND-STA-Probability unit.
#
# Note:    This script lives on Github:
#          https://github.com/harrig12/BCH441
#
# Version:  1.0
#
# Date:     2017  11 08
# Author:   Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# Versions:
#           1.0    First code
#
# ==============================================================================

#plot the birthday paradox
N <- 150
pBirthday <- numeric(N)

for (i in 1:N) {
  pBirthday[i] <- 1 - ((364/365)^((i * (i-1)) / 2))
}

plot(1:N, pBirthday,
     type = "l",
     col = "firebrick",
     xlab = "number of people in the room",
     cex.lab = "0.7",
     ylab = "Probability of at least one shared birthday",
     main = "Birthday Problem"
)

#Task: Asume there are 59 students in the class.
#What is the probability of at least one pair of them sharing a birthday?
(pBirthday[59])
#add to plot
abline(v =59, untf = FALSE, col="green")

#Task: If a restriction-endonuclease site is six bases long, how many such
#sites would you expect in a 3MB long bacterial chromosome with a GC-content of 50%?
#p(sequence of length m) = 1/(4^m)
#Then p(6bp restriction-endonuclease site) = 1/(4^6)
((3e6 - 5)/(4**6))
#there is a 1/(4^6) chance of the re site appearing along the chromosome, except for at
#the last 5 bases, where the endonuclease wouldn't fit.
#Would expect 732 such sites.


