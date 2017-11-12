#!/bin/bash

outputFolder="$1"
outputFileName="allNouns.html"

if [ -z $outputFolder ]; then
	outputFolder="./"	
fi

allNouns=$(echo "\`(" $(awk -F';' -v q="'" 'BEGIN{OFS=","} NR>1 {print "`(`"tolower($1)q,"`"$4q,"`"$2q")"q}' nouns.csv | paste -sd',') ")'")

echo "include(\`allNounsPageGenerator.m4') m4_nounListPage(\`$allNouns')" | m4 > "$outputFolder/$outputFileName" 

exit 0
