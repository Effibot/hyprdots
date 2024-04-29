#! /bin/bash

###########################################
# This scripts applies the customizations #
# contained in this folder.               #
##########################################$

# Copy the dotfiles to the home directory
if [ ! -e "$HOME"/.aliases.sh ]; then
    cp aliases.sh "$HOME"/.aliases.sh
fi
if [ ! -e "$HOME"/.functions.sh ]; then
    cp functions.sh "$HOME"/.functions.sh
fi

# overwrite the zsh plugins list
mv ../Scripts/restore_zsh.lst ../Scripts/restore_zsh.lst.bak
cp my_restore_zsh.lst ../Scripts/restore_zsh.lst
# run the zsh plugin installation script
bash -c "cd ../Scripts && ./restore_shl.sh"
# restore zshrc file
cp my.zshrc "$HOME"/.zshrc

# restore things to avoid conflicts
rm ../Scripts/restore_zsh.lst
mv ../Scripts/restore_zsh.lst.bak ../Scripts/restore_zsh.lst

# apply code settings
rm -f "$HOME"/.config/Code/User/settings.json
cp code_settings.json "$HOME"/.config/Code/User/settings.json

# add italian language?
read -p "Do you want to add italian language? (y/n)" -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cat my_userprefs.conf >> "$HOME"/.config/hypr/userprefs.conf
fi

# Installs on laptop?
read -p "Installing on laptop? (y/m)" -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cat "monitor=eDP-1,1920x1080@60,0x0,1" >> "$HOME"/.config/hypr/userprefs.conf
fi