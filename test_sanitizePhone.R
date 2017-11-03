#test_sanitizePhone.R
#

context("sanitizePhone() utility function tests")

test_that("expected input processed correctly", {
         expect_equal(sanitizePhone("6047301847"), "6047301847")
         expect_equal(sanitizePhone("604-730-1847"), "6047301847")
         expect_equal(sanitizePhone("604.730.1847"), "6047301847")
         expect_equal(sanitizePhone("604 730 1847"), "6047301847")
         expect_equal(sanitizePhone("(604)7301847"), "6047301847")
         s <- "1-858 651-5050"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "1 858 651 5050"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "+1 (858) 651-5050"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "18586515050"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "1 858 6515050"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "1.858.651.5050"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "1\t8 5 8\t6 5 1-5 0 5 0"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "1n8e5v8e6r5 1g5o0n5n0a"
         expect_equal(sanitizePhone(s), "18586515050")
         s <- "IDK"
         expect_equal(sanitizePhone(s), "")
         s <- ""
         expect_equal(sanitizePhone(s), "")
         s <- pi
         expect_equal(sanitizePhone(s), "314159265358979")
})
