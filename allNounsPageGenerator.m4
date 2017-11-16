divert(-1)
include(`base.m4')

define(`m4_nounListPage',`
m4_header()

<h1>Navneord = اسم‌ها</h1>

<ul>
  m4_foreach(m4_varI,$1,`<li><a href="/fa-da/nouns/m4_unpack_arg1(m4_varI).html">m4_unpack_arg2(m4_varI)</a> (m4_unpack_arg3(m4_varI))</li>
')
</ul>

m4_footer()')

#m4_nounListPage(`(`(man,en mand,مرد)')')
divert(0)dnl
