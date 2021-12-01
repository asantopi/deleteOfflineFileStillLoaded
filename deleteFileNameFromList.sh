#!/bin/bash
# 2021-11-30 - v1.0.0
# @author P4F
filename=$1
pathToFolderContainingFiles=$2
missing=0
deleted=0
while read line; do
    # reading each line
    FILE=$pathToFolderContainingFiles/$line
    if [ -f "$FILE" ]; then
        rm -f $FILE
        ((deleted++))
    else
        #printf "\n"
        echo "$FILE not found"
        echo $line >> fileNotFound.txt
        ((missing++))
    fi

done <$filename
echo "$missing files not found"
echo "$deleted files deleted correctly"