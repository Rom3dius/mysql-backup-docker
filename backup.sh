#!/bin/sh
# Dump the MySQL database
mysqldump -h $MYSQL_HOST -u $MYSQL_USER --single-transaction --quick --routines --triggers --events --all-databases > backup.sql

# Backup the dump using Restic
restic -r $RESTIC_REPOSITORY backup backup.sql --password-file <(echo $RESTIC_PASSWORD)

# Delete old files
restic forget --keep-within $RESTIC_FORGET --prune --password-file <(echo $RESTIC_PASSWORD)
