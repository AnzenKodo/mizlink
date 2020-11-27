# !/bin/bash

echo "Which website you redirect?"
read website_url

title="MizLink"

main() {
	cat <<-_EOF_
		<!DOCTYPE html>
		<html lang="en">
		<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>$title</title>
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
echo $(redirect) >l/$website_url.html

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
		font-size: 1.5rem;
		background: #8e44ad;
		color: #ecf0f1;
		padding: .2em;
		text-decoration: none;
		line-height: 2em;
		}
		.footer {
		background: #2c3e50;
		padding: .2em;
		color: #ecf0f1;
		font-size: 1.5rem;
		}
		.footer a {
		padding: 0em;
		background: #2c3e50;
		color: #ecf0f1;
		}
		</style>
		</head>
		<body>
		<h1>$title</h1>
	_EOF_

	for i in l/*.html; do
		cat <<-_EOF_
			<a href="$i">$(echo $i | cut -b 3-)</a>
		_EOF_
	done

	cat <<-_EOF_
		<p class="footer">@<a href="https://fillyagioro.vercel.app">Filly Agioro</a>
		| <a href="https://github.com/FillyAgioro/mizlink">Website Source</a>
		</p>
		</body>
		</html>
	_EOF_
	return
}

echo $(index) >index.html