window.onload = function(){	
	var timer;
	var elem = document.getElementById('elem');
	var elem1 = document.getElementById('elem1');
	var elem2 = document.getElementById('elem2');
	if(elem != null && elem1 != null && elem2 != null){
		elem2.innerHTML = elem1.innerHTML;
		timer = setInterval(Scroll,120);
		function Scroll(){
			if(elem.scrollTop>=elem1.offsetHeight){
				elem.scrollTop -= elem1.offsetHeight;
			}else{
				elem.scrollTop += 1;
			}
		}	
		elem.onmouseover = function(){
			clearInterval(timer);
		}	
		elem.onmouseout = function(){
			timer = setInterval(Scroll,100);
		}
	}
	
	
}