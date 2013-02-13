#tda-cal-inac/www/calendarios/ver/publicar_actividad.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	{id_actividad:notnull}
}

set res [td_calendarios::publicar_actividad -id_actividad $id_actividad]
ns_write $res


