#!/bin/bash
if [ "-h" = "$1" -o "--help" = "$1" ]; then
	echo -e	"
Usage: ./generateNounPage.sh KEY [output_folder] [inflection_file] 
       [examples_file]

    KEY: 
         A mandatory, all-uppercase key used for looking up the word in the
         inflections file and the examples file

    output_folder:
         An optional output folder. If none is specified, output to \"nouns/\"

	inflection_file:
         An optional csv file in which the following columns must be defined 
         in the top:
           - key: An all-caps identity of the noun
           - foreign-sg: The foreign language singular form of the noun
           - da-sg-i: The Danish singular indefinite form of the noun
           - da-sg-d: The Danish singular definite form of the noun
           - da-pl-i: The Danish plural indefinite form of the noun
           - da-pl-d: The Danish plural definite form of the noun

    examples_file:
         An optional lst file in which the following columns must be defined
         in the top:
           - key: An all-caps identity of the noun
           - da: Danish example sentence using the noun

    Examples:

        Generate a noun page \"man.html\" in the \"nouns\" folder:
        ~$ ./generateNounPage.sh MAN

        Generate a noun page \"man.html\" in the \"myNouns\" folder:
        ~$ ./generateNounPage.sh MAN myNouns

        Generate a noun page \"man.html\" in the \"nouns\" folder using
        the inflection file \"danishNouns.csv\" and the examples file 
        \"funnySentences.csv\":
        ~$ ./generateNounPage.sh MAN nouns danishNouns.csv funnySentences.csv

"	
	exit 99;
fi

if [ -z "$1" ]; then
	echo "Key word is missing"
	exit 1;
fi

key="$1"
outputDir="$2"
nounsFile="nouns.csv"
examplesFile="nounExamples.csv"
referencesFile="references.lst"
nounReferencesFile="nounReferences.lst"

if [ -z "$outputDir" ]; then
	outputDir="out"
fi

if ! [ -d "$outputDir" ]; then
	
	mkdir "$outputDir"
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

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
	grep "^$pKey" $pFile || echo ""
	
}

# function get-references-from-file {
# 	pFile="$1"
# 	pKey="$2"
# 	refs=$(grep -w $pKey $pFile || echo "")
# 	if [ "$refs" != "" ]; then
# 		refs=$(echo $refs | tr ' ' ',' | tr ',' "\n" | sort -u | tr '\n' ';' | sed -e 's/\(.*\);$/\1/' -e "s/;/',\`/g")
# 		refs=$(echo "\`(\`$refs')'")
# 	fi
	
# 	echo "$refs"
# }

# function create-sorted-copy {
# 	pFile="$1"
# 	pKeepHeader="$2" # 1 or 0
# 	pTmpFile=$(tempfile)
# 	tail -n +2 | sort -u $pFile > $pTmpFile
# 	echo "$pTmpFile"
# }

# function get-references-from-file {
#     pRefFile="$1"
# 	sortedNouns=$(create-sorted-copy $nounsFile)
# 	sortedRefs=$(create-sorted-copy $pRefFile)
	
# 	join -t ';' $sortedNouns $sortedRefs -1 1 -2 1 
# }

function get-references-from-file {
	pRefsFile="$1"
	pKey="$2"
	t1=$(tempfile)
	t2=$(tempfile)
	grep $pKey "$pRefsFile" | tr ',' '\n' | sort -u > "$t1"
	tail -n +2 $nounsFile | sort -u > "$t2"
	
	result=$(join $t1 $t2 -1 1 -2 1 -t ';' | cut -d ';' -f1,4)
	rm $t1 $t2
	echo "$result" | tr '[:upper:]' '[:lower:]'
}

function format-reference-list {
	refList=$1
	echo "\`("$(echo "$refList" | sed -e "s/;/',\`/g" -e "s/^\(.*\)$/\`(\`\1')'/g" | tr '\n' ',')")'"
}

function get-references {
	pKey="$1"
	nounRefs=$(format-reference-list "$(get-references-from-file "nounReferences.lst" $pKey)")
	#nouns, verbs, adjectives, phrases, lessons
	echo "\`(""$nounRefs"")'"
}

foreignWord=$(get-foreign-word $nounsFile $key)
inflections=$(get-inflections $nounsFile $key)
examples=$(get-examples $examplesFile $key)
examplesArg=","

if [ "$examples" != "" ]; then
	# todo: It assumes the order of the example columns. 
	exampleLines=$(echo "$examples" | sed -e "s/^[^;]*;\([^;]*\);\(.*\)$/\`(\`\2',\`\1')'/")
	for i in "$exampleLines"; do
		examplesArg=$(echo "\`($i)'" | tr '\n' ',')
	done
fi

# todo: Read references

references=$(get-references $key)

fileName=$(echo $key | tr '[:upper:]' '[:lower:]' | tr ' ' '_')".html"
echo "include(nounPageGenerator.m4) m4_nounTemplate($foreignWord,$inflections,$examplesArg $references)" | m4 > $outputDir/$fileName

#echo "include(nounPageGenerator.m4) m4_nounTemplate($foreignWord,$inflections,$examplesArg $references)"

exit 0 
