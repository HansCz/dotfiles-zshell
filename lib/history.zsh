## Command history configuration
HISTFILE=$HOME/.zsh_history   # history file path
HISTSIZE=15000                # size of history file, in 
SAVEHIST=10000

setopt append_history         # zsh sessions will append their history list to the history file, rather than replace it
setopt extended_history       # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
setopt hist_expire_dups_first # If the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event from the list. You should be sure to set the value of HISTSIZE to a larger number than SAVEHIST in order to give you some room for the duplicated events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique events.

setopt hist_ignore_dups       # Do not enter command lines into the history list if they are duplicates of the previous event.
setopt hist_ignore_space      # Remove command lines from the history list when the first character on the line is a space, or when one of the expanded aliases contains a leading space
setopt hist_verify            # Whenever the user enters a line with history expansion, don’t execute the line directly; instead, perform history expansion and reload the line into the editing buffer
setopt inc_append_history     # This options works like APPEND_HISTORY except that new history lines are added to the $HISTFILE incrementally (as soon as they are entered), rather than waiting until the shell exits. The file will still be periodically re-written to trim it when the number of lines grows 20% beyond the value specified by $SAVEHIST (see also the HIST_SAVE_BY_COPY option).
setopt share_history          # This option both imports new commands from the history file, and also causes your typed commands to be appended to the history file
