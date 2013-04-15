#tda-cal-inac/www/actividad/ver/eliminar_actividad.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:notnull	
} 


set actividad [td_inac_procs::seleccionar_actividad_para_ver -id_actividad $id_actividad]
set actividad [lindex $actividad 0]
set periodo [lindex $actividad 6]
set modalidad [lindex $actividad 7]
set id_calendario [lindex $actividad 8]
set nombre_actividad [lindex $actividad 1]
set categoria [lindex $actividad 2]
set fecha_inicio [lindex $actividad 3]
set fecha_final [lindex $actividad 4]
set dsc_actividad [lindex $actividad 5]

ad_form -name actividad -has_submit 1 -form {
    {actividad:integer(hidden)
        {value $id_actividad} 
        {html {id "id_actividad"} } 
    }
}
