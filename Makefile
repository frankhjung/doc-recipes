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

TEXS := $(wildcard *.tex)
PDFS := $(patsubst %.tex, %.pdf, $(TEXS))

#
# Make PDF (required before upload)
#
.tex.pdf:
	-latexmk -f -gg -quiet -pdf \
		-interaction=nonstopmode -shell-escape \
		-pdflatex="pdflatex %O %S" $<

.PHONY: all
all: $(PDFS)

#
# Google Drive Upload
#
# To upload a recipe to Google Drive, use a command like:
#
#   make MyRecipe.upload GDRIVE_FOLDER_ID=12345
#

# Your Google Drive folder ID (My Drive/Recipes)
# Set via environment variable or override on command line
GDRIVE_FOLDER_ID ?= $(error GDRIVE_FOLDER_ID is not set)

# Pattern rule to upload any given PDF
# Usage: make RecipeName.upload
.PHONY: %.upload
%.upload: %.pdf
	@echo "Uploading $< to Google Drive..."
	@echo rclone copy $< gdrive: --drive-root-folder-id $(GDRIVE_FOLDER_ID)
	@echo Upload complete

#
# Cleanup rules
#
.PHONY: clean
clean:
	-latexmk -quiet -c $(TEXS)
	-$(RM) $(patsubst %.tex, %.*.*, $(TEXS))
	-$(RM) *~
	-latexmk -quiet -C $(TEXS)
