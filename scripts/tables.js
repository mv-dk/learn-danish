function createTableRow(/*array*/ contents, /*bool*/ isHeader) {
	var tr = document.createElement("tr");
	var cells = contents.map(c => {
		var cc = document.createElement("t"+(isHeader?"h":"d"));
		cc.innerHTML = c;
		return cc;
	});
	cells.forEach(cell => tr.appendChild(cell));
	return tr;
}
