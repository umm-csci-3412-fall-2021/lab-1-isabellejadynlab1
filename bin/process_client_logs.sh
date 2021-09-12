#!/bin/bash

DIRECTORY=$1

cd "$DIRECTORY"/var/log/secure

cat * | awk 'match($0, /([a-zA-Z]{3} [ 0-9]{2}) ([0-9]{2})+ Failed password for +
if( index(10,invalid user)
	invalid user + ([a-zA-Z]) +)
else 
	([a-zA-z])+)
	from + ([0-9.]){12}, groups) {print groups[1] " " groups[2] " " groups[3] ' > failed_login_data.txt  

