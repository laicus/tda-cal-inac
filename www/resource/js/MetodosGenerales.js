

//------------------------------CrearXmlHttp---------------------------
function CrearXmlHttp()
{
    var lConexion = null;

    try
    {
	// Firefox, Opera 8.0+, Safari
	lConexion = new XMLHttpRequest();
    }
    catch (ef)
    {
	// Internet Explorer
	try
        {
	    lConexion = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch (ei)
	{
	    lConexion = new ActiveXObject("Microsoft.XMLHTTP");
	}
    }
    return lConexion;
}



function CargarModalidadXCalendario(es_modificar, es_ver){
  gConexionModalidades = CrearXmlHttp();

    if ( gConexionModalidades != null) {
    		var id_calendario = document.getElementById("cmb_calendarios").value;
    		
   		if (id_calendario == "%") {
   			id_calendario = 0;
   	   }
   	   
	   document.getElementById("cmb_modalidades").value = "%";
	   document.getElementById("cmb_periodos").value = "%";
	   document.getElementById("cmb_categorias").value = "%";   
		gConexionModalidades.onreadystatechange = RespuestaCargarModalidades;
		gConexionModalidades.open("GET", "formularios/modalidades-lista?id_calendario="+id_calendario+ "&es_modificar=" + es_modificar+"&es_ver="+es_ver, true);
		gConexionModalidades.send(null);
    }
}

function RespuestaCargarModalidades()
{
    if (gConexionModalidades.readyState == 4)
    {
	if (gConexionModalidades.status == 200)
	{	
	    document.getElementById("contenedor_frm_seccion_modalidades").innerHTML = gConexionModalidades.responseText;
	}
    }
}



function CargarPeriodosXModalidad(){
  gConexionCategorias = CrearXmlHttp();

    if ( gConexionCategorias != null) {
	var id_modalidad = document.getElementById("cmb_modalidades");
    
	if (id == null) {
		id = "";
	}
	else {
		id = id.value;
	}
	gConexionCategorias.onreadystatechange = RespuestaCargarPeriodos;
	gConexionCategorias.open("GET", "modificar_categoria?id_categoria="+id, true);
	gConexionCategorias.send(null);
    }
}

function RespuestaCargarPeriodosXModalidad()
{
    if (gConexionCategorias.readyState == 4)
    {
	if (gConexionCategorias.status == 200)
	{
	   document.getElementById("encabezado").innerHTML = gConexionCategorias.responseText;
	}
    }
}



var gConexionActualizar;




function cargarPeriodos(es_modificar, es_ver)
{
    gConexionActualizar = CrearXmlHttp();

    if (gConexionActualizar == null)
    {
	return;	
    }
    
	var id_modalidad = document.getElementById("cmb_modalidades").value;
	var id_calendario = document.getElementById("cmb_calendarios").value;

	document.getElementById("cmb_categorias").value = "%";   
	gConexionActualizar.onreadystatechange = RespuestaCargarPeriodos;
	gConexionActualizar.open("GET", "formularios/periodos-lista?id_modalidad=" + id_modalidad + "&es_modificar=" + es_modificar+"&id_calendario="+id_calendario+"&es_ver="+es_ver, true);
	gConexionActualizar.send(null);
}
 
function RespuestaCargarPeriodos()
{
    if (gConexionActualizar.readyState == 4)
    {
		if (gConexionActualizar.status == 200)
		{	
			document.getElementById("contenedor_frm_seccion_periodos").innerHTML = gConexionActualizar.responseText;
		}
    }
}

function cargarCategorias(es_modificar,es_ver)
{
    gConexionActividades = CrearXmlHttp();

    if (gConexionActividades == null)
    {
	return;	
    }
    
    var term_id = document.getElementById("cmb_periodos").value;
   gConexionActividades.onreadystatechange = RespuestaCargarCategorias;
   gConexionActividades.open("GET", "formularios/categorias-lista?term_id=" + term_id + "&es_modificar="+es_modificar+"&es_ver="+es_ver, true);
   gConexionActividades.send(null);
}
 
function RespuestaCargarCategorias()
{
    if (gConexionActividades.readyState == 4)
    {
	if (gConexionActividades.status == 200)
	{	
	    document.getElementById("contenedor_frm_seccion_categorias").innerHTML = gConexionActividades.responseText;
	}
    }
}

