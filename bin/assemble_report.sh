DIRECTORY=$1

TEMPFILE="$(mktemp /tmp/TEMP.XXXXXXXXX)"

cd "$DIRECTORY" || exit

cat country_dist.html hours_dist.html username_dist.html > "$TEMPFILE"

cd ..

./bin/wrap_contents.sh "$TEMPFILE" ./html_components/summary_plots "$DIRECTORY"/failed_login_summary.html

rm "$TEMPFILE"
