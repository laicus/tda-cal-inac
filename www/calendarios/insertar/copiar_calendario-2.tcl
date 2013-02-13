ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$

} {
	id_calendario:notnull
	anio_nuevo:notnull
	fecha_publicacion:notnull
} -properties {
}


set res [td_calendarios::copiar_calendario -id_calendario $id_calendario -anio_nuevo $anio_nuevo -fecha_publicacion $fecha_publicacion]

ns_write $res



