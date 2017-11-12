#!/bin/bash

outputDir="generated/fa-da"
templateDir="templates"
thisScriptDir=$(pwd)
# clean up
rm -rf "$outputDir"
mkdir -p "$outputDir"
cd "$outputDir"
find "$thisScriptDir"/templates/* -type d | awk -F'/' '{print $NF}' | xargs mkdir
result=$?
cd "$thisScriptDir"
if [ $result -gt 0 ]; then exit $result; fi

result=0

# create all noun pages
./createAllNounPages.sh $outputDir/nouns

# create one allNouns page
./createAllNounsPage.sh $outputDir

# create all verb pages
#./createAllVerbPages.sh $outputDir/verbs

# create one allVerb page
#./createAllVerbsPage.sh

# create all adjective pages
#./createAllAdjectivePages.sh $outputDir/adjectives

# create one allAdjectives page
#./createAllAdjectivePages.sh

# create all phrase pages
#./createAllPhrasePages.sh $outputDir/phrases

# create one allPhrases page
#./createAllPhrasesPage.sh

# create all lesson pages
#./createAllLessonPages.sh $outputDir/lessons

# create one allLessons page
#./createAllLessonsPage.sh

cp $templateDir/style.css "$outputDir/"
cp -r $templateDir/images "$outputDir/"
cp -r $templateDir/audio "$outputDir/"
cp -r $templateDir/video "$outputDir/"
cp -r $templateDir/scripts "$outputDir/"

# create index page
./createIndexPage.sh $outputDir
