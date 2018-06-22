test_that("config.help", {
  x <- config.help()
  expect_that(is.data.frame(x), equals(TRUE))
})
