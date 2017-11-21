#test_pointMutate.R
#

context("pointMutate() utility function tests")

test_that("expected input is processed correctly", {
  expect_equal(as.integer(pointMutate("ABC")["mutantIndex"]), 1)
  expect_equal(sum(adist(pointMutate("ABC")["mutant"], "ABC")), 1)
})
