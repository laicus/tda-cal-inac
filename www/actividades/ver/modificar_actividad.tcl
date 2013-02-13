#tda-cal-inac/www/actividades/ver/modificar_actividad.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_actividad:notnull
	es_especial:notnull
}

puts "entre"
set list_modalidades [td_inac_procs::seleccionar_modalidades]
set lista_calendarios [td_calendarios::seleccionar_calendarios]
puts $id_actividad
if {$es_especial == 0} {
	set actividad [td_inac_procs::seleccionar_actividad -id_actividad $id_actividad]
    set actividad [lindex $actividad 0]
	set id_periodo [lindex $actividad 6]
	set id_modalidad [lindex $actividad 7]
	set id_calendario [lindex $actividad 8]	
} else {
	set actividad [td_inac_procs::seleccionar_actividad_especial -id_actividad $id_actividad]
    set actividad [lindex $actividad 0]
	set id_periodo "No aplica"
	set id_modalidad "O"
	set id_calendario [lindex $actividad 7]	
}

set nombre_actividad [lindex $actividad 1]
set id_categoria [lindex $actividad 2]
set fecha_inicio [lindex $actividad 3]
set fecha_final [lindex $actividad 4]
set dsc_actividad [lindex $actividad 5]
	
puts "///////////////"	
puts $id_periodo
puts "///////////////"

ad_form -name actividad -has_submit 1 -form {
    {actividad:integer(hidden) 
        {value $id_actividad} 
        {html {id "id_actividad"} } 
    }
}

ad_form  -name formularioEncabezado -mode edit -has_submit 1 -form {
	{fecha_inicio:text(text)
	    {label "Fecha Inicio"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_inicio', 'yyyy-mm-dd');\"> \[<b>yyyy-mm-dd </b>\]}}
	    {value $fecha_inicio}
	}
	{fecha_final:text(text)
	    {label "Fecha Final"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_final', 'yyyy-mm-dd');\"> \[<b>yyyy-mm-dd </b>\]}}
	    {value $fecha_final}
	}
}

form create frm_seccion_general -has_submit 1

element create frm_seccion_general txt_nombre_actividad \
	-label "Nombre:" \
	-datatype text \
	-widget text \
	-value $nombre_actividad
 
element create frm_seccion_general txt_dsc_actividad \
	-label "Descripción:" \
	-datatype text \
	-widget textarea \
	-value $dsc_actividad

element create frm_seccion_general cmb_calendarios \
	-label "Calendario:" \
	-datatype text \
	-widget select \
	-value $id_calendario \
	-html { style "width:150px"  onChange "javascript:cargarPeriodos(1,0);" } \
	-options $lista_calendarios

element create frm_seccion_general cmb_modalidades \
	-label "Modalidad:" \
	-datatype text \
	-widget select \
	-html { style "width:150px" onChange "javascript:cargarPeriodos(1,0); javascript:cargarCategorias(1,0);" } \
	-options $list_modalidades \
	-value $id_modalidad
  	
form create frm_seccion_periodos -has_submit 1

element create frm_seccion_periodos cmb_periodos \
	-label "Período:" \
	-datatype text \
	-widget select \
	-html { style "width:150px" } \
	-options [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad $id_modalidad -id_calendario $id_calendario] \
	-value $id_periodo
 
form create frm_seccion_categorias -has_submit 1

element create frm_seccion_categorias cmb_categorias \
	-label "Categoría:" \
	-datatype text \
	-widget select \
	-html { style "width:150px" } \
	-options [td_categorias::seleccionar_categorias_por_modalidad -id_modalidad $id_modalidad] \
	-value $id_categoria
