# [![Build Status](https://travis-ci.org/Miachol/configr.svg)](https://travis-ci.org/Miachol/configr) [![CRAN](http://www.r-pkg.org/badges/version/configr)](https://cran.r-project.org/package=configr) [![Downloads](http://cranlogs.r-pkg.org/badges/configr?color=brightgreen)](http://www.r-pkg.org/pkg/configr) [![codecov](https://codecov.io/github/Miachol/configr/branch/master/graphs/badge.svg)](https://codecov.io/github/Miachol/configr) 

configr package
==============


The R package '[configr](https://github.com/Miachol/configr)' implements the
'[JSON](https://CRAN.R-project.org/package=jsonlite)', 
'[INI](https://CRAN.R-project.org/package=ini)', 
'[YAML](https://CRAN.R-project.org/package=yaml)', 
and '[TOML](https://CRAN.R-project.org/package=RcppTOML)' parser for R setting and writing of configuration file.

# Introduction 

The configuration file are necessary for many projects that will help us to manage and set project environment variables easily.

Configuration files, from INI/XML/JSON/YAML to TOML, readability and maneuverability have been improved too much in the past few years, and there are serveral parsers be created in R and other programming language. That have made us becomes more efficient, but, we need to remember the different functions for different format configuration file that sometimes we only just want to read it and regardless of that format. So, using single function to read or/and write most of configuration file are good way to reduce memory burden.


[configr](https://github.com/Miachol/configr) have done some work to relax us on configuration files that can be used to parse and generate JSON/INI/YAML/TOML format configuration file. The functionality of this package is similar to that of package '[config](https://CRAN.R-project.org/package=config)'.

# Installation

## CRAN
``` r
#You can install this package directly from CRAN by running (from within R):
install.packages('configr')
```

## Github
``` r
# Install the cutting edge development version from GitHub:
# install.packages("devtools")
devtools::install_github("Miachol/configr")
```

## Zip/Tarball

1. Download the appropriate zip file or tar.gz file from Github
2. Unzip the file and change directories into the configr directory
3. Run `R CMD INSTALL pkg`

# Basic usage

```r
library(configr)

config.json <- system.file('extdata', 'config.json', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')

```


```r
is.json <- is.json.file(file = config.json)
is.ini <- is.ini.file(file = config.ini)
is.yaml <- is.yaml.file(file = config.yaml)
is.toml <- is.toml.file(file = config.toml)

is.json <- is.json.file(file = config.yaml, json.file.debug = T)
is.ini <- is.ini.file(file = config.json, ini.file.debug = T)
is.yaml <- is.yaml.file(file = config.toml, yaml.file.debug = T)
is.toml <- is.toml.file(file = config.yaml, toml.file.debug = T)
```

```r
json <- get.config.type(file = config.json) 
ini <- get.config.type(file = config.ini) 
yaml <- get.config.type(file = config.yaml) 
toml <- get.config.type(file = config.toml) 
```

```r
json.list <- read.config(file = config.json)
ini.list <- read.config(file = config.ini)
yaml.list <- read.config(file = config.yaml)
toml.list <- read.config(file = config.toml) 
```

```r
config.json.obj <- eval.config(file = config.json)
config.ini.obj <- eval.config(file = config.ini)
config.yaml.obj <- eval.config(file = config.yaml)
config.toml.obj <- eval.config(file = config.toml)
```

```r
json.sections <- eval.config.sections(file = config.json)
ini.sections <- eval.config.sections(file = config.ini)
yaml.sections <- eval.config.sections(file = config.yaml)
toml.sections <- eval.config.sections(file = config.toml)
```

```r
json.config.all <- eval.config.merge(file = config.json)
ini.config.all <- eval.config.merge(file = config.ini)
yaml.config.all <- eval.config.merge(file = config.yaml)
toml.config.all <- eval.config.merge(file = config.toml)
```

```r
convert.config(file = config.yaml, out.file = tempfile(, fileext = ".json"), 
  convert.to = "JSON")

list.test <- list(a=c(123,456))
out.fn <- sprintf("%s/test.json", tempdir())

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "json")

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "json", indent = 2)

out.fn <- sprintf("%s/test.yaml", tempdir())

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "yaml")

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "yaml", indent = 4)

out.fn <- sprintf("%s/test.ini", tempdir())

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "ini")
```

```r
config.1 <- read.config(file = config.json)
other.config <- system.file('extdata', 'config.other.yaml', package='configr')

config.2 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"))

config.3 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config)

config.4 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config, rcmd.parse = T)

config.5 <- parse.extra(config.1, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config, rcmd.parse = T)
  
config.6 <- parse.extra(config.1, 
  extra.list = list(debug = "self", debug2 = "self2", yes = "1", no = "0"), 
  other.config = other.config, rcmd.parse = T, bash.parse = T)

raw <- c("a", "!!glue{1:5}", "c")
list.raw <- list(glue = raw, nochange = 1:10)
parsed <- parse.extra(list.raw, glue.parse = TRUE, glue.flag = "!!glue")
expect.parsed.1 <- c("a", "1", "2", "3", "4", "5", "c")
expect.parsed.2 <- list(glue = expect.parsed.1, nochange = 1:10)
```
