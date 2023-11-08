#! /bin/bash

# This is a script that will be run after the dotfiles are installed.
# Use this to apply customizations contained in this folder

# Assert that the script is run from the Customizations folder.

if [ ! -f apply.sh ]; then
    echo "Please run this script from the Customizations folder."
    exit 1
fi

# Copy the dotfiles to the home directory
cp aliases.sh ~/.aliases.sh
cp functions.sh ~/.functions.sh
cp my.zshrc ~/.zshrc
cp code_settings.json ~/.config/Code/User/settings.json
