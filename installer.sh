#!/bin/bash

USAGE="=================================================================
  installer.sh [-h] [-m {sys|user}] <command> <fonts>
  Install the Igo/Gooe fonts for LaTeX (Requires existing LaTeX install).

  Example: Install all fonts:
    installer.sh install all

  Example: Install gnos for just user
    installer.sh -m sys install all

  Where command is one of:
    - install
    - uninstall

  And the optional fonts is one of
    - gooe
    - igo
    - gnos (default)
    - all

  Optional Flags
  -m|--mode {sys|user} whether to install the fonts for user or system. By
      default, uses user.
      "

# kpsewhich is a standalone path lookup tool and expansion for kpathsea. In
# other words, it manages paths for TeX.
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

# Defaults for installation
INSTALL_MODE=user
PRIMARY_COMMAND=install
FONT_TO_INSTALL=gnos

# Flag processing
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$USAGE" >&2
      exit 0;
      ;;
    install)
      PRIMARY_COMMAND=install
      shift
      if [[ $1 == "gooe" || $1 == "igo" || $1 == "all" || $1 == "gnos" ]]
        then
        echo "Installing font-family $1"
        FONT_TO_INSTALL=$1
        shift
      else
        echo "Unknown go-type1 font ${1}. Allowed values are gnos, gooe, igo, all"
        exit 1
      fi
      ;;
    uninstall)
      PRIMARY_COMMAND=uninstall
      shift
      if [[ $1 == "gooe" || $1 == "igo" || $1 == "all" || $1 == "gnos" ]]
        then
        echo "Installing font-family $1"
        FONT_TO_INSTALL=$1
        shift
      else
        echo "Unknown go-type1 font ${1}. Allowed values are gnos, gooe, igo, all"
        exit 1
      fi
      ;;
    -m|--mode)
      shift
      if [[ $1 == "user" || $1 == "sys" ]]
        then
        echo "Install mode: $1"
        INSTALL_MODE=$1
        shift
      else
        echo "Invalid install mode $1. Must be user|sys"
        exit 1
      fi
      ;;
    *)
      break
      ;;
  esac
done

if [[ $FONT_TO_INSTALL == "gooe" ]]
  then
  FONT_INSTALLS=("gooe")
elif [[ $FONT_TO_INSTALL == "igo" ]]
  then
  FONT_INSTALLS=("igo")
elif [[ $FONT_TO_INSTALL == "gnos" ]]
  then
  FONT_INSTALLS=("gnos")
elif [[ $FONT_TO_INSTALL == "all" ]]
  then
  FONT_INSTALLS=("gooe" "igo" "gnos")
fi

echo "Installing fonts: $FONT_INSTALLS"

echo "INSTALL_MODE=$INSTALL_MODE"
UPDMAP_CMD="updmap"
if [[ $INSTALL_MODE == "user" ]]
  then
  if command -v "updmap-user" &> /dev/null
  then
    UPDMAP_CMD=updmap-user
    exit
  fi
elif [[ $INSTALL_MODE == "sys" ]]
  then
  UPDMAP_CMD=updmap-sys
fi
echo "UPDMAP_CMD=$UPDMAP_CMD"

texhome=$(kpsewhich -var-value TEXMFHOME)
echo "TEXMFLOCAL: $texhome"
echo "Installer Command: $PRIMARY_COMMAND"
if [[ $PRIMARY_COMMAND == "uninstall" ]]
  then
  for item in ${FONT_INSTALLS[*]}
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
    $UPDMAP_CMD --disable Map=$mapfile
  done
  $UPDMAP_CMD --syncwithtrees
  exit 0
elif [[ $PRIMARY_COMMAND == "install" ]]
  then
  for item in ${FONT_INSTALLS[*]}
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
    $UPDMAP_CMD --enable Map=$mapfile
  done
  exit 0
else
  echo "Unknown command:" $PRIMARY_COMMAND
  echo "$USAGE" >&2
  exit 1
fi
