#!/bin/bash - 

SELF="$0"
SELF_BASENAME=`basename "$SELF"`

#------------------------------------------------------------------------------
# To avoid unforeseen consequences of faulty input values,
# treat unset variables as an error
#------------------------------------------------------------------------------

set -o nounset                          

#-------------------------------------------------------------------------------
#  So that external scripts will return their error codes to this script, do:
#-------------------------------------------------------------------------------

set -o pipefail 

#-------------------------------------------------------------------------------
#  Since these functions are of general utility and not related to this script's
#  business logic, they have been placed here at the top of the file.
#-------------------------------------------------------------------------------

function die () {
    echo >&2 "$@ - E1"
    exit 1
}

function log () {
  echo `date +"%Y-%m-%d %H:%M:%S"` [$1][`whoami`@`hostname`][$(basename $0 .sh)] $2
}

function logpipe () {
  while read LOGLINE 
  do
    echo `date +"%Y-%m-%d %H:%M:%S"` [$2][$(basename $0 .sh)][$1] $LOGLINE
  done
}

function usage () {
  local DEFAULT_PREFIX='##'
  if [[ $# -ge 1 ]]; then
    local PREFIX="$1"
  else
    local PREFIX=$DEFAULT_PREFIX  
  fi
  grep "^$PREFIX" "$SELF" | sed -e "s/^$PREFIX//" -e "s/_SELF_/$SELF_BASENAME/" 1>&2
}

#===============================================================================
#
##         USAGE:  ./install.sh [--home_path <home directory>] \
##                              [--source_path <directory containing source files>] \
##                              | [-h|--help]
## 
##   DESCRIPTION:  an install script for my zshell config
## 
##       OPTIONS:  --home_path <home path>
##
##                   This option specifies a base path for the destination links
##
##                     Default: ~
##
##                 --source_path <path to gitignore and gitconfig>
##
##                   This option specifies a base path for the source files
##
##                     Default: current working directory
##
##                 -h or --help
##                   
##                   Prints this text and exits
##
##          FILE:  install.sh
##
##  REQUIREMENTS:  none
##  DEPENDENCIES:  GNU bash, version 3.2.48
##               
##
##          BUGS:  none known
##         NOTES:  
##        AUTHOR:  Hans Czajkowski Jørgensen, hans.c.jorgensen@gmail.com
##       COMPANY:  
##       CREATED:  12/10/2012
##       VERSION:  0.0.1
##    REPOSITORY:  git://github.com/HansCz/dotfiles-git.git
##       CREDITS:  
##                 usage function - http://www.thelinuxdaily.com/2012/09/self-documenting-scripts/ 
##                 Retrieved last on 12/10/2012
##
##                 option parsing - http://vimeo.com/21538711 (CRAZY Bash Programming with Wayne E Seguin and Haris Amin)
##                 Retrieved last on 12/10/2012
##                 
#===============================================================================

HOME=~
SOURCE_PATH=`pwd`

declare -a SOURCE_FILES=(
  /zshrc.zsh
)

declare -a DESTINATION_LINKS=(
  /.zshrc
)

if [ $# -gt 0 ]; then
  while [ $# -gt 0 ]; do
    case $1 in
      --home_path )    shift
                              HOME=$1
                              ;;
      --source_path )  shift
                              SOURCE_PATH=$1
                              ;;
      -h | --help )           usage
                              exit
                              ;;
      * )                     usage
                              # handle unparsed arguments here, e.g.
                              # die `log fail "Invalid arguments: $@"`;;
    esac
    shift
  done
else
  # Since it is valid to supply no options, no code should be run here.
  # however, it is a nice placeholder, should this case be needed in the future.
  # The problem is, that an else block has to run something to be registered,
  # so we run true, which is essentially a no-op.
  true
fi

if [[ ! -d $HOME ]]; then
  die `log fail "Invalid home_path: $HOME"`
fi

if [[ ! -d $SOURCE_PATH ]]; then
  die `log fail "Invalid source_path: $SOURCE_PATH"`
fi

for (( i = 0 ; i < ${#SOURCE_FILES[@]} ; i++ )); do
  if [ ! -f $SOURCE_PATH${SOURCE_FILES[$i]} ]; then
    die `log fail "The file $SOURCE_PATH${SOURCE_FILES[$i]} could not be found in $SOURCE_PATH."`
  fi
done

for (( i = 0 ; i < ${#SOURCE_FILES[@]} ; i++ )); do
  ln -sf $SOURCE_PATH${SOURCE_FILES[$i]} $HOME${DESTINATION_LINKS[$i]}
done