function md_underscore_with_span(string, spanClass){
	var open = false;
	while (string.indexOf("_") > 0) {
		if (!open) {
			string = string.replace("_", "<span class=\"" + spanClass + "\">");
		}
		else {
			string = string.replace("_", "</span>");
		}
	}

	// while (string.indexOf("_{") > 0) {
	// 	var i = string.indexOf("_{");
	// 	var j = string.indexOf("}_")
	// 	var spanContents = string.substr(i+2, j-i-2);
	// 	var span = document.createElement("span");
	// 	span.className = spanClass;
	// 	span.innerText = spanContents;
		
	// }
	
	return string;
}
