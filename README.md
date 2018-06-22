# [![Build Status](https://travis-ci.org/Miachol/configr.svg)](https://travis-ci.org/Miachol/configr) [![CRAN](http://www.r-pkg.org/badges/version/configr)](https://cran.r-project.org/package=configr) [![Downloads](http://cranlogs.r-pkg.org/badges/configr?color=brightgreen)](http://www.r-pkg.org/pkg/configr) [![codecov](https://codecov.io/github/Miachol/configr/branch/master/graphs/badge.svg)](https://codecov.io/github/Miachol/configr) 

configr package
==============

The R package '[configr](https://github.com/Miachol/configr)' implements the
'[JSON](https://CRAN.R-project.org/package=jsonlite)', 
'[INI](https://CRAN.R-project.org/package=ini)', 
'[YAML](https://CRAN.R-project.org/package=yaml)', 
and '[TOML](https://CRAN.R-project.org/package=RcppTOML)' parser for R setting and writing of configuration file.

# Introduction 

The configuration file is necessary for many projects that will help us to manage and set project environment variables easily.

Configuration files, from INI/XML/JSON/YAML to TOML, readability and maneuverability have been improved too much in the past few years, and there are several parsers be created in R and other programming languages. That has made us becomes more efficient, but, we need to remember the different functions for different format configuration file that sometimes we only just want to read it and regardless of that format. So, using a single function to read or/and write most of the configuration file are a good way to reduce memory burden.


[configr](https://github.com/Miachol/configr) have done some work to relax us on configuration files that can be used to parse and generate JSON/INI/YAML/TOML format configuration file. The functionality of this package is similar to that of package '[config](https://CRAN.R-project.org/package=config)'. Vignettes can be found in [usage-of-configr](https://life2cloud.com/en/2017/07/usage-of-configr/) and [configuration-filetypes](https://life2cloud.com/en/2017/07/configuration-filetypes/).

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

# Get demo configuration files in configr
config.json <- system.file('extdata', 'config.json', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')

# Check specific configuration file type
is.json <- is.json.file(file = config.json)
is.ini <- is.ini.file(file = config.ini)
is.yaml <- is.yaml.file(file = config.yaml)
is.toml <- is.toml.file(file = config.toml)

# Check specific configuration file types with debug information
is.json <- is.json.file(file = config.yaml, json.file.debug = T)
is.ini <- is.ini.file(file = config.json, ini.file.debug = T)
is.yaml <- is.yaml.file(file = config.toml, yaml.file.debug = T)
is.toml <- is.toml.file(file = config.yaml, toml.file.debug = T)

# Get configuration file type
json <- get.config.type(file = config.json) 
ini <- get.config.type(file = config.ini) 
yaml <- get.config.type(file = config.yaml) 
toml <- get.config.type(file = config.toml) 

# Read whole configuration file
json.list <- read.config(file = config.json)
ini.list <- read.config(file = config.ini)
yaml.list <- read.config(file = config.yaml)
toml.list <- read.config(file = config.toml) 

# Read specific section of configuration file (default is 'default' section)
# Configuration type, section, and path will be added to this object
config.json.obj <- eval.config(file = config.json)
config.ini.obj <- eval.config(file = config.ini)
config.yaml.obj <- eval.config(file = config.yaml)
config.toml.obj <- eval.config(file = config.toml)

# Get all configuration section names
json.sections <- eval.config.sections(file = config.json)
ini.sections <- eval.config.sections(file = config.ini)
yaml.sections <- eval.config.sections(file = config.yaml)
toml.sections <- eval.config.sections(file = config.toml)

# Merge multiple sections, default is all sections 
# You can use this to reduce one layer in configuration file
json.config.all <- eval.config.merge(file = config.json)
ini.config.all <- eval.config.merge(file = config.ini)
yaml.config.all <- eval.config.merge(file = config.yaml)
toml.config.all <- eval.config.merge(file = config.toml)

# Convert string to configuration list object
json_string <- '{"city" : "Z\\u00FCrich"}\n'
yaml_string <- 'foo: 123\n'
json_config <- str2config(json_string)
yaml_config <- str2config(yaml_string)

# Read configuration files from remote sits
links <- c('https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_annovar.toml', 
           'https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_main.toml')
fetch.config(links)

# Convert YAML format configuration file to JSON format
convert.config(file = config.yaml, out.file = tempfile(, fileext = ".json"), 
  convert.to = "JSON")

# Write JSON format configuration file
list.test <- list(a=c(123,456))
out.fn <- sprintf("%s/test.json", tempdir())

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "json")

# Write JSON format configuration file with 2 indent
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "json", indent = 2)

# Write YAML format configuration file
out.fn <- sprintf("%s/test.yaml", tempdir())
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "yaml")
# Write YAML format configuration file with 4 indent
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "yaml", indent = 4)

# Write TOML format configuration file
# !! You need install python and toml package
# pip install toml
out.fn <- sprintf("%s/test.toml", tempdir())
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "toml")

out.fn <- sprintf("%s/test.ini", tempdir())

# Write INI format configuration file
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "ini")

# Write INI format configuration file (only including pointed sections)
write.config(config.dat = list.test, file.path = out.fn, sections = "a",
  write.type = "ini")

# Some of demo of extend parse
# 
# Read raw configuration file that were parsed by jsonlite, yaml, INI and RcppTOML
config.1 <- read.config(file = config.json)
other.config <- system.file('extdata', 'config.other.yaml', package='configr')

# Replace any items contained string "{{debug}}" to "self" and "debug2" to "self2"
config.2 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"))

# Replace any items contained string "{{debug}}" to "self" and "debug2" to "self2"
# Then replace {{key:yes_flag}} to value in other.config key's yes_flag and no_flag
config.3 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config)

# Replace any items contained string "{{debug}}" to "self" and "debug2" to "self2"
# Then replace {{key:yes_flag}} to value in other.config key's yes_flag and no_flag
# Then replace @>@ Sys.Date() @<@ to R command result ...
config.4 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config, rcmd.parse = T)

config.5 <- parse.extra(config.1, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config, rcmd.parse = T)
  
# Replace any items contained string "{{debug}}" to "self" and "debug2" to "self2"
# Then replace {{key:yes_flag}} to value in other.config key's yes_flag and no_flag
# Then replace @>@ Sys.Date() @<@ to R command executed result ...
# Then replace #>#echo bash#<# to system() executed result
config.6 <- parse.extra(config.1, 
  extra.list = list(debug = "self", debug2 = "self2", yes = "1", no = "0"), 
  other.config = other.config, rcmd.parse = T, bash.parse = T)

# Use glue() to parse "{value or R CMD}"
# It will change the the length of a vector if returned value is a vector
raw <- c("a", "!!glue{1:5}", "c")
list.raw <- list(glue = raw, nochange = 1:10)
parsed <- parse.extra(list.raw, glue.parse = TRUE, glue.flag = "!!glue")
expect.parsed.1 <- c("a", "1", "2", "3", "4", "5", "c")
expect.parsed.2 <- list(glue = expect.parsed.1, nochange = 1:10)

# Delete a section in a configuration object
config.partial <- config.sections.del(config.1, "default")
```

If you want to access external helps about configurations format or other related information,
You can use `configr::config.help()` do this. It will return a dataframe contains all helps or open 
a browser, such as Chrome, to access the corresponding URL.

```r
# Show all help urls stored in configr
config.help()
# Open the url in browser
config.help('toml_stackoverflow_search')
# Or use the row number to access
config.help(23)
```
