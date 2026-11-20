#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=10

while IFS= read -r LINE
do
    USAGE=$(echo $LINE | cut -d "%" -f1 | awk '{print $6}')
    PARTITION=$(echo $LINE | awk '{print $7}')
    if [ $USAGE -ge $USAGE_THRESHOLD ]; then
        MESSAGE+="High disk usage on $PARTITION: $USAGE \ n"
    fi

done <<< "$DISK_USAGE"

echo "$MESSAGE"