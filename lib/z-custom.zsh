#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

#-----------------------------------------------------
# Disable the built-in command `r` for R to work
#
disable r

#-----------------------------------------------------
# https://goo.gl/M3zjNU
# activate autocd to allow change to a dir via its name
setopt auto_cd              # Auto changes to a directory without typing cd.
setopt auto_pushd           # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups    # Do not store duplicates in the stack.
setopt pushd_silent         # Do not print the directory stack after pushd or popd.
setopt pushd_to_home        # Push to home directory when no argument is given.
setopt cdable_vars          # Change directory to a path stored in a variable.
setopt auto_name_dirs       # Auto add variable-stored paths to ~ list.
setopt multios              # Write to multiple descriptors.
setopt extended_glob        # Use extended globbing syntax.
#unsetopt clobber           # Do not overwrite existing files with > and >>
                            # Use >! and >>! to bypass.
setopt clobber              # turn off warning "file exists" with > and >>

#-----------------------------------------------------
# Automatically expanding zsh global aliases 
# https://goo.gl/fJbtmJ
#
globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}

zle -N globalias
bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

#-----------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions
#
# change ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE in case the color contrast is bad
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/src/config.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

#-----------------------------------------------------
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
#
test -d ${ZDOTDIR:-$HOME}/.fzf && source ${ZDOTDIR:-$HOME}/.fzf.zsh

[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

##### nvm (node version manager) #####
# placeholder nvm shell function
# On first use, it will set nvm up properly which will replace the `nvm`
# shell function with the real one
function nvm() {
  if [[ -d '/usr/local/opt/nvm' ]]; then
    NVM_DIR="/usr/local/opt/nvm"
    export NVM_DIR
    # shellcheck disable=SC1090
    source "${NVM_DIR}/nvm.sh"
    if [[ -e ~/.nvm/alias/default ]]; then
      PATH="${PATH}:${HOME}.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"
    fi
    # invoke the real nvm function now
    nvm "$@"
  else
    echo "nvm is not installed" >&2
    return 1
  fi
}