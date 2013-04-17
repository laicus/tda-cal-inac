#tda-cal-inac/www/calendarios/ver/modificar_calendario.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_calendario:notnull
	anio:notnull
	fecha_publicacion:notnull
}

ad_form  -name formulario -mode edit -has_submit 1 -form {
	{txt_anio:text(text)
		{label "Año:"}
		{html {rows 1 cols 50}}
		{value $anio}
	}
	{fecha_publicacion:text(text)
		{label "Fecha publicación:"}
		{format {[lc_get formbuilder_date_format]}}
		{value $fecha_publicacion}
		{html {id start_date}}
		{after_html {<input type='reset' value=' ... ' onclick=\"return showCalendar('fecha_publicacion', 'yyyy-mm-dd');\"> \[<b>aaaa-mm-dd </b>\]}}
	}
}

ad_form -name calendario -has_submit 1 -form {
    {calendario:integer(hidden) 
        {value $id_calendario} 
        {html {id "id_calendario"} } 
    }
}



