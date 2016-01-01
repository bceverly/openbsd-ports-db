#! /bin/sh

site="http://openbsd.cs.toronto.edu/pub/OpenBSD/snapshots/packages/"

rm ports.db >/dev/null 2>&1

echo 'Creating sqlite3 database ports.db...'
sqlite3 -line ports.db 'create table ports(processor varchar(50), port_name text);'
sqlite3 ports.db 'create table dependencies(package text, dependency text);'

echo 'Downloading amd64 data...'
curl -s ${site}amd64/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'amd64\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

echo 'Downloading hppa data...'
curl -s ${site}hppa/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'hppa\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

echo 'Downloading i386 data...'
curl -s ${site}i386/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'i386\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

echo 'Downloading mips64 data...'
curl -s ${site}mips64/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'mips64\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

echo 'Downloading powerpc data...'
curl -s ${site}powerpc/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'powerpc\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

echo 'Downloading sparc64 data...'
curl -s ${site}sparc64/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'sparc64\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

echo 'Downloading vax data...'
curl -s ${site}vax/ | grep "<a href" | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' >file.txt
sed -e "s/^/insert into ports(processor, port_name) values (\'vax\',\'/" file.txt >file2.txt
sed -e "s/.*/&\');/" file2.txt >file3.txt

echo 'Inserting data...'
sqlite3 ports.db -init file3.txt '.quit'
rm file.txt file2.txt file3.txt >/dev/null 2>&1

# clean up the data
sqlite3 ports.db 'update ports set port_name=substr(port_name, length(port_name)/2);'
sqlite3 ports.db 'update ports set port_name=substr(port_name,3);'
sqlite3 ports.db 'delete from ports where port_name like '%gt;%';'
sqlite3 ports.db 'delete from ports where port_name like '%lt;%';'
sqlite3 ports.db 'delete from ports where port_name like '%SHA256%';'
sqlite3 ports.db 'delete from ports where port_name like '%..%';'

echo 'Generating master list of all ports...'
sqlite3 ports.db 'select port_name from ports where processor="amd64" order by port_name;' > all-ports.txt

echo 'Done loading database.'
