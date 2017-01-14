#' Test active configuration file
#'
#' Check whether a configuration file is currently active
#'
#' @param config.file Configuration filename
#' @return
#' Logical indicating whether the specified configuration file is active
#'
#' @examples
#' is.configfile.active('config.cfg')
#' @export
is.configfile.active <- function(config.file) {
  identical(config.file, Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"))
}

#' Test active configuration
#'
#' Check whether a configuration group is currently active
#'
#' @param config Configuration name
#' @return
#' Logical indicating whether the specified configuration is active
#'
#' @examples
#' is.config.active('default')
#' @export
is.config.active <- function(config) {
  identical(config, Sys.getenv("R_CONFIG_ACTIVE", "default"))
}

