config.json <- system.file('extdata', 'config.json', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')
cat("###########################################################", sep = "\n")
cat("#################  [Debug] parse module  ######################", sep = "\n")
cat("###########################################################", sep = "\n")
config.list <- list(ini = config.ini, json = config.json, toml = config.toml, yaml = config.yaml)
for(i in c("ini", "json", "toml", "yaml")) {
  config <- read.config(config.list[[i]], rcmd.parse = FALSE)
  cat(paste0("[Debug]: parse.extra(config, list(debug = 'TRUE')) # ", i), sep = "\n")
  print(parse.extra(config, list(debug = "TRUE")))
  cat(paste0("[Debug]: parse.extra(config, list(debug = 'TRUE', debug2 = 'FALSE'), other.config) # ", i), sep = "\n")
  other.config <- system.file('extdata', 'config.other.yaml', package='configr')
  print(parse.extra(config, list(debug = "TRUE", debug2 = 'FALSE'), other.config))
}

config.json <- system.file('extdata', 'config.json', package='configr')
other.config <- system.file('extdata', 'config.other.yaml', package='configr')
config <- read.config(config.json)
config <- parse.extra(config, list(debug = "TRUE", debug2 = 'FALSE'), other.config, rcmd.parse = F)
cat("[Debug]: parse.extra.rcmd(config)", sep = "\n")
print(parse.extra.rcmd(config))
cat("[Debug]: read.config(config.json, other.config = other.config, rcmd.parse = T)", sep = "\n")
print(read.config(config.json, other.config = other.config, rcmd.parse = T))


cat("###########  END parse module [Debug] end line END ###################", sep = "\n")
cat("\n\n")
