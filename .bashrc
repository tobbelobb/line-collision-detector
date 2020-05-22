# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi


PS1='\[\e[1;31m\]DOCKER:\w#\[\e[m\] '

alias gl="git branch; git log --oneline | head"
alias ll='ls -alF'
alias ..="cd .."
alias ...="cd ../.."

# Avoid having to put path in front of every shell script name all the time
PATH=$PATH:/line-collision-detector

# Avoid having to write .sh all the time
alias tidy="tidy.sh"
alias indent="indent.sh"
alias make_compilation_database="make_compilation_database.sh"
