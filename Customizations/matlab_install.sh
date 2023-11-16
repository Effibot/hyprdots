#! /bin/bash

# script to install matlab

# download the installer and put into the Downloads folder
wget https://www.mathworks.com/mpm/glnxa64/mpm -O ~/Downloads/mpm
chmod +x ~/Downloads/mpm
# enter the matlab version to install
read -p "Enter the matlab version to install: " -r && echo
release="R${REPLY}"
# convert addons in the lst file to a string
addons=$(cat matlab_addons.lst | tr '\n' ' ')
bash -c "\
cd ~/Downloads && \
sudo ./mpm install --release=${release} \
--destination=/usr/local/MATLAB/${release} \
MATLAB \
${addons}
"
rm -f ~/Downloads/mpm
# make symlink to the matlab executable
#sudo ln -s /usr/local/MATLAB/"${release}"/bin/matlab /usr/local/bin/matlab
