ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {

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
