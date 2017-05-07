config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")

test_that("convert.config Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    for (j in config.opts[!config.opts %in% c(i, "toml")]) {
      out.fn <- sprintf("%s/test.convert.%s", tempdir(), j)
      rcmd.text <- sprintf("x <- convert.config(file = config.%s, out.file = \"%s\", convert.to = \"%s\")", 
        i, out.fn, j)
      eval(parse(text = rcmd.text))
      expect_that(x, equals(TRUE))
      expect_that(get.config.type(out.fn), equals(j))
    }
  }
})
