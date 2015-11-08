# Go Fonts in Postscript Type 1

This is a repository dedicated to storing the Postscript Type1 versions of
popular fonts for the game
<a href="https://en.wikipedia.org/wiki/Go_(game)">Go</a>, also known as Igo (囲碁),
Baduk (바둑), Weiqi (围棋). In particular, this repository contains font
information for:

  - **Igo**: A font created in 1991 by Hanna Kolodziejska and modified by
    Etienne Dupuis and others, that evokes the style of the old Ishi press and
    Kiseido books.
  - **Gooe**: A font created by Dan Bump and popularized by Reid Augustin's
    [sgf2dg script](http://search.cpan.org/~reid/Games-Go-Sgf2Dg-4.252/) for
    creating go books. See also the [Sensei's library
    article](http://senseis.xmp.net/?Sgf2dg) for more details about usage and
    history. *Note:* While this repo contains the fonts, it does not contain
    the sgf2dg script or related content.
  - **Gnos**: My modification of the Gooe font series, which makes the
    border-lines a bolder, the star points bigger, and makes it easier to use in
    scripts.
  - **Jigo**: My modification of the Igo font series that allows the fonts to be
    used directly in scripts

All of these fonts are available as Postscript Type 1 fonts, which is an old
vector graphic font standard that can be used with LaTeX.

This work derives from [Vit Brunner (tasuki)](https://github.com/tasuk) who
created a series of tsumego books using the Type1 Gooe font. Later, this work
was helped tremendously by the existence of [Nyamcoder's
instructions](https://github.com/nyamcoder/tex-src/blob/master/baduk/baduk.tex)
for installing the Type1 Igo font. Ultimately, these fonts exist to be used in
[GPub](https://www.github.com/Kashomon/gpub), a Javascript library I created for generating
Go books.

These packages are designed to work with LaTeX, but there's no reason it
shouldn't work with a LaTeX compatible compiler like XeTeX.

### What's here

There are three directories containing font files:

      igo-fonts/
      gooe-fonts/
      gnos-fonts/

In both of these, there are 4 types of files of interest:

  - *.pfb* : these are the Type1 font definitions
  - *.tfm* : the LaTeX font metric files.
  - *.map* : the mapping-declaration files that tell latex how to associate the
    fonts with names
  - *.sty* : Tex macro files that make it easier to work with the font

### Tex and Tex Distributions.

Installation of these fonts relies heavily on your particular distribution of TeX.
You'll be installing the font files in TEXMFHOME.  Assuming you've installed
TeX, you can find the location of your TEX directories with:

      kpsewhich -expand-var "\$TEXMFHOME"

or

      $(kpsewhich -var-value TEXMFHOME)

### Quick Installation Steps
The easiest way to install is to use the installer script

      # Install gooe, gnos, igo
      installer.sh install all

      # Install just gnos
      installer.sh install gnos

### Long Installation Steps for {Gnos,gooe,igo}
You must perform a bit of work for LaTeX to know about your fonts, if you want
to do it by hand. I don't claim to be an expert in TeX/LaTeX, but this seems to
work.

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

### Using the Fonts

It should just work! What do I mean? Just make sure in your LaTeX, you have the
following at the top:

       \usepackage[T1]{fontenc}

Then, LaTeX should just use the Type1 font.

See the example below for more information. Ther are also more exmaple TeX files
in the examples/ directory.

#### The LaTeX structure
LaTeX starts with some header declarations, followed by begin document, content,
and lastly, ending the document.

      \documentclass{article}
      \usepackage{gnos} % or igo, gooemacs, jigofonts
      \usepackage[T1]{fontenc}

      \begin{document}

      % Content goes here

      \end{document}

#### Gooe Example
Here's an example of a simple problem using the Gooe font.

      \begin{center}
      {\goo
      \0??<\0??(\0??(\- !(\0??(\0??(\0??(\0??(\0??(\0??(
      \- ![\- !+\- !+\- !+\- @+\- @+\0??+\0??+\0??+\0??+
      \0??[\- @+\- @+\- @+\0??+\0??+\0??+\0??+\0??+\0??+
      \0??[\0??+\0??+\0??*\0??+\0??+\0??+\0??+\0??+\0??*
      \0??[\- @+\0??+\0??+\0??+\0??+\0??+\0??+\0?l+\0??+
      \0??[\0??+\0??+\0??+\0??+\0??+\0??+\0??+\0??+\0??+
      }
      A Simple Go Problem!
      \end{center}

#### Igo Example
Here's the same problem with the Igo font.

      \white{a18,b18,c18,d18,d19}
      \black{b17,c17,d17,e18,f18,b15}
      \begin{center}
      \shortstack{\showgoban[a14,k19]\\ A Simple Go Problem}
      \end{center}

#### Gnos Example
Here's the same problem with the Gnos font. Warning: Gnos is not designed to be
easy to use.  It's meant to be generated by other languages.

      {\gnos%
      <((!((((((\\
      !!!!@@++++\\
      \char91\char64@@++++++\\
      \char91\char43\char43\char42+++++*\\
      \char91@++++++++\\
      \char91+++++++++\\
      }

### Converting METAFONT to Type1
Converting from METAFONT to Type1 fonts can be a challenge. Here's what I did,
mostly a record for myself, but it might be useful for you too.

First, some setup:

  * Update homebrew (OSX package manager)
  * Download mftrace
  * Install autoconf via homebrew (`brew install autoconf`)
  * Run autoconf on mftrace's autogen.sh
  * `brew install potrace` -- font tracing program
  * `brew install fontforge`
  * Go back to mftrace and run `./configure` and `make install`

To convert METAFONT to Type1, run:

      mftrace --formats=PFB myfile.mf

To regenerate the TFM files, run:

      mktextfm myfile.mf

### Resources

For more details on all of this, see:

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

