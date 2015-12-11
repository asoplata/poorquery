#!/bin/bash

RESOLUTIONX='600px'
RESOLUTIONY='400px'

QUERY=$1
PATH_QUERY="${PWD}/$QUERY"

find $PATH_QUERY -name '*.png' -printf "%f\n" > temp1.txt
find $PATH_QUERY -name '*.png' > temp2.txt

echo 'Matches:'
cat temp2.txt

sed -e 's/^/<img src="/g' temp2.txt > temp3.txt
sed -e 's/$/" width="'${RESOLUTIONX}'" height="'${RESOLUTIONY}'" \/>/g' temp3.txt > temp4.txt

paste temp1.txt temp4.txt -d " " > temp5.md

sed -e 's/$/\n/g' temp5.md > temp6.md

pandoc -s -o poorquery_output.html temp6.md

if [ -f temp1.txt ]; then rm temp1.txt; fi
if [ -f temp2.txt ]; then rm temp2.txt; fi
if [ -f temp3.txt ]; then rm temp3.txt; fi
if [ -f temp4.txt ]; then rm temp4.txt; fi
if [ -f temp5.md  ]; then rm temp5.md ; fi
if [ -f temp6.md  ]; then rm temp6.md ; fi

echo "Now you can open 'poorquery_output.html' to see the matches."
