#tda-cal-inac/www/calendarios/ver/publicar_actividad.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	{id_actividad:notnull}
}

set res [td_calendarios::publicar_actividad -id_actividad $id_actividad]
ns_write $res
