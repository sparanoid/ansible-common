# Init bash-completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ $PS1 && -f "/usr/share/bash-completion/bash_completion" ]] && . "/usr/share/bash-completion/bash_completion"

# Increase open files
# http://superuser.com/q/433746/49848
ulimit -n 4096

# Proxy settings
# This can now be disabled since I use Surge Enhanced Mode
# export http_proxy=http://localhost:6666
# export HTTP_PROXY=http://localhost:6666
# export https_proxy=http://localhost:6666
# export HTTPS_PROXY=http://localhost:6666
# export all_proxy=socks://localhost:6667
# export ALL_PROXY=socks://localhost:6667

# https://stackoverflow.com/a/51490280/412385
dvol() {
  local volume volumes_to_list=${1:-$(docker volume ls --quiet)}
  for volume in $volumes_to_list; do
    ls -lRa "$(docker volume inspect --format '{{ .Mountpoint }}' "$volume")"
    echo
  done
}

# launchctl shortcut
# Usage: lctl load ss-aliyun-hk
# Usage: lctl load ss-aliyun-hk-almace
# Usage: lctl unload ss-aliyun-hk-almace
# Usage: lctlr ss-aliyun-hk-almace
# Usage: lctll
lctl () {
  launchctl $1 ~/Library/LaunchAgents/$2.plist
}

lctlr () {
  launchctl unload ~/Library/LaunchAgents/$1.plist && launchctl load ~/Library/LaunchAgents/$1.plist
}

lctll () {
  ls -la ~/Library/LaunchAgents/
}

# Test SSL with OpenSSL
# Usage: ssltest sparanoid.com
ssltest () {
  openssl s_client -state -nbio -servername $1 -connect $1:443
}

# Sync SSH config
# Run on your local main machine
#
# Usage: sshconfig-sync hrotti
# Usage: sshconfig-sync root@45.33.22.16
sshconfig-sync () {
  scp ~/.ssh/config $1:~/.ssh/config
}

# Sync SSH public keys to allow auto login
# Depreacated!
# ! You can use `ssh-copy-id caladbolg` for better experience
# Run on your local main machine
# Note: You must `mkdir ~/.ssh/` on your remote machine first!
#
# Usage: ssh-sync hrotti
# Usage: ssh-sync root@45.33.22.16
ssh-sync () {
  scp ~/.ssh/id_rsa.pub $1:~/.ssh/authorized_keys
}

# Sync bash profiles
# Run on your local main machine
#
# Usage: profile-sync hrotti
# Usage: profile-sync root@45.33.22.16
profile-sync () {
  scp ~/.bash_profile $1:~/.bash_profile
  scp ~/.zprofile $1:~/.zprofile
}

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

# Make dir and cd
ms () {
  bash ~/Documents/Mac/Scripts/$1.sh
}

msl () {
  ls -la ~/Documents/Mac/Scripts/ $1
}

# default add color to ls
# G - colorized output
# F - Visual Classification of Files With Special Characters
# a - show hidden files/folders
# l - list format
# alias l='exa --long --header --git --all'
alias l='ls $LS_OPTIONS -GFalh'
alias ls='ls $LS_OPTIONS -G'
alias la='ls $LS_OPTIONS -GFa'
alias pb='fc -ln -1 | awk '{$1=$1}1' | pbcopy '

# File shortcuts
alias vv='code'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias profile='vv ~/.bash_profile'
alias profilec='vv ~/.bash_customs'
alias rl='. ~/.bash_profile'
alias reload='. ~/.bash_profile'
alias hosts='vv /etc/hosts'
alias sshconfig='vv ~/.ssh/config'
alias apache='/Applications/MAMP/Library/bin/apachectl'
alias apache-config='vv /Applications/MAMP/conf/apache/httpd.conf'
alias jk='jekyll'
alias mate='/usr/local/bin/mate -w'
alias gsvn='git svn'
alias notify='~/Documents/sparanoid-mac/app-utilities/Notification.sh'
alias weinres='weinre --boundHost -all-'
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ga="git add ."
alias gc="git commit -S -m"
alias gac="git add . && git commit -S -m"
alias gs="git status"
alias gls="git log --all --graph --oneline --decorate --tags"
alias hbi="hub browse -- issues"
alias hbpr="hub pull-request"
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed"
alias listen='lsof -i -P | grep LISTEN'
alias privoxyc='vv /usr/local/etc/privoxy/config'
# alias privoxyr='privoxy /usr/local/etc/privoxy/config'
alias privoxyr='launchctl unload ~/Library/LaunchAgents/com.sparanoid.privoxy.plist && sleep 1 && launchctl load ~/Library/LaunchAgents/com.sparanoid.privoxy.plist'
alias dnsmasqr='sudo launchctl stop homebrew.mxcl.dnsmasq && sudo launchctl start homebrew.mxcl.dnsmasq'
alias polipoc='vv ~/.polipo'
alias polipor='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist && sleep 1 && launchctl load ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist'
alias flexgetc='vv ~/.flexget/config.yml'
alias plexconnect='sudo python ~/Git/PlexConnect/PlexConnect.py'
alias plexconnectr='sudo ~/Git/PlexConnect/support/OSX/restart.bash'
alias gt='gittower'
alias pc='proxychains4'
alias pcc='vv ~/.proxychains/proxychains.conf'
alias a='ansible'
alias ap='ansible-playbook'
alias ac='vv ~/Git/ansible-playbook/hosts'
alias pca='proxychains4 ansible'
alias ssh-init='ssh-copy-id -i ~/.ssh/id_rsa.pub'
alias me='cat ~/.ssh/id_rsa.pub'
alias deploy='sh ~/Git/sparanoid.com-prod/auto-commit'
alias dup='bash ~/Documents/Mac/Backups/duplicity/duplicity-backup.sh -c "/Users/sparanoid/Documents/Mac/Backups/duplicity/local.conf"'
alias pcdup='proxychains4 bash ~/Documents/Mac/Backups/duplicity/duplicity-backup.sh -c "/Users/sparanoid/Documents/Mac/Backups/duplicity/local.conf"'
alias subpull='git submodule foreach git pull origin master'
alias durabotdev='HUBOT_SLACK_TOKEN=xoxb-15747034082-vSeX61Sm46DrN0igDsmSHBYU ./bin/hubot --adapter slack'
alias nw='bash ~/Documents/Mac/Scripts/networksetup.sh'
alias nwc='vv ~/Documents/Mac/Scripts/networksetup.sh'
alias plexupdate='bash /Volumes/Gizur/Downloads/Anime/episode-rename.sh'
alias myip='curl --noproxy "*" -s http://whatismyip.akamai.com/'
alias pping='prettyping'
alias bwd='pwd | sed -e "s:/:🥖:g"'
alias cwd='pwd | sed -e "s:/: ▸ :g"'
alias dkc='docker-compose'

# https://npm.taobao.org/
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

# Directories
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias nginx='cd ~/Git/nginx'
alias prod='cd ~/Git/sparanoid.com-prod'
alias wp='cd ~/Sites/localhost/wp'
alias 7z='cd ~/Git/7z'
alias sparanoid='cd ~/Git/sparanoid.com'
alias spp='cd ~/Git/sparanoid.com-prod'
alias sparanoid-start='cd ~/Git/sparanoid-start'

# Remotes
alias li='ssh caladbolg'
alias lip='ssh -qTfnN -D 4444 caladbolg'
alias vr='ssh carnwennan'
alias vrp='ssh -qTfnN -D 4444 carnwennan'
alias bvg='ssh hrotti'
alias bvgp='ssh -qTfnN -D 4444 hrotti'
alias rn='ssh durendal'
alias rnp='ssh -qTfnN -D 4444 durendal'
alias dw='ssh kladenets'
alias ty='ssh tyrfing'
alias xxx='echo "qweqwe"'

alias live-dl='/Users/sparanoid/Git/av-dl/live-dl'
alias live-dl='/Users/sparanoid/Git/live-dl/live-dl'
