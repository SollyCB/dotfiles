######## BEGIN CUSTOM CONFIG ######

# theme.sh one-half-black

alias newterm="sudo update-alternatives --config x-terminal-emulator"

# vim
alias vi=nvim
export NIGHT=$(cat /home/solly/scripts/night.opt)
alias night='export NIGHT=1; echo 1 > /home/solly/scripts/night.opt'
alias day='export NIGHT=0; echo 0 > /home/solly/scripts/night.opt'

# 4coder
alias e='/home/solly/4ed/build-stable/4ed &'
alias ed='/home/solly/4ed/build/4ed &'
alias eb='/home/solly/4ed/build-base/4ed &'

# bluetooth
alias bctl=bluetoothctl

# audio
alias setvol="echo 'pactl set-sink-volume @DEFAULT_SINK@ $1%; echo $1'"
alias incvol="echo 'pactl set-sink-volume @DEFAULT_SINK@ +$1%; echo $1'"
alias decvol="echo 'pactl set-sink-volume @DEFAULT_SINK@ -$1%; echo $1'"

# tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# dwm
alias winstat="~/apps/dwm-6.4/stuff/status &"

if [[ $(ps -aux | rg -F '/home/solly/apps/dwm-6.4/stuff/status' | wc -l) == 1 ]]; then
    /home/solly/apps/dwm-6.4/stuff/status &
fi

# cl tools
export PATH=/home/solly/code/tools/:$PATH
alias clang="clang-17"
alias gf="/home/solly/apps/gf/gf2 $@ &"

# git
alias gs="git status"
alias gl="git log"
alias gc="git commit"
alias ga="git add"
alias gd="git diff"

# python
alias py="python3"

# whitespace
alias trailing="bash ~/scripts/trailing.bash"

# cargo
export PATH=$PATH:"/home/solly/.cargo/bin"
source "$HOME/.cargo/env"

# helix
export COLORTERM=truecolor
export HELIX_RUNTIME=/home/solly/apps/helix/runtime
export PATH=/home/solly/apps/helix/target/release/hx:$PATH

# glfw
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/solly/glfw/build/src/

# vulkan tools
export VULKAN_SDK=~/vulkan/1.3.261.1/x86_64
export PATH=$VULKAN_SDK/bin:$PATH
export LD_LIBRARY_PATH=$VULKAN_SDK/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d

######### BEGIN DEFAULTS ##########

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

. "$HOME/.cargo/env"
