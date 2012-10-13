
# Get the names of the current operating system and the host
OSNAME=`uname`
HOSTNAME=`hostname`

# Path to my zshell configuration.
ZSH=$HOME/bin/dotfiles/zshell

# Set name of the theme to load.
# Look in ~/bin/dotfiles/zshell/themes/
ZSH_THEME="standard"

# set the default username and hostname
# these will be omitted from prompt
DEFAULT_OSNAME="Darwin"
DEFAULT_USERNAME="hans"
DEFAULT_HOSTNAME="brahma.local"

# plugins to load
plugins=(git rake cap)

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

source "$ZSH/zsh-init.zsh"