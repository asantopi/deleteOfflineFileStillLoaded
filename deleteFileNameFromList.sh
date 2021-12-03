#!/bin/bash
# 2021-11-30 - v1.0.0
# @author P4F

# Including the Progress Bar script dependency.
my_dir="$(dirname "$0")"
. "$my_dir/utilityFunctions.sh"

filename=$1
pathToFolderContainingFiles=$2
echo $filename - $pathToFolderContainingFiles
missing=0
deleted=0
count=1 # count the line of file to pass it as first argument in the progress bar function
totalLineOfFile=$(wc -l $1 | grep -o "[0-9]\+")  # count the line of file to pass it as second argument in the progress bar function
while read line; do
    ProgressBar $count $totalLineOfFile # draw the progress bar
    ((count++)) # increment the counter
    # reading each line
    FILE=$pathToFolderContainingFiles/$line
    if [ -f "$FILE" ]; then
        rm -f $FILE
        ((deleted++))
    else
        #printf "\n"
        #echo "$FILE not found"
        echo $line >> fileNotFound.txt
        ((missing++))
    fi
done <$filename

echo " "
echo "$missing files not found"
echo "$deleted files deleted correctly"
filesStillTobePublished=$(ls -l $pathToFolderContainingFiles | wc -l)
echo $filesStillTobePublished " needs to be published." 