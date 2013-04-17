#tda-cal-inac/tcl/periodos-procs.tcl
ad_library {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
}

# Definicion de Namespace
# ===========================================================
namespace eval ::td_periodos {}

# Definicion de Funciones
# ===========================================================

ad_proc -public td_periodos::obtener_id_periodo {
    {-nom_periodo:required}
    {-anio:required}
} {
} {
    return [db_string id_periodo {} -default -1]
}
