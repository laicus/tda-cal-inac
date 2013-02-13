ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$

} {
	anio:notnull
	fecha_publicacion:notnull

} -properties {
}


set res [td_calendarios::insertar_calendario -anio $anio -fecha_publicacion $fecha_publicacion]

ns_write $res



