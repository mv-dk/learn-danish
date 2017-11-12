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

# if $1 = ((a,b)) return a
define(`m4_unpack_arg1',`m4_arg1'm4_arg1$1)
# if $1 = ((a,b)) return b
define(`m4_unpack_arg2',`m4_arg2'm4_arg1$1)

define(`m4_references',`ifelse(`',`$3',`',
`
<h4>$1</h4>
<ul>
	m4_foreach(m4_varJ,$3,`<li><a href="/fa-da/$2/m4_unpack_arg1(m4_varJ).html">m4_unpack_arg2(m4_varJ)</a></li>
')
</ul>')')


# Noun template page
# $1 = Foreign word
# $2 = Danish singular indefinite
# $3 = Danish singular definite
# $4 = Danish plural indefinite
# $5 = Danish plural definite
# $6 = Example sentences
# $7 = References (5 lists: nouns, verbs, adjectives, phrases, lessons)
define(`m4_nounTemplate',`
m4_header()

<h1>`$2' = `$1'</h1>

m4_soundLink(translit(`$2',( ),(_)).ogg)

m4_nounTable(`$2',`$3',`$4',`$5')

m4_nounExamples(`$6')

<hr />
ifelse(m4_arg1$7,`',`',<h3>Referencer</h3>)
ifelse(m4_arg1$7,`',`',m4_references(`Navneord',`nouns',m4_arg1$7))
ifelse(m4_arg2$7,`',`',m4_references(`Udsagnsord',`verbs',m4_arg2$7))
ifelse(m4_arg3$7,`',`',m4_references(`Tillægsord',`adjectives',m4_arg3$7))
ifelse(m4_arg4$7,`',`',m4_references(`Udtryk',`phrases',m4_arg4$7))
ifelse(m4_arg5$7,`',`',m4_references(`Lektioner',`lessons',m4_arg5$7))

m4_nounPageFooter')

#m4_nounTemplate(man,en mand,manden,flere mænd,alle mændene,`((ex1da,ex1fa),(ex2da,ex2fa))',`(((human,et menneske),(person,en person),(father,en far)),((man,at bemande)))')
divert(0)dnl
