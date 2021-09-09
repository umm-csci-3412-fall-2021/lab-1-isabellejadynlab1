#!/bin/bash

DIRECTORY=$1

cd ../"$DIRECTORY"/var/log


cat * > allLogs.txt
cat allLogs.txt

#awk 'match($0,/([a-zA-Z] {3}, [0-9] {2}, [0-9] {2}).+ Failed password .+ ([a-zA-z]).+ from .+ ([0-9].)  

