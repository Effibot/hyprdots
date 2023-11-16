#! /bin/bash

# This is a script that will customize the system to my liking after the dotfiles installation.
# Use this to apply customizations contained in this folder

# Assert that the script is run from the Customizations folder.

if [ ! -f apply_after.sh ]; then
    echo "Please run this script from the Customizations folder."
    exit 1
fi

# Copy the dotfiles to the home directory
cp aliases.sh ~/.aliases.sh
cp functions.sh ~/.functions.sh
cp code_settings.json ~/.config/Code/User/settings.json
cp neofetch_config.conf ~/.config/neofetch/config.conf
cp kitty.conf ~/.config/kitty/kitty.conf
cp my_windowrules.conf ~/.config/hypr/windowrules.conf
cp my_keybindings.conf ~/.config/hypr/keybindings.conf
cp my_keychain_conf.sh ~/.keychain_conf.sh

# ask before copy the matlab config
read -p "Do you want to copy the matlab config? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Copy matlab.desktop file
    # if the file not exist, create it
    if [ ! -f matlab.desktop ]; then
        touch matlab.desktop
    fi
    cp matlab.desktop ~/.local/share/applications/matlab.desktop
fi

# add the 'it' keyboard layout to the hyprland config
read -p "Do you want to add the 'it' keyboard layout to the hyprland config? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Copy the hyprland config
    cp my_hyprland.conf ~/.config/hypr/hyprland.conf
fi

# copy the zsh plugin list to the script folder
mv ../Scripts/restore_zsh.lst ../Scripts/restore_zsh.lst.bak
cp my_restore_zsh.lst ../Scripts/restore_zsh.lst
# run the zsh plugin installation script
bash -c "cd ../Scripts && ./restore_zsh.sh"

# Finalize Docker Installation
read -p "Do you want to finalize the Docker installation? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Finalize Docker Installation
    sudo groupadd docker
    sudo usermod -aG docker "$USER"
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
fi

# Finalize NordVPN Installation
read -p "Do you want to finalize the NordVPN installation? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Finalize NordVPN Installation
    sudo groupadd -r nordvpn
    sudo gpasswd -a "$USER" nordvpn
    sudo systemctl enable nordvpnd.service
    sudo systemctl start nordvpnd.service
fi

# Ask for ssh key generation
read -p "Do you want to generate a new ssh key? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Generate a new ssh key
    read -p "Insert the email for the ssh key: " -r email && echo
    ssh-keygen -t ed25519 -C "$email"
    # Add key to the ssh agent
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi

# Finalize the VSCode installation adding the keyring option
read -p "Do you want to finalize the VSCode installation adding the keyring option? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Finalize the VSCode installation adding the keyring option
    if [[ -f "$HOME/.vscode/argv.json" ]]; then
        echo "The file argv.json already exists, adding the keyring option"
    else
        touch "$HOME/.vscode/argv.json"
        echo "{}" >"$HOME/.vscode/argv.json"
    fi
    # look for the last } in the file, and add "password-store": "gnome" before it
    sed -i '/}/i\    ,"password-store": "gnome",' "$HOME/.vscode/argv.json"
fi

# Create python virtual environment
pyenv=~/venv/jarpy
mkdir -p "$pyenv"
virtualenv "$pyenv" --system-site-packages
# Install python packages
# shellcheck source=/dev/null
source "$pyenv"/bin/activate
pip install -r requirements.txt
deactivate

# Set microsoft-edge as default browser
read -p "Do you want to set microsoft-edge as default browser? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    unset BROWSER
    xdg-settings set default-web-browser microsoft-edge.desktop
fi

# Set configs for git
git config --global user.email "andrea.efficace1@gmail.com"
git config --global user.name "Effibot"

# change spotify permissions for spicetify compatibility
sudo chmod 777 /opt/spotify -R

# Restore old configs to avoid git conflicts
rm -f ../Scripts/custom_apps.lst
mv ../Scripts/custom_apps.lst.bak ../Scripts/custom_apps.lst
rm -f ../Configs/.zshrc
mv ../Configs/.zshrc.bak ../Configs/.zshrc
rm -f ../Scripts/restore_fnt.lst
mv ../Scripts/restore_fnt.lst.bak ../Scripts/restore_fnt.lst
rm -f ../Scripts/restore_etc.sh
mv ../Scripts/restore_etc.sh.bak ../Scripts/restore_etc.sh
rm -f ../Scripts/restore_zsh.lst
mv ../Scripts/restore_zsh.lst.bak ../Scripts/restore_zsh.lst

# remember to change the sddm conf to auto login the keyring
echo "run sudo nano /etc/pam.d/sddm and change the second line removing the -"
