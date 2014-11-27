#!/bin/bash

USAGE="=================================================================
  installer.sh [-h] <command> [fonts]
  Install the Igo/Gooe fonts for LaTeX (Requires existing LaTeX install).

  Where command is one of:
    - install
    - uninstall

  And the optional fonts is one of
    - gooe
    - igo
    - gnos (default)
    - all"

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


SECONDARY_COMMAND="gnos"
if [[ $# -gt 1 && ($2 == "gooe" || $2 == "igo" || $2 == "all" || $2 == "gnos") ]]
  then
  SECONDARY_COMMAND=$2
fi

font_installs=("gooe" "igo" "gnos")
if [[ $SECONDARY_COMMAND == "gooe" ]]
  then
  font_installs=("gooe")
elif [[ $SECONDARY_COMMAND == "igo" ]]
  then
  font_installs=("igo")
elif [[ $SECONDARY_COMMAND == "gnos" ]]
  then
  font_installs=("gnos")
fi

texhome=$(kpsewhich -var-value TEXMFHOME)
echo "TEXMFLOCAL:" $texhome
if [[ $PRIMARY_COMMAND == "uninstall" ]]
  then
  for item in ${font_installs[*]}
  do
    mapfile="${item}.map"
    echo "Uninstalling:" $item
    rm $texhome/tex/latex/$item/*
    rm $texhome/fonts/map/dvips/$item/*
    rm $texhome/fonts/type1/$item/*
    rm $texhome/fonts/tfm/$item/*
    rmdir $texhome/tex/latex/$item
    rmdir $texhome/fonts/map/dvips/$item
    rmdir $texhome/fonts/type1/$item
    rmdir $texhome/fonts/tfm/$item
    texhash $texhome
    updmap --disable Map=$mapfile
  done
  updmap --syncwithtrees
  exit 0
elif [[ $PRIMARY_COMMAND == "install" ]]
  then
  for item in ${font_installs[*]}
  do
    fontsdir="${item}-fonts"
    mapfile="${item}.map"
    echo "Installing:" $item
    echo "Fonts-directory:" $fontsdir
    echo "Map File:" $mapfile
    mkdir -p $texhome/tex/latex/$item
    mkdir -p $texhome/fonts/map/dvips/$item
    mkdir -p $texhome/fonts/type1/$item
    mkdir -p $texhome/fonts/tfm/$item
    cp $fontsdir/*.sty $texhome/tex/latex/$item
    cp $fontsdir/*.map $texhome/fonts/map/dvips/$item
    cp $fontsdir/*.pfb $texhome/fonts/type1/$item
    cp $fontsdir/*.tfm $texhome/fonts/tfm/$item
    texhash $texhome
    updmap --enable Map=$mapfile
  done
  exit 0
else
  echo "Unknown command:" $PRIMARY_COMMAND
  echo "$USAGE" >&2
  exit 1
fi
