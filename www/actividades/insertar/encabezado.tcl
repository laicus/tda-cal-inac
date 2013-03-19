#tda-cal-inac/www/actividades/insertar/encabezado.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_modalidad:optional
}

set lista_calendarios [td_calendarios::seleccionar_calendarios]


set list_modalidades [td_inac_procs::seleccionar_modalidades]

#========================================================
#  Creación del formulario
#========================================================

form create frm_seccion_general -has_submit 1

form create frm_seccion_periodos -has_submit 1

form create frm_seccion_categorias -has_submit 1

form create frm_seccion_comunidades -has_submit 1

form create frm_seccion_publicacion -has_submit 1

element create frm_seccion_general txt_nombre_actividad \
    -label "Nombre:" \
    -datatype text \
    -widget text \
    -html { style "width:500px" }

element create frm_seccion_general txt_dsc_actividad \
    -label "Descripción:" \
    -datatype text \
    -optional \
    -widget textarea \
    -html { style "width:499px; height:82px;" }

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
    -html { style "width:150px" onChange "javascript:cargarPeriodos(0,0);" } \
    -options $list_modalidades

element create frm_seccion_periodos cmb_periodos \
    -label "Período:" \
    -datatype text \
    -widget select \
    -html { style "width:150px" } \
    -options [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad [lindex [lindex $list_modalidades 0] 1] -term_year [lindex [lindex $lista_calendarios 0] 1] ]

element create frm_seccion_categorias cmb_categorias \
    -label "Categoría:" \
    -datatype text \
    -widget select \
    -html { style "width:150px" } \
    -options [td_categorias::seleccionar_categorias]


element create frm_seccion_comunidades chk_comunidades \
	-label "Comunidades:" \
	-datatype text \
	-widget checkbox \
	-html { style "width:150px" } \
	-options [td_inac_procs::seleccionar_comunidades]

element create frm_seccion_publicacion chk_publicacion \
	-label "¿Desea publicar?:" \
	-datatype text \
	-widget radio \
	-html { style "width:150px" } \
	-options { {No 0} {Si 1}} \
	-value 0


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

set var [element get_value frm_seccion_publicacion chk_publicacion]


set check [element get_value frm_seccion_comunidades chk_comunidades]
	
puts "valor de radio es $var y el check $check"


