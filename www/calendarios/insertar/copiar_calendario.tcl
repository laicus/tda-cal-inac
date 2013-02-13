ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$

} {

} -properties {
}


set lista_calendarios [td_calendarios::seleccionar_calendarios]


ad_form  -name formulario -mode edit -has_submit 1 -form {
	
	{txt_anio:text(text),optional
		{label "Año del nuevo calendario:"}
		{html {rows 1 cols 50}}
		{optional}
	}

}



form create frm_cmb_calendarios \
    -has_submit 1


element create frm_cmb_calendarios cmb_calendarios \
    -label "Calendario a copiar:" \
    -datatype text \
    -widget select \
	-optional \
    -html { style "width:100px" } \
    -options $lista_calendarios
