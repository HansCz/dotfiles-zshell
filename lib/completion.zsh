unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol     # If this option is unset, output flow control via start/stop characters (usually assigned to ^S/^Q) is disabled in the shell’s editor.
setopt auto_menu         # Automatically use menu completion after the second consecutive request for completion, for example by pressing the tab key repeatedly. This option is overridden by MENU_COMPLETE.
setopt complete_in_word  # If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
setopt always_to_end     # If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word. That is, the cursor is moved to the end of the word if either a single match is inserted or menu completion is performed.

WORDCHARS=''

zmodload -i zsh/complist # http://www.cims.nyu.edu/cgi-systems/info2html?(zsh)The%2520zsh/complist%2520Module

export LS_COLORS=""
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Users

# Delete old definitions
zstyle -d users

# complete only on accessible users + hcj
zstyle ':completion:*' users $(users) hcj

# ssh

# Add host aliases to completion 

hostaliases=()
if [[ -r ~/.ssh/config ]]; then
  hostaliases=(${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi

if [[ $#hostaliases -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[34m...\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi
