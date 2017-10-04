# RPR-Objects-Vectors
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
objectInfo(as.complex(1))
objectInfo()
objectInfo()
objectInfo()
objectInfo()
objectInfo()
