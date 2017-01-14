#' Covert configuration file from JSON/INI/YAML/TOML to JSON/INI/YAML
#'
#' @param file File name of configuration file to read from. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist and JSON/INI/YAML/TOML format only)
#' @param out.file Output path of configuration file. Defaults to the value of
#' the 'R_CONFIGFILE_ACTIVE' environment variable ('config.cfg' if the
#' variable does not exist) 
#' @param convert.to JSON/INI/YAML
#' @param ... Arguments for \code{\link{read.config}} and \code{\link{write.config}}
#' @seealso
#' \code{\link[jsonlite]{fromJSON}} JSON file will read by this
#'
#' \code{\link[ini]{read.ini}} INI file will read by this
#'
#' \code{\link[yaml]{yaml.load_file}} YAML file will read by this
#'
#' @return
#' Logical indicating whether convert success
#' @export
#' @examples
#' config.json <- system.file('extdata', 'config.json', package='configr')
#' config <- convert.config(file=config.json, out.file = sprintf('%s/config.ini', tempdir()))
convert.config <- function(file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), 
  out.file = Sys.getenv("R_CONFIGFILE_ACTIVE", "config.cfg"), convert.to = "ini", 
  ...) {
  config.dat <- read.config(file = file, ...)
  write.config(config.dat = config.dat, file.path = out.file, write.type = convert.to, 
    ...)
}
