#tda-cal-inac/www/periodos/ver/modificar_periodo_especifico.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_modalidad:notnull
	anio:notnull
	num_periodo:notnull
	fecha_inicio:notnull
	fecha_final:notnull
	term_name:notnull
	id_periodo:notnull
}

set res [td_periodos::modificar_periodo -id_modalidad $id_modalidad -anio $anio -num_periodo $num_periodo -fecha_inicio $fecha_inicio -fecha_final $fecha_final -term_name $term_name -id_periodo $id_periodo ]

ns_write $res
