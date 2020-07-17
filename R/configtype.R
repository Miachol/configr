#' Function to check wheather file is JSON format
#'
#' @param file File name of configuration file to test. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param json.file.debug If TRUE, it will show error infomation when read JSON config,
#' default is FALSE
#' @param ... Arguments for \code{\link{readLines}} and \code{\link[jsonlite]{fromJSON}}
#' @seealso
#' \code{\link{is.ini.file}},
#' \code{\link{is.yaml.file}},
#' \code{\link{is.toml.file}}
#' @return
#' Logical indicating whether the specified configuration file is JSON format
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config.ini <- system.file('extdata', 'config.ini', package='configr')
#' config.yaml <- system.file('extdata', 'config.yaml', package='configr')
#' config.toml <- system.file('extdata', 'config.toml', package='configr')
#' print(is.json.file(config.json))
#' print(is.json.file(config.ini))
#' print(is.json.file(config.yaml))
#' print(is.json.file(config.toml))
is.json.file <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"),
  json.file.debug = FALSE, ...) {
  if (!is.character(file)) {
    return(FALSE)
  }
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  if (str_detect(file, '.ini$|.yaml$|.toml$')) {
    return(FALSE)
  }
  json.list <- get.config.list(file = file, file.type = "json", json.file.debug = json.file.debug,
    ...)
  if (is.list(json.list)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Function to check wheather file is INI format
#'
#' @param file File name of configuration file to test. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param ini.file.debug If TRUE, it will show error infomation when read INI config,
#' default is FALSE
#' @param ... Arguments for \code{\link[ini]{read.ini}}
#' @seealso
#' \code{\link{is.json.file}},
#' \code{\link{is.yaml.file}},
#' \code{\link{is.toml.file}}
#' @return
#' Logical indicating whether the specified configuration file is INI format
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config.ini <- system.file('extdata', 'config.ini', package='configr')
#' config.yaml <- system.file('extdata', 'config.yaml', package='configr')
#' config.toml <- system.file('extdata', 'config.toml', package='configr')
#' print(is.ini.file(config.ini))
#' print(is.ini.file(config.json))
#' print(is.ini.file(config.yaml))
#' print(is.ini.file(config.toml))
is.ini.file <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), ini.file.debug = FALSE,
  ...) {
  if (!is.character(file)) {
    return(FALSE)
  }
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  if (str_detect(file, '.json$|.yaml$|.toml$')) {
    return(FALSE)
  }
  ini.list <- get.config.list(file = file, file.type = "ini", ini.file.debug = ini.file.debug,
    ...)
  if (!is.list(ini.list) || length(ini.list) == 0) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}

#' Function to check wheather file is YAML format
#'
#' @param file File name of configuration file to test. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param yaml.file.debug If TRUE, it will show error infomation when read YAML config,
#' default is FALSE
#' @param ... Arguments for \code{\link{is.json.file}},
#' \code{\link{readLines}} and \code{\link[yaml]{yaml.load}}
#' @seealso
#' \code{\link{is.json.file}},
#' \code{\link{is.ini.file}},
#' \code{\link{is.toml.file}}
#' @return
#' Logical indicating whether the specified configuration file is YAML format
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config.ini <- system.file('extdata', 'config.ini', package='configr')
#' config.yaml <- system.file('extdata', 'config.yaml', package='configr')
#' config.toml <- system.file('extdata', 'config.toml', package='configr')
#' print(is.yaml.file(config.yaml))
#' print(is.yaml.file(config.json))
#' print(is.yaml.file(config.ini))
#' print(is.yaml.file(config.toml))
is.yaml.file <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"),
  yaml.file.debug = FALSE, ...) {
  if (!is.character(file)) {
    return(FALSE)
  }
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  if (str_detect(file, '.json$|.ini$|.toml$')) {
    return(FALSE)
  }
  yaml.list <- get.config.list(file = file, file.type = "yaml", yaml.file.debug = yaml.file.debug,
    ...)
  if (is.list(yaml.list)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Function to check wheather file is TOML format
#'
#' @param file File name of configuration file to test. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param toml.file.debug If TRUE, it will show error infomation when read TOML config,
#' default is FALSE
#' @param ... Arguments for \code{\link[RcppTOML]{parseTOML}}
#' @seealso
#' \code{\link{is.json.file}}
#' \code{\link{is.ini.file}},
#' \code{\link{is.yaml.file}}
#' @return
#' Logical indicating whether the specified configuration file is TOML format
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config.ini <- system.file('extdata', 'config.ini', package='configr')
#' config.yaml <- system.file('extdata', 'config.yaml', package='configr')
#' config.toml <- system.file('extdata', 'config.toml', package='configr')
#' print(is.toml.file(config.json))
#' print(is.toml.file(config.ini))
#' print(is.toml.file(config.yaml))
#' print(is.toml.file(config.toml))
is.toml.file <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"),
  toml.file.debug = FALSE, ...) {
  if (!is.character(file)) {
    return(FALSE)
  }
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  if (str_detect(file, '.json$|.ini$|.yaml$')) {
    return(FALSE)
  }
  toml.list <- get.config.list(file = file, file.type = "toml", toml.file.debug = toml.file.debug,
    ...)
  if (is.list(toml.list)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Get config file type retreiving json/ini/yaml or FALSE
#'
#' @param file File name of configuration file to test. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param ... Arguments for \code{\link{is.json.file}},
#' \code{\link{is.ini.file}}, \code{\link{is.yaml.file}},
#' \code{\link{is.toml.file}}
#' @seealso
#' \code{\link{is.json.file}},
#' \code{\link{is.ini.file}},
#' \code{\link{is.yaml.file}},
#' \code{\link{is.toml.file}}
#' @return Character json/ini/yaml/toml or
#' Logical FALSE indicating that is not standard JSON/INI/YAML/TOML format file
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config.ini <- system.file('extdata', 'config.ini', package='configr')
#' config.yaml <- system.file('extdata', 'config.yaml', package='configr')
#' config.toml <- system.file('extdata', 'config.toml', package='configr')
#' get.config.type(file=config.json)
#' get.config.type(file=config.ini)
#' get.config.type(file=config.yaml)
#' get.config.type(file=config.toml)
get.config.type <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"),
  ...) {
  if (!is.character(file)) {
    return(FALSE)
  }
  status <- check.file.parameter(file)
  if (status == FALSE) {
    return(FALSE)
  }
  if (is.json.file(file = file, ...)) {
    file.type <- "json"
  } else if (is.ini.file(file = file, ...)) {
    file.type <- "ini"
  } else if (is.yaml.file(file = file, ...)) {
    file.type <- "yaml"
  } else if (is.toml.file(file = file, ...)) {
    file.type <- "toml"
  } else {
    return(FALSE)
  }
  return(file.type)
}
