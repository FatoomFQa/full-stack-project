var list = ['1', '2', '3', '4', '5'];
list.forEach(rate);

function rate(element) {
	document.getElementById(element).addEventListener("click", function() {
		var starClass = document.getElementById(element).className;

		let num = parseInt(element);//ex:4
		console.log(num);
		
			for (let i = num; i > 0; i--) {
				document.getElementById(i).classList.remove("unchecked");
				document.getElementById(i).classList.add("checked");
			}
			
			document.getElementById('rate').value =num;
		});
}


document.getElementById("submitRatingBtn").addEventListener("click", function() {
});