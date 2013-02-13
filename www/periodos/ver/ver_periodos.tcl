#tda-cal-inac/www/periodos/ver/ver_periodos.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	{id_modalidad "%"}
	especial:optional
}

set list_modalidades [concat { {"TODOS" "%"} } [td_inac_procs::seleccionar_modalidades_para_periodos]]
set lista_calendarios [concat { {"TODOS" "%"} } [td_calendarios::seleccionar_calendarios] ]

ad_form  -name formulario -mode edit -has_submit 1 -form  {
	{cmb_calendarios:text(select),optional
	    {label "Calendario:"}
	    {options $lista_calendarios}
	    {html { style "width:150px"  onChange "javascript:cargar_periodos()"} } 
	}
	{cmb_modalidades:text(select),optional
	    {label "Modalidades"}
	    {options $list_modalidades}
	    {html {style "width:150px"  onChange "javascript:cargar_periodos()"} } 
	}
} -after_submit {
	ad_return_template
}

set title "Períodos"