#tda-cal-inac/www/actividades/insertar/encabezado.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_modalidad:optional
}

set lista_calendarios [td_calendarios::seleccionar_calendarios]

#======= Modificado por fcontreras el 09.12.2012 a las 12:57pm ====
if { [exists_and_not_null lista_calendarios]} {
	set id_calendario [lindex [lindex $lista_calendarios 0] 1]
} else {
	set id_calendario 0
} 
set list_modalidades [td_inac_procs::seleccionar_modalidades_por_calendario -id_calendario $id_calendario]

#========================================================
#  Creación del formulario
#========================================================

form create frm_seccion_general -has_submit 1

form create frm_seccion_periodos -has_submit 1

form create frm_seccion_categorias -has_submit 1

element create frm_seccion_general txt_nombre_actividad \
    -label "Nombre:" \
    -datatype text \
    -widget text

element create frm_seccion_general txt_dsc_actividad \
    -label "Descripción:" \
    -datatype text \
    -optional \
    -widget textarea

element create frm_seccion_general cmb_calendarios \
    -label "Calendario:" \
    -datatype text \
    -widget select \
    -html { style "width:150px"  onChange "javascript:cargarPeriodos(0,0);" } \
    -options $lista_calendarios

element create frm_seccion_general cmb_modalidades \
    -label "Modalidad:" \
    -datatype text \
    -widget select \
    -html { style "width:150px" onChange "javascript:cargarPeriodos(0,0); javascript:cargarCategorias(0,0);" } \
    -options $list_modalidades

element create frm_seccion_periodos cmb_periodos \
    -label "Período:" \
    -datatype text \
    -widget select \
    -html { style "width:150px" } \
    -options [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad [lindex [lindex $list_modalidades 0] 1] -id_calendario [lindex [lindex $lista_calendarios 0] 1] ]

element create frm_seccion_categorias cmb_categorias \
    -label "Categoría:" \
    -datatype text \
    -widget select \
    -html { style "width:150px" } \
    -options [td_categorias::seleccionar_categorias_por_modalidad -id_modalidad [lindex [lindex $list_modalidades 0] 1] ]

ad_form  -name formularioEncabezado -mode edit -has_submit 1 -form {
	{fecha_inicio:text(text)
	    {label "Fecha inicio:"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_inicio', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	}
	{fecha_final:text(text)
	    {label "Fecha final:"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {optional}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_final', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	}
}
