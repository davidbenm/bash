#!/bin/sh

# Backing up required files

echo "Creating backup directory"
mkdir ~/backup
echo "Copying files"
cp -r /usr/bin/* ~/backup
echo "Backup done!"