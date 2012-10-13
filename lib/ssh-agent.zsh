if [[ `uname` == "Darwin" ]]; then
  eval `ssh-agent` >/dev/null
fi
