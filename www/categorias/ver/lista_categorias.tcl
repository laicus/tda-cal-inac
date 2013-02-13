#tda-cal-inac/www/categorias/ver/lista_categorias.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Mauricio Ramírez (mramirez@itcr.ac.cr)
    @creation-date 2013-01-29
    @cvs-id $Id$
    
    Se encarga de cargar la lista de categorias del calendario institucional
} { }

# Crea la lista de columnas que corresponden a las categorias
set columnas {
	nom_categoria {
	  label "Categoría"
	}
	dsc_categoria {
	  label "Descripción"
	}
	accion_modificar { 
		label "Modificar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_modificar_categoria('@categorias.id_categoria@')"\>Modificar</a> </nobr> </center> }
	}
	accion_eliminar { 
		label "Eliminar" 
		display_template { <center> <nobr> <a href=\"javascript:cargar_form_eliminar_categoria('@categorias.id_categoria@')"\>Eliminar</a> </nobr> </center> }
	}
}

# Crea la lista para las categorias
template::list::create \
    -name grid_categorias \
    -multirow categorias \
    -elements $columnas \
    -no_data "No existen categorías" \
    -html { style "width:100%" }

# Llena la lista con las categorias
td_categorias::seleccionar_categorias_para_grid -multirow categorias 
