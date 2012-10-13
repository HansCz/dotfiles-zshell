setopt prompt_subst
function ps1_identity 
{
  if [[ $USER != $DEFAULT_USERNAME ]]; then
    printf "%%{\033[38;5;240m%%}$USER%%{\033[0m%%}"
  fi
  return 0
}

function ps1_host 
{
  local current_host
  
  current_host=`hostname`
  
  if [[ $current_host != $DEFAULT_HOSTNAME ]]; then
    printf "%%{\033[38;5;240m@%%}$current_host%%{:\033[0m%%}"
  fi
  return 0
}

function ps1_working_directory () 
{
  printf "%%{\033[38;5;26m%%}%%~%%{\033[0m%%}"
  return 0
}

ps1_rvm()
{
  if command -v rvm-prompt >/dev/null 2>/dev/null ; then
    printf '%%{\033[38;5;240m%%}$(rvm-prompt v g)%%{\033[0m%%}'
  fi
  return 0
}

function ps1_git_branch () {

  # no reason to run this if git is not installed
  
  if ! command -v git >/dev/null 2>&1 ; then
    printf "\033[38;5;160m${git_prompt} [git not found]\033[0m"
    exit 0
  fi

  local branch=""
  
  while read -r line
  do
    if [[ $line =~ '^\*' ]]; then
      branch="${line#* }"

      local git_status="`git status`"
      local git_status_numeric=0
      local git_prompt="ß"
    
      if [[ "${git_status}" =~ '# Untracked files:' ]] ; then
        printf "\033[38;5;37m·\033[0m"
        let "git_status_numeric+=8"
      fi

      if [[ "${git_status}" =~ '# Changes not staged for commit:' ]] ; then
        printf "\033[38;5;136m·\033[0m"
        let "git_status_numeric+=4"
      fi

      if [[ "${git_status}" =~ '# Changes to be committed:' ]] ; then
        printf "\033[38;5;166m•\033[0m"
        let "git_status_numeric+=2"
      fi

      if [[ "${git_status}" =~ 'nothing to commit \(working directory clean\)' ]] ; then
        let "git_status_numeric+=1"
      fi          
    
      case $git_status_numeric in
        1)
          printf "\033[38;5;33m${git_prompt}\033[0m \033[38;5;33m${branch}\033[0m"
          ;;
        2|6|10|14)
          printf "\033[38;5;166m${git_prompt}\033[0m \033[38;5;166m${branch}\033[0m"
          ;;
        4|12)
          printf "\033[38;5;136m${git_prompt}\033[0m \033[38;5;136m${branch}\033[0m"
          ;;
        8)
          printf "\033[38;5;37m${git_prompt}\033[0m \033[38;5;37m${branch}\033[0m"
          ;;
        
      esac
  
    fi
  done < <(git branch 2>/dev/null)
}

function ps1_git ()
{
    printf '$(ps1_git_branch)'
}

PROMPT="$(ps1_identity)$(ps1_host)$(ps1_working_directory) $(ps1_git)
∴ "

RPROMPT="$(ps1_rvm)"
