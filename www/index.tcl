#tda-cal-inac/www/index.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
}

set title "Calendario institucional y academico"

set user [auth::require_login]

#Estilo Jquery UI
#template::head::add_css -href "/resources/tda-cal-inac/css/ui-lightness/jquery-ui-1.10.0.custom.css" -order 1
#template::head::add_css -href "/resources/tda-cal-inac/css/ui-lightness/jquery-ui-1.10.0.custom.min.css" -order 2
template::head::add_css -href "resource/css/jquery-ui.css" -order 1
template::head::add_css -href "resource/css/estilospeg.css" -order 1


#Script Jquery UI
template::head::add_javascript -src "resource/js/jquery-1.9.0.js" -order 1
template::head::add_javascript -src "resource/js/jquery-ui.js" -order 2
template::head::add_javascript -src "resource/js/index.js" -order 3


#Funciones JS TEC_Digital
template::head::add_javascript -src "/resources/acs-templating/js/funcionesAjax.js" -order  7
template::head::add_javascript -src "/resources/acs-templating/js/funcionesImpresion.js" -order  8

#generales
template::head::add_javascript -src "resource/js/MetodosGenerales.js" -order 9

#funciones actividades 
template::head::add_javascript -src "resource/js/GestionActividades.js" -order 11

#funciones periodos
template::head::add_javascript -src "resource/js/GestionPeriodos.js" -order 14

#funciones categoria
template::head::add_javascript -src "resource/js/GestionCategorias.js" -order 16

#validaciones
template::head::add_javascript -src "resource/js/validaciones.js" -order 17

#calendarios
template::head::add_javascript -src "resource/js/GestionCalendarios.js" -order 18





