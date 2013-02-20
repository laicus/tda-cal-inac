# tda-cal-inac/www/categorias/insertar/insertar_categoria.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Mauricio Ramírez (mramirez@itcr.ac.cr)
    @creation-date 2009-01-13
    @cvs-id $Id$

    Inserta una nueva categoria en la base de datos
} { }

# Almacena la lista de las modalidades
set lista_modalidades [td_inac_procs::seleccionar_modalidades]
#------------------------------------------------------------------

# Crea el formulario de la categoria
ad_form -name formulario -mode edit -has_submit 1 -form {
    {txt_nombre_categoria:text(text)
    	{label "Nombre categoría:"}
    	{html {rows 1 cols 500}}
    }
    {txt_descripcion_categoria:text(textarea)
    	{label "Descripción:"}
    	{html {rows 2 cols 50}}
    }
    {lst_modalidades:text(checkbox),multiple
        {label "Modalidades que se asocian a esta categoría"}
        {options $lista_modalidades}
        {html {class lst_modalidades}}
    }
}
