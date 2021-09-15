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

.SUFFIXES: .tex .pdf
.DEFAULT: all

TEXS := $(wildcard *.tex)
PDFS := $(patsubst %.tex, %.pdf, $(TEXS))

.tex.pdf:
	-latexmk -f -gg -quiet -pdf \
		-interaction=nonstopmode -shell-escape \
		-pdflatex="pdflatex %O %S" $<


.PHONY: all
all:		$(PDFS)

.PHONY: clean
clean:
	-latexmk -quiet -c $(TEXS)
	-$(RM) $(patsubst %.tex, %.*.*, $(TEXS))
	-$(RM) *~

.PHONY: cleanall
cleanall: clean
	-latexmk -quiet -C $(TEXS)
