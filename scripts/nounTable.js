function isNounTable(t){
	return t.getAttribute("data-type") === "nounTable";
}

function populateNounTable(t) {
	var singularIndefinite = t.getAttribute("data-sgi");
	var singularDefinite = t.getAttribute("data-sgd");
	var pluralIndefinite = t.getAttribute("data-pli");
	var pluralDefinite = t.getAttribute("data-pld");
	
	var headerRow = createTableRow(["Ental ubestemt","Ental bestemt","Flertal ubestemt","Flertal bestemt"], true);
	var contentsRow = createTableRow([singularIndefinite, singularDefinite, pluralIndefinite, pluralDefinite], false);

	t.appendChild(headerRow);
	t.appendChild(contentsRow);
}

var tables = document.getElementsByTagName("table");



tables.filter(t => isNounTable(t)).forEach(t => populateNounTable(t));

