#tda-cal-inac/www/periodos/ver/ver.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	id_modalidad:optional
}
template::head::add_javascript -src "resource/js/AjaxDinamico.js" -order 1
template::head::add_javascript -src "resource/js/actualizarModificar.js" -order 2
