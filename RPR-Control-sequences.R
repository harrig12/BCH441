# RPR-Control sequences
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

count <- 0
txt = c("3", "2", "1", "0", "Lift Off!")

while (count <= length(txt)){
    print(txt[count])
    count = count + 1
}

#[END]
