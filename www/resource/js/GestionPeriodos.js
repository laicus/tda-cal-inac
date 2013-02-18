var gConexionPeriodos;


function cargar_form_modificar_periodo(id_periodo,cod_modalidad)
{	
	document.getElementById("resultado").innerHTML =  "";
	var url = "periodos/ver/modificar_periodo?id_periodo="+id_periodo + "&id_modalidad=" + cod_modalidad;
	cargarURL(url,'pagina');
}

function cargar_form_agregar_periodo()
{	
	document.getElementById("resultado").innerHTML =  "";
	cargarURL('periodos/insertar/insertar_periodo','pagina');
} 


 

function modificar_periodo(id_periodo)
{
    gConexionPeriodos = CrearXmlHttp();


    if (gConexionPeriodos != null)
    {
	var id_modalidad = document.getElementById("cmb_modalidades").value;
	var anio = document.getElementById("valor_anio").value;
	var num_periodo = document.getElementById("cmb_periodos").value;
	var fecha_inicio = document.getElementById("fecha_inicio").value;
	var fecha_final = document.getElementById("fecha_final").value;
	var term_name = num_periodo + " " +document.getElementById("cmb_modalidades").options[document.getElementById("cmb_modalidades").selectedIndex].innerHTML;	
	var id_periodo = document.getElementById("id_periodo").value;

	if (validar_info_periodo(fecha_inicio,fecha_final,anio,id_modalidad)) {
		gConexionPeriodos.onreadystatechange = RespuestaModificarPeriodo;
		gConexionPeriodos.open("GET", "periodos/ver/modificar_periodo_especifico?id_modalidad="+id_modalidad+"&anio="+anio+"&num_periodo="+num_periodo+"&fecha_inicio="+fecha_inicio+"&fecha_final="+fecha_final+"&term_name="+term_name+"&id_periodo="+id_periodo, true);
		gConexionPeriodos.send(null);
	}

    }
    
}
 
function RespuestaModificarPeriodo ()
{

    if (gConexionPeriodos.readyState == 4)
    {

	if (gConexionPeriodos.status == 200)
	{	
 document.getElementById("resultado").innerHTML = gConexionPeriodos.responseText

var respuesta = gConexionPeriodos.responseText;
		if (respuesta == "1") {
			document.getElementById("resultado").innerHTML =  "<h2 style='color:#000066'>Modificación exitosa.</h2>";
			cargarURL("periodos/ver/ver", "pagina");

		} else if ( respuesta == "-1" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>La modificación no se pudo realizar, debido a que ya existe un período con estos datos.</h2>"

		} else if ( respuesta == "-2" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>"
		}


		
	}
    }
}


function volver_ver_periodos(){
	document.getElementById("resultado").innerHTML =  "";
	cargarURL('periodos/ver/ver','pagina');
}

//------------------------------Nuevo---------------------------


function cargar_periodos () {

	var id_modalidad = document.getElementById("cmb_modalidades").value;
	var id_calendario = document.getElementById("cmb_calendarios").value;
	document.getElementById("resultado").innerHTML =  "";
	var url = "periodos/ver/resultados?id_modalidad="+ id_modalidad +"&id_calendario="+id_calendario;
	cargarURL(url,'resultados');
}

function InsertarPeriodo()
{
    gConexionPeriodos = CrearXmlHttp();

    if ( gConexionPeriodos != null)
    {

	var id_modalidad = document.getElementById("cmb_modalidades").value;
	
	var num_periodo = document.getElementById("cmb_periodos").value;
	var fecha_inicio = document.getElementById("fecha_inicio").value;
	var fecha_final = document.getElementById("fecha_final").value;
	var term_name = num_periodo + " " +document.getElementById("cmb_modalidades").options[document.getElementById("cmb_modalidades").selectedIndex].innerHTML;	

	var id_calendario = document.getElementById("cmb_calendarios").value;
	var anio = document.getElementById("cmb_calendarios").options[document.getElementById("cmb_calendarios").selectedIndex].innerHTML;

	if (validar_info_periodo(fecha_inicio,fecha_final,anio,id_modalidad)) {
		gConexionPeriodos.onreadystatechange = RespuestaInsertarPeriodo;
		gConexionPeriodos.open("GET", "periodos/insertar/insertar?id_modalidad="+id_modalidad+"&anio="+anio+"&num_periodo="+num_periodo+"&fecha_inicio="+fecha_inicio+"&fecha_final="+fecha_final+"&term_name="+term_name+"&id_calendario="+id_calendario, true);
		gConexionPeriodos.send(null);
	}
   }
}


function RespuestaInsertarPeriodo()
{
    if (gConexionPeriodos.readyState == 4)
    {
	if (gConexionPeriodos.status == 200)
	{
		var respuesta = gConexionPeriodos.responseText;
		if (respuesta == "1") {
			cargarURL("periodos/ver/ver", "pagina");
			document.getElementById("resultado").innerHTML =  "<h2 style='color:#000066'>Inserción exitosa.</h2>";
		} else if ( respuesta == "-1" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>La inserción no se pudo realizar, debido a que ya existe un período con estos datos.</h2>"

		} else if ( respuesta == "-2" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>"
		}
	}
    }
}


function cargarComboPeriodos()
{
    gConexionPeriodos = CrearXmlHttp();

    if ( gConexionPeriodos != null)
    {

	var id_modalidad = document.getElementById("cmb_modalidades").value;
	

	gConexionPeriodos.onreadystatechange = RespuestaCargarComboPeriodos;
    gConexionPeriodos.open("GET", "formularios/numero-periodos-lista?id_modalidad=" + id_modalidad, true);
	gConexionPeriodos.send(null);
   }
}


function RespuestaCargarComboPeriodos()
{
    if (gConexionPeriodos.readyState == 4)
    {
	if (gConexionPeriodos.status == 200)
	{
		var respuesta = gConexionPeriodos.responseText;
		if (respuesta == "-1") {
			document.getElementById("contenedor_frm_num_periodos").innerHTML = "<h2 style='color:#990000'>Error al cargar los períodos.</h2>"
		}else{
		    document.getElementById("contenedor_frm_num_periodos").innerHTML = respuesta;
		}
	}
    }
}


