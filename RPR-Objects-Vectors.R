# RPR-Objects-Vectors
#
# Purpose: Practice the basics of R syntax, writing a script under
#          verision control
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

#Scalar data
x <- pi
x
length(x)
x[1]
x[2]
typeof(TRUE)
class(3L)
mode(print)

#Load R-Exercise_BasicSetup, execute init()
objectInfo()
#scalars
objectInfo(3.0)
objectInfo(3.0e0)
objectInfo(3)
objectInfo(3L)
#coersions
objectInfo(as.character(3))
#expected
# object contents:[1] 3
# structure of object:
#     char 3
# mode: character
# typeof: char
# class: char

#actual:
# object contents:[1] "3"
# structure of object:
#     chr "3"
#
# mode:    character
# typeof:  character
# class:   character
objectInfo(as.numeric("3"))
#expect
# object contents:[1] 3
#
# structure of object:
#     num 3
#
# mode:    numeric
# typeof:  double
# class:   numeric

#actual:
# object contents:[1] 3
#
# structure of object:
#     num 3
#
# mode:    numeric
# typeof:  double
# class:   numeric
objectInfo(as.numeric(3.141592653))
#expected:
# object contents:[1] 3.141592653
#
# structure of object:
#     num 3.141592653
#
# mode:    numeric
# typeof:  float
# class:   numeric

#actual:
# object contents:[1] 3.141592653000000012753
#
# structure of object:
#     num 3.14
#
# mode:    numeric
# typeof:  double
# class:   numeric
objectInfo(as.numeric(pi))
#expected:
# object contents:[1] 3.14159265358979
#
# structure of object:
#     num 3.14
#
# mode:    numeric
# typeof:  float
# class:   numeric

#actual:
# object contents:[1] 3.141592653589793115998
#
# structure of object:
#     num 3.14
#
# mode:    numeric
# typeof:  double
# class:   numeric
objectInfo(as.numeric("pi"))
#expected:
# object contents:[1] 3.141592653589793115998
#
# structure of object:
#     num 3.14
#
# mode:    numeric
# typeof:  double
# class:   numeric

#actual:
# object contents:[1] NA
#
# structure of object:
#     num NA
#
# mode:    numeric
# typeof:  double
# class:   numeric
# Warning message:
# In print(x, digits = 22) : NAs introduced by coercion

#warning appears because there's no good (widely useful - ascii is limited) way
#of creating a number to represent a string
objectInfo(as.complex(1))
#expected:
# not sure!

#actual:
# object contents:[1] 1+0i
#
# structure of object:
#     cplx 1+0i
#
# mode:    complex
# typeof:  complex
# class:   complex
objectInfo(as.logical(0))
#expected:
# object contents:[1] FALSE
#
# structure of object:
#     bool FALSE
#
# mode:    logical
# typeof:  logical
# class:   logical

#actual:
# object contents:[1] FALSE
#
# structure of object:
#     logi FALSE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(as.logical(1))
#expected:
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical

#actual:
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(as.logical(-1))
#expected:
# object contents:[1] FALSE
#
# structure of object:
#     logi FALSE
#
# mode:    logical
# typeof:  logical
# class:   logical

#actual
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(as.logical(pi))
#expected:
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical

#actual:
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(as.logical("pie"))
#expected:
# object contents:[1] NA
#
# structure of object:
#     num NA
#
# mode:    numeric
# typeof:  double
# class:   numeric
# Warning message:
# In print(x, digits = 22) : NAs introduced by coercion

#actual:
# object contents:[1] NA
#
# structure of object:
#     logi NA
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(as.character(pi))
#expected:
# object contents:[1] "pi"
#
# structure of object:
#     chr "pi"
#
# mode:    character
# typeof:  character
# class:   character
objectInfo(Inf)
#expected:
# object contents:[1] Inf
#
# structure of object:
#     num Inf
#
# mode:    numeric
# typeof:  Inf
# class:   NA

#actual:
# object contents:[1] Inf
#
# structure of object:
#     num Inf
#
# mode:    numeric
# typeof:  double
# class:   numeric
objectInfo(-Inf)
#expected:
# object contents:[1] -Inf
#
# structure of object:
#     num Inf
#
# mode:    numeric
# typeof:  double
# class:   numeric

#actual:
# object contents:[1] -Inf
#
# structure of object:
#     num -Inf
#
# mode:    numeric
# typeof:  double
# class:   numeric
objectInfo(NaN)
#expected:
# object contents:[1] NaN
#
# structure of object:
#     num NaN
#
# mode:    numeric
# typeof:  double
# class:   numeric

#actual:
# object contents:[1] NaN
#
# structure of object:
#     num NaN
#
# mode:    numeric
# typeof:  double
# class:   numeric
objectInfo(NA)
#expected:
# object contents:[1] NA
#
# structure of object:
#     obj NA
#
# mode:    NA
# typeof:  NA
# class:   NA

#actual:
# object contents:[1] NA
#
# structure of object:
#     logi NA
#
# mode:    logical
# typeof:  logical
# class:   logical
#NULL
objectInfo(NULL)
#expected:
# object contents:[1] NULL
#
# structure of object:
#     obj NULL
#
# mode:    None
# typeof:  None
# class:   None

#actual:
# object contents:NULL
#
# structure of object:
#     NULL
#
# mode:    NULL
# typeof:  NULL
# class:   NULL
objectInfo(as.factor("M"))
#expected:
# object contents:[1] M
#
# structure of object:
#     fac M
#
# mode:    factor
# typeof:  factor
# class:   factor

#actual:
# object contents:[1] M
# Levels: M
#
# structure of object:
#     Factor w/ 1 level "M": 1
#
# mode:    numeric
# typeof:  integer
# class:   factor
#
# attributes:
#     $levels
# [1] "M"
#
# $class
# [1] "factor"
objectInfo(Sys.time())
#expected:
# object contents: 10:29:03
#
# structure of object:
#     time 10:29:03
#
# mode:    datetime
# typeof:  time
# class:   time

#actual:
# object contents:[1] "2017-10-03 22:30:46 EDT"
#
# structure of object:
#     POSIXct[1:1], format: "2017-10-03 22:30:46"
#
# mode:    numeric
# typeof:  double
# class:   POSIXct POSIXt
#
# attributes:
#     $class
# [1] "POSIXct" "POSIXt"
objectInfo(letters)
#expected:
# I'm not sure!

#actual:
# object contents: [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t"
# [21] "u" "v" "w" "x" "y" "z"
#
# structure of object:
#     chr [1:26] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" ...
#
# mode:    character
# typeof:  character
# class:   character
objectInfo(1:4)
#expected:
# object contents:[4] [1,2,3,4]
#
# structure of object:
#     list  num
#
# mode:    list
# typeof:  int
# class:   num

#actual:
# object contents:[1] 1 2 3 4
#
# structure of object:
#     int [1:4] 1 2 3 4
#
# mode:    numeric
# typeof:  integer
# class:   integer
objectInfo(matrix(1:4, nrow=2))
#expected:
# object contents:[2] 1 2 3 4
#
# structure of object:
#     mat [2][2] 1 2 3 4
#
# mode:    numeric
# typeof:  integer
# class:   integer

#actual:
# object contents:     [,1] [,2]
# [1,]    1    3
# [2,]    2    4
#
# structure of object:
#     int [1:2, 1:2] 1 2 3 4
#
# mode:    numeric
# typeof:  integer
# class:   matrix
#
# attributes:
#     $dim
# [1] 2 2
objectInfo(data.frame(arabic=1:3, roman = c("I","II", "III"), stringsAsFactors=FALSE))
#expected:
# not sure!

#actual:
# object contents:  arabic roman
# 1      1     I
# 2      2    II
# 3      3   III
#
# structure of object:
#     'data.frame':	3 obs. of  2 variables:
#     $ arabic: int  1 2 3
# $ roman : chr  "I" "II" "III"
#
# attributes:
#     $names
# [1] "arabic" "roman"
#
# $row.names
# [1] 1 2 3
#
# $class
# [1] "data.frame"
objectInfo(list(arabic=1:7, roman = c("I","II", "III")))
#expected:
# object contents:  arabic roman
#
# structure of object:
#    list [1:7, c("I","II", "III")]
#
# mode:    list
# typeof:  data
# class:   list

#actual:
# object contents:$arabic
# [1] 1 2 3 4 5 6 7
#
# $roman
# [1] "I"   "II"  "III"
#
#
# structure of object:
#     List of 2
# $ arabic: int [1:7] 1 2 3 4 5 6 7
# $ roman : chr [1:3] "I" "II" "III"
#
# attributes:
#     $names
# [1] "arabic" "roman"
#Expressions
objectInfo(3>5)
#expected:
# object contents:[1] FALSE
#
# structure of object:
#     logi FALSE
#
# mode:    logical
# typeof:  logical
# class:   logical

#actual:
# object contents:[1] FALSE
#
# structure of object:
#     logi FALSE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(3<5)
#expected:
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical

#actual:
# object contents:[1] TRUE
#
# structure of object:
#     logi TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(1:6>4)
#expected:
# object contents:$V1
# [1] FALSE FALSE FALSE FALSE TRUE TRUE
#
# structure of object:
#     List of 1
# $ V1: logical FALSE FALSE FALSE FALSE TRUE TRUE
#
# attributes:
#     $names
# [1] "V1"

#actual:
# object contents:[1] FALSE FALSE FALSE FALSE  TRUE  TRUE
#
# structure of object:
#     logi [1:6] FALSE FALSE FALSE FALSE TRUE TRUE
#
# mode:    logical
# typeof:  logical
# class:   logical
objectInfo(a~b)
#expected:
# not sure!

#actual:
# object contents:a ~ b
#
# structure of object:
#     Class 'formula'  language a ~ b
# ..- attr(*, ".Environment")=<environment: R_GlobalEnv>
#
#     mode:    call
# typeof:  language
# class:   formula
#
# attributes:
#     $class
# [1] "formula"
#
# $.Environment
# <environment: R_GlobalEnv>
objectInfo(objectInfo)
#expected:
# object contents:a ~ b
#
# structure of object:
#     Class 'function'
#
# mode:    call
# typeof:  language
# class:   function
#
# attributes:
#     $class
# [1] "function"
#
# $.Environment
# <environment: R_GlobalEnv>

#actual:
# object contents:function(x) {
#     # Function to combine various information items about R objects
#     #
#     # Input: an R object
#     # Value: none - prints information as side-effect
#
#     cat("object contents:")
#     print(x, digits = 22)  # print value at maximal precision
#
#     cat("\nstructure of object:\n")
#     str(x)
#
#     if (! is.list(x)) { # Don't use cat() if x is a list. cat() can't handle lists.
#         cat("\nmode:   ", mode(x), "\n")
#         cat("typeof: ", typeof(x), "\n")
#         cat("class:  ", class(x), "\n")
#     }
#
#     # if the object has attributes, print them too
#     if (! is.null(attributes(x))) {
#         cat("\nattributes:\n")
#         attributes(x)
#     }
#     # Done
# }
#
# structure of object:
#     function (x)
#         - attr(*, "srcref")=Class 'srcref'  atomic [1:8] 16 15 40 1 15 1 16 40
# .. ..- attr(*, "srcfile")=Classes 'srcfilecopy', 'srcfile' <environment: 0x1065e3b08>
#
#     mode:    function
# typeof:  closure
# class:   function
#
# attributes:
#     $srcref
# function(x) {
#     # Function to combine various information items about R objects
#     #
#     # Input: an R object
#     # Value: none - prints information as side-effect
#
#     cat("object contents:")
#     print(x, digits = 22)  # print value at maximal precision
#
#     cat("\nstructure of object:\n")
#     str(x)
#
#     if (! is.list(x)) { # Don't use cat() if x is a list. cat() can't handle lists.
#         cat("\nmode:   ", mode(x), "\n")
#         cat("typeof: ", typeof(x), "\n")
#         cat("class:  ", class(x), "\n")
#     }
#
#     # if the object has attributes, print them too
#     if (! is.null(attributes(x))) {
#         cat("\nattributes:\n")
#         attributes(x)
#     }
#     # Done
# }


