#' Function to access external helps about configurations format or other related information
#'
#' @param name Name or number of helps
#' @param show_all_names Show all urls name
#' @export
#' @examples
#'  config.help()
#' \dontrun{
#'  config.help(1)
#'  config.help('ini_git_search')
#' }
config.help <- function(name = NULL, show_all_names = FALSE) {
  if (!is.null(name) && !is.character(name) && !is.numeric(name)) 
    stop("Please input a character or numeric format name.")
  if (!is.logical(show_all_names)) 
    stop("show_all_names must be a logical value.")
  urls <- read.config(system.file("extdata", "help.toml", package = "configr"))[["urls"]]
  if (is.null(name)) 
    show_all_names = TRUE
  urls_names <- as.data.frame(names(urls))
  colnames(urls_names)[1] <- "Items"
  if (show_all_names && is.null(name)) {
    return(urls_names)
  } else if (!is.null(name)) {
    if (name %in% urls_names) {
      browseURL(urls[[name]])
    } else if (is.numeric(name) && name <= nrow(urls_names)) {
      browseURL(urls[[urls_names[name, 1]]])
    } else {
      message(sprintf("Not found %s in configr help urls.", name))
    }
  }
}
