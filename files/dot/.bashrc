# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# load the other shell dotfiles
for dotfile in $HOME/.bash_{init,prompt,exports,aliases,functions}; do
    [ -e "$dotfile" ] && source "$dotfile"
done
unset dotfile
