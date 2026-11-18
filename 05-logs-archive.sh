#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
TIMESTAMP=$(date "+%d-%m-%Y %H:%M:%S")

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR:: Either source_dir or dest_dir empty"
    echo "USAGE:: $0 <source_dir> <dest_dir> <days(optional) to 14>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "$SOURCE_DIR source_dir does not exist"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo "$DEST_DIR dest_dir does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

ARCHIVE_FILE="$DEST_DIR/archive_file.tar.gz $TIMESTAMP"

tar -czvf "$ARCHIVE_FILE" $FILES

if [ $? -eq 0 ]; then
    echo "Archival is SUCCESS"
        while IFS= read -r FILE
            do
            echo "file is $FILE"
                rm -rf $FILE
            echo "files $FILES deleted"          
            done <<< "$FILES"
else
    echo "ERROR ARCHIVAL IS FAILED"
fi