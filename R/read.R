#' Read from the file (JSON/INI/YAML/TOML be supported), retreiving all values as a list.
#'
#' @param file File name of configuration file to read from. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param extra.list A list that can replace the configuration file '{{debug}}' by list(debug = 'TRUE'), 
#' and {{debug}} will be setted to 'TRUE'
#' @param other.config Path of another configuration file that can replace the configuration file '{{key:value}}' 
#' @param rcmd.parse Logical wheather parse '@>@str_replace('abc', 'b', 'c')@<@' that existed in config to 'acc'
#' @param ... Arguments for \code{\link{get.config.type}}, 
#' \code{\link[jsonlite]{fromJSON}}, \code{\link[ini]{read.ini}},
#' \code{\link[yaml]{yaml.load_file}}, \code{\link[RcppTOML]{parseTOML}}, 
#' \code{\link{readLines}}
#' @seealso
#' \code{\link[jsonlite]{fromJSON}} JSON file will read by this
#'
#' \code{\link[ini]{read.ini}} INI file will read by this
#'
#' \code{\link[yaml]{yaml.load_file}} YAML file will read by this
#'
#' \code{\link[RcppTOML]{parseTOML}} TOML file will read by this
#' @return All values as a list or 
#' logical FALSE indicating that is not standard JSON/INI/YAML/TOML format file 
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config <- read.config(file=config.json)
#' config.extra.parsed.1 <- read.config(config.json, list(debug = 'TRUE'))
#' other.config <- system.file('extdata', 'config.other.yaml', package='configr')
#' config.extra.parsed.2 <- read.config(config.json, list(debug = 'TRUE'), other.config)
read.config <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), extra.list = list(), 
  other.config = "", rcmd.parse = FALSE, ...) {
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  file.type <- get.config.type(file = file, ...)
  if (!is.character(file.type)) {
    return(FALSE)
  }
  config.list <- get.config.list(file = file, file.type = file.type, extra.list = extra.list, 
    other.config = other.config, rcmd.parse = rcmd.parse, ...)
  return(config.list)
}

#' Read from the currently active configuration (JSON/INI/YAML/TOML be supported), 
#' 'retreiving either a single named value or all values as a config obj which 
#' have 'config', 'configtype', 'file' 'property.
#'
#' @param file File name of configuration file to read from. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only) 
#' @param value Name of value (NULL to read all values)
#' @param config Name of configuration to read from. Defaults to the value of 
#' 'the R_CONFIG_ACTIVE environment variable ('default' if the variable does not exist). 
#' @param ... Arguments for \code{\link{read.config}}
#' @seealso
#' \code{\link{read.config}} read config by this 
#'
#' \code{\link{eval.config.merge}} which can merge multiple parameter sets by sections
#' @return Either a single value or all values as a list or 
#' logical FALSE indicating that is not standard JSON/INI/YAML/TOML format file
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config <- eval.config(file=config.json)
#' config.extra.parsed.1 <- eval.config(file = config.json, extra.list = list(debug = 'TRUE'))
#' other.config <- system.file('extdata', 'config.other.yaml', package='configr')
#' config.extra.parsed.2 <- eval.config(file = config.json, extra.list = list(debug = 'TRUE'), 
#' other.config = other.config)
#' @export
eval.config <- function(value = NULL, config = Sys.getenv("R_CONFIG_ACTIVE", "default"), 
  file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), ...) {
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  config.list <- read.config(file = file, ...)
  if (is.logical(config.list) && config.list == FALSE) {
    return(FALSE)
  }
  config.list <- get.config.value(file = file, value = value, config = config, 
    config.list = config.list, ...)
  return(config.list)
}

#' Get config file parameter sections
#'
#' @param file File name of configuration file to read from. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param ... Arguments for \code{\link{read.config}} 
#' @seealso
#' \code{\link{eval.config.merge}} which use this get all of sections of config file. 
#' @return a character vector including the sections infomation of configure file or
#' logical FALSE indicating that is not standard JSON/INI/YAML/TOML format file
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' eval.config.sections(config.json)
eval.config.sections <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), 
  ...) {
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  config.list <- read.config(file = file, ...)
  if (is.logical(config.list) && config.list == FALSE) {
    return(FALSE)
  }
  return(names(config.list))
}
