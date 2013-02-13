#tda-cal-inac/www/calendarios/ver/ver_calendario_especifico.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	{id_modalidad "%"}
	{periodo "%"}
	{id_categoria "%"}
	{id_calendario "%"}
	{filtro "todos"}
}

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
	estado_publicacion {
		html { style "width:12%" }
		label "Estado"
	}
}

template::list::create \
    -name grid_actividades \
    -multirow actividades \
    -key id_actividad \
    -elements $columnas \
    -no_data "No existen actividades." \
     -html { style "width:100%" }

if { $id_modalidad == "O" } {
	td_inac_procs::obtener_actividades_por_modalidad_todas_categorias -id_modalidad "O" -id_calendario $id_calendario -multirow actividades
} else {
	td_inac_procs::obtener_actividades_por_modalidad_todas_categorias_periodo -id_modalidad $id_modalidad -periodo $periodo -id_calendario $id_calendario -multirow actividades
}

ad_form -name modalidad -has_submit 1 -form {
    {calendario:integer(hidden) 
        {value $id_modalidad} 
        {html {id "id_modalidad"} } 
     } 
}
