#!/bin/bash

USAGE="===============================================================
  installer.sh [-h] <command> [fonts]
  Install the Igo/Gooe fonts for LaTeX (Requires existing LaTeX install).

  Where command is one of:
    - install
    - uninstall

  And the optional fonts is one of
    - gooe
    - igo
    - all (default)"

command -v kpsewhich >/dev/null 2>&1 || { 
  echo >&2 "TeX is required, but it is not installed.  Aborting."
  echo "$USAGE" >&2
  exit 1;
}

# Get directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Determine where the $TEXMFHOME directory is
TEX_HOME=$(kpsewhich -var-value TEXMFHOME)

if [ -z $TEX_HOME ]
  then
  echo >&2 "Could not find the value of the TEXMFHOME directory. Aborting."
  exit 1
fi


PRIMARY_COMMAND=""
if [[ $# -gt 0 ]]
  then
  PRIMARY_COMMAND=$1
fi

if [[ $PRIMARY_COMMAND == "-h" ||  $PRIMARY_COMMAND == "" ]]
  then
  echo "$USAGE" >&2
  exit 1
fi


SECONDARY_COMMAND="all"
if [[ $# -gt 1 && ($2 == "gooe" || $2 == "igo" || $2 == "all") ]]
  then
  SECONDARY_COMMAND=$2
fi

if [[ $PRIMARY_COMMAND == "uninstall" ]]
  then
  echo "Uninstalling:" $SECONDARY_COMMAND
  texhome=$(kpsewhich -var-value TEXMFHOME)
  echo "Uninstalling from Texhome:" $texhome
  rm $texhome/tex/latex/gooe/*
  rm $texhome/fonts/map/dvips/gooe/*
  rm $texhome/fonts/type1/gooe/*
  rm $texhome/fonts/tfm/gooe/*
  rmdir $texhome/tex/latex/gooe
  rmdir $texhome/fonts/map/dvips/gooe
  rmdir $texhome/fonts/type1/gooe
  rmdir $texhome/fonts/tfm/gooe
  texhash $texhome
  updmap --disable Map=gooe.map
  exit 0
elif [[ $PRIMARY_COMMAND == "install" ]]
  then
  echo "Installing:" $SECONDARY_COMMAND
  texhome=$(kpsewhich -var-value TEXMFHOME)
  echo "Installing to Texhome:" $texhome
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
  exit 0
else
  echo "Unknown command:" $PRIMARY_COMMAND
  echo "$USAGE" >&2
  exit 1
fi
