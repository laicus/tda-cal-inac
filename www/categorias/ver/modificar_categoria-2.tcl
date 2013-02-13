#tda-cal-inac/www/categorias/ver/modificar_categoria-2.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Mauricio Ramírez (mramirez@gmail.com)
    @creation-date 2013-01-30
    @cvs-id $Id$
} {
	nom_categoria:notnull
	dsc_categoria:notnull
	lst_modalidades:notnull
	id_categoria:notnull
}

puts "Lista de modalidades $lst_modalidades"

#Realiza la carga de la categoria modificada en la base de datos
set res [td_categorias::modificar_categoria -nom_categoria $nom_categoria -dsc_categoria $dsc_categoria -lst_modalidades $lst_modalidades -id_categoria $id_categoria]
ns_write $res
