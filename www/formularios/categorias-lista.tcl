#tda-cal-inac/www/formularios/categorias-lista.tcl
ad_page_contract {    
    Lista de Planes para carga dinamica en la seleccion
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 24-10-2008
    @cvs-id $Id$
} {
	term_id:notnull	
	es_modificar:notnull
	es_ver:notnull
}

form create frm_seccion_categorias -has_submit 1

#--------------------------------------------------------------------------------------------------

if { $es_modificar == 0 } {
	if {$es_ver == 1} {
		element create frm_seccion_categorias cmb_categorias \
		    -label "Categorías:" \
		    -datatype text \
		    -widget select \
		    -html { style "width:150px" onChange "javascript:cargar_actividades()" } \
		    -optional \
		    -options [concat { {"TODOS" "%"} } [td_categorias::seleccionar_categorias_lista -term_id $term_id ]]
	} else {
		element create frm_seccion_categorias cmb_categorias \
		    -label "Categoría:" \
		    -datatype text \
		    -widget select \
		    -html { style "width:150px" } \
		    -options [td_categorias::seleccionar_categorias_por_modalidad -id_modalidad $id_modalidad]
	}
} else {
	element create frm_seccion_categorias cmb_categorias \
	    -label "Categoría:" \
	    -datatype text \
	    -widget select \
	    -html { style "width:150px" } \
	    -options [td_categorias::seleccionar_categorias_por_modalidad -id_modalidad $id_modalidad]
}
