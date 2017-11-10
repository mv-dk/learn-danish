function isVerbTable(t){
	return t.getAttribute("data-type") === "verbTable";
}

function populateVerbTable(t) {
	var infinitive = t.getAttribute("data-infinitive");
	var present = t.getAttribute("data-present");
	var simplePast = t.getAttribute("data-simple-past");
	var perfectPast = t.getAttribute("data-perfect-past");
	var imperative = t.getAttribute("data-imperative");
	var participle = t.getAttribute("data-participle");
		
	var headerRow = createTableRow(["Infinitiv","Nutid/fremtid","Datid","Førnutid","Imperativ","Participium"], true);
	var contentsRow = createTableRow([
		infinitive, present, simplePast, perfectPast, imperative,participle
	].map(x => md_underscore_with_span(x,"underline")), false);

	t.appendChild(headerRow);
	t.appendChild(contentsRow);
}

var tables = document.getElementsByTagName("table");



tables.filter(t => isVerbTable(t)).forEach(t => populateVerbTable(t));

