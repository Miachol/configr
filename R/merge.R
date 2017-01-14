#' Merge config parameter sets by sections.
#'
#' @param file File name of configuration file to read from. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param ... Arguments for \code{\link{get.config.type}}, 
#' \code{\link{eval.config.sections}}, \code{\link{eval.config}}
#' @param sections Need be merged parameter sets, eg. sections=c('default', 'version'), will 
#' default to all of config sections
#' @seealso
#' \code{\link{eval.config.sections}} which only get all of the mainly parameter sets name in config file, 
#' \code{\link{read.config}} which only read from a config as a list,
#' \code{\link{eval.config}} which only read one sections as config obj or a value from config file.
#' @return A list or logical FALSE indicating that is not standard JSON/INI/YAML/TOML format file
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config.ini <- system.file('extdata', 'config.ini', package='configr')
#' config.yaml <- system.file('extdata', 'config.yaml', package='configr')
#' config.toml <- system.file('extdata', 'config.toml', package='configr')
#' eval.config.merge(config.json)
#' eval.config.merge(config.ini)
#' eval.config.merge(config.yaml)
#' eval.config.merge(config.toml)
eval.config.merge <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), 
  sections = NULL, ...) {
  config.dat <- list()
  sections.all <- eval.config.sections(file = file, ...)
  config.type <- get.config.type(file = file, ...)
  if (is.logical(sections.all) && sections.all == FALSE) {
    return(FALSE)
  }
  if (is.null(sections)) {
    for (i in sections.all) {
      config.tmp <- eval.config(file = file, config = i, ...)
      if (!is.list(config.tmp)) {
        config.tmp <- as.list(config.tmp)
        names(config.tmp) <- i
      }
      config.dat <- config.list.merge(list.left = config.dat, list.right = config.tmp)
    }
    attr(config.dat, "config") <- sections.all
  } else {
    sections <- sections[sections %in% sections.all]
    for (i in sections) {
      config.tmp <- eval.config(file = file, config = i, ...)
      if (!is.list(config.tmp)) {
        config.tmp <- as.list(config.tmp)
        names(config.tmp) <- i
      }
      config.dat <- config.list.merge(list.left = config.dat, list.right = config.tmp)
      attr(config.dat, "config") <- sections
    }
  }
  attr(config.dat, "configtype") <- config.type
  attr(config.dat, "file") <- file
  return(config.dat)
}

#' Merge list file (From config package), list.right will overwrite the element also existed in list.left
#'
#' @param list.left One list be merged left
#' @param list.right One list be merged right 
#' @seealso
#' \code{\link[config]{merge}} call in this function
#' @return A list 
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' list.left <- list()
#' list.right <- eval.config(file = config.json)
#' config.list.merge(list.left, list.right)
#' list.left <- list(a=c(123,456))
#' list.right <- list(a=c(4,5,6)) 
#' config.list.merge(list.left, list.right)
config.list.merge <- function(list.left = list(), list.right = list()) {
  if (!is.list(list.left) | !is.list(list.right)) {
    warning("list.left or list.left must be list type!")
  }
  list.merge(list.left, list.right)
}
