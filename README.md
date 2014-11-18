# Go: Type 1

This is a repository dedicated to storing the Type1 font versions of popular Go
fonts. In particular, this repo contains the Type1 versions of fonts:

  - Igo
  - Gooe

This work derives from [Vit Brunner (tasuki)](https://github.com/tasuk)
who created a series of tsumego books using the Gooe font. Later, it was
tremendously helped by the existence of [Nyamcoder's
instructions for Igo](https://github.com/nyamcoder/tex-src/blob/master/baduk/baduk.tex)
using the Igo font.

These packages are designed to work with LaTeX, but there's no reason it
shouldn't work with a LaTeX compatible compiler like XeTeX.

### What's here

There are two directories of interest in this repository:

      gooe-fonts/
      igo-fonts/

In both of these, there are 4 types of files of interest:

  - *.pfb* : these are the Type1 font definitions
  - *.tfm* : the LaTeX font metric files.
  - *.map* : the mapping-declaration files that tell latex how to associate the
    fonts with names
  - *.sty* : macro files that make it easier to work with the font

### Tex and Tex Distributions.

Installation of these fonts relies heavily on your particular distribution of TeX.
You'll be installing the font files in TEXMFHOME.  Assuming you've installed
TeX, you can find the location of your TEX directories with:

  - $TEXMFHOME: The place to install user-specific files.
    - kpsewhich -expand-var "\$TEXMFHOME"

There's also:

  - $TEXMFLOCAL: The place for site-wide local files
    - kpsewhich -expand-var "\$TEXMFLOCAL"

### Installation Steps for Gooe
If it comes up, know that: mktexlsr=texhash

      texhome=$(kpsewhich -expand-var "\$TEXMFHOME")

      cd go-type1
      texhome=$(kpsewhich -var-value TEXMFHOME)
      echo $texhome   # Should be non empty
      mkdir -p $texhome/tex/latex/gooe
      mkdir -p $texhome/fonts/map/dvips/gooe
      mkdir -p $texhome/fonts/type1/gooe
      mkdir -p $texhome/fonts/tfm/gooe
      cp gooe-fonts/gooemacs.sty $texhome/tex/latex/gooe
      cp gooe-fonts/gooe.map $texhome/fonts/map/dvips/gooe
      cp gooe-fonts/*.pfb $texhome/fonts/type1/gooe
      cp gooe-fonts/*.tfm $texhome/fonts/tfm/gooe
      texhash $texhome
      updmap --enable Map=gooe.map
      updmap

### Installation Steps for Igo
Essentially the same as above, but here for completeness

      cd go-type1
      texhome=$(kpsewhich -var-value TEXMFHOME)
      echo $texhome   # Should be non empty
      mkdir -p $texhome/tex/latex/igo
      mkdir -p $texhome/fonts/map/dvips/igo
      mkdir -p $texhome/fonts/type1/igo
      mkdir -p $texhome/fonts/tfm/igo
      cp igo-fonts/igo.sty $texhome/tex/latex/igo
      cp igo-fonts/igo.map $texhome/fonts/map/dvips/igo
      cp igo-fonts/*.pfb $texhome/fonts/type1/igo
      cp igo-fonts/*.tfm $texhome/fonts/tfm/igo
      texhash $texhome
      updmap --enable Map=igo.map
      updmap

### What's next

It should just work! What do I mean? Just make sure in your LaTeX, you have the
following at the top:

       \usepackage[T1]{fontenc}


### Resources

For more details, see:

  - [Tasuki's Tsumego Repo](https://github.com/tasuk/tsumego)
  - [sgf2dg on CPAN](http://search.cpan.org/~reid/Games-Go-Sgf2Dg-4.211/sgf2dg)
  - [Font Intallation Guide](
    http://www.ctan.org/tex-archive/info/Type1fonts/fontinstallationguide/)
  - [fontinst guide](
    http://www.ctan.org/tex-archive/fonts/utilities/fontinst/doc/manual/)
  - [Font Tutorial](
    http://www.tug.org/mactex/fonts/fonttutorial-current.html)
  - [Discussion on LaTeX font installation I found useful](
    http://macosx-tex.576846.n2.nabble.com/font-install-July-6-td611560.html)
  - [Converting METAFONT to type 1](
    http://www.ntg.nl/eurotex/szabo.pdf)
  - [Nyamcoder's Baduk work with Igo](https://github.com/nyamcoder/tex-src/blob/master/baduk/baduk.tex)

