#! /bin/bash

# This is a script that will customize the system to my liking after the dotfiles installation.
# Use this to apply customizations contained in this folder

# Assert that the script is run from the Customizations folder.

if [ ! -f apply_after.sh ]; then
    echo "Please run this script from the Customizations folder."
    exit 1
fi

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

read -p "Do you want to create a Python Virtual Environment? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Create a Python Virtual Environment
    pyenv=~/venv/jarpy
    mkdir -p "$pyenv"
    virtualenv "$pyenv" --system-site-packages
    # Install python packages
    # shellcheck source=/dev/null
    source "$pyenv"/bin/activate
    pip install -r requirements.txt
    deactivate
fi

# Set microsoft-edge as default browser
read -p "Do you want to set microsoft-edge as default browser? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    unset BROWSER
    xdg-settings set default-web-browser microsoft-edge.desktop
fi

# Set configs for git
read -p "Do you want to set configs for git? (y/n) " -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git config --global user.email "andrea.efficace1@gmail.com"
    git config --global user.name "Effibot"
fi

# change spotify permissions for spicetify compatibility
sudo chmod 777 /opt/spotify -R
