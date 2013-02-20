$(document).ready(function(){
	//cargar informacionGeneral
	cargarURL('informacionGeneral', 'recuadro_centro');
	
});
function cargarURL(url, contenedor) {
	$.ajax({
		type: "POST",
		  url: url		  
		}).done(function( msg ) {
			$("#" + contenedor).empty();
			$("#" + contenedor).hide();							  
			$("#" + contenedor).append(msg);
		    $("#" + contenedor).fadeIn("slow");							  
			 			  
		})
		.fail(function() {
			var error = "<span> Error al cargar la aplicación, favor contactar con el administrador a tec-digital@itcr.ac.cr </span>";
			$("#" + contenedor).empty();
			$("#" + contenedor).hide();							  
			$("#" + contenedor).append(error);
		    $("#" + contenedor).fadeIn("slow");	
		});		
}

function cargarURLParametro(url, parametros, contenedor) {
	$.ajax({
		type: "POST",
		  url: url,
		  data:	parametros	  
		}).done(function( msg ) {
			$("#" + contenedor).empty();
			$("#" + contenedor).hide();							  
			$("#" + contenedor).append(msg);
		    $("#" + contenedor).fadeIn("slow");							  
			 			  
			});
		
				
}
