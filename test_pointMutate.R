#test_pointMutate.R
#

context("pointMutate() utility function tests")

test_that("expected input is processed correctly", {
  expect_equal(sum(diag(adist(pointMutate(KRascodons), KRascodons))), 1)
  expect_equal(sum(diag(adist(pointMutate(c("ABC", "BCB")), c("ABC", "BCB")))), 1)
})
