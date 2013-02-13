# tda-cal-inac/www/calendarios/insertar/insertar_calendario.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @author Mauricio Ramírez
    @creation-date 2013-02-05
    @cvs-id $Id$

    Ingresa un calendario
} { } 

# Crea el formulario para el año 
ad_form -name formulario -mode edit -has_submit 1 \
-form {
	{txt_anio:text(text)
		{label "Año:"}
		{html {rows 1 cols 50}}
	}
} -validate {
    {txt_anio
        {string is integer txt_anio}
            "Valor no es valido"
    }
}

