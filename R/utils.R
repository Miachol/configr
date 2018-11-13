# Check value wheather is NULL, and return a list or a value in list
get.config.value <- function(file = "", value = NULL, config = "", config.list = list(), 
  ...) {
  if (is.null(value)) {
    config.list <- config.list[[config]]
    if (!is.null(config.list)) {
      attr(config.list, "config") <- config
      attr(config.list, "configtype") <- get.config.type(file, ...)
      attr(config.list, "file") <- normalizePath(file, "/", mustWork = FALSE)
    } else {
      return(NULL)
    }
  } else {
    config.list <- config.list[[config]][[value]]
  }
  return(config.list)
}


# Check parmeter and run fun
config.funs.par <- function(fun = "", ...) {
  args.all <- as.list(match.call())
  args.all <- args.all[names(args.all) != ""]
  parameters <- list()
  text.1 <- sprintf("parameters <- names(as.list(args(%s)))", fun)
  text.2 <- "parameters <- parameters[parameters != '']"
  text.3 <- "parameters <- args.all[names(args.all) %in% parameters]"
  for (j in c(text.1, text.2, text.3)) {
    eval(parse(text = j))
  }
  return(parameters)
}

# Function get config.list
get.config.list <- function(file, file.type = "json", json.file.debug = FALSE, ini.file.debug = FALSE, 
  yaml.file.debug = FALSE, toml.file.debug = FALSE, extra.list = list(), other.config = "", 
  rcmd.parse = FALSE, bash.parse = FALSE, glue.parse = FALSE, glue.flag = "!!glue", global.vars.field = "global_vars",
  ...) {
  if (file.type == "json") {
    readLines.par <- config.funs.par("readLines", ...)
    readLines.par <- config.list.merge(readLines.par, list(con = file))
    fromJSON.par <- config.funs.par("jsonlite::fromJSON", ...)
    txt <- paste(do.call(readLines, readLines.par), collapse = "")
    fromJSON.par <- config.list.merge(fromJSON.par, list(txt = txt))
    if (json.file.debug) {
      config.type <- get.config.type(file = file, ...)
      if (is.character(config.type) && config.type != "json") {
        warning(sprintf("FileType Error: %s is %s format!", file, toupper(config.type)))
        return(NULL)
      } else {
        do.call(jsonlite::fromJSON, fromJSON.par)
      }
    }
    result <- tryCatch({
      config.list <- do.call(jsonlite::fromJSON, fromJSON.par)
    }, error = function(e) {
    })
  } else if (file.type == "ini") {
    read.ini.par <- config.funs.par("ini::read.ini", ...)
    read.ini.par <- config.list.merge(read.ini.par, list(file = file))
    if (ini.file.debug) {
      config.type <- get.config.type(file = file, ...)
      if (is.character(config.type) && config.type != "ini") {
        warning(sprintf("FileType Error: %s is %s format!", file, toupper(config.type)))
        return(NULL)
      }
      config.list <- do.call(ini::read.ini, read.ini.par)
      if (length(config.list) == 0) {
        warning(sprintf("FiltType Error: %s is not a standard ini format file", 
          file))
      }
    }
    result <- tryCatch({
      config.list <- do.call(ini::read.ini, read.ini.par)
    }, error = function(e) {
    })
  } else if (file.type == "yaml") {
    readLines.par <- config.funs.par("readLines", ...)
    readLines.par <- config.list.merge(readLines.par, list(con = file))
    yaml.load.par <- config.funs.par("yaml::yaml.load", ...)
    txt <- paste(do.call(readLines, readLines.par), collapse = "\n")
    yaml.load.par <- config.list.merge(yaml.load.par, list(string = txt))
    if (yaml.file.debug) {
      config.type <- get.config.type(file = file, ...)
      if (is.character(config.type) && config.type != "yaml") {
        warning(sprintf("FileType Error: %s is %s format!", file, toupper(config.type)))
        return(NULL)
      } else {
        do.call(yaml::yaml.load, yaml.load.par)
      }
    }
    json.list <- 1
    result <- tryCatch({
      json.list <- get.config.list(file, file.type = "json")
    }, error = function(e) {
    })
    if (is.null(result) || is.list(json.list)) {
      return(FALSE)
    }
    result <- tryCatch({
      config.list <- do.call(yaml::yaml.load, yaml.load.par)
    }, error = function(e) {
    })
  } else if (file.type == "toml") {
    parseTOML.par <- config.funs.par("RcppTOML::parseTOML", ...)
    parseTOML.par <- config.list.merge(parseTOML.par, list(input = file, fromFile = TRUE))
    if (toml.file.debug) {
      config.type <- get.config.type(file = file, ...)
      if (is.character(config.type) && config.type != "toml") {
        warning(sprintf("FileType Error: %s is %s format!", file, toupper(config.type)))
        return(NULL)
      } else {
        do.call(RcppTOML::parseTOML, parseTOML.par)
      }
    }
    result <- tryCatch({
      config.list <- do.call(RcppTOML::parseTOML, parseTOML.par)
    }, error = function(e) {
    })
  }
  if (is.null(result)) {
    return(FALSE)
  } else {
    config.list <- parse.extra(config.list, extra.list, other.config, rcmd.parse, 
      bash.parse, glue.parse, glue.flag, global.vars.field)
    return(config.list)
  }
}

# Function write config
write.config.list <- function(config.dat, file.path, write.type = "json", ...) {
  write.type <- tolower(write.type)
  if (write.type == "json") {
    toJSON.par <- config.funs.par("jsonlite::toJSON", ...)
    toJSON.par <- config.list.merge(toJSON.par, list(x = config.dat, pretty = TRUE))
    json.string <- do.call(jsonlite::toJSON, toJSON.par)
    json.string <- paste0(json.string, "\n")
    cat.par <- config.funs.par("cat", ...)
    cat.par <- config.list.merge(list(json.string, file = file.path), cat.par)
    do.call(cat, cat.par)
  } else if (write.type == "ini") {
    write.ini.par <- config.funs.par("ini::write.ini", ...)
    write.ini.par <- config.list.merge(write.ini.par, list(x = config.dat, filepath = file.path))
    do.call(ini::write.ini, write.ini.par)
  } else if (write.type == "yaml") {
    as.yaml.par <- config.funs.par("yaml::as.yaml", ...)
    as.yaml.par <- config.list.merge(as.yaml.par, list(x = config.dat))
    string.formted <- do.call(yaml::as.yaml, as.yaml.par)
    cat.par <- config.funs.par("cat", ...)
    cat.par <- config.list.merge(list(string.formted, file = file.path), cat.par)
    do.call(cat, cat.par)
  } else if (write.type == "toml") {
    inputfn <- tempfile()
    write.config(config.dat, inputfn, write.type = "json")
    script <- system.file("extdata", "json2toml.py", package = "configr")
    system2(script, sprintf("-i %s -o %s", inputfn, file.path), stdout = FALSE)
  }
}

# Function to check file parameter
check.file.parameter <- function(file) {
  if (!file.exists(file)) {
    warning(sprintf("'%s' No such of file.", file))
    return(FALSE)
  }
  return(TRUE)
}

# Merge two list
list.merge <- function(base.list, overlay.list, recursive = TRUE) {
  if (length(base.list) == 0) {
    overlay.list
  } else if (length(overlay.list) == 0) {
    base.list
  } else {
    merged_list <- base.list
    for (name in names(overlay.list)) {
      base <- base.list[[name]]
      overlay <- overlay.list[[name]]
      if (is.list(base) && is.list(overlay) && recursive) 
        merged_list[[name]] <- list.merge(base, overlay) else {
        merged_list[[name]] <- NULL
        merged_list <- append(merged_list, overlay.list[which(names(overlay.list) %in% 
          name)])
      }
    }
    merged_list
  }
}

str.extract.var <- function(text) {
  # text <- str_extract_all(text, '\\{\\{.*\\}\\}')
  text <- str_extract_all(text, "\\{\\{[@a-zA-Z0-9_.:]*\\}\\}")
  text <- lapply(text, function(x) str_replace_all(x, "\"", ""))
  text <- lapply(text, function(x) str_replace_all(x, fixed("{{"), ""))
  text <- lapply(text, function(x) str_split(x, fixed("}}")))
  text <- unlist(text)
  text <- text[text != ""]
  text <- unique(text)
}
