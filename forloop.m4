# this is not working properly
# define(`m4_forloop',`ifelse(eval(`$2<$3'),`1',`$0_helper($1,$2,$3,$4)',`')')
# define(`m4_forloop_helper',`pushdef(`$1',`$2')$4`'ifelse(eval(`$2>=$3'),`1',popdef(`$1'),`$0(`$1',incr(`$2'),`$3',`$4')popdef(`$1')')')

# this is from the gnu book
define(`m4_forloop_arg', `ifelse(eval(`($1) <= ($2)'), `1',
  `m4__forloop(`$1', eval(`$2'), `$3(', `)')')')
# forloop(var, from, to, stmt) - refactored to share code
define(`m4_forloop', `ifelse(eval(`($2) <= ($3)'), `1',
  `pushdef(`$1')m4__forloop(eval(`$2'), eval(`$3'),
    `define(`$1',', `)$4')popdef(`$1')')')
define(`m4__forloop',
  `$3`$1'$4`'ifelse(`$1', `$2', `',
    `$0(incr(`$1'), `$2', `$3', `$4')')')
