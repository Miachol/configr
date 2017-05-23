config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.error.toml <- system.file("extdata", "config.error.toml", package = "configr")
config.list <- list(json = config.json, yaml = config.yaml, ini = config.ini, toml = config.toml)

test_that("config.list.merge Function", {
  list.left <- list(a = c(123, 123), b = c(4, 5, 6))
  list.right <- list(c = c(2, 3, 4))
  x <- config.list.merge(list.left, list.right)
  expect_that(x, equals(list(a = c(123, 123), b = c(4, 5, 6), c = c(2, 3, 4))))
})

test_that("eval.config.merge Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- eval.config.merge(file = config.list[[i]])
    expect_that(attributes(x)$config, equals(eval.config.sections(attributes(x)$file)))
    x <- eval.config.merge(file = config.list[[i]], sections = "comments")
    expect_that(attributes(x)$config, equals("comments"))
    x <- eval.config.merge(file = config.list[[i]], sections = c("default", "comments"))
    expect_that(attributes(x)$config, equals(c("default", "comments")))
  }
})

test_that("eval.configmerge Exception Handling", {
  suppressWarnings(x <- eval.config.merge("unknow", c("default", "comments")))
  expect_that(x, equals(FALSE))
})
