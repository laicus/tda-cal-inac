#tda-cal-inac/www/actividades/ver/eliminar_actividad_especifica.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:notnull
}

set estado_publicacion [td_categorias::obtener_estado_publicacion -id_actividad $id_actividad]
set res [td_inac_procs::eliminar_modalidadesxactividad -id_actividad $id_actividad]
set res2 [td_inac_procs::eliminar_periodosxactividades -id_actividad $id_actividad]
set res3 [td_inac_procs::eliminar_actividad -id_actividad $id_actividad -estado_publicacion $estado_publicacion]

ns_write $res3
