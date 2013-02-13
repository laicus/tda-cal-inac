#tda-cal-inac/www/actividades/ver/modificar_actividad_especifica.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:notnull
	nom_actividad:notnull
	dsc_actividad:notnull
	id_categoria:notnull
	id_modalidad:notnull
	id_periodo:notnull
	fecha_inicio:notnull
	fecha_final:notnull
	id_calendario:notnull
}

set res [td_categorias::modificar_actividad -id_actividad $id_actividad -nom_actividad $nom_actividad -dsc_actividad $dsc_actividad -id_categoria $id_categoria -id_modalidad $id_modalidad -id_periodo $id_periodo -fecha_inicio $fecha_inicio -fecha_final  $fecha_final -id_calendario $id_calendario]

ns_write $res
