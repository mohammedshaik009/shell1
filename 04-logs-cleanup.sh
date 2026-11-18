#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14}

if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR:: Missing parameters"
    echo "USAGE:: $0 <source_dir> <days(optional default) to 14>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "$SOURCE_DIR source_dir does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)
echo "scanning for $FILES older than 14 days"

if [ -z "$FILES" ]; then
    echo "no log $FILES files older than 14 days"
    exit 0
fi

while IFS= read -r FILE
do
    echo "file is: $FILE"
    rm -rf "$FILE"
    echo "file $FILE deleted"

done <<< "$FILES"