#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

############### BEGIN CUSTOM CONFIG ###############
alias py=python3
alias vi=nvim

# git
export GPG_TTY=$(tty)

export BC=/home/solly/.bashrc

export SC=/home/solly/sc
export PRJ=$SC/dev/redscale/llvm-project/clang-tools-extra/decls-to-json
export LLVM=$SC/llvm

export PATH='/opt/cuda/bin:/home/solly/code/sc/llvm/bin':$PATH
export LD_LIBRARY_PATH='/opt/cuda/lib64':$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LLVM/lib:$LD_LIBRARY_PATH

# tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

