#' Fetch configuration file and generate a merged list
#'
#' @param links Url or files path that need to be merged, 
#' e.g. /tmp/config, http://, ftp://.
#' @param return.files Only save the links configuration files to destdir 
#' and not to read and merge the configuration files, default is FALSE
#' @param destdir Fetch configuration files and copy to this directory, 
#' default is ./
#' @param keep.basename Whather use the links basename as the saved name 
#' or use paste0(tempfile(), '_configr')
#' @return A list or a vector
#' @export
#' @examples
#' links <- c('https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_annovar.toml', 
#'            'https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_main.toml', 
#'             system.file('extdata', 'config.toml', package = 'configr'))
#' x <- fetch.config(links)
fetch.config <- function(links, return.files = FALSE, destdir = normalizePath("./"), 
  keep.basename = TRUE) {
  defined_flag <- c("http://", "https://", "ftp://")
  names(defined_flag) <- c("http", "https", "ftp")
  
  # download resources
  config.pool <- c()
  for (link in links) {
    flag <- str_extract(link, "[(file)|(https?)|(ftp)]+://")
    if (is.na(flag)) {
      flag <- "file"
      config.pool <- c(config.pool, link)
    } else {
      index <- sapply(defined_flag, function(x) {
        str_detect(flag, x)
      })
      flag <- names(defined_flag)[index]
      if (keep.basename) {
        config.download.tmp <- sprintf("%s/%s", tempdir(), basename(link))
      } else {
        config.download.tmp <- paste0(tempfile(), "_configr")
      }
      config.pool <- c(config.pool, config.download.tmp)
      download.file(link, config.download.tmp)
    }
  }
  if (return.files) {
    status <- file.copy(config.pool, destdir)
    dest.files <- sprintf("%s/%s", destdir, basename(config.pool))
    attributes(status) <- list(links = links, names = dest.files)
    return(status)
  }
  config.final <- list()
  for (fn in config.pool) {
    if (!file.exists(fn) || file.size(fn) == 0) {
      warning(sprintf("Configuration file %s is empty, please check the links.", 
        fn))
    }
    config.tmp <- read.config(fn)
    config.final <- config.list.merge(config.final, config.tmp)
    attr(config.final, "links") <- links
  }
  return(config.final)
}
