<?xml version="1.0"?>
<queryset>
  <fullquery name="td_inac_procs::seleccionar_modalidades_para_periodos.seleccionar_modalidades_para_periodos">
    <querytext>
        SELECT nom_modalidad, id_modalidad 
        FROM td_cal_inac_modalidades 
        where es_especial = '0'
    </querytext>
  </fullquery>

  <fullquery name="td_inac_procs::seleccionar_modalidades_por_calendario.seleccionar_modalidades_por_calendario">
    <querytext>
        SELECT distinct (td_cal_inac_modalidades.nom_modalidad), td_cal_inac_modalidades.id_modalidad, td_admision_periodo.id_calendario  
		FROM td_cal_inac_modalidades
    		INNER JOIN td_admision_periodo
    		ON td_cal_inac_modalidades.id_modalidad = td_admision_periodo.cod_modalidad
		WHERE  td_cal_inac_modalidades.es_especial = '0' and id_calendario = :id_calendario
    </querytext>
  </fullquery>

  <fullquery name="td_inac_procs::obtener_actividades_por_modalidad_y_categoria.obtener_actividades_por_modalidad_y_categoria"> 
    <querytext> 
	    select td_cal_inac_actividades.id_actividad ,nom_actividad,dsc_actividad, nom_modalidad,
	        nom_categoria ,fecha_inicio, fecha_final 
        from td_cal_inac_actividades 
	        inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where td_cal_inac_modalidades.id_modalidad = :id_modalidad 
            and td_cal_inac_actividades.id_categoria = :id_categoria
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::obtener_actividades_por_modalidad.obtener_actividades_por_modalidad"> 
    <querytext> 
	    select td_cal_inac_actividades.id_actividad ,nom_actividad,dsc_actividad, nom_modalidad, nom_categoria, 
	        fecha_inicio, fecha_final 
	    from td_cal_inac_actividades 
	        inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where td_cal_inac_modalidades.id_modalidad = :id_modalidad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::obtener_actividades_por_modalidad_calendario.obtener_actividades_por_modalidad_calendario"> 
    <querytext> 
	    select td_cal_inac_actividades.id_actividad ,nom_actividad,dsc_actividad, nom_modalidad, nom_categoria,
    	    fecha_inicio, fecha_final
	    from td_cal_inac_actividades 
	        inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where td_cal_inac_modalidades.id_modalidad = :id_modalidad 
            and td_cal_inac_actividades.id_calendario = :id_calendario
    </querytext>
  </fullquery>

  <fullquery name="td_inac_procs::obtener_actividades_por_modalidad_todas_categorias_periodo.obtener_actividades_por_modalidad_todas_categorias_periodo"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_categorias.nom_categoria,
            td_cal_inac_modalidades.es_especial, (term_name || ' ' ||num_ano) as term_name, nom_actividad,
            dsc_actividad, fecha_inicio, fecha_final, 
            case estado_publicacion when 't' then 'Publicada' else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades 
            inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
	                    inner join td_cal_inac_periodosxactividades 
	                    on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
	                        inner join td_admision_periodo
	                        on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
	                            inner join dotlrn_terms
	                            on td_admision_periodo.id_term = dotlrn_terms.term_id
        where td_admision_periodo.id_term is null 
            and td_cal_inac_modalidades.id_modalidad like :id_modalidad
            and td_cal_inac_actividades.id_calendario = :id_calendario
        order by td_cal_inac_categorias.nom_categoria asc, fecha_inicio asc
    </querytext> 
  </fullquery>
  
  <fullquery name="td_inac_procs::obtener_actividades_por_modalidad_categoria_periodo.obtener_actividades_por_modalidad_categoria_periodo"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_categorias.nom_categoria,
            td_cal_inac_modalidades.es_especial, (term_name || ' ' ||num_ano) as term_name, nom_actividad,dsc_actividad,
            fecha_inicio, fecha_final, 
            case estado_publicacion when 't' then 'Publicada' else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades 
            inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
	                    inner join td_cal_inac_periodosxactividades 
	                    on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
	                        inner join td_admision_periodo
	                        on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
	                            inner join dotlrn_terms
	                            on td_admision_periodo.id_term = dotlrn_terms.term_id
        where td_admision_periodo.id_term = :id_periodo 
	        and td_cal_inac_modalidades.id_modalidad like :id_modalidad
	        and td_cal_inac_categorias.id_categoria = :id_categoria
	        and td_cal_inac_actividades.id_calendario = :id_calendario
        order by td_cal_inac_categorias.nom_categoria asc, fecha_inicio asc
    </querytext> 
  </fullquery>

  <fullquery name="td_inac_procs::obtener_actividades_por_modalidad_categoria.obtener_actividades_por_modalidad_categoria"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_categorias.nom_categoria,
            td_cal_inac_modalidades.es_especial ,nom_actividad,dsc_actividad, fecha_inicio, fecha_final, 
            case estado_publicacion when 't' then 'Publicada' else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	        inner join td_cal_inac_modalidades 
	        on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	        inner join td_cal_inac_categorias
	        on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
	    where td_cal_inac_modalidades.id_modalidad = :id_modalidad
	        and td_cal_inac_categorias.id_categoria = :id_categoria
	        and td_cal_inac_actividades.id_calendario = :id_calendario
	    order by td_cal_inac_categorias.nom_categoria asc, fecha_inicio asc
    </querytext> 
  </fullquery>

<fullquery name="td_inac_procs::obtener_actividades_por_modalidad_todas_categorias.obtener_actividades_por_modalidad_todas_categorias"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_categorias.nom_categoria, td_cal_inac_modalidades.es_especial ,nom_actividad,dsc_actividad, fecha_inicio, fecha_final, case estado_publicacion when 't' then 'Publicada' else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades 
            inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where td_cal_inac_modalidades.id_modalidad like :id_modalidad
	        and td_cal_inac_actividades.id_calendario = :id_calendario
        order by td_cal_inac_categorias.nom_categoria asc, fecha_inicio asc
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::obtener_todas_las_actividades.obtener_todas_las_actividades"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_modalidades.es_especial, nom_actividad,dsc_actividad,
        fecha_inicio, fecha_final, 
            case estado_publicacion when 't' then 'Publicada' else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades 
	        inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        order by fecha_inicio desc
    </querytext> 
  </fullquery>




 <fullquery name="td_inac_procs::obtener_id_cal_item_por_actividad.obtener_id_cal_item_por_actividad"> 
    <querytext> 
	    select cal_item_id 
	    from td_cal_inac_actividadesxterms
	    where id_actividad = :id_actividad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::eliminar_actividad.eliminar_actividad"> 
    <querytext> 
	    delete from td_cal_inac_actividades 
	    where id_actividad = :id_actividad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::eliminar_modalidadesxactividad.eliminar_modalidadesxactividad"> 
    <querytext> 
	    delete from td_cal_inac_modalidadesxactividad 
	    where id_actividad = :id_actividad
    </querytext> 
  </fullquery>
  
 <fullquery name="td_inac_procs::eliminar_periodosxactividades.eliminar_periodosxactividades"> 
    <querytext> 
	    delete from td_cal_inac_periodosxactividades 
	    where id_actividad = :id_actividad
    </querytext> 
  </fullquery>
  
 <fullquery name="td_inac_procs::seleccionar_actividad.seleccionar_actividad"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad, nom_actividad, id_categoria, fecha_inicio, fecha_final,
            dsc_actividad, dotlrn_terms.term_id, td_cal_inac_modalidades.id_modalidad,
            td_cal_inac_actividades.id_calendario 
        from td_cal_inac_actividades 
            inner join td_cal_inac_periodosxactividades
            on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_admision_periodo 
                on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
                    inner join dotlrn_terms on
                    dotlrn_terms.term_id = td_admision_periodo.id_term
                        inner join td_cal_inac_modalidadesxactividad
                        on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                            inner join td_cal_inac_modalidades
                            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
        where td_cal_inac_actividades.id_actividad = :id_actividad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::seleccionar_actividad_especial.seleccionar_actividad_especial"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad, nom_actividad, id_categoria, fecha_inicio, fecha_final,
            dsc_actividad, td_cal_inac_modalidades.id_modalidad,  td_cal_inac_calendarios.id_calendario 
        from td_cal_inac_actividades 
            inner join td_cal_inac_modalidadesxactividad
            on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_cal_inac_modalidades
                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
                    inner join td_cal_inac_calendarios 
                    on td_cal_inac_actividades.id_calendario = td_cal_inac_calendarios.id_calendario 
        where td_cal_inac_actividades.id_actividad = :id_actividad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::seleccionar_actividad_para_ver.seleccionar_actividad_para_ver"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad, nom_actividad, nom_categoria, fecha_inicio, fecha_final, 
            dsc_actividad, (term_name || ' ' || term_year), nom_modalidad, td_cal_inac_calendarios.num_ano 
        from td_cal_inac_actividades 
            inner join td_cal_inac_periodosxactividades
            on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_admision_periodo 
                on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
                    inner join dotlrn_terms on
                    dotlrn_terms.term_id = td_admision_periodo.id_term
                        inner join td_cal_inac_modalidadesxactividad
                        on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                            inner join td_cal_inac_modalidades
                            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
                                inner join td_cal_inac_categorias
                                on td_cal_inac_categorias.id_categoria = td_cal_inac_actividades.id_categoria
                                    inner join td_cal_inac_calendarios 
                                    on td_cal_inac_actividades.id_calendario = td_cal_inac_calendarios.id_calendario 
        where td_cal_inac_actividades.id_actividad = :id_actividad
    </querytext> 
  </fullquery>
 
 <fullquery name="td_inac_procs::seleccionar_actividad_especial_para_ver.seleccionar_actividad_especial_para_ver"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad, nom_actividad, nom_categoria, fecha_inicio, fecha_final,
            dsc_actividad, nom_modalidad, td_cal_inac_calendarios.num_ano 
        from td_cal_inac_actividades 
            inner join td_cal_inac_modalidadesxactividad
            on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_cal_inac_modalidades
                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
                    inner join td_cal_inac_categorias
                    on td_cal_inac_categorias.id_categoria = td_cal_inac_actividades.id_categoria
                        inner join td_cal_inac_calendarios 
                        on td_cal_inac_actividades.id_calendario = td_cal_inac_calendarios.id_calendario 
        where td_cal_inac_actividades.id_actividad = :id_actividad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::insertar_actividades_temporales.validar_actividad_con_no_temporales_especial"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad 
        from td_cal_inac_actividades
            inner join td_cal_inac_modalidadesxactividad
            on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_cal_inac_modalidades
                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
                    inner join td_cal_inac_categorias
                    on td_cal_inac_categorias.id_categoria = td_cal_inac_actividades.id_categoria
        where nom_actividad = :nom_actividad and nom_categoria = :nom_categoria and fecha_inicio = :fecha_inicio 
            and nom_modalidad = :nom_modalidad
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::insertar_actividades_temporales.validar_actividad_con_no_temporales"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad 
        from td_cal_inac_actividades 
            inner join td_cal_inac_periodosxactividades
            on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_admision_periodo 
                on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
                    inner join dotlrn_terms on
                    dotlrn_terms.term_id = td_admision_periodo.id_term
                        inner join td_cal_inac_modalidadesxactividad
                        on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                            inner join td_cal_inac_modalidades
                            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
                                inner join td_cal_inac_categorias
                                on td_cal_inac_categorias.id_categoria = td_cal_inac_actividades.id_categoria
        where nom_actividad = :nom_actividad and nom_categoria = :nom_categoria and fecha_inicio = :fecha_inicio 
            and (term_name || ' ' || term_year) = :nom_periodo and nom_modalidad = :nom_modalidad
    </querytext> 
  </fullquery>


 <fullquery name="td_inac_procs::seleccionar_periodos_por_modalidad_para_grid.seleccionar_periodos_por_modalidad_para_grid"> 
    <querytext> 
        SELECT term_id, cod_modalidad,term_name, num_ano, start_date, end_date 
        from dotlrn_terms 
            inner join td_admision_periodo
            on td_admision_periodo.id_term = dotlrn_terms.term_id 
        where cod_modalidad like :id_modalidad and id_calendario = :id_calendario 
        order by num_ano desc, cod_modalidad,term_name
    </querytext> 
  </fullquery>


 <fullquery name="td_inac_procs::seleccionar_periodos_por_modalidad_para_grid_todos.seleccionar_periodos_por_modalidad_para_grid_todos"> 
    <querytext> 
        SELECT term_id, cod_modalidad,term_name, num_ano, start_date, end_date 
        from dotlrn_terms 
            inner join td_admision_periodo
            on td_admision_periodo.id_term = dotlrn_terms.term_id 
        where cod_modalidad like :id_modalidad 
        order by num_ano desc, cod_modalidad,term_name
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::seleccionar_periodo.seleccionar_periodo"> 
    <querytext> 
        SELECT term_id, term_name, num_ano, start_date, end_date 
        from dotlrn_terms 
            inner join td_admision_periodo
            on td_admision_periodo.id_term = dotlrn_terms.term_id 
        where term_id = :id_periodo 
        order by num_ano
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::seleccionar_periodos_por_calendario.seleccionar_periodos_por_calendario"> 
    <querytext> 
        SELECT term_name, cod_modalidad, term_year, start_date, end_date, id_periodo
        FROM dotlrn_terms 
            right join td_admision_periodo 
            on td_admision_periodo.id_term = dotlrn_terms.term_id 
        where id_calendario = :id_calendario_viejo;
    </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::seleccionar_actividades_por_anio.seleccionar_actividades_por_anio"> 
    <querytext> 
        select td_cal_inac_actividades.nom_actividad,td_cal_inac_actividades.dsc_actividad,
            td_cal_inac_modalidades.id_modalidad, td_cal_inac_categorias.id_categoria,
            dotlrn_terms.term_name as nom_periodo, dotlrn_terms.term_year, td_cal_inac_actividades.fecha_inicio,
            td_cal_inac_actividades.fecha_final, td_cal_inac_actividades.estado_publicacion
        from td_cal_inac_actividades 
            inner join td_cal_inac_categorias
            on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria
                inner join td_cal_inac_modalidadesxactividad 
                on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad 
                    inner join td_cal_inac_modalidades 
                    on td_cal_inac_modalidadesxactividad.id_modalidad = td_cal_inac_modalidades.id_modalidad
                        inner join td_cal_inac_periodosxactividades
                        on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
                            inner join dotlrn_terms 
                            on td_cal_inac_periodosxactividades.id_periodo = dotlrn_terms.term_id
        where td_cal_inac_actividades.id_calendario = :id_calendario_viejo;
    </querytext> 
  </fullquery>
 
 <fullquery name="td_inac_procs::seleccionar_actividades_especiales_por_anio.seleccionar_actividades_especiales_por_anio"> 
    <querytext> 
        select td_cal_inac_actividades.nom_actividad,td_cal_inac_actividades.dsc_actividad, 
            td_cal_inac_modalidades.id_modalidad, td_cal_inac_categorias.id_categoria, 'No aplica' as nom_periodo, 
            'No aplica' as term_year, td_cal_inac_actividades.fecha_inicio, td_cal_inac_actividades.fecha_final,
            td_cal_inac_actividades.estado_publicacion
        from td_cal_inac_actividades 
            inner join td_cal_inac_categorias
            on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria
                inner join td_cal_inac_modalidadesxactividad 
                on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad 
                    inner join td_cal_inac_modalidades 
                    on td_cal_inac_modalidadesxactividad.id_modalidad = td_cal_inac_modalidades.id_modalidad 
        where td_cal_inac_modalidades.id_modalidad = 'O' 
        and td_cal_inac_actividades.id_calendario = :id_calendario_viejo;
    </querytext> 
  </fullquery>

<fullquery name="td_inac_procs::seleccionar_periodos_por_calendario_para_grid.seleccionar_periodos_por_calendario_para_grid"> 
    <querytext> 
        SELECT term_id, cod_modalidad,term_name, num_ano, start_date, end_date 
        from dotlrn_terms 
            inner join td_admision_periodo
            on td_admision_periodo.id_term = dotlrn_terms.term_id 
        where id_calendario = :id_calendario 
        order by num_ano desc, cod_modalidad,term_name
    </querytext> 
  </fullquery>

<fullquery name="td_inac_procs::seleccionar_actividades_por_calendario.seleccionar_actividades_por_calendario"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, nom_actividad,dsc_actividad, fecha_inicio, fecha_final,
            estado_publicacion, es_especial,
            case estado_publicacion 
                when 't' then 'Publicada' 
                else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades
	        inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where id_calendario = :id_calendario 
    </querytext> 
  </fullquery>
 
 <fullquery name="td_inac_procs::obtener_actividades_regulares_para_visualizador.obtener_actividades_regulares_para_visualizador"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_categorias.nom_categoria,
            td_cal_inac_modalidades.es_especial, (term_name || ' ' ||num_ano) as term_name, nom_actividad,dsc_actividad,
            fecha_inicio, fecha_final, 
            case estado_publicacion
                when 't' 
                then 'Publicada' 
                else 'No Publicada' end as estado_publicacion 
            from td_cal_inac_actividades 
                inner join td_cal_inac_modalidadesxactividad
	            on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	                inner join td_cal_inac_modalidades 
	                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                    inner join td_cal_inac_categorias
	                    on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
	                        inner join td_cal_inac_periodosxactividades 
	                        on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
	                            inner join td_admision_periodo
	                            on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
	                                inner join dotlrn_terms
	                                on td_admision_periodo.id_term = dotlrn_terms.term_id
	        where td_admision_periodo.id_term like :periodo 
	            and td_cal_inac_modalidades.id_modalidad like :id_modalidad
	            and td_cal_inac_categorias.id_categoria like :id_categoria
	            and td_cal_inac_actividades.id_calendario = :id_calendario
	            and estado_publicacion = 't'
	        order by td_cal_inac_categorias.nom_categoria asc, fecha_inicio asc
    </querytext> 
  </fullquery>

<fullquery name="td_inac_procs::obtener_actividades_especiales_para_visualizador.obtener_actividades_especiales_para_visualizador"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_categorias.nom_categoria, 
            td_cal_inac_modalidades.es_especial, nom_actividad,dsc_actividad, fecha_inicio, fecha_final, 
            case estado_publicacion 
                when 't' 
                then 'Publicada' 
                else 'No Publicada' end as estado_publicacion 
        from td_cal_inac_actividades 
            inner join td_cal_inac_modalidadesxactividad
	        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	                inner join td_cal_inac_categorias
	                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where td_cal_inac_modalidades.id_modalidad = :id_modalidad
	        and td_cal_inac_categorias.id_categoria like :id_categoria
	        and td_cal_inac_actividades.id_calendario = :id_calendario
	        and estado_publicacion = 't'
        order by td_cal_inac_categorias.nom_categoria asc, fecha_inicio asc
    </querytext> 
  </fullquery>
  <fullquery name="td_inac_procs::seleccionar_modalidades.seleccionar_modalidades"> 	
	<querytext>
		SELECT nom_modalidad, id_modalidad
		FROM td_sch_cal_inac.modalidad;
	</querytext>  
   </fullquery>
</queryset>
