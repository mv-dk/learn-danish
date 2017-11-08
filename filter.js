HTMLCollection.prototype.filter = function (func) {
	var results = [];
	for (var i = 0; i < this.length; i++) {
		if (func(this.item(i))) {
			results.push(this.item(i));
		}
	}
	return results;
};
