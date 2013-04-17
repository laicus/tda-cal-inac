#tda-cal-inac/www/calendarios/ver/eliminar_calendario.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_calendario:notnull
} 

ad_form -name calendario -has_submit 1 -form {
    {calendario:integer(hidden) 
        {value $id_calendario} 
        {html {id "id_calendario"} } 
    }
}

set columnas {
	term_name {
	  label "Período"
	}
	num_ano {
	  label "Año"
	}
  	start_date {
	  label "Inicia (año-mes-día)"
	}
  	end_date {
	  label "Termina (año-mes-día)"
	}
}

template::list::create \
    -name grid_periodos \
    -multirow periodos \
    -key term_id \
    -elements $columnas \
    -no_data "No existen periodos en este calendario" \
    -html { style "width:100%" }

td_inac_procs::seleccionar_periodos_por_calendario_para_grid -multirow periodos -id_calendario $id_calendario

set columnas {
	nom_actividad {
	  label "Actividad"
	}
	dsc_actividad {
	  label "Descripción"
	}
	fecha_inicio {
	  label "Inicia (año-mes-día)"
	}
	fecha_final {
	  label "Termina (año-mes-día)"
	}
	estado_publicacion {
	  label "Publicada"
	}
}

template::list::create \
    -name grid_actividades \
    -multirow actividades \
    -key id_actividad \
    -elements $columnas \
    -no_data "No existen actividades en este calendario." \
    -html { style "width:100%" }

td_inac_procs::seleccionar_actividades_por_calendario -multirow actividades -id_calendario $id_calendario



