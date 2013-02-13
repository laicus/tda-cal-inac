#tda-cal-inac/tcl/periodos-procs.tcl
ad_library {    
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-19
    @cvs-id $Id$
}

# Definicion de Namespace
# ===========================================================
namespace eval ::td_periodos {}

# Definicion de Funciones
# ===========================================================

ad_proc -public td_periodos::insertar_periodo {
    -id_modalidad:required
    -anio:required
    -num_periodo:required
    -fecha_inicio:required
    -fecha_final:required
    -term_name:required
    -id_calendario:required
} {
} { 
	db_transaction {
		puts "Verificando"
		set id_term [obtener_id_periodo -nom_periodo $term_name -anio $anio]
		set existe [td_periodos::verificar_periodo -cod_modalidad $id_modalidad -num_periodo $num_periodo -num_ano $anio]
		if {$id_term eq -1} {	
			puts "Creando Periodo"
			dotlrn_term::new \
				-term_name $term_name \
				-term_year $anio \
				-start_date $fecha_inicio \
				-end_date $fecha_final
		}
		if {$existe eq ""} {
			puts  "Obtener ID Periodo"
			set id_term [obtener_id_periodo -nom_periodo $term_name -anio $anio]
			puts "Registrar Periodo"
			db_dml insertar_periodo {}
			set salida 1
		}
	} on_error { 
		set salida -2
	}
	return $salida
}

ad_proc -public td_periodos::modificar_periodo {
    -id_modalidad:required
    -anio:required
    -num_periodo:required
    -fecha_inicio:required
    -fecha_final:required
    -term_name:required
    -id_periodo:required
} {
} { 
	db_transaction {
		set id [td_periodos::verificar_periodo -cod_modalidad $id_modalidad -num_periodo $num_periodo -num_ano $anio]
		if { $id == $id_periodo || $id == "" } {
	    	dotlrn_term::edit \
			    -term_id $id_periodo \
			    -term_name $term_name \
			    -term_year $anio \
			    -start_date $fecha_inicio \
			    -end_date $fecha_final
			db_dml modificar_periodo {}
			set retorno 1
		} else {
			set retorno -1
		}
	} 
	return $retorno
}

ad_proc -public td_periodos::verificar_periodo {
	{-cod_modalidad:required}
	{-num_periodo:required}
	{-num_ano:required}
} {
} {
    return [db_string existe_periodo {} -default ""]
}

ad_proc -public td_periodos::obtener_id_periodo {
    {-nom_periodo:required}
    {-anio:required}
} {
} {
    return [db_string id_periodo {} -default -1]
}


ad_proc -public td_periodos::insertar_periodoxactividad {
    -id_periodo:required
    -id_acividad:required
} {
} {
	db_dml insertar_periodoxactividad {}
}

ad_proc -public td_periodos::lista_periodos_por_modalidad {
	{-id_modalidad:required}
} {
} {
	db_transaction {
		set lista_periodos {}
		set cant_periodos [ db_string cantidad_de_periodos {} -default "-1"]
		for {set i 1} {$i <= $cant_periodos} {incr i} {
			set lista_periodos [concat $lista_periodos [list "$i $i"] ]
		}
	} on_error {
		set lista_periodos -1
	}
	return $lista_periodos
}
