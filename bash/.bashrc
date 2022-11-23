# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# env
export EDITOR="nvim"
export ONEDRIVE="/mnt/c/Users/jon/OneDrive"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# expand variables with Tab key
shopt -s direxpand

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

        RED="\[\e[0;31m\]"
     YELLOW="\[\e[1;33m\]"
      GREEN="\[\e[0;32m\]"
       BLUE="\[\e[1;34m\]"
     PURPLE="\[\e[0;35m\]"
  LIGHT_RED="\[\e[1;31m\]"
LIGHT_GREEN="\[\e[1;32m\]"
      WHITE="\[\e[1;37m\]"
 LIGHT_GRAY="\[\e[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function parse_git_branch(){
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function set_git_branch(){
  branch=$(parse_git_branch)
  BRANCH="${PURPLE}${branch}${COLOR_NONE} "
}

function set_prompt_symbol(){
  if test $1 -eq 0 ; then
    PROMPT_SYMBOL="\$"
  else
    PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
}

function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

function set_bash_prompt(){
  set_prompt_symbol $?

  set_virtualenv

  set_git_branch

  PS1="
  ${PYTHON_VIRTUAL_ENV}${GREEN}\w${COLOR_NONE}${BRANCH}
  ${PROMPT_SYMBOL} "
}

PROMPT_COMMAND=set_bash_prompt

#PS1=$'\n\e[92m\]\ue0b6\e[30;102m\]\w\e[0m\]\e[92m\]\ue0b4\e[0m\]\n\e[1;$((91+!$?))m\]\e[0m\] '
#PS1=$'\n\e[1;30;102m\] \w \e[0m\]\e[92m\]\ue0bc\e[0m\]\n\e[1;$((91+!$?))m\]\e[0m\] '

PROMPT_DIRTRIM=3

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls -h --color=auto --group-directories-first'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -Al'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias vim='nvim'
alias wts='nvim /mnt/c/Users/jon/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json'
alias penv='source venv/bin/activate'
alias suap='cd ~/suap/suap-uepb; source venv/bin/activate'
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Windows X Server
if uname -r | grep -q 'microsoft'; then
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
  export LIBGL_ALWAYS_INDIRECT=1
fi
