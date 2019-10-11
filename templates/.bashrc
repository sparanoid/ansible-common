# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# http://rabexc.org/posts/pitfalls-of-ssh-agents
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
  echo "Initialising new SSH agent..."
  (umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

export LS_OPTIONS='--color=auto'
eval "`dircolors`"

export EDITOR=vim

# http://unix.stackexchange.com/q/148
custom_ps () {
  LOCALHOME="${HOME}"
  local NC='\033[0m' # No color
  local SPLITTER="\[\033[1;36m\]"
  local USR='\n\033[01;31m\]'$USER
  local HOST='\033[01;34m\]\h'; HOST='\033[00;30m\]@'$NC$HOST'\033[00;30m\]:'$NC
  # TODO: fancy slash color, but path not refreshed when changing directories idky
  # CWD="$(pwd)"
  # LOCATION="${CWD//\//$SPLITTER/\[\033[0;1m\]}$SPLITTER\\[\033[0m\]"
  local LOCATION=$NC'`pwd | sed "s#$LOCALHOME#~#g"`'
  local TIME='\n\033[01;37m\]`date`'$NC
  local BRANCH=' \033[01;35m\]$(git_branch)\[\033[00m\]\n\$ '
  PS1=$TIME$USR$HOST$LOCATION$BRANCH
  PS2='\[\033[01;36m\]> '$NC
}
custom_ps
