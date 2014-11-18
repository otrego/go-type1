# Go: Type 1

This is a repository dedicated to storing the Type1 font versions of popular Go
fonts. In particular, this repo contains the Type1 versions of:
  - Igo
  - Gooe

This work derives from [Vit Brunner (tasuki)](https://github.com/tasuk)
who created a series of tsumego books using Gooe and was tremendously helped by the existenc
of [Nyamcoder's work](https://github.com/nyamcoder/tex-src/blob/master/baduk/baduk.tex)
with Igo.

### What's here

In `fonts/`, we have the base .afm, .pfa, pfb, and .tfm files.  This represents
a large amount of the work. However, we still have to create the latex support
files.

### Tex and Tex Distributions.

Installation of these fonts relies heavily on your particular distribution of TeX.
You'll be installing the font files in TEXMFHOME.  Assuming you've installed
TeX, you can find the location of your TEX directories with:

  - $TEXMFHOME: The place to install user-specific files.
    - kpsewhich -expand-var "\$TEXMFHOME"
    - Usually ~/texmf

There's also:

  - $TEXMFLOCAL: The place for site-wide local files
    - kpsewhich -expand-var "\$TEXMFLOCAL"
    - For me, 

### Installation Steps for Gooe
Note: mktexlsr=texhash

      texhome=$(kpsewhich -expand-var "\$TEXMFHOME")

      cd gooe-type1
      texhome=$(kpsewhich -var-value TEXMFHOME)
      mkdir -p $texhome/tex/latex/gooe
      mkdir -p $texhome/fonts/map/gooe
      mkdir -p $texhome/fonts/type1/gooe
      mkdir -p $texhome/fonts/afm/gooe
      mkdir -p $texhome/fonts/tfm/gooe
      cp gooe-fonts/gooemacs.sty $texhome/tex/latex/gooe
      cp gooe-fonts/gooe.map $texhome/fonts/map/dvips/gooe
      cp gooe-fonts/*.pfb $texhome/fonts/type1/gooe
      cp gooe-fonts/*.afm $texhome/fonts/afm/gooe
      cp gooe-fonts/*.tfm $texhome/fonts/tfm/gooe
      texhash $texhome
      updmap --enable Map=gooe.map

      Check that with: kpsewhich gooemacs.sty
### Igo Installation

      cd gooe-type1
      texhome=$(kpsewhich -var-value TEXMFHOME)
      mkdir -p $texhome/fonts/source/igo
      mkdir -p $texhome/tex/latex/igo
      mkdir -p $texhome/dvips/igo
      cp igo-type1/igo.sty $texhome/tex/latex/igo
      cp igo-type1/igo.map $texhome/dvips/igo
      cp igo-type1/*.pfb $texhome/fonts/source/igo
      texhash $texhome

      updmap --enable Map=$texhome/igo-type1/igo.map


      cp igo-type1/igo.map
      updmap-sys --enable Map=fontname.map

Ideas what worked?
- In $texlocal dir
- moving map files to fonts/map

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
