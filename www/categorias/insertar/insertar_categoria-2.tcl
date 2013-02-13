#tda-cal-inac/www/categorias/insertar_categoria-2.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$
    
    @param nom_categoria Nombre de la categoria
    @param dsc_categoria Descripción de la categoria
    @param lst_modalidades Lista de modalidades
} {
	nom_categoria:notnull
	dsc_categoria:notnull
	lst_modalidades:notnull
}

set res [td_categorias::insertar_categoria -nom_categoria $nom_categoria -dsc_categoria $dsc_categoria -lst_modalidades $lst_modalidades]
ns_write $res
