#tda-cal-inac/www/periodos/ver/resultados.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	{id_modalidad "%"}
	{id_calendario "%"}
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
	accion_modificar { 
		label "Modificar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_periodo('@periodos.term_id@', '@periodos.cod_modalidad@')"\>Modificar</a> </nobr> </center> }
	}
}

template::list::create \
    -name grid_periodos \
    -multirow periodos \
    -key term_id \
    -elements $columnas \
    -no_data "No existen periodos para esta categoría" \
    -html  { style "width:100%" }

set ano [clock format [clock seconds] -format "%Y"]
if { ($id_calendario eq "%") && ($id_calendario eq "%")} {
	td_inac_procs::seleccionar_periodos_por_modalidad_para_grid_todos -id_modalidad $id_modalidad -num_ano $ano -multirow periodos 
} else {
	td_inac_procs::seleccionar_periodos_por_modalidad_para_grid -id_modalidad $id_modalidad -id_calendario $id_calendario -num_ano $ano -multirow periodos 
}
