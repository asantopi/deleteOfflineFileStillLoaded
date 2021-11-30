#!/bin/bash
# 2021-11-30 - v1.0.0
filename=$1
while read line; do
	filename_xml=$(echo $line | grep -oE '\bTIBCO_PRODUCTMODELOffline_[^\s<>]*?.xml\b')
	#echo "Filename " $filename_xml
	if [ -z "$filename_xml" ]; then
		#Empty String
		printf "."
	else
		#File name presente
		#echo "Found - " $filename_xml
		#Cerchiamo se la prossima linea contiene la descrizione di success!
		#Se success allora il file deve essere cancellato altrimenti no!
		read line
		ips=$(echo $line | grep -oE '[^$\s]*is published successfully[^$\s]*')
		if [ -z "$ips" ]; then
			#Non è stato pubblicato correttamente
			printf "\n"
			echo "il file $filename_xml non è stato pubblicato correttamente e non lo cancelliamo"
		else
			echo $filename_xml >>filenameToDelete.txt
		fi
		printf "."
	fi
done <$filename