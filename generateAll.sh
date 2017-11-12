#!/bin/bash

outputDir="generated/"

# clean up
rm -rf generated
mkdir generated

if [ $? -gt 0 ]; then exit $?; fi

# create all noun pages
./createAllNounPages.sh $outputDir

# create one allNouns page
./createAllNounsPage.sh $outputDir

# create all verb pages
#./createAllVerbPages.sh

# create one allVerb page
#./createAllVerbsPage.sh

# create all adjective pages
#./createAllAdjectivePages.sh

# create one allAdjectives page
#./createAllAdjectivePages.sh

# create all phrase pages
#./createAllPhrasePages.sh

# create one allPhrases page
#./createAllPhrasesPage.sh

# create all lesson pages
#./createAllLessonPages.sh

# create one allLessons page
#./createAllLessonsPage.sh

# create index page
./createIndexPage.sh $outputDir
