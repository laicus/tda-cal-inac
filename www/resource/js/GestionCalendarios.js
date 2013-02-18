//////////////////funciones de insercion///////////////////////////

// Crea la conexion para los calendarios
var gConexionCalendario;

// Crea la funcion para insertar un calendario
function InsertarCalendario() {    
    // Crea la conexion
	gConexionCalendario = CrearXmlHttp();
	// Si la conexion no es nula
	if (gConexionCalendario != null)
	{
	    // Almacena el ano
	    var anio = document.getElementById("txt_anio").value;
	    // Crea una fecha de publicacion ??
	    var fecha_publicacion = anio+"-01-01";
        // Carga la respuesta de insertar un calendario
	    gConexionCalendario.onreadystatechange = RespuestaInsertarCalendario;
	    // Carga la pagina de insercion de calendarios
	    gConexionCalendario.open("GET", "calendarios/insertar/insertar_calendario-2?anio="+anio+'&fecha_publicacion='+fecha_publicacion, true);
	    // Termina la conexion
	    gConexionCalendario.send(null);	
    }
}

// Crea la funcion para insertar un calendario
function RespuestaInsertarCalendario()
{
    // Si se encuentra listo para la captura
	if ((gConexionCalendario.readyState == 4) && (gConexionCalendario.status == 200))
	{
	    // Carga la respuesta de la conexion
		var respuesta = gConexionCalendario.responseText;
		// En caso de error manda un mensaje
		if (respuesta == "-2") {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Inserción fallida: Error de conexión con la base de datos.</h2>";
	    // En caso de error manda un mensaje
		} else if ( respuesta == "-1" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Inserción fallida: Ya existe un calendario para este año.</h2>";
		} else {
		    // En caso de exito carga la pagina principal
			cargarURL('calendarios/ver/ver','pagina');
			// Manda un mensaje de concluido con exito
			document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Inserción exitosa.</h2>";
		}
	}
}

//////////////////funciones modificar///////////////////////////

function ModificarCalendario() {
    
	gConexionCalendario = CrearXmlHttp();

	if (gConexionCalendario == null)
	{
	return;	
	}

	var anio = document.getElementById("txt_anio").value;
	var fecha_publicacion = document.getElementById("fecha_publicacion").value;
	var validacion_anio = validar(anio, "año");
	var id_calendario = document.getElementById("id_calendario").value;
	if ( validacion_anio == "-1" ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Escriba 4 dígitos en el campo Año</h2>"
		return;			
	} else if ( validacion_anio == "-2" ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Escriba sólo dígitos en el campo Año</h2>";
		return;
	}else{
		gConexionCalendario.onreadystatechange = RespuestaModificarCalendario;
		gConexionCalendario.open("GET", "calendarios/ver/modificar_calendario-2?id_calendario=" +id_calendario+"&anio="+anio+"&fecha_publicacion="+fecha_publicacion, true);
		gConexionCalendario.send(null);
	}

}


function RespuestaModificarCalendario()
{
    if (gConexionCalendario.readyState == 4)
    {
	if (gConexionCalendario.status == 200)
	{
		var respuesta = gConexionCalendario.responseText;
		if (respuesta == "-1") {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Modificación fallida: Ya existe un calendario para este año.</h2>";
			
		} else if (respuesta == -2){
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Modificación fallida: Error de conexión con la base de datos.</h2>";
		} else {
			cargarURL('calendarios/ver/ver','pagina');
			document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Modificación exitosa.</h2>";
		}
	}
    }
}


function RespuestaCargarCalendario()
{
    if (gConexionCalendario.readyState == 4)
    {
	if (gConexionCalendario.status == 200)
	{
	    document.getElementById("principal").innerHTML = gConexionCalendario.responseText;
	    document.getElementById("resultado").innerHTML =  "";
	}
    }
}

//////////////////funciones eliminar///////////////////////////

function EliminarCalendario() {
    
	gConexionCalendario = CrearXmlHttp();

	if (gConexionCalendario == null)
	{
		return;	
	}

	var id_calendario = document.getElementById("id_calendario").value;
	gConexionCalendario.onreadystatechange = RespuestaEliminarCalendario;
	gConexionCalendario.open("GET", "calendarios/ver/eliminar_calendario-2?id_calendario="+id_calendario, true);
	gConexionCalendario.send(null);
}

function RespuestaEliminarCalendario()
{
    if (gConexionCalendario.readyState == 4)
    {
	if (gConexionCalendario.status == 200)
	{
		var respuesta = gConexionCalendario.responseText;
		if (respuesta == "1") {
			cargarURL("calendarios/ver/ver", "pagina");
			document.getElementById("resultado").innerHTML =  "<h2 style='color:#000066'>Eliminación exitosa.</h2>";
		} else if ( respuesta == "-1" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>" 			} else if ( respuesta == "-2" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>"
		}

	}
    }

}

//////////////////funciones copiar/////////////////////////// 

function CopiarCalendario(){

	gConexionCalendario = CrearXmlHttp();

	if (gConexionCalendario == null)
	{
		return;	
	}
	var id_calendario = document.getElementById("cmb_calendarios").value;
	var anio_nuevo = document.getElementById("txt_anio").value;
	var fecha_publicacion = document.getElementById("fecha_publicacion").value;
	var validacion_anio = validar(anio_nuevo , "año");
	if (id_calendario == ""){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: No existe un calendario al cual aplicarle la acción de copia.</h2>"		
				
	} else if ( validacion_anio == "-1" ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Escriba 4 dígitos en el campo Año.</h2>"
		return;			
	} else if ( validacion_anio == "-2" ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Escriba sólo dígitos en el campo Año</h2>";
		return;
	} else if (fecha_publicacion.length == 0 ) {
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Introduzca la feha de publicación.</h2>"		
	} else{
	
	
		gConexionCalendario.onreadystatechange = RespuestaCopiarCalendario;
		gConexionCalendario.open("GET", "calendarios/insertar/copiar_calendario-2?id_calendario="+id_calendario+"&anio_nuevo="+anio_nuevo+"&fecha_publicacion="+fecha_publicacion, true);
		gConexionCalendario.send(null);
	}
		
}

function RespuestaCopiarCalendario()
{
    if (gConexionCalendario.readyState == 4)
    {
	if (gConexionCalendario.status == 200)
	{
		var respuesta = gConexionCalendario.responseText;
		if (respuesta == "-1") {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Copia fallida: Ya existe un calendario para este año.</h2>";
			
		} else if (respuesta == -2){
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Copia fallida: Error de conexión con la base de datos.</h2>";
		} else {
			cargarURL('calendarios/ver/ver','pagina');
			document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Copia exitosa.</h2>";
		}
	}
    }
}
//////////////funciones publicar/////////////////////
function PublicarCalendario(){

	gConexionCalendario = CrearXmlHttp();

	if (gConexionCalendario == null)
	{
		return;	
	}

	var id_calendario = document.getElementById("id_calendario").value;
	
	gConexionCalendario.onreadystatechange = RespuestaPublicarCalendario;
	gConexionCalendario.open("GET", "calendarios/ver/publicar-2?id_calendario="+id_calendario, true);
	gConexionCalendario.send(null);
		
}

function RespuestaPublicarCalendario()
{
    if (gConexionCalendario.readyState == 4)
    {
	if (gConexionCalendario.status == 200)
	{
		var respuesta = gConexionCalendario.responseText;
		if (respuesta == "-1") {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Publicación fallida: Error al realizar la transacción.</h2>";
			
		} else if (respuesta == -2){
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Modificación fallida: Error de conexión con la base de datos.</h2>";
		} else {
			cargarURL('calendarios/ver/ver','pagina');
			document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Publicación exitosa.</h2>";
		}
	}
    }
}

//////////////acciones de interfaz/////////////////////

function cargar_form_modificar_calendario(id_calendario,anio,fecha_publicacion){
	document.getElementById("resultado").innerHTML = "";
	cargarURLParametro('calendarios/ver/modificar_calendario?', 'id_calendario='+id_calendario + '&anio='+anio+'&fecha_publicacion='+fecha_publicacion, 'pagina');
}


function cargar_form_copiar_calendario(){
	document.getElementById("resultado").innerHTML = ""
	cargarURL("calendarios/insertar/copiar_calendario", "pagina");
}

function cargar_form_eliminar_calendario(id_calendario){
	document.getElementById("resultado").innerHTML = ""
	cargarURLParametro("calendarios/ver/eliminar_calendario?", "id_calendario="+id_calendario, "pagina");

}

function cargar_form_publicar_calendario(id_calendario){
	document.getElementById("resultado").innerHTML = "";

	cargarURLParametro("calendarios/ver/publicar?", "id_calendario="+id_calendario, "pagina");

}

function volver_ver_calendarios(){
	document.getElementById("resultado").innerHTML = "";
	cargarURL('calendarios/ver/ver','pagina');
}

function cargar_form_modificar_actividades(){
	var id_calendario = document.getElementById("id_calendario").value;
	//cargarURL("calendarios/ver/menu", "sub_menu");
	
	cargarURLParametro("calendarios/ver/ver_actividades_de_calendario?", "id_calendario="+id_calendario, "modificar_actividades");

}

function cargar_form_modificar_actividad_calendario(id_actividad,es_especial)
{

	var url = "calendarios/ver/modificar_actividad?";
	var parametros = "id_actividad="+id_actividad +"&es_especial="+es_especial;
	document.getElementById("resultado").innerHTML =  "";
	cargarURLParametro(url, parametros, 'modificar_actividades');
}

function cargar_form_ver_calendario(id_calendario){

gConexionCalendario = CrearXmlHttp();

	if (gConexionCalendario == null)
	{
		return;	
	}
	gConexionCalendario.onreadystatechange = RespuestaCargarFormVerCalendario;
	gConexionCalendario.open("GET", "calendarios/ver/ver_calendario?id_calendario="+id_calendario, true);
	gConexionCalendario.send(null);


}

function cargar_form_ver_calendario_visualizador(){

gConexionCalendario = CrearXmlHttp();

	if (gConexionCalendario == null)
	{
		return;	
	}
	gConexionCalendario.onreadystatechange = RespuestaCargarFormVerCalendario;
	gConexionCalendario.open("GET", "calendarios/ver/ver_calendario", true);
	gConexionCalendario.send(null);


}

function cargar_calendario_visualizador(){
	window.open('calendarios/ver/ver_calendario_visualizador');
}

function RespuestaCargarFormVerCalendario()
{
    if (gConexionCalendario.readyState == 4)
    {
	if (gConexionCalendario.status == 200)
	{
		document.getElementById("pagina").innerHTML = gConexionCalendario.responseText;
		var id_calendario = document.getElementById("id_calendario").value;
		cargarURLParametro("calendarios/ver/ver_todas_las_actividades_de_calendario?", "id_calendario="+id_calendario,'actividades');
		document.getElementById("todas").innerHTML = "<a style='color:#0000CC'>Todas</a>";
	}
    }
}

function cargar_ver_calendario(id_modalidad){
	var id_calendario = document.getElementById("id_calendario").value;


	var id_modalidad_vieja =  document.getElementById("id_modalidad").value;

	//alert("vieja " + id_modalidad_vieja);

	//alert("nueva " + id_modalidad);

	if (id_modalidad != id_modalidad_vieja) {
		document.getElementById(id_modalidad).innerHTML = "<a style='color:#0000CC'>"+document.getElementById(id_modalidad).innerHTML+"</a>";
		if (id_modalidad_vieja == "S"){
			document.getElementById("S").innerHTML = "Semestre";
		} else if (id_modalidad_vieja == "C") {
			document.getElementById("C").innerHTML = "Cuatrimestre";
		} else if (id_modalidad_vieja == "T") {
			document.getElementById("T").innerHTML = "Trimestre";
		} else if (id_modalidad_vieja == "B") {
			document.getElementById("B").innerHTML = "Bimestre";
		} else if (id_modalidad_vieja == "M") {
			document.getElementById("M").innerHTML = "Mensual";
		} else if (id_modalidad_vieja == "O") {
			document.getElementById("O").innerHTML = "Otras";
		} else if (id_modalidad_vieja == "todas") {
			document.getElementById("todas").innerHTML = "Todas";
		} else if (id_modalidad_vieja == "%") {
			document.getElementById("todas").innerHTML = "Todas";
		}

	}


	

	if (id_modalidad == 'todas'){
		cargarURLParametro("calendarios/ver/ver_todas_las_actividades_de_calendario?" , "id_calendario="+id_calendario+"&id_modalidad="+id_modalidad,'actividades');
	} else {
		cargarURLParametro("calendarios/ver/ver_calendario_especifico?", "id_calendario="+id_calendario+"&id_modalidad="+id_modalidad,'actividades');
	}

}


