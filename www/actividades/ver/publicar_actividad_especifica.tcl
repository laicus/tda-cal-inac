#tda-cal-inac/www/actividades/ver/publicar_actividad_especifica.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:notnull
}

set res [td_calendarios::publicar_actividad -id_actividad $id_actividad]
ns_write $res
