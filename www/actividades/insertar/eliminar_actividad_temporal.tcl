#tda-cal-inac/www/actividades/insertar/eliminar_actividad_temporal.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad
}

td_categorias::eliminar_actividad_temporal -id_actividad_temporal $id_actividad
