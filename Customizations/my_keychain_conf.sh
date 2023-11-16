#! /bin/bash
/usr/bin/keychain -q "$HOME"/.ssh/id_ed25519
# shellcheck disable=SC1090
source "$HOME"/.keychain/"$(hostname)"-sh
