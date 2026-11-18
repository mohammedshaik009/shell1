#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14} #default to 14 days

if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR:: Missing Parameters"
    echo "USAGE:: $0 <source_dir> <days(optional default to 14)>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "$SOURCE_DIR source _dir does not exist"
    exit 1
fi

FILES=$(find "$SOURCE_DIR" -type f -name "*.log" -mtime +$DAYS)
echo "scaninng for $SOURCE_DIR log files older than 14 days"

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

while IFS= read -r FILE
do
    echo "file is $FILE"
    rm -rf $FILE
    echo "$FILES files deleted"

done <<< "$FILES"