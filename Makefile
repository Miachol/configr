PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGSRC  := $(shell basename `pwd`)

all: doc build

doc:
	Rscript -e "devtools::document()"

build:
	cd ..;\
	R CMD build $(PKGSRC)

build2:
	cd ..;\
	R CMD build --no-build-vignettes $(PKGSRC)

install:
	cd ..;\
	R CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz

check: build
	cd ..;\
	R CMD check $(PKGNAME)_$(PKGVERS).tar.gz

check_cran: build
	cd ..;\
	R CMD check --as-cran $(PKGNAME)_$(PKGVERS).tar.gz

clean:
	cd ..;\
	$(RM) -r $(PKGNAME).Rcheck/

test:
	cd .;\
    Rscript -e "devtools::test()"

format:
	cd .;\
	Rscript -e "library(formatR);options('formatR.indent'=2);tidy_dir('./R');tidy_dir('./BioInstaller/inst/extdata/')"
