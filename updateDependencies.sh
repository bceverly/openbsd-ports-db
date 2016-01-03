#! /bin/sh

echo 'Updating dependencies for all ports...'

while read line
	do ./findDependencies.sh $line
done <all-ports.txt

./removeVersions >fixit.txt
sqlite3 ports.db -init fixit.txt '.quit'
rm fixit.txt
