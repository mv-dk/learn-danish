#!/bin/bash

outputDir="$1"
outputFileName="index.html"

if [ -z $outputDir ]; then
	outputDir="./"	
fi

m4 templates/index.htmlt > "$outputDir/$outputFileName"  

exit 0
