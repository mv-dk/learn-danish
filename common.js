function addClickListenersToHoverElements(){
  var elements = document.getElementsByClassName("hoverVisible");
  for (var i = 0; i < elements.length; i++){
    (function(e) {
      e.addEventListener("click", function(){ removeClass(e, "hoverVisible"); });
    })(elements[i]);
  }
}

function removeClass(element, className){
  element.classList.remove(className);
}

addOnload(addClickListenersToHoverElements);

function addOnload(func) {
	if (window.onload != undefined) {
		var oldOnload = window.onload;
		window.onload = function () {
			oldOnload();
			func();
		};
	}
	else {
		window.onload = func;
	}
}
