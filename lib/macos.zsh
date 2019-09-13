#!/usr/bin/env zsh
# vim:syntax=sh
# vim:filetype=sh

#
# Define common system-wide configurations

# GNU ls aliases
#
# For macOS where GNU ls is installed via homebrew as `gls`
# case $SYSTEM in
#   Darwin)
#     alias ls='/usr/local/bin/gls --color=auto'
#   ;;
#   Linux)
#     alias ls='ls --color=auto'
#   ;;
# esac
#

# fzf
alias f=fzf

alias ls='ls --color=auto'
# Use exa instead of ls
alias ls=exa

alias l='ls -lFh'     #size,show type,human readable
alias la='ls -laFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -lFht created'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias ls.sort.time='ls -tlFh'
alias ls.sort.size='ls -SlFh'
alias ls.recursive='ls -R'
alias ls.id='ls -nFh'			# show numeric FID and GID (-n)

# diff
alias diff='colordiff'

# change dir
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../..'

alias df='df -h'

#
# Pipe Aliases
#
# Use ripgrep instead of grep
alias grep='rg --color=auto '
alias egrep='rg --color=auto '

alias L=' | less '
alias G=' | egrep --color=auto '
alias T=' | tail '
alias H=' | head '
alias W=' | wc -l '
alias S=' | sort '

function handle-multi-arguments(){
	if [ ! "$#" -gt 1 ] ; then
	  echo "Usage: $0 file1 file2 ..." >&2
	  return -1
	fi
	for file in $@; do
		if [ -f $file ] ; then
			echo -n $file
		fi
	done
	echo 'Done!'
}

# macOS specific
#
# Check if running on macOS, otherwise stop here
[[ ! "x$SYSTEM" == "xDarwin" ]] && return

# /etc/zprofile is loaded and invokes
# /usr/libexec/path_helper that might slow down start-up.
# Better enter directly the content of /etc/paths.d here

# /etc/paths.d/40-XQuartz
export PATH=$PATH:/opt/X11/bin

# /etc/paths.d/MacGPG2
export PATH=$PATH:/usr/local/MacGPG2/bin

#
# GNU Core Utils
# brew info coreutils
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# scutil
#
alias sys.get.computername='scutil --get ComputerName'
alias sys.get.localhostname='scutil --get LocalHostName'
alias sys.get.hostname='scutil --get HostName'
alias sys.get.dns='scutil --dns'
alias sys.get.proxy='scutil --proxy'
alias sys.get.network.interface='scutil --nwi'

#
alias sys.uti.file='mdls -name kMDItemContentTypeTree '

alias lsregister='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
#
# OS X's launchctl
#
alias launch.list='launchctl list '
alias launch.load='launchctl load '
alias launch.unload='launchctl unload '
alias launch.getenv='launchctl getenv '
alias launch.start='launchctl start '
alias launch.stop='launchctl stop '

#
# Spotlight / Meta-data indexing (MDS)
#
# https://apple.stackexchange.com/q/87090/7647
# https://apple.stackexchange.com/q/63178/7647
#
alias spotlight.exclusion.show='sudo defaults read /.Spotlight-V100/VolumeConfiguration.plist Exclusions'
alias spotlight.exclusion.add='sudo defaults write /.Spotlight-V100/VolumeConfiguration.plist Exclusions -array-add '

alias spotlight.indexing.stop='sudo launchctl stop com.apple.metadata.mds'
alias spotlight.indexing.start='sudo launchctl start com.apple.metadata.md'
alias spotlight.indexing.restart='spotlight.indexing.stop && spotlight.indexing.start'

alias sys.pkg.list='pkgutil --pkgs'

# show CPU info
alias sys.cpu='sysctl -n machdep.cpu.brand_string'

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gl='git pull'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gp='git push'
alias gpd='git push --dry-run'
alias gst='git status'

alias ccat='highlight -O ansi'
alias c='pygmentize -O ansi -g'