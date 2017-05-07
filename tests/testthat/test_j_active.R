x <- is.config.active("default")
expect_that(x, equals(TRUE))

x <- is.configfile.active("test.cfg")
expect_that(x, equals(FALSE))
