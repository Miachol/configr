# Use RcppTOML example.toml as input
example.toml <- system.file("toml", "example.toml", package = "RcppTOML")
test_that("TOML releated tests", {
  x <- is.toml.file(example.toml)
  expect_that(x, equals(TRUE))
  
  x <- get.config.type(example.toml)
  expect_that(x, equals("toml"))
  
  x <- read.config(example.toml)
  expect_that(is.list(x) && length(x) == 5, equals(TRUE))
  
  x <- eval.config(file = example.toml, config = "owner")
  expect_that(is.list(x) && length(x) == 2, equals(TRUE))
  expect_that(all(c("name", "dob") %in% names(x)), equals(TRUE))
  
  x <- eval.config(value = "name", file = example.toml, config = "owner")
  expect_that(x, equals("Tom Preston-Werner"))
  
  x <- eval.config.sections(example.toml)
  expect_that(length(x), equals(5))
  
  x <- eval.config.merge(example.toml)
  expect_that(length(x), equals(11))
  
  x <- eval.config.merge(example.toml, sections = c("database", "owner"))
  expect_that(length(x), equals(6))
})

