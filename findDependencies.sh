#! /bin/sh

echo "Finding dependencies for $1..."

pkg_info -f $1 | grep '^@depend' | cut -f 3 -d : >dependencies.txt

while read line
	do sqlite3 ports.db "insert into dependencies(package, dependency) values('$1', '$line');"
done <dependencies.txt

rm dependencies.txt >/dev/null 2>&1
