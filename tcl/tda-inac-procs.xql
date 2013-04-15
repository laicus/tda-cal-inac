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
        SELECT nom_modalidad, nom_modalidad 
		FROM td_sch_cal_inac.modalidad
		ORDER BY nom_modalidad
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
		 SELECT distinct
		  actividad.id_actividad,
		  actividad.nom_actividad,
		  categoria.id_categoria,
		  categoria.nom_categoria, 
		  actividad_term.fecha_inicio, 
		  actividad_term.fecha_fin,
		  actividad.dsc_actividad,
		  (dotlrn_terms.term_name || ', ' || dotlrn_terms.term_year) as periodo,
		  split_part(dotlrn_terms.term_name,' ',1) as nom_modalidad,
		  dotlrn_terms.term_id,
		  dotlrn_terms.term_year,
		  cal_actividad.estado_publicacion  
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad, 
		  public.dotlrn_terms, 
		  td_sch_cal_inac.categoria
		WHERE 
		  actividad.id_categoria = categoria.id_categoria AND
		  actividad_term.id_actividad = actividad.id_actividad AND
		  actividad_term.term_id = dotlrn_terms.term_id AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND
		  dotlrn_terms.term_year = :id_calendario AND split_part(dotlrn_terms.term_name,' ',1) = :id_modalidad
		
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
         SELECT distinct
		  actividad.id_actividad,
		  actividad.nom_actividad,
		  categoria.id_categoria,
		  categoria.nom_categoria, 
		  actividad_term.fecha_inicio, 
		  actividad_term.fecha_fin,
		  actividad.dsc_actividad,
		  (dotlrn_terms.term_name || ', ' || dotlrn_terms.term_year) as periodo,
		  split_part(dotlrn_terms.term_name,' ',1) as nom_modalidad,
		  dotlrn_terms.term_id,
		  dotlrn_terms.term_year,
		  cal_actividad.estado_publicacion  
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad, 
		  public.dotlrn_terms, 
		  td_sch_cal_inac.categoria
		WHERE 
		  actividad.id_categoria = categoria.id_categoria AND
		  actividad_term.id_actividad = actividad.id_actividad AND
		  actividad_term.term_id = dotlrn_terms.term_id AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND
		  dotlrn_terms.term_id = :periodo AND 
		  dotlrn_terms.term_year = :id_calendario AND 
		  split_part(dotlrn_terms.term_name,' ',1) = :id_modalidad AND
		  categoria.id_categoria = :id_categoria
        
        
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
       SELECT 
		  actividad.id_actividad,
		  actividad.nom_actividad, 
		  actividad_term.fecha_inicio, 
		  actividad_term.fecha_fin, 
		  (dotlrn_terms.term_name || ', ' || dotlrn_terms.term_year) as periodo,
		  categoria.nom_categoria,
		  case cal_actividad.estado_publicacion
		  when 't' then 'Publicada' else 'No publicada' end as estado_publicacion
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad, 
		  public.dotlrn_terms, 
		  td_sch_cal_inac.categoria
		WHERE 
		  actividad.id_categoria = categoria.id_categoria AND
		  actividad_term.id_actividad = actividad.id_actividad AND
		  actividad_term.term_id = dotlrn_terms.term_id AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad
		ORDER BY
		  actividad_term.fecha_inicio 
    </querytext> 
  </fullquery>




 <fullquery name="td_inac_procs::obtener_id_cal_item_por_actividad.obtener_id_cal_item_por_actividad"> 
    <querytext> 
	    SELECT distinct
		  cal_actividad.cal_item_id
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad
		WHERE 
		  actividad_term.id_actividad = actividad.id_actividad AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND	  
		  actividad.id_actividad = :id_actividad
    </querytext> 
  </fullquery>
  <fullquery name="td_inac_procs::obtener_id_term_actividad_por_actividad.obtener_id_term_actividad_por_actividad"> 
    <querytext> 
		SELECT distinct
		  cal_actividad.id_term_actividad
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad
		WHERE 
		  actividad_term.id_actividad = actividad.id_actividad AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND	  
		  actividad.id_actividad = :id_actividad
	 </querytext> 
  </fullquery>

 <fullquery name="td_inac_procs::eliminar_actividad.eliminar_actividad"> 
    <querytext> 
	    DELETE FROM td_sch_cal_inac.actividad 
	    WHERE id_actividad = :id_actividad
    </querytext> 
  </fullquery>

  <fullquery name="td_inac_procs::eliminar_actividad.eliminar_actividad_term"> 
	<querytext> 
		DELETE FROM td_sch_cal_inac.actividad_term 
		WHERE id_actividad = :id_actividad
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
         
         SELECT distinct
		  actividad.id_actividad,
		  actividad.nom_actividad,
		  categoria.id_categoria,
		  categoria.nom_categoria, 
		  actividad_term.fecha_inicio, 
		  actividad_term.fecha_fin,
		  actividad.dsc_actividad,
		  (dotlrn_terms.term_name || ', ' || dotlrn_terms.term_year) as periodo,
		  dotlrn_terms.term_id,
		  dotlrn_terms.term_year,
		  cal_actividad.estado_publicacion,
		  modalidad.id_modalidad,
		  modalidad.nom_modalidad,
		  actividad.dsc_actividad
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad, 
		  public.dotlrn_terms, 
		  td_sch_cal_inac.categoria,
		  td_sch_cal_inac.modalidad
		WHERE 
		  actividad.id_categoria = categoria.id_categoria AND
		  actividad_term.id_actividad = actividad.id_actividad AND
		  actividad_term.term_id = dotlrn_terms.term_id AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND
		  td_sch_cal_inac.modalidad.nom_modalidad = split_part(dotlrn_terms.term_name,' ',1) AND
		  actividad.id_actividad = :id_actividad
         
    </querytext> 
  </fullquery>
  
  <fullquery name="td_inac_procs::seleccionar_actividad_publicacion.seleccionar_actividad_publicacion"> 
    <querytext>		
			
	SELECT distinct
	  calendars.calendar_id,
	  calendars.calendar_name,
	  cal_actividad.estado_publicacion,
	  cal_actividad.id_cal_actividad,
	  cal_actividad.id_term_actividad,
	  cal_actividad.cal_item_id
	FROM 
	  td_sch_cal_inac.actividad, 
	  td_sch_cal_inac.actividad_term, 
	  td_sch_cal_inac.cal_actividad, 
	  public.dotlrn_terms, 
	  td_sch_cal_inac.categoria,
	  td_sch_cal_inac.modalidad,
	  public.calendars
	WHERE 
	  actividad_term.id_actividad = actividad.id_actividad AND
	  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND
	  td_sch_cal_inac.cal_actividad.calendar_id = calendars.calendar_id AND
	  actividad.id_actividad = :id_actividad

    
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
        SELECT 
		  actividad.id_actividad,
		  actividad.nom_actividad,
		  categoria.nom_categoria, 
		  actividad_term.fecha_inicio, 
		  actividad_term.fecha_fin,
		  actividad.dsc_actividad,
		  (dotlrn_terms.term_name || ', ' || dotlrn_terms.term_year) as periodo,
		  split_part(dotlrn_terms.term_name,' ',1) as nom_modalidad,
		  dotlrn_terms.term_year  
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad, 
		  public.dotlrn_terms, 
		  td_sch_cal_inac.categoria
		WHERE 
		  actividad.id_categoria = categoria.id_categoria AND
		  actividad_term.id_actividad = actividad.id_actividad AND
		  actividad_term.term_id = dotlrn_terms.term_id AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND
		  actividad.id_actividad = :id_actividad
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
        SELECT distinct
		  actividad.id_actividad,
		  actividad.nom_actividad,
		  categoria.id_categoria,
		  categoria.nom_categoria, 
		  actividad_term.fecha_inicio, 
		  actividad_term.fecha_fin,
		  actividad.dsc_actividad,
		  (dotlrn_terms.term_name || ', ' || dotlrn_terms.term_year) as periodo,
		  split_part(dotlrn_terms.term_name,' ',1) as nom_modalidad,
		  dotlrn_terms.term_id,
		  dotlrn_terms.term_year,
		  cal_actividad.estado_publicacion  
		FROM 
		  td_sch_cal_inac.actividad, 
		  td_sch_cal_inac.actividad_term, 
		  td_sch_cal_inac.cal_actividad, 
		  public.dotlrn_terms, 
		  td_sch_cal_inac.categoria
		WHERE 
		  actividad.id_categoria = categoria.id_categoria AND
		  actividad_term.id_actividad = actividad.id_actividad AND
		  actividad_term.term_id = dotlrn_terms.term_id AND
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad AND
          dotlrn_terms.term_year = :id_calendario
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
		SELECT nom_modalidad, nom_modalidad
		FROM td_sch_cal_inac.modalidad
		ORDER BY nom_modalidad
	</querytext>  
   </fullquery>
   <!-- Consultar comunidades-->
   <fullquery name="td_inac_procs::seleccionar_comunidades.seleccionar_comunidades"> 	
	<querytext>
     SELECT calendar_name, calendar_id 
     FROM calendars 
	 WHERE calendar_name = 'Profesores ITCR' OR
		   calendar_name = 'Funcionarios ITCR' OR
           calendar_name = 'Estudiantes ITCR'
     </querytext>  
   </fullquery>
   
   <fullquery name="td_inac_procs::eliminar_actividad.eliminar_cal_actividad"> 
    <querytext> 
	    DELETE FROM td_sch_cal_inac.cal_actividad
	    WHERE id_term_actividad = :id_term_actividad
    </querytext>
  </fullquery>
   
   
         
</queryset>
