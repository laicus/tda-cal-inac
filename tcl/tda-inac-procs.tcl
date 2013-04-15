#tda-inac-procs.tcl
ad_library {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com) 
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2009-01-19
    @cvs-id $Id$
}

# Definicion de Namespace
# ===========================================================
namespace eval ::td_inac_procs {}

# Definicion de Funciones
# ===========================================================

ad_proc -public td_inac_procs::seleccionar_modalidades {
	
} {
    Devuelve la lista de las modalidades disponibles
    #Modificado por Ederick Navas (enavas@itcr.ac.cr)
} {
	
    #return [concat [td_periodo::modalidades_disponibles] {{NO APLICA NA}}]
    #Crea una variable de lista vacia
    #set lista [list]
    #Carga la lista de modalidades
    #set periodos [td_periodo::modalidades_disponibles]
    #set periodos [db_list_of_lists seleccionar_modalidades_para_periodos {}]
    #Por cada modalidad quita deja el codigo como solo una letra
    #foreach periodo $periodos {
    #    lappend lista [list [lindex $periodo 0] [lindex [split [lindex $periodo 1] .] 0]]
    #}
    
    return [db_list_of_lists seleccionar_modalidades {}]
}

ad_proc -public td_inac_procs::seleccionar_modalidades_para_periodos {
} {
} {
    return [db_list_of_lists seleccionar_modalidades_para_periodos {}]
}


ad_proc -public td_inac_procs::seleccionar_modalidades_por_calendario {
	-id_calendario
} {
} {
    return [db_list_of_lists seleccionar_modalidades_por_calendario {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_y_categoria {
	-id_modalidad
	-id_categoria
	-multirow
} {
} {
	return [db_multirow $multirow obtener_actividades_por_modalidad_y_categoria {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad {
	-id_modalidad
	-id_categoria
	-multirow
} {
} {
	return [db_multirow $multirow obtener_actividades_por_modalidad {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_calendario {
	-id_modalidad
	-id_calendario
	-multirow
} {
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
} {
	if { $periodo == "TODOS" } { 
		set periodo "%"
	}
	return [db_multirow $multirow obtener_actividades_por_modalidad_categoria_periodo {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_todas_categorias_periodo {
	-id_modalidad
	-periodo
	-id_calendario
	-multirow
} {
} {
	if { $periodo == "TODOS" } { 
		set periodo "%"
	}
	return [db_multirow $multirow obtener_actividades_por_modalidad_todas_categorias_periodo {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_todas_categorias {
	-id_modalidad
	-id_calendario
	-multirow
} {
} {
	return [db_multirow $multirow obtener_actividades_por_modalidad_todas_categorias {}]
}

ad_proc -public td_inac_procs::obtener_actividades_por_modalidad_categoria {
	-id_modalidad
	-id_categoria
	-id_calendario
	-multirow
} {
} {
	return [db_multirow $multirow obtener_actividades_por_modalidad_categoria {}]
}

ad_proc -public td_inac_procs::obtener_actividades_regulares_para_visualizador {
	-id_modalidad
	-id_categoria
	-periodo
	-id_calendario
	-multirow
} {
} {
	if { $periodo == "TODOS" } { 
		set periodo "%"
	}
	return [db_multirow $multirow obtener_actividades_regulares_para_visualizador {}]
}

ad_proc -public td_inac_procs::obtener_actividades_especiales_para_visualizador {
	-id_modalidad
	-id_categoria
	-id_calendario
	-multirow
} {
} {
	return [db_multirow $multirow obtener_actividades_especiales_para_visualizador {}]
}

ad_proc -public td_inac_procs::obtener_todas_las_actividades {
	-multirow
	-sql_query
} {
} {
	return [db_multirow $multirow obtener_todas_las_actividades {}]
}

ad_proc -public td_inac_procs::eliminar_actividad {
	-id_actividad	
} {
	Eliminar una actividad especifica incluyendo la publicacion en el calendario
} {
	db_transaction {
		
		#cargar los cal_item_id de las actividades publicadas	
		set lista_cal_item_ids [td_inac_procs::obtener_id_cal_item_por_actividad -id_actividad $id_actividad]
		set largo [llength $lista_cal_item_ids]
		set id_term_actividad [td_inac_procs::obtener_id_term_actividad_por_actividad -id_actividad $id_actividad]
		puts "paso1 con largo de $largo"
		#eliminar de cal_actividad los registros de la actividad id_term_actividad
		db_dml eliminar_cal_actividad {}
		puts "paso2"
		#eliminar las publicaciones de las comunidades
		if { $lista_cal_item_ids != -1 } {
			puts "paso3"
			puts "$lista_cal_item_ids"
			foreach cal_item_id $lista_cal_item_ids {
				puts "cal_item_id es $cal_item_id"
				if { $cal_item_id != "" } {
					calendar::item::get -cal_item_id $cal_item_id -array cal_item
					calendar::item::delete -cal_item_id $cal_item_id
					calendar::item::delete_recurrence -recurrence_id $cal_item(recurrence_id)
				}
			}
			puts "paso4"
		}
		puts "paso5"
		#eliminar registro de actividad term
		db_dml eliminar_actividad_term {}
		puts "paso6"
		#eliminar registro de actividad
		db_dml eliminar_actividad {}
		puts "paso7"
		set retorno 1
		 	
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_inac_procs::eliminar_modalidadesxactividad {
	-id_actividad
} {
} {
	return [db_list_of_lists eliminar_modalidadesxactividad {}] 
}

ad_proc -public td_inac_procs::eliminar_periodosxactividades {
	-id_actividad
} {
} {
	return [db_list_of_lists eliminar_periodosxactividades {}] 
}

ad_proc -public td_inac_procs::obtener_id_cal_item_por_actividad {
	-id_actividad
} {
} {
	db_transaction {
		set retorno [db_string obtener_id_cal_item_por_actividad {}]
	} on_error {
		set retorno -1
	}
	return $retorno
}

ad_proc -public td_inac_procs::obtener_id_term_actividad_por_actividad {
	-id_actividad
} {
	devuelve el id_term_actividad de una actividad especifica
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
} {
	return [db_list_of_lists seleccionar_actividad {}] 
}

ad_proc -public td_inac_procs::seleccionar_actividad_publicacion {
	-id_actividad
} {
	Devuelve los nombre de los calendarios de las comunidades
} {
	return [db_list_of_lists seleccionar_actividad_publicacion {}] 
}

ad_proc -public td_inac_procs::seleccionar_actividad_para_ver {
	-id_actividad
} {
} {
	return [db_list_of_lists seleccionar_actividad_para_ver {}] 
}

ad_proc -public td_inac_procs::seleccionar_actividad_especial {
	-id_actividad
} {
} {
	return [db_list_of_lists seleccionar_actividad_especial {}] 
}

ad_proc -public td_inac_procs::seleccionar_actividad_especial_para_ver {
	-id_actividad
} {
} {
	return [db_list_of_lists seleccionar_actividad_especial_para_ver {}] 
}

ad_proc -public td_inac_procs::seleccionar_periodos_por_modalidad_para_grid {
	-id_modalidad
	-id_calendario
	-num_ano
	-multirow
} {
} {
	return [db_multirow $multirow seleccionar_periodos_por_modalidad_para_grid {}]
}

ad_proc -public td_inac_procs::seleccionar_periodos_por_modalidad_para_grid_todos {
	-id_modalidad
	-num_ano
	-multirow
} {
} {
	return [db_multirow $multirow seleccionar_periodos_por_modalidad_para_grid_todos {}]
}

ad_proc -public td_inac_procs::seleccionar_periodo {
	-id_periodo
} {
} {
	return [db_list_of_lists seleccionar_periodo {}] 
}

ad_proc -public td_inac_procs::copiar_periodos {
	-anio_viejo
	-anio_nuevo
	-id_calendario_viejo
	-id_calendario_nuevo
} {
} {
	db_transaction {	
		set  lista_periodos [td_inac_procs::seleccionar_periodos_por_calendario -id_calendario_viejo $id_calendario_viejo]
		foreach periodo $lista_periodos {
			set term_name [lindex $periodo 0]
			set id_modalidad [lindex $periodo 1]		
    		set anio $anio_nuevo
			set fecha_inicio [lindex $periodo 3]
			set fecha_final [lindex $periodo 4]
    		set num_periodo [lindex $periodo 5]
			regsub -all $anio_viejo $fecha_inicio $anio_nuevo fecha_inicio
			regsub -all $anio_viejo $fecha_final $anio_nuevo fecha_final
			td_periodos::insertar_periodo -id_modalidad $id_modalidad -anio $anio_nuevo -num_periodo $num_periodo -fecha_inicio $fecha_inicio -fecha_final $fecha_final -term_name $term_name -id_calendario $id_calendario_nuevo
		}
		set salida 1
	} on_error {
		set salida -1
	}
	return $salida
}

ad_proc -public td_inac_procs::copiar_actividades {
	-anio_viejo
	-anio_nuevo
	-id_calendario_viejo
	-id_calendario_nuevo
} {
} {
	db_transaction {
		set lista_actividades [concat [td_inac_procs::seleccionar_actividades_por_anio -id_calendario_viejo $id_calendario_viejo] [td_inac_procs::seleccionar_actividades_especiales_por_anio -id_calendario_viejo $id_calendario_viejo]]
		foreach actividad $lista_actividades {
			set nom_actividad [lindex $actividad 0]
			set dsc_actividad [lindex $actividad 1]
			set id_modalidad [lindex $actividad 2]
			set id_categoria [lindex $actividad 3]
			set nom_periodo [lindex $actividad 4]
			set anio_periodo [lindex $actividad 5]
			set fecha_inicio [lindex $actividad 6]
			set fecha_final [lindex $actividad 7]
			set estado_publicacion [lindex $actividad 8]
			regsub -all $anio_viejo $fecha_inicio $anio_nuevo fecha_inicio
			regsub -all $anio_viejo $fecha_final $anio_nuevo fecha_final
			set id_periodo [td_periodos::obtener_id_periodo -nom_periodo $nom_periodo -anio $anio_nuevo]
			td_categorias::copiar_actividad -nom_actividad $nom_actividad -dsc_actividad $dsc_actividad -id_categoria $id_categoria -id_modalidad $id_modalidad -id_periodo $id_periodo -fecha_inicio $fecha_inicio -fecha_final $fecha_final -id_calendario $id_calendario_nuevo -estado_publicacion $estado_publicacion 
		}
		set salida 1
	} on_error {
		set salida -1
	}
	return $salida
}

ad_proc -public td_inac_procs::seleccionar_periodos_por_calendario {
	-id_calendario_viejo
} {
} {
	return [db_list_of_lists seleccionar_periodos_por_calendario {}]
}

ad_proc -public td_inac_procs::seleccionar_actividades_por_anio {
	-id_calendario_viejo
} {
} {
	return [db_list_of_lists seleccionar_actividades_por_anio {}]
}

ad_proc -public td_inac_procs::seleccionar_actividades_especiales_por_anio {
	-id_calendario_viejo
} {
} {
	return [db_list_of_lists seleccionar_actividades_especiales_por_anio {}]
}

ad_proc -public td_inac_procs::seleccionar_periodos_por_calendario_para_grid {
	-id_calendario
	-multirow
} {
} {
	return [db_multirow $multirow seleccionar_periodos_por_calendario_para_grid {}]
}

ad_proc -public td_inac_procs::seleccionar_actividades_por_calendario {
	-multirow
	-id_calendario	
} {
} {
	return [db_multirow $multirow seleccionar_actividades_por_calendario {}]
}

ad_proc -public td_inac_procs::seleccionar_comunidades {	
} {
	returna la lista de las comunidades	
} {
	return [db_list_of_lists seleccionar_comunidades {}]
}

