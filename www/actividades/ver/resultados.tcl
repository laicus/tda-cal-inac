#tda-cal-inac/www/actividades/ver/resultados.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	{id_modalidad "%"}
	{periodo "%"}
	{id_categoria "%"}
	{id_calendario "%"}
	{accion "ver"}
}

set columnas {
	nom_actividad {
	  label "Actividad"
	}	
	nom_categoria {
	  label "Categoría"
	}	
	fecha_inicio {
	  label "Inicia (año-mes-día)"
	}
  	fecha_fin {
	  label "Termina (año-mes-día)"
	}		
	periodo {
	  label "Periodo"
	}
	estado_publicacion {
		label "Publicación"
		display_template { <if @actividades.estado_publicacion@ eq "f"><a>No</a></if><else><a >Sí</a></else> }
	}
	accion_modificar {
		label "Modificar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades.id_actividad@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades.id_actividad@')"\>Eliminar</a> </nobr> </center> }
	}
}

template::list::create \
    -name grid_actividades \
    -multirow actividades \
    -key id_actividad \
    -elements $columnas \
    -html { style "width:100%" } \
    -no_data "No existen actividades bajo estos parámetros."

if { $id_calendario eq 0 } { 
    set id_calendario "%" 
}

set sql_query {}

if {$id_calendario !="%"} {
	append sql_query "AND dotlrn_terms.term_year = '$id_calendario' "
}
 
if {$id_modalidad !="%"} {
	append sql_query "AND split_part(dotlrn_terms.term_name,' ',1) = '$id_modalidad' "
} 

if {$periodo !="%"} {
	append sql_query "AND dotlrn_terms.term_id = $periodo "
} 

if {$id_categoria !="%"} {
	append sql_query "AND categoria.id_categoria = $id_categoria "
}

td_categorias::seleccionar_actividades_temporales -multirow actividades -sql_query $sql_query
