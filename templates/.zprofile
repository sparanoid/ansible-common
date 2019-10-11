# bash completion script compatibility mode
# https://github.com/eddiezane/lunchy/issues/57#issuecomment-121173592
autoload bashcompinit
bashcompinit

# Source bash profiles
if [ -f "$HOME/.bash_profile" ]; then
  source "$HOME/.bash_profile"
fi
