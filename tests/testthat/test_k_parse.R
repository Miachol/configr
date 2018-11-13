config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.bio <- system.file("extdata", "complex.toml", package = "configr")
config.global <- system.file("extdata", "config.global.toml", package = "configr") 
config.list <- list(ini = config.ini, json = config.json, toml = config.toml, yaml = config.yaml)

test_that("parse.config", {
  for (i in c("ini", "json", "toml", "yaml")) {
    config <- read.config(config.list[[i]], rcmd.parse = FALSE)
    x <- parse.extra(config, list(debug = "TRUE", yes = "1", no = "0"))
    expect_that(is.list(x), equals(TRUE))
    expect_that(x$default$debug, equals("TRUE {{debug2}}"))
    expect_that(x$extra_list_parse$raw, equals("1"))
    x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
    expect_that(x[4], equals("1"))
    expect_that(x[8], equals("0"))
    other.config <- system.file("extdata", "config.other.yaml", package = "configr")
    x <- parse.extra(config, list(debug = "TRUE", debug2 = "FALSE"), other.config)
    expect_that(is.list(x), equals(TRUE))
    expect_that(x$default$debug, equals("TRUE FALSE"))
    expect_that(x$other_config_parse$raw, equals("yes no"))
    x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
    expect_that(x[3], equals("yes"))
    expect_that(x[7], equals("no"))
    x <- parse.extra(config, list(debug = "TRUE", debug2 = "FALSE"), other.config = other.config, 
      rcmd.parse = T)
    expect_that(is.list(x), equals(TRUE))
    x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
    expect_that(x[1], equals("configr"))
    expect_that(x[5], equals("config"))
    x <- parse.extra(config, list(debug = "TRUE", debug2 = "FALSE", yes = "1", 
      no = "0"), other.config = other.config, rcmd.parse = T, bash.parse = T)
    expect_that(is.list(x), equals(TRUE))
    expect_that(x$default$debug, equals("TRUE FALSE"))
    expect_that(x$extra_list_parse$raw, equals("1"))
    expect_that(x$bash_parse$raw, equals("bash"))
    x <- str_split(x$mulitple_parse$raw, ", ")[[1]]
    expect_that(x[1], equals("configr"))
    expect_that(x[2], equals("configr"))
    expect_that(x[3], equals("yes"))
    expect_that(x[4], equals("1"))
    expect_that(x[5], equals("config"))
    expect_that(x[6], equals("config"))
    expect_that(x[7], equals("no"))
    expect_that(x[8], equals("0"))
  }
})

test_that("str2multiple", {
  raw <- c("a", "!!glue{1:5}", "c")
  parsed <- str2multiple(raw, glue.flag = "!!glue")
  expect.parsed.1 <- c("a", "1", "2", "3", "4", "5", "c")
  expect_that(all(parsed == expect.parsed.1), equals(TRUE))
  
  list.raw <- list(glue = raw, nochange = 1:10)
  parsed <- parse.extra.glue(list.raw)
  expect.parsed.2 <- list(glue = expect.parsed.1, nochange = 1:10)
  expect_that(parsed, equals(expect.parsed.2))
  
  list.raw <- list(nochange.1 = c("{a}", "{b}"), glue = raw, nochange.2 = c("{{a}}", 
    "{{b}}"))
  parsed <- parse.extra.glue(list.raw)
  expect.parsed.2 <- list(nochange.1 = c("{a}", "{b}"), glue = expect.parsed.1, 
    nochange.2 = c("{{a}}", "{{b}}"))
  expect_that(parsed, equals(expect.parsed.2))
})

test_that("parse.extra glue", {
  for (i in c("ini", "json", "toml", "yaml")) {
    config <- read.config(config.list[[i]], glue.parse = TRUE)
    x <- config$glue_parse$raw_1
    expect_that(length(x), equals(10))
    expect_that(all(x == sprintf("%s", 1:10)), equals(TRUE))
    x <- config$glue_parse$raw_2
    expect_that(length(x), equals(10))
    expect_that(all(x == 1:10), equals(TRUE))
  }
})

test_that("parse.extra global var", {
  config <- read.config(config.global)
  expect_that(config$subsection$value_1, equals("G1/value_1")) 
  expect_that(config$subsection$value_2, equals("G2/value_2"))
  config <- read.config(config.global, global.vars.field = NULL)
  expect_that(config$subsection$value_1, equals("{{gvar_1}}/value_1")) 
  expect_that(config$subsection$value_2, equals("{{gvar_2}}/value_2"))
})

test_that("BioInstaller parse", {
  config <- read.config(config.bio, rcmd.parse = TRUE, glue.parse = TRUE, extra.list = list(version = 'v1.1.0'))
  expect_that(is.list(config), equals(TRUE))
})
