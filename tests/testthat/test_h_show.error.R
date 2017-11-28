config.json <- system.file("extdata", "config.json", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
config.error.json <- system.file("extdata", "config.error.json", package = "configr")
config.error.ini <- system.file("extdata", "config.error.ini", package = "configr")
config.error.yaml <- system.file("extdata", "config.error.yaml", package = "configr")
config.error.toml <- system.file("extdata", "config.error.toml", package = "configr")

test_that("Raise Warning and Error tests or return FALSE", {
  x <- tryCatch({
    suppressWarnings(get.config.type(list()))
  }, warning = function(w) {
    return("Warning")
  }, error = function(e) {
    return("Error")
  })
  expect_that(x, equals(FALSE))
  
  config.opts <- c("json", "ini", "yaml", "toml")
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("is.%s.file(list())", i)
    x <- tryCatch({
      eval(parse(text = rcmd.text))
    }, warning = function(w) {
      return("Warning")
    }, error = function(e) {
      return("Error")
    })
    expect_that(x, equals(FALSE))
  }
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("get.config.type(config.error.%s)", i)
    x <- tryCatch({
      eval(parse(text = rcmd.text))
    }, warning = function(w) {
      return("Warning")
    }, error = function(e) {
      return("Error")
    })
    expect_that(x, equals(FALSE))
  }
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("is.%s.file(config.error.%s)", i, i)
    x <- tryCatch({
      eval(parse(text = rcmd.text))
    }, warning = function(w) {
      return("Warning")
    }, error = function(e) {
      return("Error")
    })
    expect_that(x, equals(FALSE))
  }
  for (i in config.opts) {
    x <- NULL
    rcmd.text <- sprintf("get.config.type(config.error.%s, %s.file.debug = TRUE)", 
      i, i)
    x <- tryCatch({
      eval(parse(text = rcmd.text))
    }, warning = function(w) {
      return("Warning")
    }, error = function(e) {
      return("Error")
    })
    expect_that(x, equals("Error"))
  }
  for (i in config.opts) {
    for (j in config.opts[config.opts != i]) x <- NULL
    rcmd.text <- sprintf("is.%s.file(config.%s, %s.file.debug = TRUE)", i, i, 
      i)
    x <- tryCatch({
      eval(parse(text = rcmd.text))
    }, warning = function(w) {
      return("Warning")
    }, error = function(e) {
      return("Error")
    })
    expect_that(x, equals(TRUE))
  }
})
