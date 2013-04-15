#tda-cal-inac/www/actividades/ver/eliminar_actividad_especifica.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:notnull
}

set res3 [td_inac_procs::eliminar_actividad -id_actividad $id_actividad]

ns_write $res3
