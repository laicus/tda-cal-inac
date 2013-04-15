#tda-cal-inac/tcl/categoria-procs.tcl
ad_library {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-19
    @cvs-id $Id$
}

# Definicion de Namespace
# ===========================================================
namespace eval ::td_categorias {}

# Definicion de Funciones
# ===========================================================

ad_proc -public td_categorias::seleccionar_categoria {
    -id_categoria:required
} {
    Devuelve la información de la categoria
    
    @param id_categoria Identificador de la categoria
    @return Devuelve el nombre y la descripción de la categoria. Blanco en caso de error.
} {
    set resultado {"" ""}
    # Bloque de transaccion
	db_transaction {
	    # Busca la informacion de la categoria
		if { [db_0or1row seleccionar_categoria {}]} {
			# Devuelve la informacion
			set resultado [list $nom_categoria $dsc_categoria]
		}
	}
	return $resultado
}

ad_proc -public td_categorias::eliminar_categoria {
    {-id_categoria:required}
} {
    Realiza el borrado de una categoria
    @param id_categoria Identificador de la categoria
} {
	set retorno ""
    # Abre el bloque de transacciones de base de datos
	db_transaction {
	    # Verifica que exista la categoria
		if {[db_0or1row existe_actividad_con_categoria {}] != 1 }  {
		    # Borra las modalidades asociadas a la categoria
			#db_dml eliminar_categoria_modalidad {}
			# Borra la categoria
			db_dml eliminar_categoria {}
			# Guarda el valor de 1
			set retorno 1
	    # En caso de que no exista
		} else {
		    # Devuelve el valor de -1
			set retorno -1
		}
    # En caso de error de base de datos
	} on_error {
	    # Devuelva -2
		set retorno -2
	}
	# Devuelve el codigo de respuesta
	return $retorno
}

ad_proc -public td_categorias::seleccionar_categorias {
} {
} {
	db_transaction { 
		set lista [db_list_of_lists seleccionar_categorias {}]
	} on_error {
		set lista -1
	}
    return $lista
}

ad_proc -public td_categorias::seleccionar_categorias_para_grid {
	-multirow
} {
    Selecciona las categorias disponibles en la base de datos
    
    @param multirow Lista donde se almacena la respuesta
    @return Devuelve 1 en caso de exito, y -1 en caso de error
} {
    # Bloque de base de datos
	db_transaction { 
	    # Realiza el llenado de la lista
		db_multirow $multirow seleccionar_categorias {}
		return 1
	} on_error {
		return -1
	}
}

ad_proc -public td_categorias::seleccionar_categorias_lista {
  {-term_id:required}
} {
} {
	db_transaction {
		set lista [db_list_of_lists seleccionar_categorias_lista {}]
	} on_error {
		set lista -1
	}
	return $lista
}

ad_proc -public td_categorias::insertar_categoria {
    {-nom_categoria:required}
    {-dsc_categoria:required}
    
} {
    Función encargada de agregar de insertar las categorias
    
    @param nom_categoria Nombre de la categoria
    @param dsc_categoria Descripción de la categoria
    @param lst_modalidades Lista de modalidades
    @return Devuelve 1 en caso exitos, -1 y -2 en caso de error
} {
    # Bloque de transaccion de base de datos
    set salida ""
	db_transaction {
	    # Verifica si existe la categoria en la base de datos
		set id_categoria [db_string seleccionar_categoria_por_nombre {} -default ""]
		# Si no existe la categoria
		if { $id_categoria == "" } {
		    # Guarda la categoria y almacena el identificador
			set id_categoria [db_string insertar_categoria {}]
			# REVISAR, PROBLEMA DE LISTA DENTRO DE LISTA
			#set lst_modalidades [lindex $lst_modalidades 0]
			# Por cada modalidad
			#foreach id_modalidad $lst_modalidades {
			    # Guarde la categoria y la modalidad
				#db_dml insertar_categoria_modalidad {}
			#}
			# Termina con exito
			set salida 1;
		} else {
		    # Error la categoria ya existe
			set salida -1;
		}
	} on_error {
	    # Error de base de datos
	    set salida -2;
	}
	return $salida;
}

ad_proc -public td_categorias::modificar_categoria {
    {-nom_categoria:required}
    {-dsc_categoria:required}    
    {-id_categoria:required}
} {
    Función encargada de realizar la actualización de la categoria
    
    @param nom_categoria Nombre de la categoría
    @param dsc_categoria Descripción de la categoría
    @param id_categoria Identificador de la categoría
    @return Devuelve 1 en caso de exito, 0 en cualquier otro caso
} {
    #Abre el bloque de transacciones
	db_transaction {
	    #Realiza la actualizacion
		db_dml modificar_categoria {}
		#elimina publicacion del calendar y elimina los datos de cal_actividad
		
		#ingresa la nueva publicacion e ingresa los datos en cal_actividad
		
		
		#Almacena el valor de salida
		set salida 1;
	} on_error {
	    #En caso de error guarda el valor de salida
		set salida -1;
	}
	#Devuelve el valor de salida
	return $salida;
}

ad_proc -public td_categorias::seleccionar_modalidades {
} {
} {
	db_transaction {
		set lista [db_list_of_lists seleccionar_modalidades {}]		
	} on_error {
		set lista  -1
	}
	return $lista
}

ad_proc -public td_categorias::seleccionar_modalidades_por_categoria {
    {-id_categoria:required}
} {
    Devuelve la lista de modalidades para una categoria
    
    @param id_categoria Identificador de la categoria
    @return Devuelve la lista con las categorias
} {
	return [db_list_of_lists seleccionar_modalidades_por_categoria {}]		
}

ad_proc -public td_categorias::seleccionar_actividades_temporales  {
	-multirow
	-sql_query	
} {
} {
	
	db_transaction {
		
		return [db_multirow $multirow seleccionar_actividades_temporales {}]
		
	} on_error {
		return -1
	}
}

ad_proc -public td_categorias::seleccionar_actividades  {
	-multirow
} {
	@multirow estructura donde almacena las actividades
} {
	db_transaction {	
		return [db_multirow $multirow seleccionar_actividades {}]
	} on_error {
		return -1
	}
}



ad_proc -public td_categorias::seleccionar_actividades  {
	-multirow
} {
} {
	db_transaction {	
		return [db_multirow $multirow seleccionar_actividades_temporales {}]
	} on_error {
		return -1
	}
}


ad_proc -public td_categorias::insertar_actividades_temporales  {
	-nom_actividad
	-dsc_actividad
	-nom_categoria
	-nom_modalidad
	-nom_periodo
	-fecha_inicio
	-fecha_final
	-id_calendario
	-calendario
	-id_categoria
	-id_modalidad
	-id_periodo
	-comunidades
	-estado_publicacion
} {
} {
	db_transaction {
		set repetidas [db_list_of_lists validar_actividad_con_no_temporales {}]
		
		if {[llength $repetidas] != 0 } {
		
			set retorno -2
		
		} else {
			
			set id_actividad [td_categorias::insertar_actividad -nom_actividad $nom_actividad -dsc_actividad $dsc_actividad -id_categoria $id_categoria -id_modalidad $id_modalidad -id_periodo $id_periodo -fecha_inicio $fecha_inicio -fecha_final $fecha_final -id_calendario $id_calendario -comunidades $comunidades -estado_publicacion $estado_publicacion]
			if { $id_actividad > 0 } {				
				#db_dml insertar_actividades_temporales {}
				set retorno 1
			} else {
				set retorno -5				
			}			
		}	
	} on_error {
		set retorno -4
	}
	return $retorno
}

ad_proc -public td_categorias::seleccionar_periodos_por_modalidad {
	{-id_modalidad}
	{-term_year}
} {
} {
	db_transaction {
		set lista [db_list_of_lists seleccionar_periodos_por_modalidad {}]
	} on_error {
		set lista -1
	}
	return $lista
}

ad_proc -public td_categorias::eliminar_actividad_temporal {
	{-id_actividad}
} {
} {
	db_transaction {
		db_dml eliminar_actividad_temporal {}
		set retorno 1
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_categorias::validar_actividades {
	-actividades
} {
} {
	foreach actividad $actividades {
		set nom_actividad [lindex $actividad 0]
		set dsc_actividad [lindex $actividad 1]
		set id_modalidad [lindex $actividad 2]
		set id_categoria [lindex $actividad 3]
		set id_periodo [lindex $actividad 4]
		set fecha_inicio [lindex $actividad 5]
		set fecha_final [lindex $actividad 6]
		set repetidas [db_list_of_lists validar_actividad_con_no_temporales {}]
		if {[llength $repetidas] != 0 } {
			return -1
		} else { 
			set repetidas [db_list_of_lists validar_actividad_con_no_temporales_especial {}]
			if {[llength $repetidas] != 0 } {
				return -1
			}
		}
	}
	return 1
}

ad_proc -public td_categorias::submit_actividades {
} {
} {
	db_transaction {	
		set actividades [db_list_of_lists seleccionar_actividades_temporales_para_insertar {}]
		set entro 0
		set err [td_categorias::validar_actividades -actividades $actividades]
		if {$err == 1} {
			foreach actividad $actividades {
				set nom_actividad [lindex $actividad 0]
				set dsc_actividad [lindex $actividad 1]
				set id_modalidad [lindex $actividad 2]
				set id_categoria [lindex $actividad 3]
				set id_periodo [lindex $actividad 4]
				set fecha_inicio [lindex $actividad 5]
				set fecha_final [lindex $actividad 6]
				set id_calendario [lindex $actividad 7]
				set id_actividad [ db_string insertar_actividad {} ]
				db_dml insertar_modalidadxactividad {}
				db_dml insertar_periodoxactividad {}
			}
			set actividades [db_list_of_lists seleccionar_actividades_especiales_temporales_para_insertar {}]
			foreach actividad $actividades {
				set nom_actividad [lindex $actividad 0]
				set dsc_actividad [lindex $actividad 1]
				set id_modalidad [lindex $actividad 2]
				set id_categoria [lindex $actividad 3]
				set fecha_inicio [lindex $actividad 4]
				set fecha_final [lindex $actividad 5]
				set id_calendario [lindex $actividad 6]
				set id_actividad [ db_string insertar_actividad {} ]
				db_dml insertar_modalidadxactividad {}
			}
			db_dml eliminar_actividades_temporales {} 
			set salida 1
		} else {
			set salida -1				
		}
	} on_error {
		set salida -2
	}
	return $salida
}

ad_proc -public td_categorias::eliminar_actividades_temporales {	
} {
} {
	db_dml eliminar_actividades_temporales {} 
}

ad_proc -public td_categorias::seleccionar_periodo {
	-term_id
} {
} {
	db_transaction {
		set periodo [db_string seleccionar_periodo {}]
	} on_error { 
		set periodo -1
	}
	return $periodo
}

ad_proc -public td_categorias::obtener_estado_publicacion {
	-id_actividad
} {
} {
	db_transaction {
		set retorno [db_string obtener_estado_publicacion {}]
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_categorias::modificar_actividad {
	-id_actividad	
	-nom_actividad
	-dsc_actividad
	-term_id
	-id_categoria	
	-fecha_inicio
	-fecha_final
	-comunidades
	-estado_publicacion
} {
	
} {	
	db_transaction {
		puts "entro a modificar actividad  $id_actividad $nom_actividad -dsc_actividad $dsc_actividad -id_categoria $id_categoria -id_periodo $term_id -fecha_inicio $fecha_inicio -fecha_final $fecha_final -comunidades $comunidades -estado_publicacion $estado_publicacion"
			
		#modificar los valores de la actividad
		db_dml modificar_actividad {}
		
		#modificar actividad_term
		set id_term_actividad [db_string  modificar_actividad_term {}]
		
		#consultar las comunidades de los calendarios		
		set lista_cal_item_ids [td_inac_procs::obtener_id_cal_item_por_actividad -id_actividad $id_actividad]
		set publicaciones [td_inac_procs::seleccionar_actividad_publicacion -id_actividad $id_actividad]
		set estado_original [lindex $publicaciones 0 2]
		
		puts "publicaciones aqui $lista_cal_item_ids  estado original $estado_original y nuevo estado es $estado_publicacion"
		
		db_dml eliminar_cal_actividad {}
		
		#recorrer las cal_item_id de las comunidades de los calendarios para ser eliminados
		if { $lista_cal_item_ids != -1 } {
			foreach cal_item_id $lista_cal_item_ids {
				if { $cal_item_id != "" } {	
					calendar::item::get -cal_item_id $cal_item_id -array cal_item
					calendar::item::delete -cal_item_id $cal_item_id
					calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
					puts "cal_item_id es $cal_item_id"
				}	
			}
		}
				
		#si va a publicar
		if { $estado_publicacion == 1} {
			
			set s $nom_actividad
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
	           
			#Insertar actividad en el calendario del calendars
			foreach calendar_id $comunidades {
				
				set cal_item_id [calendar::item::new -start_date $start_date -end_date $end_date -name $nom_actividad -description $dsc_actividad -calendar_id $calendar_id]
				if { $fecha_inicio >= $fecha_final } {
					set repeat_p 0
				} else {
					set repeat_p 1
				}
				# Fecha inicio < que ficha final
				if { $repeat_p == 1 } {
					set recur_until $fecha_final
					set recur_until [calendar::from_sql_datetime -sql_date $recur_until  -format "YYY-MM-DD"]
					set interval_type "day"
					set every_n 1
					calendar::item::add_recurrence \
						-cal_item_id $cal_item_id \
						-interval_type $interval_type \
						-every_n $every_n \
						-recur_until [calendar::to_sql_datetime -date $recur_until -time "" -time_p 0]
				}
				#insertar en cal_actividad
				#id_term_activad, calendar_id, estado_publicacion, cal_item_id	
				db_dml insertar_cal_actividad {}			
			}
		} else { 
					
			#Insertar insertar_cal_actividad
			foreach calendar_id $comunidades {
				
				set cal_item_id ""
				db_dml insertar_cal_actividad {}
			}
		}
		
		set salida 1
		
	} on_error {
		set salida -1
	}
	return $salida
}

ad_proc -public td_categorias::insertar_actividad {
	-nom_actividad
	-dsc_actividad
	-id_categoria
	-id_modalidad
	-id_periodo
	-fecha_inicio
	-fecha_final
	-id_calendario
	-comunidades
	-estado_publicacion
} {
} {
	db_transaction {
		puts "===================............. INICIO PROCESO DE INSERCION...."	
		if { $estado_publicacion } {
		
			set s $nom_actividad
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
			
			# Insertar actividad
            puts "===========........ Se va a insertar la actividad..."
			set id_actividad [ db_string insertar_actividad {} ]
            
            
            # Insertar fechas y periodo de actividad
			set id_term_activad [db_string insertar_actividad_term {}]
			
			#Insertar actividad en el calendario del calendars
			foreach calendar_id $comunidades {
				
				set cal_item_id [calendar::item::new -start_date $start_date -end_date $end_date -name $nom_actividad -description $dsc_actividad -calendar_id $calendar_id]
				if { $fecha_inicio >= $fecha_final } {
					set repeat_p 0
				} else {
					set repeat_p 1
				}
				# Fecha inicio < que ficha final
				if { $repeat_p == 1 } {
					set recur_until $fecha_final
					set recur_until [calendar::from_sql_datetime -sql_date $recur_until  -format "YYY-MM-DD"]
					set interval_type "day"
					set every_n 1
					calendar::item::add_recurrence \
						-cal_item_id $cal_item_id \
						-interval_type $interval_type \
						-every_n $every_n \
						-recur_until [calendar::to_sql_datetime -date $recur_until -time "" -time_p 0]
				}
				db_dml insertar_cal_actividad {}
				
			}			

		} else { 
			
			# ============================
			# AUN NO SE VA A PUBLICAR
			# ============================
			# Insertar actividad
            puts "===========........ Se va a insertar la actividad..."
			set id_actividad [ db_string insertar_actividad {} ]
            #puts "===========........ Se inserto la actividad... RESULTADO $id_actividad"
            # Insertar fechas y periodo de actividad
			
			set id_term_actividad [db_string insertar_actividad_term {}]
			
			#Insertar insertar_cal_actividad
			foreach calendar_id $comunidades {
				set cal_item_id ""
				db_dml insertar_cal_actividad {}
			}
            
			
		}
		set retorno $id_actividad
	} on_error { 
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_categorias::copiar_actividad {
	-nom_actividad
	-dsc_actividad
	-id_categoria
	-id_modalidad
	-id_periodo
	-fecha_inicio
	-fecha_final
	-id_calendario
	-estado_publicacion
} {
} {
	db_transaction {
		set id_actividad [ db_string insertar_actividad {} ]
		db_dml insertar_modalidadxactividad {}
		if {$id_modalidad != "O"} {
			db_dml insertar_periodoxactividad {}
		}
		set retorno 1
	} on_error { 
		set retorno -1
	}
	return retorno	
}
