#tda-cal-inac/www/calendarios/ver/publicar-2.tcl
ad_page_contract {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
} {
	id_calendario:notnull
}

set res [td_calendarios::publicar_calendario -id_calendario $id_calendario ]
ns_write $res


