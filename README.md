# Go Fonts in Postscript Type 1

![Go Type1 Demo](go-type1-demo.png)

This is a repository dedicated to storing the Postscript Type1 versions of
popular fonts for the game <a
href="https://en.wikipedia.org/wiki/Go_(game)">Go</a>, also known as Igo
(囲碁), Baduk (바둑), Weiqi (围棋), for use in LaTeX. These are all provided as
**vector-grahics** fonts rather than rasterized (bitmap) fonts, and so provide
a much more professional look for e-books and print books.

## Overview

In summary, this repository contains font information for four fonts:

*   **Gnos**: My modification of the Gooe font series, which makes the
    border-lines a bolder, the star points bigger, and makes it easier to use
    in scripts. This font was used by GoGameGuru's book
    [*Relentless*](https://www.amazon.com/Relentless-Lee-Sedol-Gu-Li/dp/0981912184)
    and is **the recommended font**.
*   **Igo**: A font created in 1991 by Hanna Kolodziejska and modified by
    Etienne Dupuis and others, that evokes the style of the old Ishi press and
    Kiseido books.
*   **Gooe**: A font created by Dan Bump and popularized by Reid Augustin's
    [sgf2dg script](http://search.cpan.org/~reid/Games-Go-Sgf2Dg-4.252/) for
    creating go books. See also the [Sensei's library
    article](http://senseis.xmp.net/?Sgf2dg) for more details about usage and
    history. *Note:* While this repo contains the fonts, it does not contain
    the sgf2dg script or related content.
*   **Jigo**: (Experimental) My attempt at modifying the Igo font series to
    allow the fonts to be used directly in scripts. This is a work in progress
    and not currently installed by the installer.

**Note**: This repository, Go-Type1, was original created by Kashomon but was
moved to the *Otrego* Organization in 2020.

All of these fonts are available as Postscript Type 1 fonts, which is an old
vector graphic font standard that can be used with LaTeX.

This work derives from [Vit Brunner (tasuki)](https://github.com/tasuk) who
created a series of tsumego books using the Type1 Gooe font. Later, this work
was helped tremendously by the existence of [Nyamcoder's
instructions](https://github.com/nyamcoder/tex-src/blob/master/baduk/baduk.tex)
for installing the Type1 Igo font. Ultimately, these fonts exist to be used in
[GPub](https://www.github.com/Kashomon/gpub), a Javascript library I (Kashomon)
created for generating Go books.

These packages are designed to work with LaTeX, but there's no reason it
shouldn't work with a LaTeX compatible compiler like XeTeX.

### Recommendations

If you're here trying to decide what fonts to use in generating Go books then
here are my **recommendations**

1.  If you are planning on creating or using scripts to generate your books:
    1.  Gnos (**Recommended**): Fully featured; Looks great in print form.
    1.  Gooe: Fully featured, has a less bold-look than Gnos.
1.  If you are manually creating diagrams yourself only using LaTeX:
    1.  Igo: Igo is meant for users creating diagrams manually at LaTeX.
        However, it comes at the cost of having missing glyphs, being slow to
        compile, and creating incompatibilities with other LaTeX packages.

## Quick Installation Steps
The easiest way to install is to use the installer script

```shell
# Install gooe, gnos, igo
go-type1/installer.sh install all

# Install just gnos
go-type1/installer.sh install gnos
```

## Examples

All these examples are present in [examples/full_comparison.tex](examples/full_comparison.tex)

### Gnos Example
Here's the same problem with the Gnos font. Warning: Gnos is not designed to be
easy to use by hand. It's meant to be used in scripts that generate diagrams.

```latex
\begin{center}
{\gnos%
<((!((((((\\
!!!!@@++++\\
\char91\char64@@++++++\\
\char91\char43\char43\char42+++++*\\
\char91@++++++++\\
\char91+++++++++\\
}
A Simple Go Problem!
\end{center}
```

![Gnos Example](gnos-example.png)

```latex
{
\gnosfontsize{14}
{
\gnos%
<!((((((@((!(((((!>\\
!+1Cc2Ss3Tt4Xx++++!\\
\char91+@+++++++++++++++]\\
\char91+@*+++++*+++++*++]\\}
{\gnosb\char1\char2\char3\char4\char5\char6\char7\char8\char9\char10\char11\char12\char13\char14\char15\char16\char17\char18}{\gnos]\\}
{\gnosw\char1\char2\char3\char4\char5\char6\char7\char8\char9\char10\char11\char12\char13\char14\char15\char16\char17\char18}{\gnos]\\
\char91+++++++++++++++++]\\
\char91+++++++++++++++++]\\
\char91+++++++++++++++++]\\
\char91++*+++++*+++++*++]\\
\char91+++++++++++++++++]\\
\char91+++++++++++++++++]\\
\char91+++++++++++++++++]\\
\char91+++++++++++++++++]\\
\char91+++++++++++++++++]\\
\char91++*{\gnoswi\char11}{\gnoswii\char11}{\gnoswiii\char11}{\gnosbi\char11}{\gnosbii\char11}{\gnosbiii\char11}+++++*++]\\
\char91++++{\gnoswl\char1}{\gnosbl\char1}++++++\gnosEmptyLbl{\sffamily{10}}\gnosOverlap{!}{Z}\gnosOverlap{+}{\gnos 2}\gnosOverlap{@}{\color{white}Z}+]\\
!++++++++\gnosOverlap{+}{\gnos 3}\gnosOverlap{+}{\gnos 4}\gnosOverlap{+}{\gnos 1}++++++!\\
,!))))@)!))))))))!.\\
}}
14pt: A board full of stuff!
```

![Gnos Example: Full Symbol Set](gnos-full-symbol-set.png)

### Gooe Example
Here's an example of a simple problem using the Gooe font.

```latex
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
```

![Gooe Example](gooe-example.png)

#### Igo Example
Here's the same problem with the Igo font.

```latex
\white{a18,b18,c18,d18,d19}
\black{b17,c17,d17,e18,f18,b15}
\begin{center}
\shortstack{\showgoban[a14,k19]\\ A Simple Go Problem}
\end{center}
```

![Igo Example](igo-example.png)


### What's here

There are four directories containing font files:

      gnos-fonts/
      gooe-fonts/
      igo-fonts/
      jigo-fonts/ (Experimental)

In each of these, there are 4 types of files of interest:

  - *.pfb* : these are the Type1 font definitions
  - *.tfm* : the LaTeX font metric files.
  - *.map* : the mapping-declaration files that tell latex how to associate the
    fonts with names
  - *.sty* : Tex macro files that make it easier to work with the font

### Tex and Tex Distributions.

Installation of these fonts relies heavily on your particular distribution of
TeX.  You'll be installing the font files in TEXMFHOME location.  Assuming
you've installed TeX, you can find the location of your TEX directories with:

```shell
kpsewhich -expand-var "\$TEXMFHOME"
```

or

```shell
$(kpsewhich -var-value TEXMFHOME)
```

### Long Installation Steps for {Gnos,gooe,igo}
This is not recommended for most users, but this is a record of what I did
install the fonts by hand initially if you get stuck.

```shell
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
```

### Using the Fonts

At this point, it should just work! Make sure in your LaTeX, you have the
following at the top:

```latex
\usepackage[T1]{fontenc}
```

Then, LaTeX should be able use the new Type1 fonts.

See the example below for more information. Ther are also more exmaple TeX files
in the examples/ directory.

#### The LaTeX structure
LaTeX starts with some header declarations, followed by begin document, content,
and lastly, ending the document.

```latex
\documentclass{article}
\usepackage{gnos} % or igo, gooemacs
\usepackage[T1]{fontenc}

\begin{document}

% Content goes here

\end{document}
```

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

```shell
mftrace --formats=PFB myfile.mf
```

To regenerate the TFM files, run:

```shell
mktextfm myfile.mf
```

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

