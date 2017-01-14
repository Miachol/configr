config.json <- system.file('extdata', 'config.json', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')
config.error.json <- system.file('extdata', 'config.error.json', package='configr')
config.error.ini <- system.file('extdata', 'config.error.ini', package='configr')
config.error.yaml <- system.file('extdata', 'config.error.yaml', package='configr')
config.error.toml <- system.file('extdata', 'config.error.toml', package='configr')

cat("###########################################################", sep = "\n")
cat("#################  [Debug] Show Error  ######################", sep = "\n")
cat("###########################################################", sep = "\n")
#Test non character
cat("[Debug]:Show warning in get.config.type(list())", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(list())))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.json.file(list())", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.json.file(list())))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.yaml.file(list())", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.yaml.file(list())))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.ini.file(list())", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.ini.file(list())))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.toml.file(list())", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.toml.file(list())))
}, error = function(e) {
  print(e)
})

#Test non standard file
cat("[Debug]:Show FALSE in get.config.type(config.error.json)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.json)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in get.config.type(config.error.ini)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.ini)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in get.config.type(config.error.yaml)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.yaml)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in get.config.type(config.error.toml)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.toml)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in is.json.file(config.error.json)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.json.file(config.error.json)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in is.yaml.file(config.error.json)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.yaml.file(config.error.json)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in is.ini.file(config.error.json)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.ini.file(config.error.json)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show FALSE in is.toml.file(config.error.json)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.toml.file(config.error.json)))
}, error = function(e) {
  print(e)
})

# debug parameter test
## get.config.type *.file.debug test
cat("[Debug]:Show Error in get.config.type(config.error.json, json.file.debug = TRUE)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.json, json.file.debug = TRUE)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show Error in get.config.type(config.error.yaml, yaml.file.debug = TRUE)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.yaml, yaml.file.debug = TRUE)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show Error in get.config.type(config.error.ini, ini.file.debug = TRUE)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.ini, ini.file.debug = TRUE)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show Error in get.config.type(config.error.toml, toml.file.debug = TRUE)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(get.config.type(config.error.toml, toml.file.debug = TRUE)))
}, error = function(e) {
  print(e)
})

## *.file.debug test
cat("[Debug]:Show TRUE in is.json.file(config.json, json.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(is.json.file(config.json, json.file.debug = T))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show TRUE in is.ini.file(config.ini, ini.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(is.ini.file(config.ini, ini.file.debug = T))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show TRUE in is.yaml.file(config.yaml, yaml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(is.yaml.file(config.yaml, yaml.file.debug = T))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show TRUE in is.toml.file(config.toml, toml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(is.toml.file(config.toml, toml.file.debug = T))
}, error = function(e) {
  print(e)
})

## is.json.file json.file.debug test
cat("[Debug]:Show warning in is.json.file(config.yaml, json.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.json.file(config.yaml, json.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.json.file(config.ini, json.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.json.file(config.ini, json.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.json.file(config.toml, json.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.json.file(config.toml, json.file.debug = T)))
}, error = function(e) {
  print(e)
})


## is.ini.file ini.file.debug test
cat("[Debug]:Show warning in is.ini.file(config.yaml, ini.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.ini.file(config.yaml, ini.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.ini.file(config.json, ini.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.ini.file(config.json, ini.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.ini.file(config.toml, ini.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.ini.file(config.toml, ini.file.debug = T)))
}, error = function(e) {
  print(e)
})


## is.yaml.file yaml.file.debug test
cat("[Debug]:Show warning in is.yaml.file(config.ini, yaml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.yaml.file(config.ini, yaml.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.yaml.file(config.json, yaml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.yaml.file(config.json, yaml.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.yaml.file(config.toml, yaml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.yaml.file(config.toml, yaml.file.debug = T)))
}, error = function(e) {
  print(e)
})

## is.toml.file toml.file.debug test
cat("[Debug]:Show warning in is.toml.file(config.ini, toml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.toml.file(config.ini, toml.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.toml.file(config.json, toml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.toml.file(config.json, toml.file.debug = T)))
}, error = function(e) {
  print(e)
})
cat("[Debug]:Show warning in is.toml.file(config.yaml, toml.file.debug = T)", sep = "\n")
result <- tryCatch({
  print(suppressWarnings(is.toml.file(config.yaml, toml.file.debug = T)))
}, error = function(e) {
  print(e)
})

cat("###########  END Show Error [Debug] end line END ###################", sep = "\n")
cat("\n\n")
