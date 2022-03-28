#!/bin/bash

# Backing up required files

if [ -z $1 ]
then
        echo "You need to supply a parameter for the log file."
        exit 255
fi

LOGFILE=$1
BACKUP_LOC="/usr/bin/"
BACKUP_TARGET="/home/$USER/backup"

init () {
        echo "Timestamp before work is done: $(date +"%D %T")" > $LOGFILE
        if [ -d $BACKUP_TARGET ]
        then
                echo "Directory already exists." >> $LOGFILE
                return 1
        else
                mkdir $BACKUP_TARGET
                echo "Creating backup directory." >> $LOGFILE
                return 0
        fi
}

cleanup () {
        rm -rf $BACKUP_TARGET
        echo "RECEIVED CTRLC" >> /home/$USER/$LOGFILE
        echo ""
        exit 127
}

#set -x
init
#set +x
trap cleanup SIGINT

echo "Copying files." >> $LOGFILE
cd $BACKUP_LOC
for i in $(ls /usr/bin/ | grep -E 'deb|dpkg|docker'); do
        cp -v -r "$i" $BACKUP_TARGET/"$i"-backup >> /home/$USER/$LOGFILE 2>&1
done

grep -i denied /home/$USER/$LOGFILE | tail -n 2 >> /home/$USER/$LOGFILE

echo "Backup ready!" >> /home/$USER/$LOGFILE
sleep 5
echo "Timestamp after work is done: $(date +"%D %T")" >> /home/$USER/$LOGFILE
echo "------------------------------------------------" >> /home/$USER/$LOGFILE