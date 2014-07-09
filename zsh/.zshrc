# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="pygmalion"
ZSH_THEME="roz"

alias noproxies='unset https_proxy; unset http_proxy; unset HTTPS_PROXY; unset HTTP_PROXY'
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias rnda='cd ~/vegas-RNDA; noproxies; echo "proxies unset"; workon OSClients'
alias rndb='cd ~/vegas-RNDB; noproxies; echo "proxies unset"; workon OSClients'
alias rndd='cd ~/vegas-RNDD; noproxies; echo "proxies unset"; workon OSClients; alias neutron="neutron --insecure"'
alias rnde='cd ~/vegas-RNDE; noproxies; echo "proxies unset"; workon OSClients; alias neutron="neutron --insecure"'
alias stb='cd ~/vegas-STB; unset https_proxy; echo "proxies unset"; workon OSClients; alias neutron="neutron --insecure"'
# That should work fine but no for me so creating an alis
alias .='source'



# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git history-substring-search common-aliases)
autoload -U zmv
autoload -Uz compinit
autoload -U promptinit
source $ZSH/oh-my-zsh.sh

export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

#History configuration
setopt hist_ignore_all_dups
setopt hist_ignore_space
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
#enable comments format like in bash
setopt interactivecomments
#
export EDITOR=vim

#Proxy
export http_proxy=<PROXYADDRESS>
export https_proxy=<PROXYADDRESS>
export ftp_proxy=<PROXYADDRESS>
#export no_proxy=

export PATH=/home/andrea/src/hpcs-nova-buildhelper:/home/andrea/src/hpcs-nova-buildhelper/scripts:/sbin:$PATH

# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
source "$HOME/.rvm/scripts/rvm"

# Python virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

#add my key to avoid to insert the password everytime
#ssh-add ~/.ssh/id_rsa &>/dev/null
