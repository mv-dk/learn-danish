#!/bin/bash

outputFolder="$1"
outputFileName="index.html"

if [ -z $outputFolder ]; then
	outputFolder="./"	
fi

head -n1 nouns.csv > nouns.csv.tmp
tail -n+2 nouns.csv | sort -t';' -k5 >> nouns.csv.tmp
allNouns=$(echo "\`(" $(awk -F';' -v q="'" 'BEGIN{OFS=","} NR>1 {print "`(`"tolower($1)q,"`"$4q,"`"$2q")"q}' nouns.csv.tmp | paste -sd',')")'")
#rm nouns.csv.tmp
#echo "allNouns:"
#echo "$allNouns"
#echo "----"

echo "include(\`allNounsPageGenerator.m4') m4_nounListPage(\`$allNouns')" | m4 > "$outputFolder/$outputFileName"

exit 0
