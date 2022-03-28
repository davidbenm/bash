#!/bin/bash

# Backing up required files

LOGFILE=$1
BACKUP_LOC="/usr/bin/"
BACKUP_TARGET="/home/$USER/backup"

init () {
        echo "Timestamp before work is done: $(date +"%D %T")" > $LOGFILE
        echo "Creating backup directory." >> $LOGFILE && mkdir $BACKUP_TARGET 2> /dev/null || echo "Directory already exists." >> $LOGFILE
}

cleanup () {
        rm -rf $BACKUP_TARGET
        echo "RECEIVED CTRLC" >> /home/$USER/$LOGFILE
        echo ""
        exit
}

init
trap cleanup SIGINT

echo "Copying files." >> $LOGFILE
cd $BACKUP_LOC
for i in $(ls); do
        cp -r "$i" $BACKUP_TARGET/"$i"-backup >> /home/$USER/$LOGFILE 2>&1
done

grep -i denied /home/$USER/$LOGFILE | tail -n 2 >> /home/$USER/$LOGFILE

#sleep 3

echo "Backup ready!" >> /home/$USER/$LOGFILE
echo "Timestamp after work is done: $(date +"%D %T")" >> /home/$USER/$LOGFILE
echo "------------------------------------------------" >> /home/$USER/$LOGFILE