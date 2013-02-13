#tda-cal-inac/www/actividades/insertar/grid_actividades.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
} {
	nom_actividad:optional
	dsc_actividad:optional
	nom_categoria:optional
	nom_modalidad:optional
	nom_periodo:optional
	fecha_inicio:optional
	fecha_final:optional
	id_actividad:optional
	id_calendario:optional
	calendario:optional
	id_categoria:optional
	id_modalidad:optional
	id_periodo:optional
	{accion "nada"}
}
set msn ""

puts "=========........... accion a realizar $accion "

if {$accion == "insertar"} {
	puts "----------------- ANTES DE TRATAR DE INSERTAR......"	
	set res [td_categorias::insertar_actividades_temporales -nom_actividad $nom_actividad -nom_categoria $nom_categoria -dsc_actividad $dsc_actividad -nom_modalidad $nom_modalidad -nom_periodo $nom_periodo -fecha_inicio $fecha_inicio -fecha_final $fecha_final -id_calendario $id_calendario -calendario $calendario -id_categoria $id_categoria -id_modalidad $id_modalidad -id_periodo $id_periodo ]
	puts "----------------- $res"	

	if { $res == 1 } {
		set  msn "<h2 style='color:#000066'>La inserción fue realizada de manera correcta.</h2>";
	} elseif { $res == -1 } {
		set  msn "<h2 style='color:#990000'>Error: Inserción fallida, la actividad ya existe en tabla de actividades temporales.</h2>";	
	} elseif { $res == -2 || $res == -3 } {
		set  msn "<h2 style='color:#990000'>Error: Inserción fallida, la actividad ya existe en la base de datos.</h2>";	
	} elseif { $res == -4 } {
		set  msn "<h2 style='color:#990000'>Error: Inserción fallida, error al realizar la transacción.</h2>";
	} else {
		set  msn "<h2 style='color:#990000'>Error: Inserción fallida, error desconocido.</h2>";
	}
}

if {$accion == "eliminar"} {
    puts "==========........ Entra a eliminar.... trata de eliminar actividad temporal con id_actividad $id_actividad"
	set res [td_categorias::eliminar_actividad_temporal -id_actividad $id_actividad]
    puts "==========........ ya elimino actividad temporal resultado $res"
	if {$res == -1} { 
		set  msn "<h2 style='color:#990000'>Error: Eliminación fallida, problemas al conectarse con la base de datos.</h2>"		
	} else {
        puts "==========........ todo bien... sigue eliminando"
		set estado_publicacion [td_categorias::obtener_estado_publicacion -id_actividad $id_actividad]
		set res [td_inac_procs::eliminar_actividad -id_actividad $id_actividad -estado_publicacion $estado_publicacion]
		if {$res == -1} { 
			set  msn "<h2 style='color:#990000'>Error: Eliminación fallida, problemas al conectarse con la base de datos.</h2>"		
		} else {
			set  msn "<h2 style='color:#000066'>La actividad se ha eliminado correctamente.</h2>"
		}
	}
}

set columnas {
	nom_actividad {
	  label "Actividad"
	}
	nom_categoria {
	  label "Categoría"
	}
	nom_modalidad {
	  label "Modalidad"
	}
  	nom_periodo {
	  label "Periodo"
	}
  	fecha_inicio {
	  label "Inicia (año-mes-día)"
	}
  	fecha_final {
	  label "Termina (año-mes-día)"
	}
  	calendario {
	  label "Calendario"
	}
	acciones { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:eliminar_actividad_temporal('@actividades.id_actividad@')"\>Eliminar</a> </nobr> </center> }
	}
}

template::list::create \
    -name grid_actividades \
    -multirow actividades \
    -key id_categoria_temporal \
    -elements $columnas

td_categorias::seleccionar_actividades_temporales -multirow actividades

ad_form -name frm_mensaje -has_submit 1 -form {
    {mensaje:string(hidden) 
        {value $msn} 
        {html {id "mensaje"} } 
    }
}
