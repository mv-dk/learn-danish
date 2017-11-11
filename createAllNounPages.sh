#!/bin/bash

outputDir="$1"

if [ -z "$1" ]; then
	outputDir="nouns/"
fi

for key in $(tail -n +2 nouns.csv | cut -f 1 -d';'); do
	./createNounPage.sh $key "$outputDir"
done

exit 0
