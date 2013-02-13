ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:optional
	{id_categoria "%"}
	{periodo "%"}
	{id_modalidad "%"}
}
td_inac_procs::eliminar_actividad -id_actividad $id_actividad

set columnas {
	nom_actividad {
	  label "Actividad"
	}
	dsc_actividad {
	  label "Descripcion"
	}
  	fecha_inicio {
	  label "Inicia"
	}
  	fecha_final {
	  label "Termina"
	}
	acciones { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:eliminar_actividad('@actividades.id_actividad@')"\>Eliminar</a> </nobr> </center> }
	}
}

template::list::create \
    -name grid_actividades_nuevas \
    -multirow actividades \
    -key id_actividad \
    -elements $columnas \
    -no_data "No existen actividades para esta categoria"

td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad $id_modalidad -id_categoria $id_categoria -periodo $periodo -multirow actividades 

template::head::add_javascript -src "resource/js/AjaxDinamico.js" -order 1
template::head::add_javascript -src "resource/js/actualizarModificar.js" -order 2
