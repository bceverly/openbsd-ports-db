#! /bin/sh

echo 'Updating dependencies for all ports...'

while read line
	do ./findDependencies.sh $line
done <all-ports.txt

./removeVersions >fixit.txt
sort -u fixit.txt > fixit2.txt
sqlite3 ports.db -init fixit2.txt '.quit'
rm fixit.txt fixit2.txt
