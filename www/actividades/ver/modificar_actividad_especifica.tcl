#tda-cal-inac/www/actividades/ver/modificar_actividad_especifica.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_actividad:notnull
	nom_actividad:notnull
	dsc_actividad:notnull
	term_id:notnull
	id_categoria:notnull	
	fecha_inicio:notnull
	fecha_final:notnull
	comunidades:notnull
	estado_publicacion:notnull
}

set res [td_categorias::modificar_actividad -id_actividad $id_actividad -nom_actividad $nom_actividad -dsc_actividad $dsc_actividad -term_id $term_id -id_categoria $id_categoria -fecha_inicio $fecha_inicio -fecha_final  $fecha_final -comunidades $comunidades -estado_publicacion $estado_publicacion]
ns_write $res
