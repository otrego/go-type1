#!/bin/bash

rm *.tfm

pdflatex gnos_font_mapping.tex

mftrace --formats=PFB gnos.mf
mftrace --formats=PFB gnosb.mf
mftrace --formats=PFB gnosbi.mf
mftrace --formats=PFB gnosbii.mf
mftrace --formats=PFB gnosbiii.mf
mftrace --formats=PFB gnosw.mf
mftrace --formats=PFB gnoswi.mf
mftrace --formats=PFB gnoswii.mf
mftrace --formats=PFB gnoswiii.mf
mftrace --formats=PFB gnoswl.mf
mftrace --formats=PFB gnosbl.mf

cp *.pfb ../../../gnos-fonts/
cp *.tfm ../../../gnos-fonts/
cp *.sty ../../../gnos-fonts/

# cp *.pfb ../../../gno-fonts/
# cp *.tfm ../../../gno-fonts/
# cp *.sty ../../../gno-fonts/
