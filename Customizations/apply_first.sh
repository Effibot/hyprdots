#! /bin/bash

# This is a script that will customize the system to my liking.
# Use this to apply customizations contained in this folder

# Assert that the script is run from the Customizations folder.

if [ ! -f apply.sh ]; then
    echo "Please run this script from the Customizations folder."
    exit 1
fi

# Copy the custom app list to the script directory
cp my_apps_list.lst ../Scripts/custom_apps_list.lst
# Copy the custom zshrc file to the config directory
cp my.zshrc ../Configs/.zshrc
