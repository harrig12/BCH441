#test_detectMutationType.R
#

context("detectMutationType() utility function tests")

test_that("expected input is processed correctly", {
  expect_equal(detectMutationType(c("TTT", "TGA"), 1, "TAT"), "Missense")
  expect_equal(detectMutationType(c("TTT", "TGA"), 1, "TTC"), "Silent")
  expect_equal(detectMutationType(c("TTT", "TGC", "TAA"), 2, "TGA"), "Nonsense")
  expect_equal(detectMutationType(c("TTT", "TGA"), 2, "TGT"), "Nonsense")
})

test_that("non-point mutant input is processed correctly", {
  expect_equal(detectMutationType(c("TTT", "TGA"), 1, "AAA"), "Missense") #triple mutant
})

test_that("genetic code variants input is processed correctly", {
  expect_equal(detectMutationType(c("CTA", "TGA"), 1, "CTG", getGeneticCode("12")), "Missense")
  expect_equal(detectMutationType(c("CTA", "TGA"), 1, "CTT", getGeneticCode("12")), "Silent")
  expect_equal(detectMutationType(c("TTT", "TGC", "TAA"), 2, "TGA", getGeneticCode("12")), "Nonsense")
  expect_equal(detectMutationType(c("TTT", "TGC", "TAA"), 2, "TGA", getGeneticCode("3")), "Missense")
})

test_that("incorrect input throws error", {
  expect_error(detectMutationType(c("TTT", "AAA"), 2, "AAA"), "no mutant found")
})

