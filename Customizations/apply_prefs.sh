#! /bin/bash

###########################################
# This scripts applies the customizations #
# contained in this folder.               #
##########################################$

# Copy the dotfiles to the home directory
if [ ! -e ~/.aliases.sh ]; then
    cp aliases.sh ~/.aliases.sh
fi
if [ ! -e ~/.functions.sh ]; then
    cp functions.sh ~/.functions.sh
fi
# overwrite the zsh plugins list
mv ../Scripts/restore_zsh.lst ../Scripts/restore_zsh.lst.bak
cp my_restore_zsh.lst ../Scripts/restore_zsh.lst
# run the zsh plugin installation script
bash -c "cd ../Scripts && ./restore_shl.sh"
# restore zshrc file
cp my.zshrc ~/.zshrc
# restore things to avoid conflicts
rm ../Scripts/restore_zsh.lst
mv ../Scripts/restore_zsh.lst.bak ../Scripts/restore_zsh.lst
# apply code settings
rm -f ~/.config/Code/User/settings.json
cp code_settings.json ~/.config/Code/User/settings.json
# copy custom files
cp neofetch_config.conf ~/.config/neofetch/config.conf
cp kitty.conf ~/.config/kitty/kitty.conf
# apply customizations to Hyprland Configs
cat my_userprefs.conf >>~/.config/hypr/userprefs.conf
