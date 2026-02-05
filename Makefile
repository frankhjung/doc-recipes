#!/usr/bin/env make

# To create a new recipe, copy the template _recipe.tex to a new TeX file.
# Then call make using the DOCS variable to filter specific files.
#
# For example, if the recipe is called MyRecipe.tex:
#
# 	make DOCS=MyRecipe
#
# Or more simply, specify the target:
#
#	make MyRecipe.pdf
#
# To publish a recipe to Google Drive:
#
# 	make MyRecipe.upload

# If DOCS is specified, only process those files; otherwise, find all .tex files.
ifdef DOCS
  TEXS := $(addsuffix .tex,$(DOCS))
else
  TEXS := $(wildcard *.tex)
endif

# Corresponding PDF files
PDFS := $(patsubst %.tex, %.pdf, $(TEXS))

#
# Make PDF (required before upload)
# Flags:
#   -f: Force processing
#   -gg: Aggressive cleanup before build (ensures fresh build)
#   -quiet: Suppress output
#   -pdf: Generate PDF output
#   -interaction=nonstopmode: Don't stop on LaTeX errors
#   -shell-escape: Allow LaTeX to run shell commands (USE WITH CAUTION)
#
%.pdf: %.tex
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
#   make MyRecipe.upload GDRIVE_RECIPES=12345
#

# My Google Drive folder ID (My Drive/Recipes)
# Set via environment variable or override on command line
GDRIVE_RECIPES ?=

# Guard to ensure environment variables are set
.PHONY: guard-%
guard-%:
	@if [ -z "$($*)" ]; then \
		echo "Error: Variable $* is not set."; \
		echo "Usage: make <target> GDRIVE_RECIPES=your_folder_id"; \
		exit 1; \
	fi

# Pattern rule to upload any given PDF
# Usage: make RecipeName.upload
.PHONY: %.upload
%.upload: %.pdf guard-GDRIVE_RECIPES
	@echo "Uploading $< to Google Drive..."
	@rclone copy "$<" gdrive: --drive-root-folder-id $(GDRIVE_RECIPES) --update --verbose
	@echo Upload complete

#
# Cleanup rules
#
.PHONY: clean
clean:
	@echo "Performing full cleanup of LaTeX files..."
	-latexmk -quiet -C $(wildcard *.tex)
	-$(RM) *~

#
# Help target
#
.PHONY: help
help:
	@echo "Recipe Management Commands:"
	@echo "  make <recipe>.pdf     - Generate PDF from TeX file (e.g., make Meatballs.pdf)"
	@echo "  make all              - Generate all recipe PDFs"
	@echo "  make <recipe>.upload  - Upload PDF to Google Drive (requires GDRIVE_RECIPES)"
	@echo "  make list             - List all available recipes"
	@echo "  make clean            - Remove all generated files"
	@echo "  make help             - Show this help message"

#
# List available recipes
#
.PHONY: list
list:
	@echo Available recipes...
	@printf '  - %s\n' $(patsubst %.tex,%,$(filter-out _recipe.tex, $(TEXS)))
