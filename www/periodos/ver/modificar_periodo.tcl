#tda-cal-inac/www/periodos/ver/modificar_periodo.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_periodo:notnull
	id_modalidad:notnull	
}
set list_modalidades [td_inac_procs::seleccionar_modalidades_para_periodos]
set periodo [td_inac_procs::seleccionar_periodo -id_periodo $id_periodo]
set lista_periodos [td_periodos::lista_periodos_por_modalidad -id_modalidad $id_modalidad ] 

set anio [clock format [clock seconds] -format "%Y"]

set num_periodo [lindex [lindex [lindex $periodo 0] 1] 0]
set anio [lindex [lindex $periodo 0] 2]
set fecha_inicio [lindex [lindex $periodo 0] 3]
set fecha_final [lindex [lindex $periodo 0] 4]

ad_form -name periodo -has_submit 1 -form {
    {periodo:integer(hidden) {value $id_periodo} {html {id "id_periodo"} } }
}

ad_form -name anio -has_submit 1 -form {
    {anio:integer(hidden) {value $anio} {html {id "valor_anio"} } }
}

ad_form  -name formulario -mode edit -has_submit 1 -form {
	{fecha_inicio:text(text)
	    {label "Fecha Inicio"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_inicio', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	    {value $fecha_inicio}
	}
	{fecha_final:text(text)
	    {label "Fecha Final"}
	    {format {[lc_get formbuilder_date_format]}}
	    {html {id start_date}}
	    {after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_final', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	    {value $fecha_final}
	}	
} -after_submit {
	ad_return_template
}

form create frm_seccion_general \
    -has_submit 1
    
element create frm_seccion_general cmb_modalidades \
    -label "Modalidad:" \
    -datatype text \
    -widget select \
    -html { style "width:150px" onChange "javascript:cargarComboPeriodos()" } \
    -options $list_modalidades \
    -value $id_modalidad

form create frm_num_periodos \
    -has_submit 1

element create frm_num_periodos cmb_periodos \
    -label "Número de período:" \
    -datatype text \
    -widget select \
    -options $lista_periodos \
    -value $num_periodo
