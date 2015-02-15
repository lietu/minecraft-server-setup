#!/usr/bin/env bash

# Set to 1 to enable backups
ENABLED=0

# What directories to backup, space separated
DIRECTORIES="$HOME/server"

# Where to store backups in
DESTINATION="$HOME/backups"

# How many of them to back up
KEEP_BACKUPS=2


# ----- SCRIPT LOGIC ----- #


# Only run if enabled
if [[ "$ENABLED" == "0" ]]; then
    exit 0
fi

# Current time, used as the backup directory, needs to be sortable!
timestamp=$(date +%Y-%m-%d_%H%M)

# Loop through directories to back up
for d in $DIRECTORIES; do
        # Figure out the destination directories
        name=$(basename "$d")
        backups_dir="$DESTINATION/$name"
        dest="$backups_dir/$timestamp"

        # Create the backup
        mkdir -p "$dest"
        cp -a $d/ $dest

        # Figure out how big it was
        size=$(du -chs "$dest" | tail -n1 | awk '{ print $1 }')

        echo "Backed up $d -> $dest ($size)"

        # Figure out which old backups to delete and delete them
        delete=$(ls $backups_dir | sort -r | tail -n+$(($KEEP_BACKUPS + 1)))
        for del in $delete; do
                delpath="$backups_dir/$del"
                echo "Deleting expired backup $delpath"
                rm -rf "$delpath"
        done
done

