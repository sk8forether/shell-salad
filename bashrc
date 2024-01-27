# .bashrc

## WARNING: This will not work unless you fill in a path to the ssh key on the system for KEY_FILE
KEY_FILE=""

# User specific aliases and functions
## conda stuff
. /opt/conda/etc/profile.d/conda.sh
conda activate base

## github stuff
### add ssh key (with passphrase) to connect to github
### note that ~/ssh-add-pw.sh script will prompt user for passphrase immediately upon login
eval $(ssh-agent)
DISPLAY=1 SSH_ASKPASS="~/ssh-add-pw.sh" ssh-add ${KEY_FILE} 

### auth to github with key
ssh -T git@github.com

### git configurations
git config --global core.editor vim
git config --global user.name "sk8forether"
git config --global user.email "peter.vaillancourt@colorado.edu"
git config --global color.ui true
git config --global push.default simple

## starting point
#cd /lustre/Development/NOAA-PSL/graph-ufs/
#git status

