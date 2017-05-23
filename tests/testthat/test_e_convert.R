config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.list <- list(json = config.json, yaml = config.yaml, ini = config.ini, toml = config.toml)
test_that("convert.config Function", {
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    for (j in config.opts[!config.opts %in% c(i, "toml")]) {
      out.fn <- sprintf("%s/test.convert.%s", tempdir(), j)
      x <- convert.config(file = config.list[[i]], out.file = out.fn, convert.to = j)
      expect_that(x, equals(TRUE))
      expect_that(get.config.type(out.fn), equals(j))
    }
  }
})
