#! /bin/bash

# apply code settings
rm -f ~/.config/Code/User/settings.json
cp code_settings.json ~/.config/Code/User/settings.json
# copy custom files
cp neofetch_config.conf ~/.config/neofetch/config.conf
cp kitty.conf ~/.config/kitty/kitty.conf
# restore zshrc file
cp my.zshrc ~/.zshrc
