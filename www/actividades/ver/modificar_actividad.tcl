#tda-cal-inac/www/actividades/ver/modificar_actividad.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_actividad:notnull	
}

set list_modalidades [td_inac_procs::seleccionar_modalidades]
set lista_calendarios [td_calendarios::seleccionar_calendarios]
set actividad [td_inac_procs::seleccionar_actividad -id_actividad $id_actividad]
set list_comunidades [td_inac_procs::seleccionar_comunidades]
set comu_calendar [td_inac_procs::seleccionar_actividad_publicacion -id_actividad $id_actividad]

set actividad [lindex $actividad 0]
set id_periodo [lindex $actividad 8]
set id_modalidad [lindex $actividad 11]
set nom_modalidad [lindex $actividad 12]
set id_calendario [lindex $actividad 9]	
set nombre_actividad [lindex $actividad 1]
set id_categoria [lindex $actividad 2]
set fecha_inicio [lindex $actividad 4]
set fecha_final [lindex $actividad 5]
set dsc_actividad [lindex $actividad 13]

#========================================================
# Cargar Comunidades Institucionales
#========================================================

set nbr_com1 [lindex $list_comunidades 0 0]
set val_com1 [lindex $list_comunidades 0 1]
set nbr_com2 [lindex $list_comunidades 1 0]
set val_com2 [lindex $list_comunidades 1 1]
set nbr_com3 [lindex $list_comunidades 2 0]
set val_com3 [lindex $list_comunidades 2 1]

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
form create frm_seccion_periodos -has_submit 1
form create frm_seccion_categorias -has_submit 1
form create frm_seccion_comunidades -has_submit 1
form create frm_seccion_publicacion -has_submit 1

element create frm_seccion_general txt_nombre_actividad \
	-label "Nombre:" \
	-datatype text \
	-widget text \
	 -html { style "width:500px" } \
	-value $nombre_actividad
	
element create frm_seccion_general txt_dsc_actividad \
	-label "Descripción:" \
	-datatype text \
	-widget textarea \
	-html { style "width:499px; height:82px;" } \
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
	-value $nom_modalidad \
	-html { style "width:150px" onChange "javascript:cargarPeriodos(1,0);" } \
	-options $list_modalidades 	

element create frm_seccion_periodos cmb_periodos \
	-label "Período:" \
	-datatype text \
	-widget select \
	-value $id_periodo \
	-html { style "width:150px" } \
	-options [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad $nom_modalidad -term_year $id_calendario]

element create frm_seccion_categorias cmb_categorias \
	-label "Categoría:" \
	-datatype text \
	-widget select \
	-html { style "width:150px" } \
	-options [td_categorias::seleccionar_categorias] \
	-value $id_categoria

element create frm_seccion_comunidades chk_comunidad1 \
	-label "Comunidades:" \
	-datatype text \
	-widget checkbox \
	-html { style "width:150px"  } \
	-options [list [list $nbr_com1  $val_com1] ]

element create frm_seccion_comunidades chk_comunidad2 \
	-label "" \
	-datatype text \
	-widget checkbox \
	-optional \
	-html { style "width:150px" } \
	-options [list [list $nbr_com2  $val_com2] ]

element create frm_seccion_comunidades chk_comunidad3 \
	-label "" \
	-datatype text \
	-widget checkbox \
	-optional \
	-html { style "width:150px" } \
	-options [list [list $nbr_com3  $val_com3] ]

element create frm_seccion_publicacion rad_publicacion \
	-label "publicado :" \
	-datatype text \
	-widget radio \
	-html { style "width:150px" } \
	-options { {No 0} {Si 1}} \
	-value 0

#========================================================
# Cargar los checkbox de las Comunidades Institucionales
#========================================================
				
foreach comunidad $comu_calendar {
	set com [lindex $comunidad 0]
	if { $com == $val_com1 } { 		
		template::element::set_value frm_seccion_comunidades chk_comunidad1 $val_com1
	}
	if { $com == $val_com2 } { 		
		template::element::set_value frm_seccion_comunidades chk_comunidad2 $val_com2
	}
	if { $com == $val_com3 } { 		
		template::element::set_value frm_seccion_comunidades chk_comunidad3 $val_com3
	}
}

set pub [lindex $comu_calendar 0 2]
if { $pub == t } {
	template::element::set_value frm_seccion_publicacion rad_publicacion 1
}
