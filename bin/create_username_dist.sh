#!/bin/bash

# Takes a directory as an arguement and stores it for later use.
DIRECTORY=$1

#stores the orginal directory we call the program in for later use.
ORIGINALDIRECTORY=$(pwd)

# Create a temporary temp file to store data in.
TEMPFILE="$(mktemp /tmp/TEMP.XXXXXXXXX)"

# changes directory into the directory given as an arguement, and exits the program if directory does not exist.
cd "$DIRECTORY" || exit

# Using awk, we are able to print out the 4th string in each line of the failed_login_data file.
# Then we sort the file, count each time a user is on the file (using uniq -c). Then we reformat
#file by using awk print to insert the user name and the amount of times the user shows up
#into data.addRow(['USER', NUMBER]) and then puts that in to the temp file.
cat ./*/failed_login_data.txt | awk '{print $4}' | sort | uniq -c | awk '{print("data.addRow([\x27"$2"\x27, "$1"]);")}' > "$TEMPFILE"

# changes directory back to the original directory
cd "$ORIGINALDIRECTORY" || exit

# Runs the wrap_contents
./bin/wrap_contents.sh "$TEMPFILE" html_components/username_dist "$DIRECTORY"/username_dist.html

rm "$TEMPFILE"
