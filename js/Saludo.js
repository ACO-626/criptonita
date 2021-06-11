function Fecha(){
	var var_saludo;
	var hora = new Date().getHours();
	

	if ( hora <= 6) {
		var_saludo="¡Hola de madrugada!";


	}else if ( hora <= 12){
		var_saludo="¡Buenos días!";

	}else if ( hora <= 19){
		var_saludo="¡Buenas tardes!"
	}
	else{
		var_saludo ="¡Buenas noches!";
	
	}

	document.getElementById("Saludo").innerHTML=var_saludo;





}