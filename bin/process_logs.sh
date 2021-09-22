#!/bin/bash

# stores the original directory
ORIGINALDIRECTORY=$(pwd)

# Creates a temporary directory.
TEMPDIRECTORY="$(mktemp -d)"

# Runs through all files that were given as arguments 
# decompresses the .tgz files given, stores them to
# the temporary directory. Then we run those files
# through process client logs.
for file in "$@"; do 
	name="$(basename "$file" .tgz)"
	mkdir "$TEMPDIRECTORY"/"$name"
	tar -xzf "$file" -C "$TEMPDIRECTORY"/"$name"	
	./bin/process_client_logs.sh "$TEMPDIRECTORY"/"$name"
done

# Runs the programs create_username, create_hours
# create_country and assemble_report with the
# temporary directory as the argument.
./bin/create_username_dist.sh "$TEMPDIRECTORY"

./bin/create_hours_dist.sh "$TEMPDIRECTORY"

./bin/create_country_dist.sh "$TEMPDIRECTORY"

./bin/assemble_report.sh "$TEMPDIRECTORY"

# Moves failed_login_summary.html to the original directory.
mv "$TEMPDIRECTORY"/failed_login_summary.html "$ORIGINALDIRECTORY"

# Removes the temporary directory.
rm -r "$TEMPDIRECTORY"
