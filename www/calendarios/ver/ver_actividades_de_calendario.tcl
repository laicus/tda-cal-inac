#tda-cal-inac/www/calendarios/ver/ver_actividades_de_calendario.tcl
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

set columnas_especiales {
	nom_actividad {
	  html { style "width:40%" }
	  display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades_especiales.id_actividad@','@actividades_especiales.es_especial@')"\>@actividades_especiales.nom_actividad@</a></left> }	  
	}
	fecha_inicio {
		html { style "width:12% align:center" }
	  label "Inicia (año-mes-día)"
	}
	fecha_final {
		html { style "width:12% align:center" }
	  label "Termina (año-mes-día)"
	}
	estado_publicacion {
		html { style "width:12% align:center" }
	  label "Estado"
	}
	accion_modificar { 
		label "Modificar"
		html { style "width:12%" } 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades_especiales.id_actividad@','@actividades_especiales.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		html { style "width:12%" }
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades_especiales.id_actividad@','@actividades_especiales.es_especial@')"\>Eliminar</a> </nobr> </center> }
	}
}

set columnas_semestre {
	nom_actividad {
  html { style "width:40%" }
	  display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades_semestre.id_actividad@','@actividades_semestre.es_especial@')"\>@actividades_semestre.nom_actividad@</a></left> }
	}
	fecha_inicio {
		html { style "width:12% align:center" }
	  label "Inicia (año-mes-día)"
	}
	fecha_final {
		html { style "width:12% align:center" }
	  label "Termina (año-mes-día)"
	}

	estado_publicacion {
		html { style "width:12% align:center" }
	  label "Estado"
	}
	accion_modificar { 
		html { style "width:12%" }
		label "Modificar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades_semestre.id_actividad@','@actividades_semestre.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades_semestre.id_actividad@','@actividades_semestre.es_especial@')"\>Eliminar</a> </nobr> </center> }
	}
}

set columnas_cuatrimestre {
	nom_actividad {
		html { style "width:40%" }
		display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades_cuatrimestre.id_actividad@','@actividades_cuatrimestre.es_especial@')"\>@actividades_cuatrimestre.nom_actividad@</a></left> }
	}
	fecha_inicio {
		html { style "width:12% align:center" }
		label "Inicia (año-mes-día)"
	}
	fecha_final {
		html { style "width:12% align:center" }
		label "Termina (año-mes-día)"
	}
	estado_publicacion {
		html { style "width:12% align:center" }
		label "Estado"
	}
	accion_modificar { 
		label "Modificar"
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades_cuatrimestre.id_actividad@','@actividades_cuatrimestre.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades_cuatrimestre.id_actividad@','@actividades_cuatrimestre.es_especial@')"\>Eliminar</a> </nobr> </center> }
	}
}

set columnas_trimestre {
	nom_actividad {
		html { style "width:40%" }
		display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades_trimestre.id_actividad@','@actividades_trimestre.es_especial@')"\>@actividades_trimestre.nom_actividad@</a></left> }
	}
	fecha_inicio {
		html { style "width:12% align:center" }
		label "Inicia (año-mes-día)"
	}
	fecha_final {
		html { style "width:12% align:center" }
		label "Termina (año-mes-día)"
	}
	estado_publicacion {
		html { style "width:12% align:center" }
		label "Estado"
	}
	accion_modificar { 
		label "Modificar" 
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades_trimestre.id_actividad@','@actividades_trimestre.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		html { style "width:12%" }		
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades_trimestre.id_actividad@','@actividades_trimestre.es_especial@')"\>Eliminar</a> </nobr> </center> }
	}
}

set columnas_bimestre {
	nom_actividad {
	  html { style "width:40%" }
	  display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades_bimestre.id_actividad@','@actividades_bimestre.es_especial@')"\>@actividades_bimestre.nom_actividad@</a></left> }
	}
	fecha_inicio {
		html { style "width:12% align:center" }
		label "Inicia (año-mes-día)"
	}
	fecha_final {
		html { style "width:12% align:center" }
		label "Termina (año-mes-día)"
	}
	estado_publicacion {
		html { style "width:12% align:center" }
		label "Estado"
	}
	accion_modificar { 
		label "Modificar"
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades_bimestre.id_actividad@','@actividades_bimestre.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades_bimestre.id_actividad@','@actividades_bimestre.es_especial@')"\>Eliminar</a> </nobr> </center> }
	}
}

set columnas_mensual {
	nom_actividad {
		html { style "width:40%" }
	  display_template { <left> <a href=\"javascript:cargar_form_ver_actividad('@actividades_mensual.id_actividad@','@actividades_mensual.es_especial@')"\>@actividades_mensual.nom_actividad@</a></left> }
	}
	fecha_inicio {
		html { style "width:12% align:center" }
		label "Inicia (año-mes-día)"
	}
	fecha_final {
		html { style "width:12% align:center" }
		label "Termina (año-mes-día)"
	}
	estado_publicacion {
		html { style "width:12% align:center" }
		label "Estado"
	}
	accion_modificar { 
		label "Modificar"
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_actividad('@actividades_mensual.id_actividad@','@actividades_mensual.es_especial@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		html { style "width:12%" }
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_actividad('@actividades_mensual.id_actividad@','@actividades_mensual.es_especial@')"\>Eliminar</a> </nobr> </center> }
	}
}

template::list::create \
    -name grid_actividades_especiales \
    -multirow actividades_especiales \
    -key id_actividad \
    -elements $columnas_especiales \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

template::list::create \
    -name grid_actividades_semestre \
    -multirow actividades_semestre \
    -key id_actividad \
    -elements $columnas_semestre \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

template::list::create \
    -name grid_actividades_cuatrimestre \
    -multirow actividades_cuatrimestre \
    -key id_actividad \
    -elements $columnas_cuatrimestre \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

template::list::create \
    -name grid_actividades_trimestre \
    -multirow actividades_trimestre \
    -key id_actividad \
    -elements $columnas_trimestre \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

template::list::create \
    -name grid_actividades_bimestre \
    -multirow actividades_bimestre \
    -key id_actividad \
    -elements $columnas_bimestre \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

template::list::create \
    -name grid_actividades_mensual \
    -multirow actividades_mensual \
    -key id_actividad \
    -elements $columnas_mensual \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

	td_inac_procs::obtener_actividades_por_modalidad_categoria -id_modalidad "O" -id_categoria $id_categoria -id_calendario $id_calendario -multirow actividades_especiales

	td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad "S" -id_categoria $id_categoria -periodo $periodo -id_calendario $id_calendario -multirow actividades_semestre

	td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad "C" -id_categoria $id_categoria -periodo $periodo -id_calendario $id_calendario -multirow actividades_cuatrimestre

	td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad "T" -id_categoria $id_categoria -periodo $periodo -id_calendario $id_calendario -multirow actividades_trimestre

	td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad "B" -id_categoria $id_categoria -periodo $periodo -id_calendario $id_calendario -multirow actividades_bimestre

	td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo -id_modalidad "M" -id_categoria $id_categoria -periodo $periodo -id_calendario $id_calendario -multirow actividades_mensual





