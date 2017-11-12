include(`forloop.m4')
include(`foreach.m4')

#m4_arg1 is already defined in foreach.m4
define(`m4_arg2',`$2')
define(`m4_arg3',`$3')
define(`m4_arg4',`$4')
define(`m4_arg5',`$5')

define(`m4_header',`<!DOCTYPE html>
<html lang="fa">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<title>دنمرکی</title>
<link rel="stylesheet" href="/fa-da/style.css" type="text/css" />
<script src="/fa-da/scripts/filter.js"></script>
<script src="/fa-da/scripts/common.js"></script>
<script src="/fa-da/scripts/play.js"></script>
<script src="/fa-da/scripts/tables.js"></script>
<script src="/fa-da/scripts/md.js"></script>
</head>
<body>')

define(`m4_footer',`</body></html>')

define(`m4_soundLink',`<img src="/fa-da/images/speaker.svg" class="speakerIcon" onclick="play(\"$1\")" />')

define(`m4_noun_link',`<a href="/fa-da/noun/`$1'">`$2'</a>')
define(`m4_verb_link',`<a href="/fa-da/verb/`$1'">`$2'</a>')
