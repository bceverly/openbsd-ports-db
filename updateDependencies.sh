#! /bin/sh

echo 'Updating dependencies for all ports...'

while read line
	do ./findDependencies.sh $line
done <all-ports.txt

