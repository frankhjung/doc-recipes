#!/usr/bin/env make

# To make a new recipe copy tempate _recipe.tex to a new TeX file.
#
# Then make using -e [file name]
# For example:
# 	make -e DOCS=MyRecipe

.PHONY: all clean cleanall
.SUFFIXES: .tex .pdf
.DEFAULT: all

TEXS := $(wildcard *.tex)

.tex.pdf:
	-latexmk -f -gg -quiet -pdf \
		-interaction=nonstopmode -shell-escape \
		-pdflatex="pdflatex %O %S" $<

tex := $(patsubst %.tex, %.pdf, $(TEXS))

all: $(tex)

clean:
	-latexmk -quiet -c $(TEXS)
	@$(RM) $(patsubst %.tex, %.*.*, $(TEXS))

cleanall: clean
	-latexmk -quiet -C $(TEXS)
	@$(RM) *~
