#!/bin/bash
## Script to prompt user input for ssh-add passphrase during .bashrc
## Not checked to be secure to use outside of .bashrc

# Call script with key filename as input
KEY_FILE=$1

echo -n "Enter passphrase for ${KEY_FILE}:"
read -s PASSPHRASE
echo $PASSPHRASE
