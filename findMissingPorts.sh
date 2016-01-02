#! /bin/sh

echo 'Now extracting missing hppa ports into hppa-missing-ports.txt...'
sqlite3 ports.db -separator ',' "select port_name, ' '||cast((select count(*) from dependencies where package=port_name) as varchar(10))||' dependencies' as num_dependencies from ports where processor='amd64' and port_name not in (select port_name from ports where processor='hppa') order by num_dependencies asc, port_name;" >hppa-missing-ports.txt

echo 'Now extracting missing i386 ports into i386-missing-ports.txt...'
sqlite3 ports.db -separator ',' "select port_name, ' '||cast((select count(*) from dependencies where package=port_name) as varchar(10))||' dependencies' as num_dependencies from ports where processor='amd64' and port_name not in (select port_name from ports where processor='i386') order by num_dependencies asc, port_name;" >i386-missing-ports.txt

echo 'Now extracting missing mips64 ports into mips64-missing-ports.txt...'
sqlite3 ports.db -separator ',' "select port_name, ' '||cast((select count(*) from dependencies where package=port_name) as varchar(10))||' dependencies' as num_dependencies from ports where processor='amd64' and port_name not in (select port_name from ports where processor='mips64') order by num_dependencies asc, port_name;" >mips64-missing-ports.txt

echo 'Now extracting missing powerpc ports into powerpc-missing-ports.txt...'
sqlite3 ports.db -separator ',' "select port_name, ' '||cast((select count(*) from dependencies where package=port_name) as varchar(10))||' dependencies' as num_dependencies from ports where processor='amd64' and port_name not in (select port_name from ports where processor='powerpc') order by num_dependencies asc, port_name;" >powerpc-missing-ports.txt

echo 'Now extracting missing sparc64 ports into sparc64-missing-ports.txt...'
sqlite3 ports.db -separator ',' "select port_name, ' '||cast((select count(*) from dependencies where package=port_name) as varchar(10))||' dependencies' as num_dependencies from ports where processor='amd64' and port_name not in (select port_name from ports where processor='sparc64') order by num_dependencies asc, port_name;" >sparc64-missing-ports.txt

echo 'Now extracting missing vax ports into vax-missing-ports.txt...'
sqlite3 ports.db -separator ',' "select port_name, ' '||cast((select count(*) from dependencies where package=port_name) as varchar(10))||' dependencies' as num_dependencies from ports where processor='amd64' and port_name not in (select port_name from ports where processor='vax') order by num_dependencies asc, port_name;" >vax-missing-ports.txt
