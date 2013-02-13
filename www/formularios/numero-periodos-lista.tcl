#tda-cal-inac/www/formularios/numero-periodos-lista.tcl
ad_page_contract {    
    Lista de periodos para un selec
    @author Isaac Alpízar (ialpizar@itcr.ac.cr)
    @creation-date 08-11-2008
    @cvs-id $Id$
} {
	id_modalidad
}

set lista_periodos [td_periodos::lista_periodos_por_modalidad -id_modalidad $id_modalidad] 

form create frm_num_periodos -has_submit 1

if {$lista_periodos == -1} {
	ns_write $lista_periodos 
} else {
	element create frm_num_periodos cmb_periodos \
	    -label "Número de período:" \
	    -datatype text \
	    -widget select \
	    -options $lista_periodos
}
