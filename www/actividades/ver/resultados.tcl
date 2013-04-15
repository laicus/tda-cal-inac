#tda-cal-inac/www/actividades/ver/resultados.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2009-01-13 to 2013-04-03
    @cvs-id $Id$
} {
	{id_modalidad "%"}
	{periodo "%"}
	{id_categoria "%"}
	{id_calendario "%"}
	{accion "ver"}
}

puts "........========== entra a resultados.tcl y los valores son modalidad $id_modalidad calendario $id_calendario categoria $id_categoria periodo $periodo accion $accion"

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

puts "========================= modalidad: $id_modalidad === categoria: $id_categoria === periodo: $periodo === calendario: $id_calendario..."
set sql_query {}


if {$id_calendario !="%"} {
	puts "calendario"
	append sql_query "AND dotlrn_terms.term_year = '$id_calendario' "
	puts $sql_query

}
 
if {$id_modalidad !="%"} {
	puts "modalidad"
	append sql_query "AND split_part(dotlrn_terms.term_name,' ',1) = '$id_modalidad' "
	puts $sql_query	
} 

if {$periodo !="%"} {
	
	puts "periodo"
	append sql_query "AND dotlrn_terms.term_id = $periodo "
	puts $sql_query
	
} 
if {$id_categoria !="%"} {
	
	puts "categoria"
	append sql_query "AND categoria.id_categoria = $id_categoria "
	puts $sql_query
	
}

td_categorias::seleccionar_actividades_temporales -multirow actividades -sql_query $sql_query



