#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
FILE1=$1

FILESIZE=$(wc -c < "$FILE1")
#echo $FILESIZE

if [ $FILESIZE -ge 5120 ]; then
    echo "this file is so BIG! : ($FILESIZE Byte)"
else
    echo "this file is so small! : ($FILESIZE Byte)"
fi