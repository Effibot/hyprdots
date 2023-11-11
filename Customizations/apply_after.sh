#! /bin/bash

# This is a script that will customize the system to my liking after the dotfiles installation.
# Use this to apply customizations contained in this folder

# Assert that the script is run from the Customizations folder.

if [ ! -f apply.sh ]; then
    echo "Please run this script from the Customizations folder."
    exit 1
fi

# Copy the dotfiles to the home directory
cp aliases.sh ~/.aliases.sh
cp functions.sh ~/.functions.sh
cp code_settings.json ~/.config/Code/User/settings.json
cp neofetch_config.conf ~/.config/neofetch/config.conf
cp kitty.conf ~/.config/kitty/kitty.conf

# ask before copy the matlab config
read -p "Do you want to copy the matlab config? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Copy matlab.desktop file
    cp matlab.desktop ~/.local/share/applications/matlab.desktop
fi

# add the 'it' keyboard layout to the hyprland config
read -p "Do you want to add the 'it' keyboard layout to the hyprland config? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Copy the hyprland config
    cp hyprland ~/.config/hyprland
fi

# copy the zsh plugin list to the script folder
cp my_zsh_plugins.lst ../Scripts/my_zsh_plugins.lst
# run the zsh plugin installation script
bash -c "cd ../Scripts && ./restore_zsh.sh"
