#!/bin/bash

USAGE="installer.sh <command>
  Install the Igo/Gooe fonts for LaTeX (Requires existing LaTeX install).

  Where command is:
    - install
    - clean"

command -v kpsewhich >/dev/null 2>&1 || { 
  echo >&2 "TeX is required, but it is not installed.  Aborting."
  exit 1;
}

# Get directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEX_HOME=$(kpsewhich -var-value TEXMFHOME)

if [ -z $TEX_HOME ] 
  then
  echo >&2 "Could not find the value of the TEXMFHOME directory. Aborting."
  exit 1
fi

COMMAND=$@

if [ "-h" == $COMMAND ] || [ "--help" == $COMMAND ] || [ -z $COMMAND ]
  then
  echo "$USAGE" >&2
  exit 1
fi

echo $COMMAND
