# openbsd-ports-db
Some sketchy shell scripts to create a sqlite3 database containing all of the 
ports (by processor) in OpenBSD along with their dependencies.  The goal is to
start with the ones that most ports depend on that aren't on some of the older
processors, fix them and get more ports available to revitilize the older ar
chitectures.

Execute ./runAll.sh to run these in sequence.  The end result will be a set of
text files for each processor architecture containing the ports that are
present in amd64 and not in that processor's package list, followed by a count
of the number of packages this one depends upon.
