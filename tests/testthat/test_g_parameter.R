config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")

test_that("Genetic parameter tests", {
  # enocoding and n be pass to jsonlite, n is the JSON lines be readed
  x <- is.json.file(config.json, encoding = "UTF-8", n = 50)
  expect_that(x, equals(TRUE))
  x <- is.json.file(config.json, encoding = "UTF-8", n = 11)
  expect_that(x, equals(FALSE))
})
