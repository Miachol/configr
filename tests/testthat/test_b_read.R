config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.error.toml <- system.file("extdata", "config.error.toml", package = "configr")

test_that("read.config Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("x <- read.config(config.%s)", i)
    eval(parse(text = rcmd.text))
    expect_that(is.list(x) && length(x) >= 1, equals(TRUE))
  }
})

test_that("read.config using extra.list parse", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("x <- read.config(config.%s, extra.list = list(debug = \"TRUE\"))", 
      i)
    eval(parse(text = rcmd.text))
    expect_that(is.list(x) && length(x) >= 1, equals(TRUE))
    parsed.value <- x$default$debug
    expect_that(parsed.value, equals("TRUE {{debug2}}"))
  }
})

test_that("eval.config Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("config.path <- config.%s; x <- eval.config(file = config.%s)", 
      i, i)
    eval(parse(text = rcmd.text))
    expect_that(is.list(x) && length(x) >= 1, equals(TRUE))
    expect_that(attributes(x)$config, equals("default"))
    expect_that(attributes(x)$configtype, equals(i))
    file.attr <- attributes(x)$file
    expect_that(is.character(file.attr), equals(TRUE))
    expect_that(file.attr, equals(config.path))
  }
})

test_that("eval.config using extra.list parse", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("x <- eval.config(file = config.%s, extra.list = list(debug = \"TRUE\"))", 
      i)
    eval(parse(text = rcmd.text))
    expect_that(is.list(x) && length(x) >= 1, equals(TRUE))
    parsed.value <- x$debug
    expect_that(parsed.value, equals("TRUE {{debug2}}"))
  }
})

test_that("eval.config.sections Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("x <- eval.config.sections(file = config.%s)", i)
    eval(parse(text = rcmd.text))
    expect_that(length(x) > 1, equals(TRUE))
    expect_that("default" %in% x, equals(TRUE))
  }
})

test_that("eval.config and eval.config.sections Exception Handling", {
  suppressWarnings(x <- read.config(file = "unknow"))
  expect_that(x, equals(FALSE))
  suppressWarnings(x <- read.config(file = config.error.toml))
  expect_that(x, equals(FALSE))
  suppressWarnings(x <- read.config(file = config.error.toml))
  expect_that(x, equals(FALSE))
  suppressWarnings(x <- eval.config(file = "unknow"))
  expect_that(x, equals(FALSE))
  suppressWarnings(x <- eval.config(file = config.error.toml))
  expect_that(x, equals(FALSE))
  suppressWarnings(x <- eval.config.sections(file = "unknow"))
  expect_that(x, equals(FALSE))
  suppressWarnings(x <- eval.config.sections(file = config.error.toml))
  expect_that(x, equals(FALSE))
})
