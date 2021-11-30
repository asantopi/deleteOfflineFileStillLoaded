#!/bin/bash
# 2021-11-30 - v1.0.0
filename=$1
pathToFolderContainingFiles=$2
i=0
while read line; do
    # reading each line
    FILE=$pathToFolderContainingFiles/$line
    if [ -f "$FILE" ]; then
        rm -f $FILE
    else
        #printf "\n"
        echo "il file $FILE non esiste"
        echo $line >> fileNonTrovati.txt
        ((i++))
    fi
    
    #printf "."
done <$filename
echo "$i files non trovati"