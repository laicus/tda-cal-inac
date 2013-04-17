#tda-cal-inac/www/actividades/ver/ver_actividad_especifica.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_actividad:notnull	
}

set actividad [td_inac_procs::seleccionar_actividad_para_ver -id_actividad $id_actividad]

set actividad [lindex $actividad 0]
set nombre_actividad [lindex $actividad 1]
set categoria [lindex $actividad 2]
set fecha_inicio [lindex $actividad 3]
set fecha_final [lindex $actividad 4]
set dsc_actividad [lindex $actividad 5]
set periodo [lindex $actividad 6]
set modalidad [lindex $actividad 7]
set id_calendario [lindex $actividad 8]
