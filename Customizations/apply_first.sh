#! /bin/bash

# This is a script that will customize the system to my liking.
# Use this to apply customizations contained in this folder

# Assert that the script is run from the Customizations folder.

if [ ! -f apply_first.sh ]; then
    echo "Please run this script from the Customizations folder."
    exit 1
fi

# Copy the custom app list to the script directory
mv ../Scripts/custom_apps.lst ../Scripts/custom_apps.lst.bak
cp my_custom_apps.lst ../Scripts/custom_apps.lst
# Copy the custom zshrc file to the config directory
mv ../Configs/.zshrc ../Configs/.zshrc.bak
cp my.zshrc ../Configs/.zshrc
# Copy the fnt restore list
mv ../Scripts/restore_fnt.lst ../Scripts/restore_fnt.lst.bak
cp my_restore_fnt.lst ../Scripts/restore_fnt.lst
# Copy the restore etc script
mv ../Scripts/restore_etc.sh ../Scripts/restore_etc.sh.bak
cp my_restore_etc.sh ../Scripts/restore_etc.sh
