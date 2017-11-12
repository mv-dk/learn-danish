#!/bin/bash

templateDir="$1"
outputDir="$2"


if [ -z "$1" ]; then
	templateDir="lessons/"
fi
if [ -z "2" ]; then
	outputDir="lessons/"
fi

for f in $(ls $templateDir/*.htmlt); do
	m4 $f > $outputDir/$(basename -s ".htmlt" $f).html
done

exit 0
