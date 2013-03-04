# tda-cal-inac/www/categorias/ver/modificar_categoria.tcl
ad_page_contract {    
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Mauricio Ramírez (mramirez@itcr.ac.cr)
    @creation-date 2012-01-29
    @cvs-id $Id$
    
    @param id_categoria Identificador de la categoría
} {
	id_categoria:notnull
}

# Almacena la informacion de la categoria
set datos [td_categorias::seleccionar_categoria -id_categoria $id_categoria]
# Almacena el nombre de la categoria
set nom_categoria [lindex $datos 0]
# Almacena la descripcion de la categoria
set dsc_categoria [lindex $datos 1]


#Crea un formulario con los datos de la categoria
ad_form  -name formulario -mode edit -has_submit 1 -form {
    {categoria:integer(hidden) 
        {value $id_categoria} 
        {html {id "id_categoria"}}
    }
	{txt_nombre_categoria:text(text)
	    {label "Nombre categoría:"}
	    {value {$nom_categoria}}
	    {html {style "width:300px"}}
	}
	{txt_descripcion_categoria:text(textarea)
	    {label "Descripción:"}
	    {value $dsc_categoria}
	    {html {style "width:300px" rows 2 cols 50}}
	}
	
} -validate {
    {txt_nombre_categoria
        {[string length $txt_nombre_categoria] == 0}
        "Nombre de categoria no valido"
    }
}
