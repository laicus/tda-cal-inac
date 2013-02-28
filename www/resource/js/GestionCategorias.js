//-------------------------------Variables-----------------------------

var gConexionCategorias;

// Crea una nueva categoria
function InsertarCategoria() {
   
	    //Carga el nombre de la categoria
	    var nom_categoria = document.getElementById("txt_nombre_categoria").value;
	    //Carga la descripción de la categoria
	    var dsc_categoria = document.getElementById("txt_descripcion_categoria").value;
	    //Carga la lista de elementos en los cuales aplica
	    var lista = document.getElementsByName("lst_modalidades");
	   
	        // Valida la lista de modalidades -> validar con jquery
		    var seleccionados = validar_lista_modalidades(lista);
		    // Si el valor es -1
		    if(seleccionados!="-1"){
		       
				
				//AJAX/Jquery
				//enviar datos para insertar la categoria
				var xhr = $.ajax({
					type: "POST",
					  url: "categorias/insertar/insertar_categoria-2",
					  data: { nom_categoria: nom_categoria, dsc_categoria: dsc_categoria, lst_modalidades: seleccionados }
					
					})
					.done(function( respuesta ) { 
						$("#resultado").empty();
						//var res = respuesta.val();
						//alert(respuesta);
						 if (respuesta == 1) {
								//Carga la pagina de categorias
								cargarURL('categorias/ver/ver','pagina');
								$("#resultado").append("<h2 style='color:#000066'>Inserción exitosa.</h2>");	
							} else if ( respuesta == -1 ) {
								//Si la categoria ya existe. Despliega un mensaje de error
								$("#resultado").append("<h2 style='color:#990000'>Inserción fallida: Nombre inválido, el nombre de la categoría ya existe.</h2>");
							} else if ( respuesta == -2 ) {
								//Si la categoria exite otro problema. Manda un mensaje de error.
								$("#resultado").append("<h2 style='color:#990000'>Inserción fallida: Error de conexión con la base de datos.</h2>");
							}													  
					})
					.fail(function() { alert("error"); });				
				
		    }
	
}

//Funcion para modificar categorias
function cargar_form_modificar_categoria(id_categoria){
    //Limpia el elemento resultado
    document.getElementById("resultado").innerHTML = "";
    //Carga la pagina para modificar la categoria
	 cargarURLParametro('categorias/ver/modificar_categoria?', 'id_categoria='+id_categoria, 'pagina');
}

//Funcion para modificar categoria
function ModificarCategoria() {
    //Crea la conexion
	gConexionCategorias = CrearXmlHttp();
    //Si la conexion es diferente de nula
	if (gConexionCategorias != null)
	{
        //Carga el identificador de la categoria
	    var id_categoria = document.getElementById("id_categoria").value;
	    //Carga el nombre de la categoria
	    var nom_categoria = document.getElementById("txt_nombre_categoria").value;
	    //Carga la descripcion de la categoria
	    var dsc_categoria = document.getElementById("txt_descripcion_categoria").value;
	    //Carga la lista de elementos en los cuales aplica
	    var lista = document.getElementsByName("lst_modalidades");
	    // Saca los elementos de la lista
	    var seleccionados = elementos_lista(lista);
        //Carga la lista funcion de respuesta para carga de categoria
	    gConexionCategorias.onreadystatechange = RespuestaModificarCategoria;
	    //Carga la pagina de modificar categoria
	    gConexionCategorias.open("GET", "categorias/ver/modificar_categoria-2?nom_categoria="+nom_categoria+"&lst_modalidades="+seleccionados+"&dsc_categoria="+dsc_categoria+"&id_categoria="+id_categoria, true);
	    //Termina la conexion
	    gConexionCategorias.send();
	}
}

//Funcion para carga de modificar la categoria
function RespuestaModificarCategoria()
{
    //Verifica que la conexion este activa
    if ((gConexionCategorias.readyState == 4) && (gConexionCategorias.status == 200))
	{
	    //Realiza la llama a la pagina
		 cargarURL('categorias/ver/ver','pagina');
		//Mensaje de respuesta
		document.getElementById("resultado").innerHTML = "<h2 style='color:#000066'>Modificación exitosa.</h2>";
    }
}

function CargarCategoria()
{
	gConexionCategorias = CrearXmlHttp();
	if ( gConexionCategorias != null)
	{
		var id = document.getElementById("cmb_categorias");
		if (id == null) {
			id = "";
		} else {
			id = id.value;
		}
		gConexionCategorias.onreadystatechange = RespuestaCargarCategoria;
		gConexionCategorias.open("GET", "categorias/modificar/modificar_categoria?id_categoria="+id, true);
		gConexionCategorias.send(null);
	}
}

//Función para regresar a la página de categorias
function volver_ver_categorias(){
    //Guarda vacio en el resultado
    document.getElementById("resultado").innerHTML = "";
    //Carga el elemento página con la página ver
	 cargarURL('categorias/ver/ver','pagina');
}

function RespuestaCargarCategoria()
{
    if (gConexionCategorias.readyState == 4)
    {
	if (gConexionCategorias.status == 200)
	{
	    document.getElementById("principal").innerHTML = gConexionCategorias.responseText;
	    document.getElementById("resultado").innerHTML =  "";
	}
    }
}

//funciones eliminar

function cargar_form_eliminar_categoria(id_categoria){
	document.getElementById("resultado").innerHTML = ""
	 cargarURLParametro("categorias/ver/eliminar_categoria?", "id_categoria="+id_categoria, "pagina");

}

/**
    Funcion para eliminar una categoria
*/
function EliminarCategoria() {
    
	// Crea una variable para el identificador de la categoria
	var id = document.getElementById("id_categoria").value;
     	
	var xhr = $.ajax({
		type: "POST",
		  url: "categorias/ver/eliminar_categoria-2",
		  data: { id_categoria: id }
	 
		})
		.done(function( respuesta ) { 
			$("#resultado").empty();
			//var res = respuesta.val();
			//alert(respuesta);
			 if (respuesta == 1) {
					//Carga la pagina de categorias
					cargarURL("categorias/ver/ver", "pagina");
					$("#resultado").append("<h2 style='color:#000066'>Eliminación exitosa.</h2>");	
				} else if ( respuesta == -1 ) {
					//Si la categoria ya existe. Despliega un mensaje de error
					$("#resultado").append("<h2 style='color:#990000'>Eliminación fallida: Esta categoría está asociada a una o más actividades, por lo cual no se puede eliminar.</h2>");
				} else if ( respuesta == -2 ) {
					//Si la categoria exite otro problema. Manda un mensaje de error.
					$("#resultado").append("<h2 style='color:#990000'>Eliminación fallida: Error de conexión con la base de datos.</h2>");
				}													  
		})
		.fail(function() { alert("error"); });				
			
		
}

