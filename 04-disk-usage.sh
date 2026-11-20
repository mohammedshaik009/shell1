#!/bin/bash

DISK_USAGE=$(df -hT | grep Filesystem)

echo "disk usage is :$DISK_USAGE"