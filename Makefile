#!/usr/bin/env make

# To create a new recipe copy tempate _recipe.tex to a new TeX file.
# Then call make using -e [file name].
#
# For example if recipe is called MyRecipe.tex then make with:
#
# 	make -e DOCS=MyRecipe
#
# Or more simply, specify the target:
#
#	make MyRecipe.pdf

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
	@$(RM) *~

cleanall: clean
	-latexmk -quiet -C $(TEXS)
