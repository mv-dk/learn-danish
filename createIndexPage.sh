#!/bin/bash

outputFolder="$1"
outputFileName="index.html"

if [ -z $outputFolder ]; then
	outputFolder="./"	
fi

m4 templates/index.htmlt > "$outputFolder/$outputFileName"  

exit 0
