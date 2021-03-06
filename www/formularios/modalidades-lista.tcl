#tda-cal-inac/www/formularios/modalidades-lista.tcl
ad_page_contract {    
    Lista de modalidades para carga dinamica en la seleccion
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2012-12-09
    @cvs-id $Id$
} {
	es_modificar:notnull
	es_ver:notnull
	id_calendario:notnull
}

form create frm_seccion_modalidades -has_submit 1

#--------------------------------------------------------------------------------------------------
if { $es_modificar == 0 } {
	if {$es_ver == 1} {
		element create frm_seccion_modalidades cmb_modalidades \
		-label "Modalidades:" \
		-datatype text \
		-widget select \
    	-html { style "width:150px" onChange "javascript:cargarPeriodos(0,1);  javascript:cargar_actividades();"} \
		-optional \
		-options [concat { {"TODOS" "%"} } [td_inac_procs::seleccionar_modalidades_por_calendario -id_calendario $id_calendario]]
	} else {
		element create frm_seccion_modalidades cmb_modalidades \
		-label "Modalidades:" \
		-datatype text \
		-widget select \
		-html { style "width:150px" } \
    	-options [td_inac_procs::seleccionar_modalidades_por_calendario -id_calendario $id_calendario]
	}
} else {
		element create frm_seccion_modalidades cmb_modalidades \
		-label "Modalidades:" \
		-datatype text \
		-widget select \
		-html { style "width:150px" } \
	    -options [td_inac_procs::seleccionar_modalidades_por_calendario -id_calendario $id_calendario]
}
