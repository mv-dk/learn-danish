# this is not working properly
# define(`m4_rest',`shift($@)')
# define(`m4_first',`$1')
# define(`m4_pushdef_do',`pushdef(`$1',`$2')$3`'popdef(`$1')')

# define(`m4_foreach_helper1',`ifelse(`',m4_first$2,`',`m4_pushdef_do(`$1',`m4_first$2',`$3')'`$0(`$1',(m4_rest$2),`$3')')')

# define(`m4_foreach',`ifelse(`',`m4_first$2',`',`m4_foreach_helper1($1,$2,$3)')')

# this is from the gnu book
#define(`m4__foreach', `ifelse(`$2', `()', `',
#  `define(`$1', m4_arg1$2)$3`'$0(`$1', (shift$2), `$3')')')

define(`m4_arg1', `$1')
define(`m4__foreach', `ifelse(`$2', `()', `',
  `pushdef(`$1', `m4_arg1$2')$3`'popdef(`$1')$0(`$1', (shift$2), `$3')')')

define(`m4_foreach', `pushdef(`$1')m4__foreach($@)popdef(`$1')')
