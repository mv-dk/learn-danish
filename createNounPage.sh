#!/bin/bash

if [ "-h" = "$1" -o "--help" = "$1" ]; then
	echo -e	"
Usage: ./createNounPage.sh KEY output_folder
--------------------------------------------------------------------------------
    KEY: a mandatory, all-uppercase key used for looking up the word in the
         inflections file and the examples file

    Example: ./createNounPage.sh MAN nouns
	     This will generate a noun page \"man.html\" in the \"nouns\" folder 
"	
	exit 99;
fi

if [ -z "$1" ]; then
	echo "Key word is missing"
	exit 1;
fi

key="$1"
outputFolder="$2"
nounsFile="nouns.csv"
examplesFile="nounExamples.csv"

function get-inflections {
	pFile="$1"
	pKey="$2"

	pRow=$(get-row-with-key $pFile $pKey)
	pSgiIdx=$(get-column-field $pFile "da-sg-i") #singular indefinite
	pSgdIdx=$(get-column-field $pFile "da-sg-d") #singular definite
	pPliIdx=$(get-column-field $pFile "da-pl-i") #plural indefinite
	pPldIdx=$(get-column-field $pFile "da-pl-d") #plural definite

	pSgi=$(echo $pRow | cut -f $pSgiIdx -d';')
	pSgd=$(echo $pRow | cut -f $pSgdIdx -d';')
	pPli=$(echo $pRow | cut -f $pPliIdx -d';')
	pPld=$(echo $pRow | cut -f $pPldIdx -d';')
	echo "\`$pSgi',\`$pSgd',\`$pPli',\`$pPld'"
}

function get-foreign-word {
	pFile="$1"
	pKey="$2"

	pRow=$(get-row-with-key $pFile $pKey)
	pForeignIdx=$(get-column-field $pFile "foreign-sg") #singular indefinite

	pForeignWord=$(echo $pRow | cut -f $pForeignIdx -d';')
	echo "\`$pForeignWord'"
}

# 1-indexed
function get-column-field {
	pFile="$1"
	pColumnName="$2"
	#key;fa-sg;fa-pl;da-sg-i;da-sg-d;da-pl-i;da-pl-d
	pLine=$(head -n1 "$pFile")
	if [ $(echo $pLine | grep -c $pColumnName) -eq 0 ]; then
		echo -1
	else
		head -n1 "$pFile" | sed -e "s/$pColumnName.*$//" -e "s/;/\n/g" | wc -l
	fi
}

function get-row-with-key {
	pFile="$1"
	pKey="$2"
	grep "^$pKey" $pFile
}

function get-examples {
	pFile="$1"
	pKey="$2"
	grep "^$pKey" $pFile
}

foreignWord=$(get-foreign-word $nounsFile $key)
inflections=$(get-inflections $nounsFile $key)
examples=$(get-examples $examplesFile $key)
exampleLines=$(echo "examples: $examples" | sed -e "s/^[^;]*;\([^;]*\);\(.*\)$/\`(\`\2',\`\1')'/")
examplesArg=""
for i in "$exampleLines"; do
	examplesArg=$(echo "\`($i)'" | tr '\n' ',')
done

fileName=$(echo $key | tr '[:upper:]' '[:lower:]' | tr ' ' '_')".html"
echo "include(nounPageGenerator.m4) m4_nounTemplate($foreignWord,$inflections,$examplesArg)" | m4 > $outputFolder/$fileName

exit 0 
