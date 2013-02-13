#tda-cal-inac/www/calendarios/ver/ver_calendario.tcl
ad_page_contract {
    @author Virgilio Solis Rojas (vsolisrojas@gmail.com)
    @creation-date 2009-01-13
    @cvs-id $Id$

} {
	{id_calendario "%"}
}

ad_form -name calendario -has_submit 1 -form {
    {calendario:integer(hidden) {value $id_calendario} {html {id "id_calendario"} } }
}
