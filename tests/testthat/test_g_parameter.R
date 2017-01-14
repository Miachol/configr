config.json <- system.file('extdata', 'config.json', package='configr')
config.yaml <- system.file('extdata', 'config.yaml', package='configr')
config.ini <- system.file('extdata', 'config.ini', package='configr')
config.toml <- system.file('extdata', 'config.toml', package='configr')

cat("###########################################################", sep = "\n")
cat("##############  [Debug] Genetic parameter  ##################", sep = "\n")
cat("###########################################################", sep = "\n")

cat('[Debug] genetic parameter: print(is.json.file(config.json, encoding = "UTF-8", n = 7))', sep = "\n")
print(is.json.file(config.json, encoding = "UTF-8", n = 7))
cat('[Debug] genetic parameter: print(is.json.file(config.json, encoding = "UTF-8", n = 6)) # n is the JSON lines be readed', sep = "\n")
print(is.json.file(config.json, encoding = "UTF-8", n = 6))

cat("###########  END Genetic parameter [Debug] end line END ###################", sep = "\n")
cat("\n\n")
