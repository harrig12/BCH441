#test_detectMutationType.R
#

context("detectMutationType() utility function tests")

test_that("expected input is processed correctly", {
  expect_equal(detectMutationType("TTT", "TAT"), "missense")
  expect_equal(detectMutationType("TTT", "TTC"), "silent")
  expect_equal(detectMutationType(c("TTT", "TGC", "TAA"), c("TTT", "TGA", "TAA") ), "nonsense")
})

test_that("non-point mutant input is processed correctly", {
  expect_equal(detectMutationType("TTT", "AAA"), "missense") #triple mutant
  expect_error(detectMutationType("TTT", "TTT"), "strings match, no mutant found") #no mutant
})

test_that("genetic code variants input is processed correctly", {
  expect_equal(detectMutationType("CTA", "CTG", getGeneticCode("12")), "missense")
  expect_equal(detectMutationType("CTA", "CTT", getGeneticCode("12")), "silent")
  expect_equal(detectMutationType(c("TTT", "TGC", "TAA"), c("TTT", "TGA", "TAA")), "nonsense")
})

test_that("incorrect input throws error", {
  expect_error(detectMutationType(c("TTT", "AAA"), "AAA"), "input lengths may not differ")
})

