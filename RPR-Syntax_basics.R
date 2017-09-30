# RPR-Syntax basics
#
# Purpose: Practice the basics of R syntax, writing a script under
#verision control
#
# Note:    This script lives on Github:
#          https://github.com/harrig12/BCH441
#
# Version: 0.1
#
# Date:    2017  09
# Author:  Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# V 0.1    First code

numbers <- c(16,20,3,5,9)
lastNum <- tail(numbers,1) #returns the nth last elements of numbers (where n=1)

#instructions>=================================================================
#instructions>  Write R expressions:
#instructions>      one)   To check whether lastNum is less than 6 or greater than 10
#instructions>      two)   To check whether lastNum is in the interval [10, 20).
#instructions>             (By the rules of mathematical notation this means 10 is included but 20 is not).
#instructions>      three) To output TRUE if the following operation gives 2:
#instructions>              - take lastNum
#instructions>              - divide it by 7
#instructions>              - subtract the integer part and the first digit after the decimal point
#instructions>                (hint: multiply by 10, then integer division by 1 gives you ... what)
#instructions>              - multiply by 100
#instructions>              - integer divide by 1
#instructions>              - take the third root
#instructions>=================================================================

one <- (lastNum<6 | lastNum>10)
two <- (lastNum<=10 & lastNum<20)
three <- (2 == ((((lastNum / 7) - (lastNum %/% 7) - (((((lastNum / 7) - (lastNum %/% 7)) * 10) %/% 1) / 10)) * 100) %/% 1) ^ (1/3))


