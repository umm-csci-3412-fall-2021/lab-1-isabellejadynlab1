#!/bin/bash

# Takes a directory as an arguement and stores it for later use.
DIRECTORY=$1

#stores the orginal directory we call the program in for later use.
ORIGINALDIRECTORY=$(pwd)

# Create a temporary temp file to store data in.
TEMPFILE="$(mktemp /tmp/TEMP.XXXXXXXXX)"
TEMPFILE2="$(mktemp /tmp/TEMP2.XXXXXXXXX)"

# changes directory into the directory given as an arguement, and exits the program if directory does not exist.
cd "$DIRECTORY" || exit

# Using awk, we are able to print out the 5th string (IP address) in each line of the failed_login_data file.
cat ./*/failed_login_data.txt | awk '{print $5}' | sort > "$TEMPFILE"

#Changes back to the original directory.
cd "$ORIGINALDIRECTORY" || exit 

#We join our temp file containing the IP addresses and another file containing what country those files are from.
#Then using awk, we take the second string (The abbreviation of the country), sort them, count them, and then
#add them to TEMPFILE2 using the last awk print statement.
join "$TEMPFILE" ./etc/country_IP_map.txt | awk '{print $2}' | sort | uniq -c | awk '{print("data.addRow([\x27"$2"\x27, "$1"]);")}' > "$TEMPFILE2"

# Runs the wrap_contents
./bin/wrap_contents.sh "$TEMPFILE2" html_components/country_dist "$DIRECTORY"/country_dist.html

#Removes both the temp files.
rm "$TEMPFILE"
rm "$TEMPFILE2"
