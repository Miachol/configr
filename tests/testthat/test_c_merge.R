config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.error.toml <- system.file("extdata", "config.error.toml", package = "configr")

test_that("config.list.merge Function", {
  list.left <- list(a = c(123, 123), b = c(4, 5, 6))
  list.right <- list(c = c(2, 3, 4))
  x <- config.list.merge(list.left, list.right)
  expect_that(x, equals(list(a = c(123, 123), b = c(4, 5, 6), c = c(2, 3, 4))))
})

test_that("eval.config.merge Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("x <- eval.config.merge(file = config.%s)", i)
    eval(parse(text = rcmd.text))
    expect_that(attributes(x)$config, equals(eval.config.sections(attributes(x)$file)))
    rcmd.text <- sprintf("x <- eval.config.merge(file = config.%s, sections = \"comments\")", 
      i)
    eval(parse(text = rcmd.text))
    expect_that(attributes(x)$config, equals("comments"))
    rcmd.text <- sprintf("x <- eval.config.merge(file = config.%s, sections = c(\"default\", \"comments\"))", 
      i)
    eval(parse(text = rcmd.text))
    expect_that(attributes(x)$config, equals(c("default", "comments")))
  }
})

test_that("eval.configmerge Exception Handling", {
  suppressWarnings(x <- eval.config.merge("unknow", c("default", "comments")))
  expect_that(x, equals(FALSE))
})
