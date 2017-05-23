# [![Build Status](https://travis-ci.org/Miachol/configr.svg)](https://travis-ci.org/Miachol/configr) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://en.wikipedia.org/wiki/MIT_License) [![CRAN](http://www.r-pkg.org/badges/version/configr)](https://cran.r-project.org/package=configr) [![Downloads](http://cranlogs.r-pkg.org/badges/configr?color=brightgreen)](http://www.r-pkg.org/pkg/configr) [![codecov](https://codecov.io/github/Miachol/configr/branch/master/graphs/badge.svg)](https://codecov.io/github/Miachol/configr) 

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


## Configuration file format

### JSON
``` json
{
  "default": {
    "debug": "{{debug}} {{debug2}}"
  },
  "comments": {
    "version": "0.2.3"
  },
  "extra_list_parse": {
    "raw": "{{yes}}",
    "parsed": "1"
  },
  "other_config_parse": {
    "raw": "{{key:yes_flag}} {{key:no_flag}}",
    "parsed": "yes no"
  },
  "rcmd_parse": {
    "raw": "@>@ Sys.Date() @<@"
  },
  "bash_parse": {
    "raw": "#>#echo bash#<#",
    "parsed": "bash"
  },
  "mulitple_parse": {
    "raw":"@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr','r','')@<@, #># echo config#<#, {{key:no_flag}}, {{no}}",
    "parsed":"configr, configr, yes, 1, config, config, no, 0"
  }
}

```
More infomation and example of JSON can be founded in [json.org](http://www.json.org/), [JSON Example](http://www.json.org/example.html) and [JSON-wikipedia](https://en.wikipedia.org/wiki/JSON). `{{key:key:value}}/{{key}}` can be parsed by parse.extra using `extra.list` and `other.config` parameters. `@>@ str_replace("config", "g$", "gr")@<@` can be parsed by `parse.extra` setting parameter `rcmd.parse` to `TRUE`. Example of that can be founded in this document tail.

### INI
``` ini
[default]
debug = {{debug}} {{debug2}}

[comments]
version = 0.2.3

[extra_list_parse]
raw = {{yes}}
parsed = 1

[other_config_parse]
raw = {{key:yes_flag}} {{key:no_flag}}
parsed = yes no

[rcmd_parse]
raw = @>@ Sys.Date() @<@

[bash_parse]
raw = #>#echo bash#<#
parsed = bash

[mulitple_parse]
raw = @>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr','r','')@<@, #>#echo config#<#, {{key:no_flag}}, {{no}}
parsed = configr, configr, yes, 1, config, config, no, 0
```
More infomation and example of INI can be founded in [INI-wikipedia](https://en.wikipedia.org/wiki/INI_file).

### YAML
``` yaml
default:
  debug: '{{debug}} {{debug2}}'
comments:
  version: 0.2.3
extra_list_parse:
  raw: '{{yes}}'
  parsed: '1'
other_config_parse:
  raw: '{{key:yes_flag}} {{key:no_flag}}'
  parsed: yes no
rcmd_parse:
  raw: '@>@ Sys.Date() @<@'
bash_parse:
  raw: "#>#echo bash#<#"
  parsed: bash
mulitple_parse:
  raw: "@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr','r','')@<@, #>#echo config#<#, {{key:no_flag}}, {{no}}"
  parsed: configr, configr, yes, 1, config, config, no, 0
```
More infomation and example of YAML can be founded in [yaml.org](http://www.yaml.org/) and [YAML-wikipedia](https://en.wikipedia.org/wiki/YAML).

### TOML
``` toml
# This is a TOML document. Jianfeng.

title = "TOML Example"

[default]
debug = "{{debug}} {{debug2}}"

[comments]
version = "0.2.3"

[extra_list_parse]
raw = "{{yes}}"
parsed = "1"

[other_config_parse]
raw = "{{key:yes_flag}} {{key:no_flag}}"
parsed = "yes no"

[bash_parse]
raw = "#>#echo bash#<#"
parsed = "bash"

[mulitple_parse]
raw = "@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr','r','')@<@, #>#echo config#<#, {{key:no_flag}}, {{no}}"
parsed = "configr, configr, yes, 1, config, config, no, 0"
```
More infomation and example of TOML can be founded in and [toml-lang/toml](https://github.com/toml-lang/toml) and [TOML-wikipedia](https://en.wikipedia.org/wiki/TOML).

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

# Usage

``` r
#Get filepath of example configuration files
config.json <- system.file('extdata', 'config.json', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')
```
**is.json.file/is.ini.file/is.yaml.file/is.toml.file**

is.json.file/is.ini.file/is.yaml.file/is.toml.file can test configuration file type,
and more filetype will be supported in the future. If file.debug be setted to TRUE, it will show the warning infomation.
``` r
#Test file type of config file (No warning message)
is.json <- is.json.file(file = config.json)
is.ini <- is.ini.file(file = config.ini)
is.yaml <- is.yaml.file(file = config.yaml)
is.toml <- is.toml.file(file = config.toml)

#Test file type of config file (Debug, print warning message) 
is.json <- is.json.file(file = config.yaml, json.file.debug = T)
is.ini <- is.ini.file(file = config.json, ini.file.debug = T)
is.yaml <- is.yaml.file(file = config.toml, yaml.file.debug = T)
is.toml <- is.toml.file(file = config.yaml, toml.file.debug = T)
```

**get.config.type**

get.config.type can get configuration file type directly, it will return the json/ini/yaml/toml or FALSE for other format.
``` r
json <- get.config.type(file = config.json) 
ini <- get.config.type(file = config.ini) 
yaml <- get.config.type(file = config.yaml) 
toml <- get.config.type(file = config.toml) 
```

**read.config**

read.config can read a configuration file in R and as a list object that can pass parameter to inner read function (fromJSON/read.ini/yaml.load_file/parseToml) accordingly.
``` r
#Read in R as a list (JSON/INI/YAML/TOML be suported)
#fromJSON/read.ini/readLines/yaml.load  parameters can be automatch by parameter name (encoding .etc.)
json.list <- read.config(file = config.json)
ini.list <- read.config(file = config.ini)
yaml.list <- read.config(file = config.yaml)
toml.list <- read.config(file = config.toml) 
toml.list.parsed.1 <- read.config(file = config.toml, extra.list = list(debug = "TRUE")) 
other.config <- system.file('extdata', 'config.other.yaml', package='configr')
toml.list.parsed.2 <- read.config(file = config.toml, other.config = other.config) 
```

**eval.config**

eval.config return a value or a list object containing the file path, config group, filetype as the attribute.
``` r
#Get the same obj with config package, only get the 'default or R_CONFIG_ACTIVE config sets' in config.cfg or R_CONFIGFILE_ACTIVE
config.json.obj <- eval.config(file = config.json)
config.ini.obj <- eval.config(file = config.ini)
config.yaml.obj <- eval.config(file = config.yaml)
config.toml.obj <- eval.config(file = config.toml)
```

**eval.config.sections**

eval.config.sections can get all top sections in configuration file. 
``` r
json.sections <- eval.config.sections(file = config.json)
ini.sections <- eval.config.sections(file = config.ini)
yaml.sections <- eval.config.sections(file = config.yaml)
toml.sections <- eval.config.sections(file = config.toml)
```

**eval.config.merge**

eval.config.merge can read mulitple selected config sections as a list
(Default to read all sections, you can set parameter 'sections' to read whatever you want sections).
``` r
json.config.all <- eval.config.merge(file = config.json)
ini.config.all <- eval.config.merge(file = config.ini)
yaml.config.all <- eval.config.merge(file = config.yaml)
toml.config.all <- eval.config.merge(file = config.toml)
```

**convert.config**

convert.config can covert JSON/INI/YAML/TOML format configuration file to JSON/INI/YAML format configuration file 
``` r
convert.config(file = config.yaml, out.file = tempfile(, fileext = ".json"), convert.to = "JSON")
```

**write.config**

write.config as the only write function, JSON/INI/YAML be supported now, the TOML will be done soon. Of course, 
toJSON/write.ini/as.yaml can get the parameters from write.config
``` r
#Write config in file (JSON/INI/YAML be supported now, TOML be included TODO list, 
list.test <- list(a=c(123,456))
out.fn <- sprintf("%s/test.json", tempdir())
write.config(config.dat = list.test, file.path = out.fn, write.type = "json")

# toJSON/write.ini/as.yaml parameters can be automatch by parameter name (indent/encoding .etc.)
write.config(config.dat = list.test, file.path = out.fn, write.type = "json", indent = 2)
out.fn <- sprintf("%s/test.yaml", tempdir())
write.config(config.dat = list.test, file.path = out.fn, write.type = "yaml")
write.config(config.dat = list.test, file.path = out.fn, write.type = "yaml", indent = 4)

out.fn <- sprintf("%s/test.ini", tempdir())
write.config(config.dat = list.test, file.path = out.fn, write.type = "ini")
```

**parse.extra**

parse.extra default be used by read.config, eval.config and others by parameters "extra.list", "other.config", "rcmd.parse".
``` r
config.1 <- read.config(file = config.json)
other.config <- system.file('extdata', 'config.other.yaml', package='configr')
config.2 <- read.config(file = config.json, extra.list = list(debug = "self", debug2 = "self2"))
config.3 <- read.config(file = config.json, extra.list = list(debug = "self", debug2 = "self2"), other.config = other.config)
# The followed two line command will return the same value
config.4 <- read.config(file = config.json, extra.list = list(debug = "self", debug2 = "self2"), other.config = other.config, rcmd.parse = T)
config.5 <- parse.extra(config.1, extra.list = list(debug = "self", debug2 = "self2"), other.config = other.config, rcmd.parse = T)
config.6 <- parse.extra(config.1, extra.list = list(debug = "self", debug2 = "self2", yes = "1", no = "0"), other.config = other.config, rcmd.parse = T, bash.parse = T)
```
