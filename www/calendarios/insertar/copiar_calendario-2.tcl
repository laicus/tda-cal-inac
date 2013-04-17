ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_calendario:notnull
	anio_nuevo:notnull
	fecha_publicacion:notnull
}

set res [td_calendarios::copiar_calendario -id_calendario $id_calendario -anio_nuevo $anio_nuevo -fecha_publicacion $fecha_publicacion]

ns_write $res
