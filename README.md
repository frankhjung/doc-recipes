# documents-recipes

My favourite recipes and notes on how to manage them.

## Why?

_Because food is wonderful._

These recipes have been collected over the years. They are being constantly
modified to my tastes. I prefer recipes that are simple and enjoyable without
being overly taxing to prepare. Interesting spices and vegetables are a bonus.
But ultimately, it is all about the taste.

So please, enjoy.

## Prerequisites

To use these recipes, ensure you have:

- **[latexmk](https://mgeier.github.io/latexmk.html)**: TeX processing tool
- **pdflatex**: PDF generation from TeX
- **[rclone](https://rclone.org/)**: For uploading recipes to Google Drive
  (optional)

## How To

### write a new recipe (LibreOffice)

Write recipes with LibreOffice using the template: `_recipe.ott`. Then save in
Open Document Format.

To share them, export as a PDF. You can also send
[ODF](https://en.wikipedia.org/wiki/OpenDocument) files to others who use
[LibreOffice](https://www.libreoffice.org/).

### write a new recipe (TeX)

Copy the recipe template `_recipe.tex` to a new file, for example
[Meatballs.tex](Meatballs.tex).

Edit [TeX](https://www.latex-project.org/) file to update header, ingredients
and method. I also add a link to the original recipe source.

I use the [Enter TeX](https://gitlab.gnome.org/World/gedit/enter-tex/) editor.

Create PDF using:

```bash
make Meatballs.pdf
```

### print the recipe (PDF)

To print a PDF to a network printer:

```bash
lp -d device -t title file.pdf
```

Example:

```bash
lp -d Canon_G3010 -t "Lamb Hyderabadi" LambHyderabadi.pdf
```

### upload the recipe to Google Drive

To upload a recipe to Google Drive, use the [rclone](https://rclone.org/)
command:

Connect to gdrive:

```bash
rclone config reconnect gdrive:
```

Build the PDF:

```bash
make MyRecipe.pdf
```

Upload the PDF:

```bash
make MyRecipe.upload GDRIVE_RECIPES=<your-folder-id>
```

**Finding your Google Drive Folder ID**: Open your Recipes folder in Google
Drive, look at the URL bar—the folder ID is the alphanumeric string after
`/folders/`. For example, in
`https://drive.google.com/drive/folders/1ABCDef_GHI`, the ID is `1ABCDef_GHI`.

## Troubleshooting

- **latexmk not found**: Install TeX Live or equivalent for your system.
- **Google Drive upload fails**: Run `rclone config reconnect gdrive:` and ensure
  your `GDRIVE_RECIPES` is correct.
- **PDF generation hangs**: Check for LaTeX errors in the `.log` file or enable
  verbose mode by removing `-quiet` from the Makefile.
- Check the generated log files for more details.
