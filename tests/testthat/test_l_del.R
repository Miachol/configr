config.json <- system.file("extdata", "config.json", package = "configr")
config <- read.config(config.json, file.type = "json")

test_that("config.section.del", {
  x1 <- "default" %in% names(config)
  config <- config.sections.del(config, "default")
  x2 <- !"default" %in% names(config)
  expect_that(x1 && x2, equals(TRUE))
})
