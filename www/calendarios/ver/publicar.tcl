ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	{id_calendario:notnull}
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
	funcion {
		label "Estado"
		display_template { <a href="javascript:cargar_form_publicar_actividad('@actividades.id_actividad@','@actividades.es_especial@')">Publicar</a> }
	}
}

template::list::create \
    -name grid_actividades \
    -multirow actividades \
    -key id_actividad \
    -elements $columnas \
    -no_data "No existen actividades que actualizar." \
    -html { style "width:100%" }

td_calendarios::seleccionar_actividades_a_publicar_por_calendario -id_calendario $id_calendario -multirow actividades 
ad_form -name calendario -has_submit 1 -form {
    {calendario:integer(hidden) {value $id_calendario} {html {id "id_calendario"} } }
}
