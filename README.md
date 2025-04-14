# documents-recipes

My favourite recipes.

## Why?

Because food is wonderful.

These recipes have been collected over the years. They are being constantly
modified to my tastes. I do prefer if recipes are simple enough to be enjoyable
without being overly taxing in preparation. Interesting spices and vegetables
are a bonus. But, ultimately it is all about the taste.

So please, enjoy.

## How To - write a new recipe (LibreOffice)

Write recipes with LibreOffice using the template: `_recipe.ott`.
Then save in Open Document Format.

To share them, export as a PDF. However, most of my friends now use
[LibreOffice](https://www.libreoffice.org/), so sending an
[ODF](https://en.wikipedia.org/wiki/OpenDocument) is now much less of a problem.

## How To - write a new recipe (Tex)

Copy the recipe template `_recipe.tex` to a new file, for example
[Meatballs.tex](Meatballs.tex).

Edit [TeX](https://www.latex-project.org/) file to update header, ingredients
and method. I also add a link to the original recipe source.

I use the [Enter Tex](https://gitlab.gnome.org/World/gedit/enter-tex/) editor.

Create PDF using:

```bash
make Meadballs.pdf
```

## How To - print the recipe (PDF)

To print the PDF to a network printer:

```bash
lp -d device -t title file.pdf
```

Example:

```bash
lp -d Canon_G3010 -t "Lamb Hyderabadi" LambHyderabadi.pdf
```

