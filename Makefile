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
#
# To publish a recipe to Google Drive:
#
# 	make MyRecipe.upload

.SUFFIXES: .tex .pdf

# All TeX source files in the directory
TEXS := $(wildcard *.tex)
# Corresponding PDF files
PDFS := $(patsubst %.tex, %.pdf, $(TEXS))

#
# Make PDF (required before upload)
# Flags:
#   -f: Force processing
#   -gg: Aggressive garbage collection
#   -quiet: Suppress output
#   -pdf: Generate PDF output
#   -interaction=nonstopmode: Don't stop on LaTeX errors
#   -shell-escape: Allow LaTeX to run shell commands
#
.tex.pdf:
	@latexmk -f -gg -quiet -pdf \
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
	@rclone copy $< gdrive: --drive-root-folder-id $(GDRIVE_FOLDER_ID)
	@echo Upload complete

#
# Cleanup rules
#
.PHONY: clean
clean:
	@echo "Cleaning LaTeX intermediate files..."
	-latexmk -quiet -c $(TEXS)
	-$(RM) $(patsubst %.tex, %.*.*, $(TEXS))
	-$(RM) *~
	@echo "Performing full cleanup..."
	-latexmk -quiet -C $(TEXS)

#
# Help target
#
.PHONY: help
help:
	@echo "Recipe Management Commands:"
	@echo "  make <recipe>.pdf     - Generate PDF from TeX file (e.g., make Meatballs.pdf)"
	@echo "  make all              - Generate all recipe PDFs"
	@echo "  make <recipe>.upload  - Upload PDF to Google Drive (requires GDRIVE_FOLDER_ID)"
	@echo "  make list             - List all available recipes"
	@echo "  make clean            - Remove all generated files"
	@echo "  make help             - Show this help message"

#
# List available recipes
#
.PHONY: list
list:
	@echo "Available recipes:"
	@$(foreach tex, $(TEXS), echo "  - $(basename $(tex))";)
