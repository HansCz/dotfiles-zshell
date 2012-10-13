if [[ "$OSNAME" == "$DEFAULT_OSNAME" && "$HOSTNAME" == "$DEFAULT_HOSTNAME" ]] 
then
  export EDITOR='subl'
  export NODE_PATH=/usr/local/lib/node_modules

  # Putting /usr/local/share/npm/bin in the front of PATH so as to include npm binaries, like tower
  export PATH="/usr/local/share/npm/bin:$PATH"
  # Putting /usr/local/bin in the front of PATH so as to override default vim executable (7.2) in favor of newer vim at /usr/local/bin/vim
  export PATH="/usr/local/bin:$PATH"
fi
