include(`forloop.m4')
include(`foreach.m4')

define(`m4_host',`https://paje.dk')
define(`m4_imgs',`m4_host/fa-da/images')

#m4_arg1 is already defined in foreach.m4
define(`m4_arg2',`$2')
define(`m4_arg3',`$3')
define(`m4_arg4',`$4')
define(`m4_arg5',`$5')

# if $1 = ((a,b)) return a
define(`m4_unpack_arg1',`m4_arg1'm4_arg1$1)
# if $1 = ((a,b)) return b
define(`m4_unpack_arg2',`m4_arg2'm4_arg1$1)
# etc
define(`m4_unpack_arg3',`m4_arg3'm4_arg1$1)
define(`m4_unpack_arg4',`m4_arg4'm4_arg1$1)
define(`m4_unpack_arg5',`m4_arg5'm4_arg1$1)

define(`m4_topBar',`
<div id="topBar"><a href="..">&larr; Tilbage</a></div>
')

define(`m4_header',`<!DOCTYPE html>
<html lang="fa">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<title>دنمرکی</title>
<link rel="stylesheet" href="m4_host/fa-da/style.css" type="text/css"">
<link href="https://fonts.googleapis.com/css?family=Noto+Serif" rel="stylesheet"> 
<script src="m4_host/fa-da/scripts/filter.js"></script>
<script src="m4_host/fa-da/scripts/common.js"></script>
<script src="m4_host/fa-da/scripts/play.js"></script>
<script src="m4_host/fa-da/scripts/tables.js"></script>
<script src="m4_host/fa-da/scripts/md.js"></script>
</head>
<body>
m4_topBar
')

define(`m4_footer',`</body></html>')

define(`m4_soundLink',`<img src="m4_host/fa-da/images/speaker.svg" class="speakerIcon" onclick="play(&quot;$1&quot;)" />')

define(`m4_noun_link',`<a href="m4_host/fa-da/noun/`$1'">`$2'</a>')
define(`m4_verb_link',`<a href="m4_host/fa-da/verb/`$1'">`$2'</a>')

define(`m4_ddg_image_link',`<p><img class="ddgImageLink" src="m4_imgs/ddg_image_link.svg" />&nbsp;&nbsp;<a href="https://duckduckgo.com/?q=$1&t=hj&iax=images&ia=images">Billeder af $2</a></p>')

define(`m4_youtube_link',`<p><img class="youtubeLink" src="m4_imgs/youtube_link.svg" />&nbsp;&nbsp;<a href="https://www.youtube.com/watch?v=$1">$2</a></p>')
