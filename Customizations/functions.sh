#! /bin/bash

# make find works with bat
function find {
    /usr/bin/find $1 -exec bat {} +
}
# config for manpager with bat
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
