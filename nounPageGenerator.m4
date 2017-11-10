divert(-1)
include(`base.m4')
define(`m4_nounPageFooter',`<script src="/fa-da/scripts/nounTable.js"></script>
m4_footer()')

# $1 = Danish noun in singular indefinite form
# $2 = Singular definite
# $3 = Plural indefinite
# $4 = Plural definite
define(`m4_nounTable',`<table>
  <tr>
    <th>Ental ubestemt</th>
    <th>Ental bestemt</th>
    <th>Flertal ubestemt</th>
    <th>Flertal bestemt</th>
  </tr>
  <tr>
    <td>`$1'</td>
    <td>`$2'</td>
    <td>`$3'</td>
    <td>`$4'</td>
  </tr>
</table>')

define(`m4_nounExample',`
<li><span class="foreign">m4_arg2$1</span>
<br /><span class="danish hoverVisible">m4_arg1$1</span>
</li>')

define(`m4_nounExamples',`ifelse(`',`$1',`',
`<hr />
<h2>Eksempler</h2>
<ul>
	m4_foreach(m4_varI,$1,`m4_nounExample(m4_varI)')
</ul>')')

# Noun template page
# $1 = Foreign word
# $2 = Danish singular indefinite
# $3 = Danish singular definite
# $4 = Danish plural indefinite
# $5 = Danish plural definite
define(`m4_nounTemplate',`
m4_header()

<h1>`$2' = `$1'</h1>

m4_soundLink(translit(`$2',( ),(_)).ogg)

m4_nounTable(`$2',`$3',`$4',`$5')

m4_nounExamples(`$6')

m4_nounPageFooter')

#m4_nounTemplate(man,en mand,manden,flere mænd,alle mændene,`((ex1da,ex1fa),(ex2da,ex2fa))')
divert(0)dnl
