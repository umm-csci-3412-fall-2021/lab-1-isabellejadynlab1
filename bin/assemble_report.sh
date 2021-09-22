#!/bin/bash

# Takes a directory as an arguement.
DIRECTORY=$1
OLDPATH=$(pwd)

#Creates a temporary file for us to store
#the contents of other files.
TEMPFILE="$(mktemp /tmp/TEMP.XXXXXXXXX)"

#Changes into the directory given as the arguement
#exits the program if that directory does not exist.
cd "$DIRECTORY" || exit

#Copying the information from country_dist, hour_dist,
#and username_dist into the temp file.
cat country_dist.html hours_dist.html username_dist.html > "$TEMPFILE"

#Moves up a directory.
cd "$OLDPATH" || exit

#Uses wrap_contents to merge together the tempfile with the summary plots
#header and footer, than saves it to failed_login_summary.
./bin/wrap_contents.sh "$TEMPFILE" html_components/summary_plots "$DIRECTORY"/failed_login_summary.html

#Removes the temp file.
rm "$TEMPFILE"
