#tda-cal-inac/www/actividades/ver/resultados.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
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
	  display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades.id_actividad@','@actividades.es_especial@')"\>@actividades.nom_actividad@</a></left> }	  
	}
	fecha_inicio {
	  label "Inicia (año-mes-día)"
	}
	fecha_final {
	  label "Termina (año-mes-día)"
	}
	funcion {
		label "Estado"
		display_template { <if @actividades.estado_publicacion@ eq "No Publicada"><a href="javascript:cargar_form_publicar_actividad('@actividades.id_actividad@','@actividades.es_especial@')">Publicar</a></if><else><a href="javascript:cargar_form_despublicar_actividad('@actividades.id_actividad@','@actividades.es_especial@')">Quitar publicación</a></else> }
	} 
	accion_modificar {
		label "Modificar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades.id_actividad@','@actividades.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades.id_actividad@','@actividades.es_especial@')"\>Eliminar</a> </nobr> </center> }
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

if { $id_modalidad == "%" && $id_categoria == "%" && $periodo == "%" && $id_calendario == "%" } { 
	td_inac_procs::obtener_todas_las_actividades -multirow actividades
} elseif { $id_modalidad == "%" && $id_categoria == "%" && $periodo == "%" && $id_calendario != "%" } { 
	td_inac_procs::seleccionar_actividades_por_calendario -multirow actividades -id_calendario $id_calendario
} elseif { $id_modalidad != "O" } {  
	if { ($id_categoria == "%") && ($periodo == "%") } { 
		td_inac_procs::obtener_actividades_por_modalidad_calendario -id_modalidad $id_modalidad -id_calendario $id_calendario -multirow actividades
	} else {
puts "========================= if 4"
		td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad $id_modalidad -id_categoria $id_categoria -periodo $periodo -id_calendario $id_calendario -multirow actividades	
	}
} else {
puts "========================= if 5"
	td_inac_procs::obtener_actividades_por_modalidad_categoria -id_modalidad $id_modalidad -id_categoria $id_categoria -id_calendario $id_calendario -multirow actividades
}
