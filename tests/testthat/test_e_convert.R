cat("###########################################################", sep = "\n")
cat("##############  [Debug] convert.config  #####################", sep = "\n")
cat("###########################################################", sep = "\n")

config.json <- system.file('extdata', 'config.json', package='configr')
out.file <- sprintf("%s/config.ini", tempdir()) 
cat(sprintf("[Debug]:convert.config(file = '%s', out.file = '%s').", config.json, out.file))
print(convert.config(file=config.json, out.file = out.file))

cat("###########  END convert.config [Debug] end line END ###################", sep = "\n")
cat("\n\n")
