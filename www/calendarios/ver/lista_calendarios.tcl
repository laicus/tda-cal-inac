#tda-cal-inac/www/calendarios/ver/lista_calendarios.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Mauricio Ramírez (mramirez@itcr.ac.cr)
    @creation-date 2013-02-07
    @cvs-id $Id$
    
    Se encarga de crear los nuevos calendarios
} { }

# Crea las columnas que se van a presentar
set columnas {
	num_ano {
	  display_template { <center> <a href=\"javascript:cargar_form_ver_calendario('@calendarios.id_calendario@')"\>Calendario @calendarios.num_ano@</a> </center> }
	}
	ultima_actualizacion {
	  label "Ultima Actualización"
	}
	accion_publicar { 
		label "Publicar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_publicar_calendario('@calendarios.id_calendario@')"\>Publicar</a> </nobr> </center> }
	}
	accion_modificar { 
		label "Modificar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_calendario('@calendarios.id_calendario@','@calendarios.num_ano@','@calendarios.fecha_publicacion@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_calendario('@calendarios.id_calendario@')"\>Eliminar</a> </nobr> </center> }
	}
}

# Crea la plantilla de los calendarios
template::list::create \
    -name grid_calendarios \
    -multirow calendarios \
    -key id_calendario \
    -elements $columnas \
    -no_data "No existen calendarios." \
    -html { style "width:100%" }

# Selecciona los calendarios
td_calendarios::seleccionar_calendarios_para_grid -multirow calendarios 
