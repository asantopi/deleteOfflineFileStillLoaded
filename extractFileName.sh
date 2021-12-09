#!/bin/bash
# 2021-12-03 - v1.1.0
# @author P4F

# Including the Progress Bar script dependency.
my_dir="$(dirname "$0")"
. "$my_dir/utilityFunctions.sh"

filename=$1 # getting the filename from first argument
count=0 # count the line of file to pass it as first argument in the progress bar function
totalLineOfFile=$(wc -l $1 | grep -o "[0-9]\+")  # count the line of file to pass it as second argument in the progress bar function
fileNameToDelete=$(date +"%Y-%m-%d_%H%M%S")"_list_of_file_to_delete.txt" 
while read line; do
	((count++)) # increment the counter
	ProgressBar $count $totalLineOfFile # draw the progress bar
	
	# Find if in current line if there is the phrase "is published successfully"
	ips=$(echo $line | grep -oE '[^$\s]*is published successfully[^$\s]*') # ips variable stands for "is published successfully" :)
	if [ -n "$ips" ]; then
		read line
		((count++)) # increment the counter becaouse we read a new line of file
		filename_xml=$(echo $line | grep -oE '\bTIBCO_PRODUCTMODELOffline_[^\s<>]*?.xml\b')
		if [ -n "$filename_xml" ]; then
			# If is present the filename it go in the list of deletion files. Otherwise the file is not published correctly a will not go into the list of deletion files.
			echo $filename_xml >> $fileNameToDelete
		fi
	fi

done < $filename

if test -f "$fileNameToDelete"; then
    echo "File generated: " $fileNameToDelete
	echo "Now you can use the following command..."
	echo "$my_dir/deleteFileNameFromList.sh $fileNameToDelete relativeOrAbsolute/path/to/folder/withFileToDelete/"
else
	echo "No file to delete. All Is OK."
fi