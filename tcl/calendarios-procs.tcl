#tda-cal-inac/tcl/calendarios-procs.tcl
ad_library {  
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-19
    @cvs-id $Id$
}

# Definicion de Namespace
# ===========================================================
namespace eval ::td_calendarios {}

# Definicion de Funciones
# ===========================================================

ad_proc -public td_calendarios::seleccionar_calendarios {
} {
    Todavia no esta en uso
    Selecciona la lista de calendarios disponibles
    
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

ad_proc -public td_calendarios::seleccionar_calendario_para_anio {
	-num_ano 
} {
} {
	db_transaction { 
		set retorno [db_string seleccionar_calendario_para_anio {}]
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::copiar_calendario {
	-id_calendario
	-anio_nuevo
	-fecha_publicacion
} {
} {
	db_transaction {
		set anio_viejo [td_calendarios::sacar_anio -id_calendario $id_calendario]
		set id_calendario_nuevo [td_calendarios::insertar_calendario -anio $anio_nuevo -fecha_publicacion $fecha_publicacion]
		if {$id_calendario_nuevo > 0} {
			td_inac_procs::copiar_periodos -anio_viejo $anio_viejo -anio_nuevo $anio_nuevo -id_calendario_viejo $id_calendario -id_calendario_nuevo $id_calendario_nuevo
			td_inac_procs::copiar_actividades -anio_viejo $anio_viejo -anio_nuevo $anio_nuevo -id_calendario_viejo $id_calendario -id_calendario_nuevo $id_calendario_nuevo
			set retorno 1
		} else {
			set retorno $id_calendario_nuevo
		}		
	} on_error {
		set retorno -2
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

ad_proc -public td_calendarios::insertar_calendario {
	{-anio:required}	
	{-fecha_publicacion:required}
} {
} {
	db_transaction {
		set existe [td_calendarios::verificar_calendario -anio $anio]
		if { $existe == 0 } {
			set salida [db_string insertar_calendario {}]
		} else {
			set salida -1
		}
	} on_error {
		set salida -2
	}
	return $salida
}

ad_proc -public td_calendarios::modificar_calendario {
	{-anio:required}
	{-id_calendario:required}	
	{-fecha_publicacion:required}
} {
} {
	db_transaction {
		set existe [td_calendarios::verificar_calendario_para_modificar -anio $anio -id_calendario $id_calendario]
		if {$existe == 0 } {
			db_dml modificar_calendario {}
			set salida 1
		} else {
			set salida -1
		}
	} on_error {
		set salida -2
	}
	return $salida
}

ad_proc -public td_calendarios::verificar_calendario_para_modificar {
	{-anio:required}
	{-id_calendario:required}
} {
} {
	db_transaction {
		set existe [db_0or1row verificar_calendario_para_modificar {}]
	} on_error {
		set existe -1
	}
	return $existe	
}

ad_proc -public td_calendarios::sacar_anio {
	{-id_calendario:required}
} {
} {
	db_transaction {
		set num_ano [db_string sacar_anio {}]
	} on_error {
		set num_ano -1
	}
	return $num_ano	
}

ad_proc -public td_calendarios::publicar_calendario {
	-id_calendario
} {
} {
	db_transaction {
		set actividades [ td_calendarios::seleccionar_actividades_no_publicadas -id_calendario $id_calendario ]
		foreach actividad $actividades {
			set id_actividad [lindex $actividad 0]
			td_calendarios::publicar_actividad -id_actividad $id_actividad	
		}
		set actividades [td_calendarios::seleccionar_actividades_especiales_no_publicadas -id_calendario $id_calendario ]
		foreach actividad $actividades {
			set id_actividad [lindex $actividad 0]
			td_calendarios::publicar_actividad -id_actividad $id_actividad
		}
		td_calendarios::setear_fecha_actualizacion -id_calendario $id_calendario
		set retorno 1
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::seleccionar_actividades_no_publicadas {
	-id_calendario
} {
} {
	db_transaction {
		set retorno [db_list_of_lists seleccionar_actividades_no_publicadas {} ]
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::seleccionar_actividades_especiales_no_publicadas {
	-id_calendario
} {
} {
	db_transaction {
		set retorno [db_list_of_lists seleccionar_actividades_especiales_no_publicadas {} ]
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::despublicar_actividad {
	-id_actividad
} {
} {
	db_transaction {
		set lista_cal_item_ids [td_inac_procs::obtener_id_cal_item_por_actividad -id_actividad $id_actividad]
		if { $lista_cal_item_ids != -1 } {
			foreach cal_item_id $lista_cal_item_ids {			
				calendar::item::get -cal_item_id $cal_item_id -array cal_item
				calendar::item::delete -cal_item_id $cal_item_id
				calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
			}
			db_dml despublicar_actividad {}
			set retorno 1
		}
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::borrar_items_de_un_calendario {
	-id_calendario
} {
} {
		set retorno 1
		set lista_cal_item_ids [td_calendarios::obtener_id_cal_items_por_calendario -id_calendario $id_calendario]
		if { $lista_cal_item_ids != -1 } {
			foreach cal_item_id $lista_cal_item_ids {
                puts $cal_item_id
				db_transaction {
					calendar::item::get -cal_item_id $cal_item_id -array cal_item
					calendar::item::delete -cal_item_id $cal_item_id
					calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
				} on_error {
                    puts "Error"
				}
			}
		}
	return $retorno
}

ad_proc -public td_calendarios::obtener_id_cal_items_por_calendario {
	-id_calendario
} {
} {
	db_transaction {
		set retorno [db_list_of_lists obtener_id_cal_items_por_calendario {}]
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::publicar_actividad {
	-id_actividad
} {
} {
	db_transaction {
		set actividad [td_calendarios::seleccionar_actividad_para_publicar -id_actividad $id_actividad]
		db_1row funcionarios { select calendar_id as funcionarios from calendars where calendar_name = 'Funcionarios ITCR' }
		set nom_actividad [lindex $actividad 1]
		set dsc_actividad [lindex $actividad 2]
		set fecha_inicio [lindex $actividad 3]
		set fecha_final [lindex $actividad 4]
		set date $fecha_inicio 
		set ansi_date $date
		set date [calendar::from_sql_datetime -sql_date $ansi_date  -format "YYY-MM-DD"]
		set start_time 7
		set start_minutes 30
		set start_hour $start_time
		set start_time "{} {} {} $start_time $start_minutes {} {HH24:MI}"
		set end_hour 16
		set end_minutes 30
		set end_time "{} {} {} $end_hour $end_minutes {} {HH24:MI}"
		set time_p 1
		set start_date [calendar::to_sql_datetime -date $date -time $start_time -time_p $time_p]
		set end_date [calendar::to_sql_datetime -date $date -time $end_time -time_p $time_p]
#quitar----------------
		set cal_item_profesor_id 1
		set cal_item_estudiante_id 2
#quitar----------------
		set cal_item_funcionario_id [calendar::item::new -start_date $start_date -end_date $end_date -name $nom_actividad -description $dsc_actividad -calendar_id $funcionarios]
		if { $fecha_inicio >= $fecha_final } {
			set repeat_p 0
		} else {
			set repeat_p 1
		}
		if { $repeat_p == 1 } {
			set recur_until $fecha_final
			set recur_until [calendar::from_sql_datetime -sql_date $recur_until  -format "YYY-MM-DD"]
			set interval_type "day"
			set every_n 1
			calendar::item::add_recurrence \
				-cal_item_id $cal_item_funcionario_id \
				-interval_type $interval_type \
				-every_n $every_n \
				-recur_until [calendar::to_sql_datetime -date $recur_until -time "" -time_p 0]
		}
		db_dml publicar_actividad {}
		td_calendarios::insertar_relacion_actividades_comunidades -id_actividad $id_actividad -cal_item_profesor_id $cal_item_profesor_id -cal_item_estudiante_id $cal_item_estudiante_id -cal_item_funcionario_id $cal_item_funcionario_id
		set retorno 1
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::seleccionar_actividad_para_publicar {
	-id_actividad
} {
} {
	db_transaction {
		set retorno [db_list_of_lists seleccionar_actividad_para_publicar {}]
		set retorno [lindex $retorno 0]
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::insertar_relacion_actividades_comunidades {
	-id_actividad
	-cal_item_profesor_id
	-cal_item_estudiante_id
	-cal_item_funcionario_id
} {
} {
	db_transaction {
		db_dml insertar_relacion_actividades_comunidades {}
		set retorno 1
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_calendarios::seleccionar_actividades_especiales_temporales_para_insertar {
} {
} {
	db_transaction {
		set retorno [ db_list_of_lists seleccionar_actividades_especiales_temporales_para_insertar {} ]
	} on_error {
		set retorno -1
	}
	return $retorno 
}

ad_proc -public td_calendarios::seleccionar_actividades_temporales_para_insertar {
} {
} {
	db_transaction {
		set retorno [ db_list_of_lists seleccionar_actividades_temporales_para_insertar {} ]
	} on_error {
		set retorno -1
	}
	return $retorno 
}

ad_proc -public td_calendarios::setear_fecha_actualizacion {
	-id_calendario 
} {
} {
	db_transaction {
		db_dml setear_fecha_actualizacion {}
		set retorno 1
	} on_error {
		set retorno -1
	}
	return $retorno 
}

ad_proc -public td_calendarios::seleccionar_actividades_a_publicar_por_calendario {
	-id_calendario
	-multirow
} {
} {
	db_transaction {
		db_multirow $multirow seleccionar_actividades_a_publicar_por_calendario {}
		set retorno 1
	} on_error {
		set retorno -1
	}
	return $retorno 
}

# funciones para eliminar un calendario
ad_proc -public td_calendarios::eliminar_calendario {
	-id_calendario
} {
} {
	db_transaction {
		set lista_cal_item_ids [td_calendarios::obtener_id_cal_item_a_eliminar_por_calendario -id_calendario $id_calendario]
		foreach cal_item_id $lista_cal_item_ids {					
			calendar::item::get -cal_item_id $cal_item_id -array cal_item
			calendar::item::delete -cal_item_id $cal_item_id
			calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
		}
		set lista_terms_borrar [td_calendarios::seleccionar_terms_a_borrar -id_calendario $id_calendario]
		foreach term_id $lista_terms_borrar {
			td_calendarios::eliminar_term -term_id $term_id
		}
		db_dml eliminar_calendario {}
		set retorno 1
	} on_error {
		set retorno -1
	}
	return $retorno 
}

ad_proc -public td_calendarios::obtener_id_cal_item_a_eliminar_por_calendario {
	-id_calendario
} {
} {
	return [db_list_of_lists obtener_id_cal_item_a_eliminar_por_calendario {} ]
}

ad_proc -public td_calendarios::seleccionar_terms_a_borrar {
	-id_calendario
} {
} {
	return [db_list seleccionar_terms_a_borrar {} ]
}

ad_proc -public td_calendarios::eliminar_term {
	-term_id
} {
} {
	return [db_dml eliminar_term {} ]
}
