# !/bin/bash

echo "Which website you redirect?"
read website_url

website_file=$(echo $website_url | cut -f 1 -d '.')

main() {
	cat <<-_EOF_
		<!DOCTYPE html>
		<html lang="en">
		<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>HTML Redirect Website</title>
		<link rel="icon" type="image/png" href="logo.png" />
	_EOF_
	return
}

redirect() {
	cat <<-_EOF_
		$(main)
		<meta http-equiv = "refresh" content = "0 ; url = https://$website_url"/>
		</head>
	_EOF_

}
echo $(redirect) >sites/$website_file.html

index() {
	cat <<-_EOF_
		$(main)
		<style>
		body {
		font-family: sans-serif;
		max-width: 30em;
		margin: 1em auto;
		text-align: center;
		background: #ecf0f1;
		color: #2c3e50;
		}
		a {
		font-size: 1.5em;
		background: #8e44ad;
		color: #ecf0f1;
		padding: .2em;
		text-decoration: none;
		}
		</style>
		</head>
		<body>
		<h1>HTML Redirect Website</h1>
	_EOF_

	for i in sites/*.html; do
		cat <<-_EOF_
			<a href="$i">$(echo "$website_file" | sed 's/.*/\u&/')</a>
		_EOF_
	done

	cat <<-_EOF_
		</body>
		</html>
	_EOF_
	return
}

echo $(index) >index.html