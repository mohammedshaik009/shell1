#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)

echo "disk usage is :$DISK_USAGE"