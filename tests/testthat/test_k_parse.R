config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.list <- list(ini = config.ini, json = config.json, toml = config.toml, yaml = config.yaml)

for (i in c("ini", "json", "toml", "yaml")) {
  config <- read.config(config.list[[i]], rcmd.parse = FALSE)
  x <- parse.extra(config, list(debug = "TRUE", yes = "1"))
  expect_that(is.list(x), equals(TRUE))
  expect_that(x$default$debug, equals("TRUE {{debug2}}"))
  expect_that(x$extra_list_parse$raw, equals("1"))
  x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
  expect_that(x[4], equals("1"))
  other.config <- system.file("extdata", "config.other.yaml", package = "configr")
  x <- parse.extra(config, list(debug = "TRUE", debug2 = "FALSE"), other.config)
  expect_that(is.list(x), equals(TRUE))
  expect_that(x$default$debug, equals("TRUE FALSE"))
  expect_that(x$other_config_parse$raw, equals("yes no"))
  x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
  expect_that(x[3], equals("yes"))
  x <- parse.extra(config, list(debug = "TRUE", debug2 = "FALSE"), other.config = other.config, 
    rcmd.parse = T)
  expect_that(is.list(x), equals(TRUE))
  x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
  expect_that(x[1], equals("configr"))
  x <- parse.extra(config, list(debug = "TRUE", debug2 = "FALSE", yes = "1"), other.config = other.config, 
    rcmd.parse = T, bash.parse = T)
  expect_that(is.list(x), equals(TRUE))
  expect_that(x$default$debug, equals("TRUE FALSE"))
  expect_that(x$extra_list_parse$raw, equals("1"))
  expect_that(x$bash_parse$raw, equals("bash"))
  x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
  expect_that(x[1], equals("configr"))
  expect_that(x[2], equals("configr"))
  expect_that(x[3], equals("yes"))
  expect_that(x[4], equals("1"))
}
