# Takes a directory as an arguement and stores it for later use.
DIRECTORY=$1

#stores the orginal directory we call the program in for later use.
ORIGINALDIRECTORY=$(pwd)

# Create a temporary temp file to store data in.
TEMPFILE="$(mktemp /tmp/TEMP.XXXXXXXXX)"
TEMPFILE2="$(mktemp /tmp/TEMP.XXXXXXXXX)"

# changes directory into the directory given as an arguement, and exits the program if directory does not exist.
cd "$DIRECTORY" || exit

# Using awk, we are able to print out the 5th string in each line of the failed_login_data file.
cat ./*/failed_login_data.txt | awk '{print $5}' | sort | > "$TEMPFILE"

cd "$ORIGINALDIRECTORY" || exit 

join "$TEMPFILE"./etc/country_IP_map.txt | awk '{print $2}' | sort | uniq -c | awk '{print("data.addRow([\x27"$2"\x27, "$1"]);")}' > "$TEMPFILE2"

# changes directory back to the original directory
#cd "$ORIGINALDIRECTORY" || exit

# Runs the wrap_contents
./bin/wrap_contents.sh "$TEMPFILE2" html_components/country_dist "$DIRECTORY"/country_dist.html

rm "$TEMPFILE"
rm "$TEMPFILE2"
