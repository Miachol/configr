config.json <- system.file('extdata', 'config.json', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')

cat("###########################################################", sep = "\n")
cat("##############  [Debug] configtype module  ##################", sep = "\n")
cat("###########################################################", sep = "\n")

cat(sprintf("[Debug]:%s config file type:%s", config.json, get.config.type(config.json)), sep = "\n")
cat(sprintf("[Debug]:%s config file type:%s", config.ini, get.config.type(config.ini)), sep = "\n")
cat(sprintf("[Debug]:%s config file type:%s", config.yaml, get.config.type(config.yaml)), sep = "\n")
cat(sprintf("[Debug]:%s config file type:%s", config.toml, get.config.type(config.toml)), sep = "\n")

#Test is.json.file
cat("[Debug]:is.json.file(config.json)", sep = "\n")
print(is.json.file(config.json))
cat("[Debug]:is.json.file(config.yaml)", sep = "\n")
print(is.json.file(config.yaml))
cat("[Debug]:is.json.file(config.ini)", sep = "\n")
print(is.json.file(config.ini))
cat("[Debug]:is.json.file(config.toml)", sep = "\n")
print(is.json.file(config.toml))

#Test is.ini.file
cat("[Debug]:is.ini.file(config.json)", sep = "\n")
print(is.ini.file(config.json))
cat("[Debug]:is.ini.file(config.yaml)", sep = "\n")
print(is.ini.file(config.yaml))
cat("[Debug]:is.ini.file(config.ini)", sep = "\n")
print(is.ini.file(config.ini))
cat("[Debug]:is.ini.file(config.toml)", sep = "\n")
print(is.ini.file(config.toml))

#Test is.yaml.file
cat("[Debug]:is.yaml.file(config.json)", sep = "\n")
print(is.yaml.file(config.json))
cat("[Debug]:is.yaml.file(config.yaml)", sep = "\n")
print(is.yaml.file(config.yaml))
cat("[Debug]:is.yaml.file(config.ini)", sep = "\n")
print(is.yaml.file(config.ini))
cat("[Debug]:is.yaml.file(config.toml)", sep = "\n")
print(is.yaml.file(config.toml))

#Test is.toml.file
cat("[Debug]:is.toml.file(config.json)", sep = "\n")
print(is.toml.file(config.json))
cat("[Debug]:is.toml.file(config.yaml)", sep = "\n")
print(is.toml.file(config.yaml))
cat("[Debug]:is.toml.file(config.ini)", sep = "\n")
print(is.toml.file(config.ini))
cat("[Debug]:is.toml.file(config.toml)", sep = "\n")
print(is.toml.file(config.toml))

cat("###########  END configtype module END ###################", sep = "\n")
cat("\n\n")
