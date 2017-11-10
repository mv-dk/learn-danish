#!/bin/bash

for key in $(tail -n +2 nouns.csv | cut -f 1 -d';'); do
	./createNounPage.sh $key nouns/
done

exit 0
