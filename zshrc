#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

# for profiling zsh
# https://unix.stackexchange.com/a/329719/27109
#
# zmodload zsh/zprof

export SCRIPTS=${HOME}/scripts

export ZSHCONFIG=${ZDOTDIR:-$HOME}/.zsh-config

ZSH_INIT=${ZSHCONFIG}/_init.sh

if [[ -s ${ZSH_INIT} ]]; then
    source ${ZSH_INIT}
else
    echo "Could not find the init script ${ZSH_INIT}"
fi


autoload -Uz compinit

case $SYSTEM in
  Darwin)
    if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
      compinit;
    else
      compinit -C;
    fi
    ;;
  Linux)
  ;;
esac

# https://direnv.net/
# see zplugin-init.zsh
# https://github.com/zdharma/zplugin/wiki/Direnv-explanation
# eval "$(direnv hook zsh)"


# Private script here
[ -f ~/.private.zsh ] && source ~/.private.zsh
