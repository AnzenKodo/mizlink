#!/usr/bin/env bash
output() {
  local file=config.yaml
  echo $(yq "$1" $file)
}
links() {
  echo $(output ".links$1")
}

name=$(output .name)
description=$(output '.description')
site=$(output '.site')
length=$(expr $(links " | length"))
footer=$(output '.footer')
favicon=$(output '.favicon.url')
favicon_type=$(output '.favicon.type')
start_url=$(output '.start_url')

head() {
  cat <<-_EOF_
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <title>$name</title>
_EOF_
  return
}

redirect() {
  cat <<-_EOF_
        <meta http-equiv = "refresh" content = "0 ; url = $1"/>
      </head>
      <body>
        <h1>Redirecting to <a href="$1">$1</a></h1>
      </body>
_EOF_
  return
}

index() {
  cat <<-_EOF_
        $(head)
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="$description">
        <meta property="og:description" content="$description">
        <meta property="og:type" content="website">
        <meta property="og:image" content="$start_url/$favicon">
        <meta property="og:image:alt" content="$name logo">
        <link rel="icon" type="$favicon_type" href="$start_url/$favicon">
        <style>
          :root {
            --bg: rgb(21, 20, 27);
            --fg: rgb(237, 236, 238);
            --a: rgb(97, 255, 202);
          }
          
          body {
            font-family: ui-monospace, monospace;
            font-size: 100%;
            background: var(--bg);
            color: var(--fg);
            max-width: 40rem;
            padding: 1em;
            height: 100%;
            margin: auto;
          }
          
          header{ margin-bottom: 2em; }
          header h1 {
            margin:0;
            font-size:1.5em;
          }
          header p{
            margin:0;
            font-size:0.85em;
          }
          
          a { color: var(--a); }
          a:hover, a:focus { text-decoration: none; }
          a:active {
            background: var(--a);
            color: var(--bg);
          }
          
          ul li{
            font-size: 1.5em;
            margin-top: .5em;
            list-style: "> "
          }
          ul li::marker {
            font-size: .7em;
            color: rgb(109, 109, 109);
          }
          ul li:hover { list-style: "+ " }
          ul li a { text-decoration: none; }
          ul li a:visted { color: blue }
          
          footer {
            text-align: center;
            font-size: .9em;
          }
        </style>
      </head>
      <body>
        <header>
          <h1>$name</h1>
          <p>$description</p>
        </header>
        <main>
          <ul>
_EOF_

  for (( i=0; i < $length; i++ ))
  do
    name=$(links "[$i].name")
    url=$(links "[$i].url")

    echo "<li><a href=\"$start_url/$name.html\">$name</a></li>"
    echo $(head)$(redirect $url) >$site/$name.html
  done

  cat <<-_EOF_
        $(head)
          </ul>
        </main>
        <footer><p>$footer</p></footer>
      </body>
    </html>
_EOF_

  return
}


rm site &> /dev/null
mkdir -pv $site

cp -f $favicon $site &> /dev/null

echo $(index) > $site/index.html
echo $(index) > $site/404.html
