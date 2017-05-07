test_that("write.config Function", {
  config.opts <- c("json", "ini", "yaml")
  list.test <- list(a = c(c = 123, b = list(456)))
  for (i in config.opts) {
    out.fn <- sprintf("%s/test.%s", tempdir(), i)
    x <- NULL
    x <- write.config(list.test, out.fn, write.type = i)
    expect_that(x, equals(TRUE))
    expect_that(get.config.type(out.fn), equals(i))
  }
})

test_that("write.config Exception Handling", {
  config.opts <- c("json", "ini", "yaml")
  for (i in config.opts) {
    out.fn <- sprintf("%s/test.%s", tempdir(), i)
    suppressWarnings(x <- write.config(NULL, out.fn, write.type = i))
    expect_that(x, equals(FALSE))
  }
})
