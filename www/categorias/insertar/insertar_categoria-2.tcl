#tda-cal-inac/www/categorias/insertar_categoria-2.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Ederick Navas (enavas@itcr.ac.cr)
    @creation-date 2009-01-13
    @cvs-id $Id$
    
    @param nom_categoria Nombre de la categoria
    @param dsc_categoria Descripción de la categoria
    @param lst_modalidades Lista de modalidades - borrado (modificado por Ederick Navas)
} {
	nom_categoria:notnull
	dsc_categoria:notnull
	
}

set res [td_categorias::insertar_categoria -nom_categoria $nom_categoria -dsc_categoria $dsc_categoria]

##ns_write $res
