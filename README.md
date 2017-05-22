# documents-recipes

My favourite recipes.

## Why?

Because food is wonderful!

These recipes have been collected over the years. They are being constantly
modified to my tastes. I do prefer if recipes are simple enough to be enjoyable
without being overly taxing in preparation. Interesting spices and vegetables
are a bonus. But, ultimately it is all about the taste!

So please, enjoy!

## How To - write a new recipe (LibreOffice)

I use LibreOffice to write these recipes from a template (*_recipe.ott*) and
save them in Open Document Format. To share them, export as a PDF. However, most
of my friends now use LibreOffice, so sending ODF is now much less of a problem.

## How To - write a new recipe (Tex)

Copy the recipe template `_recipe.tex` to a new file, for example MyRecipe.tex.

Edit TeX file to update header, ingredients and method.

Create PDF using:

```bash
make -e DOCS=MyRecipe
```
