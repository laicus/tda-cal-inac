ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	anio:notnull
	fecha_publicacion:notnull
}

set res [td_calendarios::insertar_calendario -anio $anio -fecha_publicacion $fecha_publicacion]
ns_write $res
