#tda-cal-inac/www/calendarios/ver/modificar_calendario-2.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	anio:notnull
	id_calendario:notnull
	fecha_publicacion:notnull
}

set res [td_calendarios::modificar_calendario -anio $anio -id_calendario $id_calendario -fecha_publicacion $fecha_publicacion ] 
ns_write $res


