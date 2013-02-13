set user [auth::require_login]
ad_page_contract {
    
    @author Jose Alberto Garita (vsolisrojas@gmail.com)
    @creation-date 2008-08-21
    @cvs-id $Id$
} {
} -validate {
} -errors {
}


set title "Calendario institucional y academico"



#Estilos YUI
template::head::add_css -href "/resources/acs-templating/yui/container/assets/skins/sam/container.css" -order 2


#Scripts JS YUI
template::head::add_javascript -src "/resources/acs-templating/yui/yahoo-dom-event/yahoo-dom-event.js" -order 2
template::head::add_javascript -src "/resources/acs-templating/yui/dragdrop/dragdrop-min.js" -order 3
template::head::add_javascript -src "/resources/acs-templating/yui/build/animation/animation-min.js" -order 4
template::head::add_javascript -src "/resources/acs-templating/yui/container/container-min.js" -order 5
template::head::add_javascript -src "/resources/acs-templating/yui/utilities/utilities.js" -order 6

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





