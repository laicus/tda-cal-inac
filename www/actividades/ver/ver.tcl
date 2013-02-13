#tda-cal-inac/www/actividades/ver/ver.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	{id_modalidad "%"}
	{id_calendario 0}
	{id_categoria "%"}
	{id_periodo "%"}
	{especial "%"}
	{accion "ver"} 
}

ad_form -name accion -has_submit 1 -form {
    {hiden_accion:integer(hidden) {value $accion} {html {id "hiden_accion"} } }
}

set especial 1
set lista_calendarios [concat { {"TODOS" "0"} } [td_calendarios::seleccionar_calendarios] ]
set list_modalidades [concat { {"TODOS" "%"} } [td_inac_procs::seleccionar_modalidades_por_calendario -id_calendario $id_calendario] ]

if { $especial == 0 } {

} else {
	set list_categorias [concat { {"TODOS" "%"} } [td_categorias::seleccionar_categorias_por_modalidad -id_modalidad $id_modalidad ]]
	set list_periodos [concat { {"TODOS" "%"} } [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad $id_modalidad -id_calendario $id_calendario ]]
}

form create frm_seccion_general -has_submit 1

element create frm_seccion_general cmb_calendarios \
    -label "Calendario:" \
    -datatype text \
    -widget select \
	-optional \
    -html { style "width:150px"  onChange "javascript:CargarModalidadXCalendario(0,1); javascript:cargar_actividades(); document.frm_seccion_modalidades.cmb_modalidades.disabled = false; document.frm_seccion_periodos.cmb_periodos.disabled = true; document.frm_seccion_categorias.cmb_categorias.disabled = true;" } \
    -options $lista_calendarios \
    -value $id_calendario

form create frm_seccion_modalidades \
    -has_submit 1
    
element create frm_seccion_modalidades cmb_modalidades \
    -label "Modalidades:" \
    -datatype text \
    -widget select \
	-optional \
    -html { style "width:150px" onChange "document.frm_seccion_periodos.cmb_periodos.disabled = true; javascript:cargarPeriodos(0,1); document.frm_seccion_categorias.cmb_categorias.disabled = true; " disabled "disabled"} \
    -options $list_modalidades \
    -value $id_modalidad

form create frm_seccion_periodos -has_submit 1

element create frm_seccion_periodos cmb_periodos \
    -label "Períodos:" \
    -datatype text \
    -widget select \
	-optional \
    -html { style "width:150px" onChange "document.frm_seccion_categorias.cmb_categorias.disabled = false; javascript:cargarCategorias(0,1);" disabled "disabled"} \
    -options $list_periodos \
    -value $id_periodo

    
form create frm_seccion_categorias -has_submit 1

element create frm_seccion_categorias cmb_categorias \
    -label "Categorías:" \
    -datatype text \
    -widget select \
	-optional \
    -html { style "width:150px" onChange "javascript:cargar_actividades()" disabled "disabled"} \
    -options $list_categorias \
    -value $id_categoria

template::head::add_javascript -src "resource/js/AjaxDinamico.js" -order 1
template::head::add_javascript -src "resource/js/actualizarModificar.js" -order 2
