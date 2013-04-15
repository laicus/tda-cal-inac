#tda-cal-inac/www/formularios/periodos-lista.tcl
ad_page_contract {    
    Lista de Planes para carga dinamica en la seleccion
    @author Marco Loaiza (mloaiza@gmail.com)
    @creation-date 24-10-2008
    @cvs-id $Id$
} {
	id_modalidad:notnull
	es_modificar:notnull
	es_ver:notnull
	id_calendario:notnull
}

form create frm_seccion_periodos -has_submit 1

#--------------------------------------------------------------------------------------------------

if { $es_modificar == 0 } {
	if {$es_ver == 1} {
		element create frm_seccion_periodos cmb_periodos \
		    -label "Períodos:" \
		    -datatype text \
		    -widget select \
		    -html { style "width:150px" onChange "javascript:cargarCategorias(0,1); javascript:cargar_actividades()" } \
		    -optional \
		    -options [concat { {"TODOS" "%"} } [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad $id_modalidad -term_year $id_calendario]]
	} else {
		element create frm_seccion_periodos cmb_periodos \
		    -label "Período:" \
		    -datatype text \
		    -widget select \
		    -html { style "width:150px" } \
        	-options [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad $id_modalidad -term_year $id_calendario]
	}
} else {
	element create frm_seccion_periodos cmb_periodos \
	    -label "Período:" \
        -datatype text \
        -widget select \
        -html { style "width:150px" } \
        -options [td_categorias::seleccionar_periodos_por_modalidad -id_modalidad $id_modalidad -term_year $id_calendario]
}
