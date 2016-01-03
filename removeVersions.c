#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sqlite3.h>

void removeVersion(char *filename)
{
	int foundDash = 0;

	while (*filename != '\0')
	{
		if ((!isalpha(*filename)) && (*filename != '-'))
		{
			if (foundDash == 1)
			{
				*filename = '\0';
				if (*(filename-1) == '-')
				{
					*(filename-1) = '\0';
				}
				return;
			}
		}

		if (*filename == '-')
		{
			foundDash = 1;
		}

		filename++;
	}
}

static int process_row(void *NotUsed, int argc, char **argv, char **azColName)
{
	char *stripped;
	stripped = (char *)malloc(2048);
	strlcpy(stripped, argv[0], 2048);
	removeVersion(stripped);
	printf("update ports set port_name='%s' where port_name='%s';\n", stripped, argv[0]);
	free(stripped);

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

	rc = sqlite3_exec(db, "select port_name from ports order by port_name;", process_row, 0, &zErrMsg);
	if (rc!=SQLITE_OK)
	{
		fprintf(stderr, "SQL error: %s\n", zErrMsg);
		sqlite3_free(zErrMsg);
	}

	sqlite3_close(db);
	return(0);
}
