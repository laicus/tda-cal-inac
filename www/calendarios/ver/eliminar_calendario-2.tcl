#tda-cal-inac/www/calendarios/ver/eliminar_calendario-2.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$

} {
	id_calendario:notnull
}

set res [td_calendarios::eliminar_calendario -id_calendario $id_calendario]
ns_write $res
