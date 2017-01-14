#Use RcppTOML example.toml as input
example.toml <- system.file("toml", "example.toml", package="RcppTOML")
is.toml <- is.toml.file(example.toml)
file.type <- get.config.type(example.toml)
toml.list.raw <- read.config(example.toml)
owner.config <- eval.config(file = example.toml, config = "owner")
owner.config.name <- eval.config(value = "name", file = example.toml, config = "owner")
toml.sections <- eval.config.sections(example.toml)
toml.merged.all <- eval.config.merge(example.toml)
toml.merged.selected <- eval.config.merge(example.toml, sections = c("database", "owner"))

others <- list(others = list(lastupdate="2017-01-07"))
toml.list.add <- config.list.merge(toml.list.raw, others)
