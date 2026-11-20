#!/bin/bash

DISK_USAGE=$( df -hT | grep -v Filesystem )
USAGE_THRESHOLD=10

while IFS= read -r line
do
    USAGE=$( echo $line | cut -d "%" -f1 | awk '{print $6}')
    PARTITION=$( echo $line | awk '{print $7}')
    if [ $USAGE -ge $USAGE_THRESHOLD ]; then
        MESSAGE+="high disk usage on $PARTITION: $USAGE \n"
    fi

done <<< "$DISK_USAGE"

echo -e "$MESSAGE"