#include <stdio.h>
#include <string.h>
#include <sqlite3.h>

void removeVersion(char *filename)
{
	int i;
	char *ptr;

	i = strlen(filename);
	ptr = filename + i - 1 - 4;

	while (ptr > filename)
	{
		if ((*ptr != '0') &&
			(*ptr != '1') &&
			(*ptr != '2') &&
			(*ptr != '3') &&
			(*ptr != '4') &&
			(*ptr != '5') &&
			(*ptr != '6') &&
			(*ptr != '7') &&
			(*ptr != '8') &&
			(*ptr != '9') &&
			(*ptr != 'p') &&
			(*ptr != '.') &&
			(*ptr != '-') &&
			(*ptr != '.'))
		{
			*(ptr + 1) = '\0';
			return;
		}
		ptr--;
	}
}

static int process_row(void *NotUsed, int argc, char **argv, char **azColName)
{
	removeVersion(argv[0]);
	printf("%s\n", argv[0]);
	return(0);
}

int main(int argc, char **argv)
{
	sqlite3 *db;
	char *zErrMsg = 0;
	int rc;

	rc = sqlite3_open("ports.db", &db);
	if (rc != 0)
	{
		fprintf(stderr, "Can't open ports.db database: %s\n", sqlite3_errmsg(db));
		sqlite3_close(db);
		return(1);
	}

	rc = sqlite3_exec(db, "select port_name from ports where processor='amd64'order by port_name;", process_row, 0, &zErrMsg);
	if (rc!=SQLITE_OK)
	{
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
	}

	sqlite3_close(db);
	return(0);
}
