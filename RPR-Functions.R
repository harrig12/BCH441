# RPR-Functions
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

#Task: Use seq()
?seq()
seq(-5,3)
seq(from=-2, to=2, by=(1/3))
seq(length.out=30, to=100, from=1)

#Task: write a count down function
getCountDown <- function(x){
    txt <- c(as.character(x))
    while (x != 0){
        x <- x-1
        txt <- c(txt, as.character(x))
    }
    txt <- c(txt, "Lift Off!")
    return(txt)
}

#Task: modify a lifedays function
myLifeDays <- function(birthday, days) {
    if (missing(birthday)) {
        print ("Enter your birthday as a string in \"YYYY-MM-DD\" format.")
        return()
    }
    anniversary <- as.Date(birthday) + days
    print(sprintf("The %d day anniversary is %s", days, anniversary))
}
#[END]
