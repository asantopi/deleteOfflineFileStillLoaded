#!/bin/bash
# 2021-11-30 - v1.0.0
# @author P4F
filename=$1
while read line; do
	filename_xml=$(echo $line | grep -oE '\bTIBCO_PRODUCTMODELOffline_[^\s<>]*?.xml\b')
	if [ -z "$filename_xml" ]; then
		# Empty String
		printf "."
	else
		# File name found
		# echo "Found - " $filename_xml
		# Find if in the next line there is the phrase "is published successfully"
		# If is present the file name can go in the list of deletion files. Otherwise print that the file is not published correctly a will not be deleted.
		read line
		ips=$(echo $line | grep -oE '[^$\s]*is published successfully[^$\s]*')
		if [ -z "$ips" ]; then
			# File not correctly published
			printf "\n"
			echo "The file $filename_xml is not correctly published. It will not be deleted."
		else
			echo $filename_xml >>xmlFileToDelete.txt
		fi
		printf "."
	fi
done <$filename
