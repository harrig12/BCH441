#test_allPointMutants.R
#

context("allPointMutants() utility function tests")

test_that("expected input is processed correctly", {
  expect_equal(allPointMutants("TTC", "C", "T"), c("TTT"))
  expect_equal(allPointMutants("CCC", "C", "T"), c("TCC", "CTC", "CCT"))
  expect_equal(allPointMutants("GGG", "C", "T"), character())
})
