


//-------------------------------Variables-----------------------------

var gConexionActividades;

var id_cat_g = "%";
var id_mod_g = "%";
var id_cat_g = "%";
var id_per_g = "%";



function publicar_actividad()
{

	var id_actividad = document.getElementById("id_actividad").value;
    gConexionActividades = CrearXmlHttp();

    if (gConexionActividades == null)
    {
	return;	
    }
    
   gConexionActividades.onreadystatechange = RespuestaPublicarActividad;
   gConexionActividades.open("GET", "actividades/ver/publicar_actividad_especifica?id_actividad=" + id_actividad, true);
   gConexionActividades.send(null);
}
 
function RespuestaPublicarActividad()
{
	if (gConexionActividades.readyState == 4)
	{
		if (gConexionActividades.status == 200)
		{
			var respuesta = gConexionActividades.responseText;
			if (respuesta == "1") {
				if (document.getElementById("id_calendario") == null){
					cargarURLParametro("actividades/ver/ver?", "id_categoria="+id_cat_g+"&id_modalidad="+ id_mod_g+"&id_periodo="+id_per_g+"&id_calendario="+id_cal_g, "pagina");
				}else {
					var id_calendario = document.getElementById("id_calendario").value;
				
					cargarURLParametro("calendarios/ver/publicar?", "id_calendario="+id_calendario, "modificar_actividades");	
				}
				document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Publicación exitosa.</h2>";
			} else if ( respuesta == "-1" ) {
				document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Publicación fallida: Error de conexión con la base de datos.</h2>";
			} 
		}
	}
}

function despublicar_actividad()
{

	var id_actividad = document.getElementById("id_actividad").value;
    gConexionActividades = CrearXmlHttp();

    if (gConexionActividades == null)
    {
	return;	
    }
    
   gConexionActividades.onreadystatechange = RespuestaDesPublicarActividad;
   gConexionActividades.open("GET", "actividades/ver/despublicar_actividad_especifica?id_actividad=" + id_actividad, true);
   gConexionActividades.send(null);
}
 
function RespuestaDesPublicarActividad()
{
	if (gConexionActividades.readyState == 4)
	{
		if (gConexionActividades.status == 200)
		{
			var respuesta = gConexionActividades.responseText;
			if (respuesta == "1") {
				if (document.getElementById("id_calendario") == null){
					cargarURLParametro("actividades/ver/ver?", "id_categoria="+id_cat_g+"&id_modalidad="+ id_mod_g+"&id_periodo="+id_per_g+"&id_calendario="+id_cal_g, "pagina");
				}else {
					var id_calendario = document.getElementById("id_calendario").value;
				
					cargarURLParametro("calendarios/ver/publicar?", "id_calendario="+id_calendario, "modificar_actividades");	
				}
				document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Transacción exitosa.</h2>";
			} else if ( respuesta == "-1" ) {
				document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Transacción fallida: Error de conexión con la base de datos.</h2>";
			} 
		}
	}
}


function eliminar_actividad()
{

	var id_actividad = document.getElementById("id_actividad").value;
    gConexionActividades = CrearXmlHttp();

    if (gConexionActividades == null)
    {
	return;	
    }
    gConexionActividades.onreadystatechange = RespuestaEliminarActividad;
    gConexionActividades.open("GET", "actividades/ver/eliminar_actividad_especifica?id_actividad=" + id_actividad, true);
    gConexionActividades.send(null);
}
 
function RespuestaEliminarActividad() {
    if (gConexionActividades.readyState == 4)
    {
		if (gConexionActividades.status == 200) {
			var respuesta = gConexionActividades.responseText;
			if (respuesta == "1") {
				if (document.getElementById("id_calendario") == null){
					cargarURLParametro("actividades/ver/ver?", "id_categoria="+ id_cat_g+"&id_modalidad="+ id_mod_g+"&id_periodo="+id_per_g+"&id_calendario="+id_cal_g, "pagina");
				}else {
					var id_calendario = document.getElementById("id_calendario").value;
					cargarURLParametro("calendarios/ver/ver_actividades_de_calendario?", "id_calendario="+id_calendario, "modificar_actividades");	
				}
				document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Eliminación exitosa.</h2>";
			} else if ( respuesta == "-1" ) {
				document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>";
			} 
		}
	}
}

/*==============================================
 * Modificar Actividad
 * funciones para modificar actividades
 * =============================================*/

function modificar_actividad(id_actividad,origen)
{
	//variables
	gConexionActividades = CrearXmlHttp();
	var comunidades = ""; //para las comuidades del calendario
	//validación de conexión
	if (gConexionActividades == null)
	{
		return;	
	}
	//Obtener datos del formulario
	
	var id_actividad = document.getElementById("id_actividad").value;
	var nom_actividad = document.getElementById("txt_nombre_actividad").value;
	var dsc_actividad = document.getElementById("txt_dsc_actividad").value;
	var anio = document.getElementById("cmb_calendarios").options[document.getElementById("cmb_calendarios").selectedIndex].innerHTML;
	var id_periodo = document.getElementById("cmb_periodos").value;
	var id_categoria = document.getElementById("cmb_categorias").value
	var fecha_inicio = document.getElementById("fecha_inicio").value;
	var fecha_final = document.getElementById("fecha_final").value;
	
	//validar en caso de que no se elija fecha final	
	if ( fecha_final.length == 0 ) {
		fecha_final = fecha_inicio;
	}
	
	//Obtener comunidades de los calendarios 
	if($("input[name=chk_comunidad1]").is(':checked'))
	{		
		comunidades = comunidades + $("input[name=chk_comunidad1]").val() + " ";				
	} 
	if ($("input[name=chk_comunidad2]").is(':checked'))
	{		
		comunidades = comunidades + $("input[name=chk_comunidad2]").val() + " ";				
	} 
	if ($("input[name=chk_comunidad3]").is(':checked'))
	{		
		comunidades = comunidades + $("input[name=chk_comunidad3]").val() + " ";
	}
	
	var estado_publicacion = $("input[name='rad_publicacion']:checked").val();
	
	if(validar_info_actividad(nom_actividad,dsc_actividad ,fecha_final,fecha_inicio,anio, comunidades)) {
		if ( dsc_actividad.length == 0 ) {
			dsc_actividad = "  ";
		}

		gConexionActividades.onreadystatechange = RespuestaModificarActividad;
		
		gConexionActividades.open("GET", "actividades/ver/modificar_actividad_especifica?id_actividad=" + id_actividad + "&nom_actividad="+nom_actividad+"&dsc_actividad="+dsc_actividad+"&id_categoria="+id_categoria+"&term_id="+id_periodo+"&fecha_inicio="+fecha_inicio+"&fecha_final="+fecha_final+"&comunidades="+comunidades+"&estado_publicacion="+estado_publicacion, true);
		gConexionActividades.send(null);
	}
}
 
function RespuestaModificarActividad ()
{
    if (gConexionActividades.readyState == 4)
    {
	if (gConexionActividades.status == 200)
	{	
		var respuesta = gConexionActividades.responseText;
		if (respuesta == "1") {
			if (document.getElementById("id_calendario") == null){
				cargarURLParametro("actividades/ver/ver?", "id_categoria="+id_cat_g+"&id_modalidad="+ id_mod_g+"&id_periodo="+id_per_g+"&id_calendario="+id_cal_g, "pagina");
			}else {
				var id_calendario = document.getElementById("id_calendario").value;
				cargarURLParametro("calendarios/ver/ver_actividades_de_calendario?", "id_calendario="+id_calendario, "modificar_actividades");	
			}
			
			document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Modificación exitosa.</h2>";
		} else if ( respuesta == "-1" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Modificación fallida, error al ejecutar la transacción</h2>";
		} else if ( respuesta == "-2" ) {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Modificación fallida. Ya existe una actividad con estos datos.</h2>";

		} 
	}
    }
}




//funciones de insertar


function submit_actividades(){
 	gConexionActividades = CrearXmlHttp();
	gConexionActividades.onreadystatechange = respuesta_submit_actividades;
	gConexionActividades.open("GET", "actividades/insertar/submit_actividades", true);
	gConexionActividades.send(null);

}

function respuesta_submit_actividades()
{
	if (gConexionActividades.readyState == 4)
	{
		if (gConexionActividades.status == 200)
		{ 
			var respuesta = gConexionActividades.responseText;
			if (respuesta == "1") {
				cargarURLParametro("actividades/ver/ver?", "id_categoria="+id_cat_g+"&id_modalidad="+ id_mod_g+"&id_periodo="+id_per_g+"&id_calendario="+id_cal_g, "pagina");
				document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>El calendario se ha actualizado correctamente.</h2>";
			} else if ( respuesta == "-1" ) {
				document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>";
			} 
		}
	}
}



function InsertarActividad(){	

	gConexionActividades = CrearXmlHttp();

	if (gConexionActividades == null)
	{
		return;	
	}

	var nom_actividad = document.getElementById("txt_nombre_actividad").value;
	var nom_modalidad = document.getElementById("cmb_modalidades").options[document.getElementById("cmb_modalidades").selectedIndex].innerHTML;
	var nom_periodo = document.getElementById("cmb_periodos").value;
	var id_calendario = document.getElementById("cmb_calendarios").value;
	var id_modalidad = document.getElementById("cmb_modalidades").value;
	var comunidades = "";
	
	if (id_calendario.length == 0){
		document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Calendario inválido.</h2>";
		return false;
	}

	var anio = document.getElementById("cmb_calendarios").options[document.getElementById("cmb_calendarios").selectedIndex].innerHTML;

	if (nom_periodo == "") {
		if (id_modalidad != "O") {
			document.getElementById("resultado").innerHTML = "<h2 style='color:#990000'>Error: Período inválido.</h2>";
		return;
		}else{
			nom_periodo = "No Aplica";
			var id_periodo = "";
		}	
	} else {
		nom_periodo = document.getElementById("cmb_periodos").options[document.getElementById("cmb_periodos").selectedIndex].innerHTML;
		var id_periodo = document.getElementById("cmb_periodos").value;
	}
	
	
	if($("input[name=chk_comunidad1]").is(':checked'))
	{
		
		comunidades = comunidades + $("input[name=chk_comunidad1]").val() + " ";
				
	} 
	if ($("input[name=chk_comunidad2]").is(':checked'))
	{
		
		comunidades = comunidades + $("input[name=chk_comunidad2]").val() + " ";
				
	} 
	if ($("input[name=chk_comunidad3]").is(':checked'))
	{
		comunidades = comunidades + $("input[name=chk_comunidad3]").val() + " ";
				
	}
		
	var nom_categoria = document.getElementById("cmb_categorias").options[document.getElementById("cmb_categorias").selectedIndex].innerHTML;
	var id_categoria = document.getElementById("cmb_categorias").value;
	var fecha_inicio = document.getElementById("fecha_inicio").value;
	var fecha_final = document.getElementById("fecha_final").value;
	var dsc_actividad = document.getElementById("txt_dsc_actividad").value;


	if(fecha_final.length == 0 ){
		fecha_final = fecha_inicio;
	}
	
	var estado_publicacion = $("input[name='rad_publicacion']:checked").val();
	//alert(publicacion + " " + comunidades);

	if(validar_info_actividad(nom_actividad,dsc_actividad ,fecha_final,fecha_inicio,anio, comunidades)) {
		
		var url = "actividades/insertar/grid_actividades?nom_actividad="+nom_actividad +"&dsc_actividad="+dsc_actividad+"&nom_modalidad="+nom_modalidad+"&nom_periodo="+nom_periodo+"&nom_categoria="+nom_categoria+"&fecha_inicio="+fecha_inicio+"&fecha_final="+fecha_final+"&id_calendario="+id_calendario+"&calendario="+anio+"&id_categoria="+id_categoria+"&id_modalidad="+id_modalidad+"&id_periodo="+id_periodo+"&comunidades="+comunidades+"&estado_publicacion="+estado_publicacion+"&accion=insertar";

		gConexionActividades.onreadystatechange = respuesta_insertar_actividad_temporal;
		gConexionActividades.open("GET", url, true);
		gConexionActividades.send(null);
		
	}
}


function respuesta_insertar_actividad_temporal()
{
     if ((gConexionActividades.readyState == 4) && (gConexionActividades.status == 200)){
      
		var respuesta = gConexionActividades.responseText;
		alert(respuesta);
		volver_ver_actividades();
	   	//document.getElementById("grid_actividades").innerHTML = respuesta;
		document.getElementById("resultado").innerHTML = document.getElementById("mensaje").value;
		var msj = document.getElementById("mensaje").value;
		alert(msj);


    }
}


function eliminar_actividad_temporal(id_actividad)
{
    gConexionActividades = CrearXmlHttp();

    if (gConexionActividades == null)
    {
	return;	
    }


alert(id_actividad);

	var url = "actividades/insertar/grid_actividades?accion=eliminar"+"&id_actividad="+id_actividad;

	gConexionActividades.onreadystatechange = respuesta_insertar_actividad_temporal;
	gConexionActividades.open("GET", url, true);

 gConexionActividades.send(null);
}


function validar_modalidad()
{
	var nom_modalidad = document.getElementById("cmb_modalidades").options[document.getElementById("cmb_modalidades").selectedIndex].innerHTML;
	if (nom_modalidad != "Bimestre" && nom_modalidad != "Cuatrimestre" && nom_modalidad != "Verano" && nom_modalidad != "Semestre") {
		document.getElementById("cmb_categorias").value = 70;
		document.getElementById("cmb_categorias").disabled = true;
	}else{
		document.getElementById("cmb_categorias").disabled = false;
	}
}


//interfaz


function volver_ver_actividades() {
	if (document.getElementById("id_calendario") == null){	
		id_calendario = 0;	
		cargarURLParametro("actividades/ver/ver?" , "id_categoria="+id_cat_g+"&id_modalidad="+ id_mod_g+"&id_periodo="+id_per_g+"&id_calendario="+id_cal_g, "pagina");
	} else {
		var id_calendario = document.getElementById("id_calendario").value;
		if (document.getElementById("id_modalidad") == null){
			if (document.getElementById("p") == null){
				cargarURLParametro("calendarios/ver/ver_actividades_de_calendario?" , "id_calendario="+id_calendario, "modificar_actividades");
			}else {
				cargarURLParametro("calendarios/ver/publicar?" , "id_calendario="+id_calendario, "pagina");
			}
		} else {
			if (document.getElementById("p") == null){
				var id_modalidad = document.getElementById("id_modalidad").value;
				if (id_modalidad == 'todas'){
					cargarURLParametro("calendarios/ver/ver_todas_las_actividades_de_calendario?", "id_calendario="+id_calendario+"&id_modalidad="+id_modalidad,'actividades');
				} else {
					cargarURLParametro("calendarios/ver/ver_calendario_especifico?" , "id_calendario="+id_calendario+"&id_modalidad="+id_modalidad,'actividades');
				}
			} else {
				cargarURLParametro("calendarios/ver/publicar?", "id_calendario="+id_calendario, "pagina");
			}		
		} 	
	}
	document.getElementById("resultado").innerHTML =  "";
}



function cargar_form_insertar_actividad(){
	document.getElementById("resultado").innerHTML = "";

	id_cat_g = document.getElementById("cmb_categorias").value;
	id_per_g = document.getElementById("cmb_periodos").value;
	id_mod_g = document.getElementById("cmb_modalidades").value;
	id_cal_g = document.getElementById("cmb_calendarios").value;

	cargarURL('actividades/insertar/insertar_actividad','pagina');
}

function cargar_actividades () {
	var id_categoria = document.getElementById("cmb_categorias").value;
	var id_periodo = document.getElementById("cmb_periodos").value;
	var id_modalidad = document.getElementById("cmb_modalidades").value;
	var id_calendario = document.getElementById("cmb_calendarios").value;
    //alert("hola");
	var url = "actividades/ver/resultados?";
	var parametros = "id_categoria="+id_categoria+"&id_modalidad="+ id_modalidad+"&periodo="+id_periodo+"&id_calendario="+id_calendario +"&accion=ver";
	document.getElementById("resultado").innerHTML =  "";
	cargarURLParametro(url, parametros, 'resultados');
}

function cargar_form_ver_actividad(id_actividad,es_especial)
{
	var url = "actividades/ver/ver_actividad_especifica?";
    var parametros = "id_actividad="+id_actividad;
	

	if (document.getElementById("id_calendario") == null){
		id_cat_g = document.getElementById("cmb_categorias").value;
		id_per_g = document.getElementById("cmb_periodos").value;
		id_mod_g = document.getElementById("cmb_modalidades").value;
		id_cal_g = document.getElementById("cmb_calendarios").value;
		cargarURLParametro(url, parametros, 'pagina');
	} else {
		if (document.getElementById("p") == null){
			cargarURLParametro(url, parametros, "modificar_actividades");
		}else{
			id_cat_g = document.getElementById("cmb_categorias").value;
			id_per_g = document.getElementById("cmb_periodos").value;
			id_mod_g = document.getElementById("cmb_modalidades").value;
			id_cal_g = document.getElementById("cmb_calendarios").value;
			cargarURLParametro(url, parametros, "actividades");
		}
	}
	document.getElementById("resultado").innerHTML =  "";
}

function cargar_form_eliminar_actividad(id_actividad)
{
	var url = "actividades/ver/eliminar_actividad?";
	var parametros = "id_actividad="+id_actividad;
	
	id_cat_g = document.getElementById("cmb_categorias").value;
	id_per_g = document.getElementById("cmb_periodos").value;
	id_mod_g = document.getElementById("cmb_modalidades").value;
	id_cal_g = document.getElementById("cmb_calendarios").value;

	if (document.getElementById("id_calendario") == null){
	
		cargarURLParametro(url, parametros, 'pagina');
	} else {

		cargarURLParametro(url, parametros,  "modificar_actividades");
	}
	document.getElementById("resultado").innerHTML =  "";
	
} 

function cargar_form_publicar_actividad(id_actividad,es_especial)
{
	var url = "actividades/ver/publicar_actividad?";
    var parametros = "id_actividad="+id_actividad +"&es_especial="+es_especial;
    
	id_cat_g = document.getElementById("cmb_categorias").value;
	id_per_g = document.getElementById("cmb_periodos").value;
	id_mod_g = document.getElementById("cmb_modalidades").value;
	id_cal_g = document.getElementById("cmb_calendarios").value;

	if (document.getElementById("id_calendario") == null){
	
		cargarURLParametro(url, parametros, 'pagina');
	} else {

		cargarURLParametro(url, parametros, "modificar_actividades");
	}
	document.getElementById("resultado").innerHTML =  "";
	
} 


function cargar_form_despublicar_actividad(id_actividad,es_especial)
{
	var url = "actividades/ver/despublicar_actividad?";
	var parametros = "id_actividad="+id_actividad +"&es_especial="+es_especial;
	
	id_cat_g = document.getElementById("cmb_categorias").value;
	id_per_g = document.getElementById("cmb_periodos").value;
	id_mod_g = document.getElementById("cmb_modalidades").value;
	id_cal_g = document.getElementById("cmb_calendarios").value;

	if (document.getElementById("id_calendario") == null){
	
		cargarURLParametro(url, parametros, 'pagina');
	} else {

		cargarURLParametro(url, parametros, "modificar_actividades");
	}
	document.getElementById("resultado").innerHTML =  "";
	
} 



function cargar_form_modificar_actividad(id_actividad,es_especial)
{
	var url = "actividades/ver/modificar_actividad?";
	var parametros = "id_actividad="+id_actividad;

	id_cat_g = document.getElementById("cmb_categorias").value;
	id_per_g = document.getElementById("cmb_periodos").value;
	id_mod_g = document.getElementById("cmb_modalidades").value;
	id_cal_g = document.getElementById("cmb_calendarios").value;
	
	if (document.getElementById("id_calendario") == null){
		cargarURLParametro(url, parametros, 'pagina');
	} else {
		cargarURLParametro(url, parametros, "modificar_actividades");
	}
	document.getElementById("resultado").innerHTML =  "";		
}
