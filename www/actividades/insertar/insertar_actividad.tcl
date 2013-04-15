#tda-cal-inac/www/actividades/insertar/insertar_actividades.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} { }


#td_categorias::eliminar_actividades_temporales

set columnas {
	nom_actividad {
	  label "Actividad"
	}
	nom_categoria {
	  label "Categoría"
	}
	nom_modalidad {
	  label "Modalidad"
	}
  	nom_periodo {
	  label "Periodo"
	}
  	fecha_inicio {
	  label "Inicia (año-mes-día)"
	}
  	fecha_final {
	  label "Termina (año-mes-día)"
	}
  	calendario {
	  label "Calendario"
	}
	acciones { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:eliminar_actividad_temporal('@actividades.id_actividad@')"\>Eliminar</a> </nobr> </center> }
	}
}

template::list::create \
    -name grid_actividades \
    -multirow actividades \
    -key id_categoria_temporal \
    -elements $columnas

td_categorias::seleccionar_actividades_temporales -multirow actividades
