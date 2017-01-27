# Simple Git Prompt
#
find_git_status() {

  local c_red='\[\e[31m\]'
  local c_green='\[\e[32m\]'
  local c_yellow='\[\e[33m\]'
  local c_blue='\[\e[36m\]'
  local c_clear='\[\e[0m\]'

  ps1pc_start="$1"
  ps1pc_end="$2"

  local branch

  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="$branch"
  else
    git_branch=""
  fi

  if [[ "$git_branch" != "" ]]; then
    git_sha=$(git rev-parse --short HEAD 2> /dev/null)
    local status=$(git status --porcelain 2> /dev/null)
    local staged=$(git diff --cached --name-only 2> /dev/null)
    if [[ "$staged" != "" ]]; then
      git_message="$c_yellow($git_branch*)$c_clear "
    elif [[ "$status" != "" ]]; then
      git_message="$c_red($git_branch*)$c_clear "
    else
      git_message="$c_green($git_branch=$git_sha)$c_clear "
    fi
  else
    git_message=''
  fi

  export PS1="$git_message$ps1pc_start$c_blue$ps1pc_end$c_clear"
}

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

PROMPT_COMMAND='find_git_status "\u $(date +%H:%M)" " \w \\\$ "'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export MAVEN_OPTS="-Xms256m -Xmx512m -Djavax.net.ssl.trustStore=/Users/basons01/workspace/jssecacerts -Djavax.net.ssl.keyStore=/Users/basons01/workspace/sambason.p12 -Djavax.net.ssl.keyStorePassword=donkeys -Djavax.net.ssl.keyStoreType=PKCS12"

export JAVA_HOME=$(/usr/libexec/java_home)

export SIKULIX_HOME=/Users/basons01/workspace/tip-git/features/libs/sikuli-java.jar

eval "$(docker-machine env default)"
