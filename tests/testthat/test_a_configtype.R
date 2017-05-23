config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.error <- system.file("extdata", "config.error.yaml", package = "configr")
config.list <- list(json = config.json, yaml = config.yaml, ini = config.ini, toml = config.toml)

test_that("Configtype Specificity", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    x <- get.config.type(config.list[[i]])
    expect_that(x, equals(i))
    
    x <- NULL
    rcmd.text <- sprintf("x <- is.%s.file(config.%s)", i, i)
    eval(parse(text = rcmd.text))
    expect_that(x, equals(TRUE))
    
    for (j in config.opts[config.opts != i]) {
      x <- NULL
      rcmd.text <- sprintf("x <- is.%s.file(config.%s)", i, j)
      eval(parse(text = rcmd.text))
      expect_that(x, equals(FALSE))
    }
  }
  x <- suppressWarnings(get.config.type(config.error))
  expect_that(x, equals(FALSE))
})
