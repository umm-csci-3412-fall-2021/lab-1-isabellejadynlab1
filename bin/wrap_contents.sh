#!/bin/bash

# The arguements needed to run the program
FILENAME=$1
NAME=$2
RESULTFILE=$3

# Create names for the name header and name footer
NAMEHEADER="$NAME"_header.html
NAMEFOOTER="$NAME"_footer.html

#Copy contents of NAME_header to RESULTFILE
cat "$NAMEHEADER"  > "$RESULTFILE"

#Copy contents of FILENAME to RESULTFILE
cat "$FILENAME" >> "$RESULTFILE"

#Copy contents of NAME_footer to RESULTFILE
cat "$NAMEFOOTER"  >> "$RESULTFILE"
