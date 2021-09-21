GIVENFILE=$1

TEMPDIRECTORY="$(mktemp -d)"

for file in "$GIVENFILE"; do 
	name="$(basename "$file" secure.tgz)"
	mkdir "$TEMPDIRECTORY"/"$name"
	tar -xzf "$file" -C "$TEMPDIRECTORY"/"$name"
	bin/process_client_logs.sh "$TEMPDIRECTORY"/"$name"
done

bin/create_username_dist.sh "$TEMPDIRECTORY"

bin/create_hours_dist.sh "$TEMPDIRECTORY"

bin/create_country_dist.sh "$TEMPDIRECTORY"

bin/assemble_report.sh "$TEMPDIRECTORY"

cp "$TEMPDIRECTORY"/failed_login_summary.html ./failed_login_summary.html
