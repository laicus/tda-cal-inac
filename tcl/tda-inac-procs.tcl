#tda-cal-inac/tcl/tda-inac-procs.tcl
ad_library {
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2013-04-16
    @cvs-id $Id$
}

# Definicion de Namespace
namespace eval ::td_inac_procs {}

# ===========================================================
# Definicion de Funciones
# ===========================================================


ad_proc -public td_inac_procs::seleccionar_modalidades_por_calendario {
	-id_calendario
} {
	Seleccionar modalidades por calendario
	@return lista de modalidades
} {
    return [db_list_of_lists seleccionar_modalidades_por_calendario {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_calendario {
	-id_modalidad
	-id_calendario
	-multirow
} {
	Seleccionar las actividades por las condiciones de los parámetros
	@param id_modalidad identificador de las modalidades
	@param id_calendario identificador de los periodos
	@return multirow de las actividades seleccionadas
} {
	return [db_multirow $multirow obtener_actividades_por_modalidad_calendario {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo {
	-id_modalidad
	-id_categoria
	-periodo
	-id_calendario
	-multirow
} {
	Seleccionar las actividades por las condiciones de los parámetros
	@param id_modalidad identificador de las modalidades
	@param id_categoria identificador de las modalidades
	@param periodo identificador de los periodos
	@param id_calendario año del periodo
	@return multirow de las actividades seleccionadas
} {
	if { $periodo == "TODOS" } { 
		set periodo "%"
	}
	return [db_multirow $multirow obtener_actividades_por_modalidad_categoria_periodo {}]
}

ad_proc -public td_inac_procs::obtener_todas_las_actividades {
	-multirow
	-sql_query
} {
	Obtener todas las actividades ordenadas por la ficha de inicio
	@param multirow valor en que se va cargar los datos de retorno
	@param sql_query consulta sql para condicionar la consulta
} {
	return [db_multirow $multirow obtener_todas_las_actividades {}]
}

ad_proc -public td_inac_procs::eliminar_actividad {
	-id_actividad	
} {
	Eliminar una actividad especifica incluyendo la publicacion en el calendario
	@param id_actividad Identificador de la actividad
} {
	db_transaction {
		
		#cargar los cal_item_id de las actividades publicadas	
		set lista_cal_item_ids [td_inac_procs::obtener_id_cal_item_por_actividad -id_actividad $id_actividad]
		set largo [llength $lista_cal_item_ids]
		set id_term_actividad [td_inac_procs::obtener_id_term_actividad_por_actividad -id_actividad $id_actividad]
		
		#eliminar de cal_actividad los registros de la actividad id_term_actividad
		db_dml eliminar_cal_actividad {}
		
		#eliminar las publicaciones de las comunidades
		if { $lista_cal_item_ids != -1 } {
			
			foreach cal_item_id $lista_cal_item_ids {
				
				if { $cal_item_id != "" } {
					calendar::item::get -cal_item_id $cal_item_id -array cal_item
					calendar::item::delete -cal_item_id $cal_item_id
					calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
				}
			}
			
		}
	
		#eliminar registro de actividad term
		db_dml eliminar_actividad_term {}
	
		#eliminar registro de actividad
		db_dml eliminar_actividad {}
	
		set retorno 1
		 	
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_inac_procs::obtener_id_cal_item_por_actividad {
	-id_actividad
} {
	Obtener el identificador de una actividad en cal_actividad
	@param id_actividad Identificador de la actividad
} {
	db_transaction {
		set retorno [db_list obtener_id_cal_item_por_actividad {}]
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_inac_procs::obtener_id_term_actividad_por_actividad {
	-id_actividad
} {
	devuelve el id_term_actividad de una actividad especifica
	@param id_actividad Identificador de la actividad
} {
	db_transaction {
		set retorno [db_list_of_lists obtener_id_term_actividad_por_actividad {}]
	} on_error {
		set retorno -1
	}
	return $retorno
}


ad_proc -public td_inac_procs::seleccionar_actividad {
	-id_actividad
} {
	Devuelve los datos de una actividad específica
	@param id_actividad Identificador de la actividad
} {
	return [db_list_of_lists seleccionar_actividad {}] 
}

ad_proc -public td_inac_procs::seleccionar_actividad_publicacion {
	-id_actividad
} {
	Devuelve los nombre de los calendarios de las comunidades
	@param id_actividad Identificador de la actividad
} {
	return [db_list_of_lists seleccionar_actividad_publicacion {}] 
}

ad_proc -public td_inac_procs::seleccionar_actividad_para_ver {
	-id_actividad
} {
	Devuelve una actividad específica
	@param id_actividad Identificador de la actividad
} {
	return [db_list_of_lists seleccionar_actividad_para_ver {}] 
}


ad_proc -public td_inac_procs::seleccionar_actividades_por_calendario {
	-multirow
	-id_calendario	
} {
	Devuelve las actividades por año
} {
	return [db_multirow $multirow seleccionar_actividades_por_calendario {}]
}


ad_proc -public td_inac_procs::seleccionar_comunidades {	
} {
	returna la lista de las comunidades	
} {
	return [db_list_of_lists seleccionar_comunidades {}]
}

