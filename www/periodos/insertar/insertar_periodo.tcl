#tda-cal-inac/www/periodos/insertar/insertar_periodo.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} { }

set list_modalidades [td_inac_procs::seleccionar_modalidades_para_periodos]
set inicio [lindex [lindex $list_modalidades 0] 1  ]
set lista_periodos [td_periodos::lista_periodos_por_modalidad -id_modalidad $inicio ] 
set lista_calendarios [td_calendarios::seleccionar_calendarios]
set anio [clock format [clock seconds] -format "%Y"]

ad_form  -name formulario -mode edit -has_submit 1 -form {
	{fecha_inicio:text(text)
	    {label "Fecha Inicio:"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {optional}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_inicio', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	}
	{fecha_final:text(text)
	    {label "Fecha Final:"}
	    {format {[lc_get formbuilder_date_format]}}
	    {optional}
	    {html {id start_date}}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_final', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	}	
} -after_submit {
	ad_return_template
}

form create frm_seccion_general -has_submit 1

element create frm_seccion_general cmb_calendarios \
    -label "Calendario:" \
    -datatype text \
    -widget select \
    -html { style "width:200px" } \
    -options $lista_calendarios

element create frm_seccion_general cmb_modalidades \
    -label "Modalidad:" \
    -datatype text \
    -widget select \
    -html { style "width:200px" onChange "javascript:cargarComboPeriodos()"} \
    -options $list_modalidades

form create frm_num_periodos -has_submit 1

element create frm_num_periodos cmb_periodos \
    -label "Número de período:" \
    -datatype text \
    -widget select \
    -options $lista_periodos