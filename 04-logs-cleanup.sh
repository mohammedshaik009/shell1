#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14}

if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR:: Missing parameters"
    echo "USAGE:: <source_dir> <days(optional) default to 14>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "$SOURCE_DIR source_dir does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)
echo "scanning for $SOURCE_DIR 14 days older log files"

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

while IFS= read -r FILE
do
    echo "files is $FILE"
        rm -rf $FILE
    echo "files to be deleted: $FILE"

done <<< "$FILES"