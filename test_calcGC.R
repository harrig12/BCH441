# test_calcGC.R
#
# Purpose:  A Bioinformatics Course:
#              R code accompanying the RPR-Unit_testing unit.
#
# Note:    This script lives on Github:
#          https://github.com/harrig12/BCH441
#
# Version:  1.0
#
# Date:     2017  11  01
# Author:   Cait Harrigan (cait.harrigan@mail.utoronto.ca)
#
# Versions:
#           1.0    First code
#
# Task:
#       Write tests that:
#          confirm that calcGC("AATT") is 0;
#          confirm that calcGC("ATGC") is 0.5;
#          confirm that calcGC("AC")   is 0.5;
#          confirm that calcGC("CGCG") is 1;

# =============================================================================

context("calcGC() utility function tests")

test_that("expected input is processed correctly", {
  expect_equal(calcGC("AATT"), 0)
  expect_equal(calcGC("ATGC"), 0.5)
  expect_equal(calcGC("AC"), 0.5)
  expect_equal(calcGC("CGCG"), 1)
  expect_equal(calcGC("AGGCCT"), 2/3)
})

