#tda-cal-inac/tcl/calendarios-procs.tcl
ad_library {  
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
}

# Definicion de Namespace
# ===========================================================
namespace eval ::td_calendarios {}

# Definicion de Funciones
# ===========================================================

ad_proc -public td_calendarios::seleccionar_calendarios {
} {
    
    Selecciona la lista de calendarios disponibles
    Todavia no está en uso    
    @return Devuelve la lista de calendarios
} {
    db_transaction {
	    set lista_calendarios [db_list_of_lists seleccionar_calendarios {}]
    } on_error {
	    set lista_calendarios -1
    }
    return $lista_calendarios	
}

ad_proc -public td_calendarios::seleccionar_calendarios_para_grid {
	-multirow
} {
    Selecciona la lista de calendarios para un lista

    @param multirow Variable de la lista
    @return Devuelve 1 en caso de exito y -1 en caso de error
} {
	db_transaction {
		db_multirow $multirow seleccionar_calendarios_para_grid {}
		set retorno 1
	} on_error {
		set retorno -1
	}
    return $retorno	
}

ad_proc -public td_calendarios::verificar_calendario {
	{-anio:required}
} {
} {
	db_transaction {
		set existe [db_0or1row verificar_calendario {}]
	} on_error {
		set existe -1
	}
	return $existe
}

ad_proc -public td_calendarios::borrar_items_de_un_calendario {
	-id_calendario
} {
	Borrar los eventos de un calendario
	Todavia no está en uso
} {
		set retorno 1
		set lista_cal_item_ids [td_calendarios::obtener_id_cal_items_por_calendario -id_calendario $id_calendario]
		if { $lista_cal_item_ids != -1 } {
			foreach cal_item_id $lista_cal_item_ids {
                
				db_transaction {
					calendar::item::get -cal_item_id $cal_item_id -array cal_item
					calendar::item::delete -cal_item_id $cal_item_id
					calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
				} on_error {
                    set $retorno -1
				}
			}
		}
	return $retorno
}

ad_proc -public td_calendarios::obtener_id_cal_items_por_calendario {
	-id_calendario
} {
	Retorna los cal_item de un calendario
	Todavia no está
} {
	db_transaction {
		set retorno [db_list_of_lists obtener_id_cal_items_por_calendario {}]
	} on_error {
		set retorno -1
	}
	return $retorno
}
