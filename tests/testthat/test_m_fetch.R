test_that("fetch.config", {
  links <- c("https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_annovar.toml", 
    "https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_main.toml", 
    system.file("extdata", "config.toml", package = "configr"))
  x <- fetch.config(links)
  expect_that(is.list(x), equals(TRUE))
  destdir.a <- sprintf("%s/a", tempdir())
  dir.create(destdir.a)
  destdir.b <- sprintf("%s/b", tempdir())
  dir.create(destdir.b)
  x <- fetch.config(links, return.files = TRUE, destdir = destdir.a)
  x <- fetch.config(links, return.files = TRUE, keep.basename = FALSE, destdir = destdir.b)
})
