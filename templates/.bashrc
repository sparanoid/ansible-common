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
git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/';
}

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

# Useful functions
# Make dir and cd
mcd () {
  mkdir -p $1
  cd $1
}

# Block IP using iptables
ipblock () {
  iptables -A INPUT -s $1 -j DROP
}

# Unblock IP using iptables
ipunblock () {
  iptables -D INPUT -s $1 -j DROP
}

alias l='ls $LS_OPTIONS -GFalh'
alias ls='ls $LS_OPTIONS -G'
alias la='ls $LS_OPTIONS -GFa'

alias ap='ansible-playbook'
alias rl='. ~/.bashrc'
alias reload='. ~/.bashrc'
alias profile='vi ~/.bashrc'
alias hosts='vi /etc/hosts'
alias sshconfig='vi ~/.ssh/config'
alias free='free -m'
alias ds='du -h --max-depth=1'
alias vi='vim'
alias vmstat='vmstat -S m'
alias ngx='service nginx'
alias ngxt='nginx -t'
alias ht='service httpd'
alias fpm='service php-fpm'
alias net80="netstat -n --protocol inet | grep ':80'"
alias net22="sudo lsof -i -n | egrep '\<sshd\>'"
alias ngxpurge="rm -rf /var/lib/nginx/cache/*"
alias listen='lsof -i -P | grep LISTEN'
alias mysqltuner='perl /usr/share/MySQLTuner-perl/mysqltuner.pl'
alias apcc='vi /etc/php.d/apc.ini'
alias vhostc='/etc/httpd/conf.d/vhost.conf'
alias dup='bash /srv/scripts/duplicity/duplicity-backup.sh -c /srv/scripts/duplicity/server.conf'
alias conn="netstat -ntu | awk '{print \$5}' | cut -d: -f1 | sort | uniq -c | sort -n"

alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ga="git add ."
alias gc="git commit -S -m"
alias gac="git add . && git commit -S -m"
alias gs="git status"

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
