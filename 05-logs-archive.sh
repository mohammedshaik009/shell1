#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR:: Either source_dir or dest_dir empty"
    echo "USAGE:: $0 <source_dir> <dest_dir> <days(optional) default to 14>"
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

FILES=$(find "$SOURCE_DIR" -type f -name "*.log" -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

ARCHIVAL_FILE="$DEST_DIR/logs_archive-$TIMESTAMP.tar.gz"
tar -czvf "$ARCHIVAL_FILE" $FILES

if [ $? -eq 0 ]; then
        echo "ARCHIVAL is ...SUCCESS"
        while IFS= read -r FILE
        do
            echo "file is $FILE"
                  rm -rf $FILE
            echo "files $FILE deleted"
        done <<< "$FILES"
    else
        echo "ERROR ARCHIVAL is ...FAILED"
fi
