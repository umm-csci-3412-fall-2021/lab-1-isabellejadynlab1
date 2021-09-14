#!/bin/bash

# Arguement needed is a directory
DIRECTORY=$1

# Changes directory in to the directory given and then in to /var/log
cd "$DIRECTORY"/var/log || exit

# cat is used to gatehr the contents of all the log files needed and pipes them to awk
# awk is used to extract the correct information needed
# and then prints out the necessary groups
cat ./* | awk 'match($0, /([a-zA-Z]{3} [ 0-9]{2}) ([0-9]{2})[0-9:]+ [a-zA-Z]+.+ Failed password .+ ([a-zA-Z0-9 ]+) from ([0-9.]+)/, groups) {print groups[1] " " groups[2] " " groups[3] " " groups[4]}' | sed 's/  / /' > failed_login_data.txt

#Moves failed_login_data.txt out of two directories
mv failed_login_data.txt ../../
