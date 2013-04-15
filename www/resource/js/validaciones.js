/**
    Devuelve los elementos de una lista en un formato valido
    
    @param lista Lista de los elementos marcados
    @return Devuelve la lista para tcl
*/
function elementos_lista (lista) {
    //Crea la lista para respuesta
	var seleccionados = "{";
	//Variable de la lista
	var largo = lista.length
	// Mientras hayan elementos en la lista
	for (var i = 0; i!=largo;i++)
	{
	    //Si el elemento esta activo
		if(lista[i].checked){
		    // Almacene el elemento en la variable de seleccionados
			seleccionados += " " + lista[i].value;
		} 
	}
	//Cierra la variable
	seleccionados += " }";
	//Devuelve la lista de seleccionados
	return seleccionados;
}

function validar(elemento, tipo){

	if(tipo == "año"){
		if (elemento.length != 4) {
			// escriba solo 4 digitos
			return "-1";
		}

		var checkOK = "0123456789";
		var allValid = true;

		for (i = 0; i < elemento.length; i++) {
			ch = elemento.charAt(i);
			for (j = 0; j < checkOK.length; j++)
				if (ch == checkOK.charAt(j))
					break;
			if (j == checkOK.length) {
				allValid = false;
				break;
			}
		}

		if (!allValid) {
			//"Escriba sólo dígitos en el campo Año"
			return "-2";
		} 
	} 

	else if(tipo == "mes" || tipo == "dia"){
		if (elemento.length != 2) {
			// escriba solo 4 digitos
			return "-1";
		}

		var checkOK = "0123456789";
		var allValid = true;

		for (i = 0; i < elemento.length; i++) {
			ch = elemento.charAt(i);
			for (j = 0; j < checkOK.length; j++)
				if (ch == checkOK.charAt(j))
					break;
			if (j == checkOK.length) {
				allValid = false;
				break;
			}
		}

		if (!allValid) {
			//"Escriba sólo dígitos en el campo Año"
			return "-2";
		} 
	}
	return 1;
};


//validaciones insertar y modificar actividades 

function validar_info_actividad(nom_actividad,dsc_actividad ,fecha_final,fecha_inicio,anio, comunidades){
	if( nom_actividad.length > 500 ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: El nombre de la actividad es inválido.No puede tener mas de 500 carácteres.</h2>";
		return false;
	}

	if( nom_actividad.length == 0 ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: El nombre de la actividad es inválido.</h2>";
		return false;
	}
	
	if( dsc_actividad.length != 0 && dsc_actividad.length > 500 ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: La descripción de la actividad es inválida.No puede tener mas de 500 carácteres.</h2>";
		return false;
	}

	if (validar_fecha(fecha_inicio) != 1) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Formato inválido en la fecha de inicio.</h2>";
		return false;
	}

	/*if (validar_fecha_con_anio (fecha_inicio, anio) != 1) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: El año de la fecha de inicio debe coincidir con el año del calendario ("+anio+").</h2>";
		return false;
	}*/

	if (validar_fecha(fecha_final) != 1) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Formato inválido en la fecha final.</h2>";
		return false;
	}

	//if (validar_fecha_con_anio (fecha_final, anio) != 1) {
	//	document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: El año de la fecha final debe coincidir con el año del calendario ("+anio+").</h2>";
	//	return false;
	//}
	
	if ( fecha_inicio > fecha_final ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Fechas inválidas, la fecha de inicio debe ser menor a la de finalización.</h2>";
		return false;
	} 
	
	
	if (fecha_inicio.length == 0){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Fecha de inicio inválido.</h2>";
		return false;
	}
	
	if (comunidades == ""){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: No se seleccionó ninguna comunidad.</h2>";
		return false
	}
	
	 
	return true;
}



//validaciones insertar y modificar periodos
function validar_info_periodo(fecha_inicio,fecha_final,anio,id_modalidad){
	
	var validacion_anio = validar(anio, "año");

	if ( validacion_anio == "-1" ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Escriba 4 dígitos en el campo Año</h2>"
		return false;			
	} 
	
	if ( validacion_anio == "-2" ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Escriba sólo dígitos en el campo Año</h2>";
		return false;
	}
	
	if ( fecha_inicio.length == 0 ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Fecha de inico inválida.</h2>";
		return false;
	}

	if ( fecha_final.length == 0 ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Fecha de finalización inválida.</h2>";
		return false;
	}

	if (validar_fecha(fecha_inicio) != 1) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Formato inválido en la fecha de inicio.</h2>";
		return false;
	}

	if (validar_fecha_con_anio (fecha_inicio, anio) != 1) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: El año de la fecha de inicio debe coincidir con el año del calendario ("+anio+").</h2>";
		return false;
	}

	if (validar_fecha(fecha_final) != 1) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Formato inválido en la fecha final.</h2>";
		return false;
	}

	if (validar_fecha_con_anio (fecha_final, anio) != 1) {
		if (id_modalidad != "V"){
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: El año de la fecha final debe coincidir con el año del calendario ("+anio+").</h2>";
			return false;
		}
	}

	if ( fecha_inicio > fecha_final ){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Fechas inválidas, la fecha de inicio debe ser menor a la de finalización.</h2>";
		return false;
	}
	return true;
}

// INNECESARIO - BORRAR cambiar por validaciones de Jquery
//validaciones de categorias

function validar_info_categoria (nom_categoria, dsc_categoria){
	if(nom_categoria.length == 0){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Nombre de categoria inválido.</h2>";
		return "-1"
	/*} else if ( nom_categoria.length > 200) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Nombre de categoria inválido, no puede tener más de 200 caracteres.</h2>";
		return "-2"
	} else if (dsc_categoria.length > 200){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Descripción inválida, no puede tener más de 200 caracteres.</h2>";
		return "-3"*/
	}else{
		return "1"
	}

}


function validar_lista_modalidades(lista){
	var especial = false;
	var tiene = false
	var seleccionados = "{";
	for (var i = 0; i!=lista.length;i++)
	{
		if(lista[i].checked){
			tiene = true
			seleccionados += " " + lista[i].value;
			if (lista[i].value == "O"){
				especial = true;		
			}
		} 
	}


	seleccionados += " }";

	if(especial){
		if(lista.length > 1){
			
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Si se selecciona la modalidad 'No Aplica', no se puede seleccionar otra modalidad.</h2>"
			//return "-1";
		}
	}
	if(!tiene){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Debe seleccionar al menos una modalidad.</h2>";
		//return "-1";
	}

	return seleccionados;

}


//validacion de fechas

function validar_fecha (fecha_a_validar) {

	var tokens = fecha_a_validar.split("-");
	if (tokens.length != 3) {
		return "-1";
	}

	var res = validar(tokens[0],"año");
 	if ( res != 1 ) {
		return "-1";	
	}

	var res = validar(tokens[1],"mes");
 	if ( res != 1 ) {
		return "-1";
			
	} 

	var res = validar(tokens[2],"dia");
 	if ( res != 1 ) {
		return "-1";
	}
 
	return 1;
}

function validar_fecha_con_anio (fecha_a_validar, anio) {
	var tokens = fecha_a_validar.split("-");
	var anio_fecha = parseInt(tokens[0]);
	var anio = parseInt(anio);
	//alert(anio);

 	if ( tokens[0] != anio && anio_fecha != (anio + 1)) {	
		return "-1";	
	} 
	return 1;
}



























