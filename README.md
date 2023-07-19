# [![Build Status](https://travis-ci.org/Miachol/configr.svg)](https://travis-ci.org/Miachol/configr) [![CRAN](http://www.r-pkg.org/badges/version/configr)](https://cran.r-project.org/package=configr) [![Downloads](http://cranlogs.r-pkg.org/badges/configr?color=brightgreen)](http://www.r-pkg.org/pkg/configr) [![codecov](https://codecov.io/github/Miachol/configr/branch/master/graphs/badge.svg)](https://codecov.io/github/Miachol/configr) 

configr package
==============

The R package '[configr](https://github.com/Miachol/configr)' implements the
'[JSON](https://CRAN.R-project.org/package=jsonlite)', 
'[INI](https://CRAN.R-project.org/package=ini)', 
'[YAML](https://CRAN.R-project.org/package=yaml)', 
and '[TOML](https://CRAN.R-project.org/package=RcppTOML)' parser for R setting and writing of configuration file.

# Introduction 

The configuration file is required for several projects. It can be used to manage and set the project environment variables. The readability and maneuverability of configuration files, from INI/XML/JSON/YAML to TOML, have been improved in the past few years.  Several such parsers were created in the R language. Though it is more efficient than before, we still need to utilize different functions to parse configuration files with different formats. However, in most cases, we only just want to read it and regardless of the format. Using a single function to read or/and write such configuration files is more comfortable.

[configr](https://github.com/Miachol/configr) provides a more simple way to parse and generate the diverse configuration files including JSON/INI/YAML/TOML files. The `configr` is similar to that of package '[config](https://CRAN.R-project.org/package=config)'. Vignettes can be found in [usage-of-configr](https://life2cloud.com/en/2017/07/usage-of-configr/) and [configuration-filetypes](https://life2cloud.com/en/2017/07/configuration-filetypes/).

# Installation

## CRAN
``` r
# Install this package directly from CRAN by running (from within R):
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

# Demo files
config.json <- system.file('extdata', 'config.json', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')
config.glob <- system.file('extdata', 'config.global.toml', package='configr')

# Check the type of configuration file
is.json <- is.json.file(file = config.json)
is.ini <- is.ini.file(file = config.ini)
is.yaml <- is.yaml.file(file = config.yaml)
is.toml <- is.toml.file(file = config.toml)

# Check the type of configuration file (Debug mode)
is.json <- is.json.file(file = config.yaml, json.file.debug = T)
is.ini <- is.ini.file(file = config.json, ini.file.debug = T)
is.yaml <- is.yaml.file(file = config.yaml, yaml.file.debug = T)
is.toml <- is.toml.file(file = config.toml, toml.file.debug = T)

# Query the type of configuration file
json <- get.config.type(file = config.json) 
ini <- get.config.type(file = config.ini) 
yaml <- get.config.type(file = config.yaml) 
toml <- get.config.type(file = config.toml) 

# Read the whole configuration file
json.list <- read.config(file = config.json)
ini.list <- read.config(file = config.ini)
yaml.list <- read.config(file = config.yaml)
toml.list <- read.config(file = config.toml) 

# Read specific section of configuration file (default is 'default' section)
# Configuration type, section, and path were added to the parsed object
config.json.obj <- eval.config(file = config.json)
config.ini.obj <- eval.config(file = config.ini)
config.yaml.obj <- eval.config(file = config.yaml)
config.toml.obj <- eval.config(file = config.toml)

# Query all section names
json.sections <- eval.config.sections(file = config.json)
ini.sections <- eval.config.sections(file = config.ini)
yaml.sections <- eval.config.sections(file = config.yaml)
toml.sections <- eval.config.sections(file = config.toml)

# Merge multiple sections, default is all
# Reduce a layer of configuration file
json.config.all <- eval.config.merge(file = config.json)
ini.config.all <- eval.config.merge(file = config.ini)
yaml.config.all <- eval.config.merge(file = config.yaml)
toml.config.all <- eval.config.merge(file = config.toml)

# Parse string to configuration list object
json_string <- '{"city" : "Z\\u00FCrich"}\n'
yaml_string <- 'foo: 123\n'
json_config <- str2config(json_string)
yaml_config <- str2config(yaml_string)

# Download and parse files from remote websits
links <- c('https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_annovar.toml', 
           'https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_main.toml')
fetch.config(links)

# Convert YAML format to JSON format
convert.config(file = config.yaml, out.file = tempfile(, fileext = ".json"), 
  convert.to = "JSON")

# Write JSON format file
list.test <- list(a=c(123,456))
out.fn <- sprintf("%s/test.json", tempdir())

write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "json")

# Write JSON format file with 2 indent
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "json", indent = 2)

# Write YAML format file
out.fn <- sprintf("%s/test.yaml", tempdir())
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "yaml")
# Write YAML format file with 4 indent
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "yaml", indent = 4)

# Write TOML format file
# !! You need install python and toml package
# pip install toml
out.fn <- sprintf("%s/test.toml", tempdir())
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "toml")

out.fn <- sprintf("%s/test.ini", tempdir())

# Write INI format file
write.config(config.dat = list.test, file.path = out.fn, 
  write.type = "ini")

# Write INI format file. It only includes given sections.
write.config(config.dat = list.test, file.path = out.fn, sections = "a",
  write.type = "ini")

# Demo of extended parse functions
# 
# Read raw file by jsonlite, yaml, INI and RcppTOML packages
config.1 <- read.config(file = config.json)
other.config <- system.file('extdata', 'config.other.yaml', package='configr')

# Replace any string "{{debug}}" and "{{debug2}}" to "self" and "self2" respectively
config.2 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"))

# Replace any string "{{debug}}" and "{{debug2}}" to "self" and "self2" respectively
# Then replace {{key:yes_flag}} to the value of other.config key's yes_flag and no_flag
config.3 <- read.config(file = config.json, 
  extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config)

# Replace any string "{{debug}}" and "{{debug2}}" to "self" and "self2" respectively
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
# It will changes the length of a vector if returned value is a vector
raw <- c("a", "!!glue{1:5}", "c")
list.raw <- list(glue = raw, nochange = 1:10)
parsed <- parse.extra(list.raw, glue.parse = TRUE, glue.flag = "!!glue")
expect.parsed.1 <- c("a", "1", "2", "3", "4", "5", "c")
expect.parsed.2 <- list(glue = expect.parsed.1, nochange = 1:10)


# Global vars parse (new feature in v0.3.4)
# 
config_no_parsed_global <- read.config(config.glob, global.vars.field = NULL)
config_parsed <- read.config(config.glob)

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
