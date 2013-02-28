# tda-cal-inac/www/categorias/ver/eliminar_categoria-2.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
    
    @param id_categoria Identificador de la categoria
    @return Devuelve 1 si se realizo con exito, -1 o -2 en caso de error
} {
	id_categoria:notnull
}

# Llama a la funcion de borrado de la categoria
set res [td_categorias::eliminar_categoria -id_categoria $id_categoria]
# Escribe la respuesta en consola
##ns_write $res

