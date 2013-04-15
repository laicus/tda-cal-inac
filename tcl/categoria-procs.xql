<?xml version="1.0"?>
<queryset> 
  <fullquery name="td_categorias::insertar_categoria.insertar_categoria"> 
    <querytext> 
        INSERT INTO td_sch_cal_inac.categoria (nom_categoria, dsc_categoria) 
        VALUES (:nom_categoria, :dsc_categoria) returning id_categoria;
    </querytext> 
  </fullquery> 

  <fullquery name="td_categorias::seleccionar_categoria.seleccionar_categoria"> 
    <querytext> 
        SELECT nom_categoria, dsc_categoria 
        FROM td_sch_cal_inac.categoria
        WHERE id_categoria = :id_categoria;
    </querytext> 
  </fullquery>
    
  <fullquery name="td_categorias::seleccionar_categorias_lista.seleccionar_categorias_lista"> 
    <querytext> 
    
	SELECT distinct	 
	  categoria.nom_categoria, 
	  categoria.id_categoria 
	FROM 
	  td_sch_cal_inac.actividad, 
	  td_sch_cal_inac.actividad_term, 
	  public.dotlrn_terms, 
	  td_sch_cal_inac.categoria
	WHERE 
	  actividad.id_categoria = categoria.id_categoria AND
	  actividad_term.id_actividad = actividad.id_actividad AND
	  actividad_term.term_id = :term_id
    </querytext> 
  </fullquery>  

  <fullquery name="td_categorias::insertar_categoria.seleccionar_categoria_por_nombre"> 
    <querytext> 
        SELECT id_categoria 
        FROM td_sch_cal_inac.categoria 
        WHERE nom_categoria = :nom_categoria
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::seleccionar_categorias.seleccionar_categorias"> 
    <querytext> 
        SELECT nom_categoria, id_categoria, dsc_categoria 
        FROM td_sch_cal_inac.categoria 
        order by nom_categoria;
    </querytext> 
  </fullquery>
  <fullquery name="td_categorias::seleccionar_categorias_para_grid.seleccionar_categorias"> 
    <querytext> 
        SELECT nom_categoria, id_categoria, dsc_categoria 
        FROM td_sch_cal_inac.categoria 
        order by nom_categoria;
    </querytext> 
  </fullquery>
  
  <fullquery name="td_categorias::modificar_categoria.modificar_categoria"> 
    <querytext> 
	    UPDATE td_sch_cal_inac.categoria 
	    SET nom_categoria = :nom_categoria, dsc_categoria = :dsc_categoria 
	    WHERE id_categoria = :id_categoria;
    </querytext> 
  </fullquery> 

  <fullquery name="td_categorias::modificar_categoria.borrar_modalidades"> 
    <querytext> 
	    DELETE FROM td_sch_cal_inac.modalidad_categoria
	    WHERE id_categoria = :id_categoria;
    </querytext> 
  </fullquery> 

  <fullquery name="td_categorias::modificar_categoria.insertar_categoria_modalidad"> 
    <querytext> 
        INSERT INTO td_sch_cal_inac.modalidad_categoria (id_categoria, id_modalidad) 
        VALUES (:id_categoria, :id_modalidad)
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::eliminar_categoria.existe_actividad_con_categoria"> 
    <querytext> 
	    select distinct(1) 
	    from td_sch_cal_inac.actividad 
	    where id_categoria = :id_categoria
    </querytext> 
  </fullquery> 

  <fullquery name="td_categorias::eliminar_categoria.eliminar_categoria"> 
    <querytext> 
	    DELETE FROM td_sch_cal_inac.categoria 
	    WHERE id_categoria = :id_categoria;
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::seleccionar_modalidades.seleccionar_modalidades"> 
    <querytext> 
        SELECT id_modalidad, nom_modalidad
        FROM td_sch_cal_inac.modalidad;
        
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::insertar_categoria.insertar_categoria_modalidad"> 
    <querytext> 
        INSERT INTO td_sch_cal_inac.modalidad_categoria (id_categoria, id_modalidad) 
        VALUES (:id_categoria, :id_modalidad)
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::modificar_categoria.eliminar_categoria_modalidad"> 
    <querytext> 
        DELETE FROM td_sch_cal_inac.modalidad_categoria 
        WHERE id_categoria = :id_categoria
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::eliminar_categoria.eliminar_categoria_modalidad"> 
    <querytext> 
        DELETE FROM td_sch_cal_inac.modalidad_categoria
        WHERE id_categoria = :id_categoria;
    </querytext> 
  </fullquery>  
 
  <fullquery name="td_categorias::seleccionar_modalidades_por_categoria.seleccionar_modalidades_por_categoria"> 
    <querytext> 
        SELECT id_modalidad
        FROM td_sch_cal_inac.modalidad_categoria
        WHERE id_categoria = :id_categoria;
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividades_temporales.validar_actividad_con_no_temporales"> 
    <querytext> 
	    
	   SELECT 
		  actividad.id_actividad		  
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
		  actividad.nom_actividad = :nom_actividad AND
		  actividad.id_categoria = :id_categoria AND
		  actividad_term.fecha_inicio = :fecha_inicio AND
		  actividad_term.fecha_fin = :fecha_final AND
		  actividad_term.term_id = :id_periodo
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividades_temporales.validar_actividad_con_no_temporales_especial"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad 
        from td_cal_inac_actividades
            inner join td_cal_inac_modalidadesxactividad
            on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_cal_inac_modalidades
                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad 
                    and td_cal_inac_modalidades.id_modalidad = 'O'
                    inner join td_cal_inac_categorias
                    on td_cal_inac_categorias.id_categoria = td_cal_inac_actividades.id_categoria
        where nom_actividad = :nom_actividad and nom_categoria = :nom_categoria 
        and fecha_inicio = :fecha_inicio and nom_modalidad = :nom_modalidad
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::modificar_actividad.validar_actividad_con_no_temporales"> 
    <querytext> 
	    select td_sch_cal_inac.actividad.id_actividad 
	    from td_sch_cal_inac.actividad 
	        inner join td_cal_inac_periodosxactividades
	        on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
	            inner join td_admision_periodo 
	            on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
	                inner join dotlrn_terms 
	                on dotlrn_terms.term_id = td_admision_periodo.id_term
                	    inner join td_cal_inac_modalidadesxactividad
	                    on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                    	    inner join td_cal_inac_modalidades
                    	    on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	    where nom_actividad = :nom_actividad and td_cal_inac_actividades.id_categoria = :id_categoria 
	        and fecha_inicio = :fecha_inicio and td_cal_inac_modalidades.id_modalidad = :id_modalidad 
	        and td_admision_periodo.id_term = :id_periodo and (not td_cal_inac_actividades.id_actividad = :id_actividad)
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::modificar_actividad.validar_actividad_con_no_temporales_especial"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad 
        from td_cal_inac_actividades
            inner join td_cal_inac_modalidadesxactividad
            on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_cal_inac_modalidades
                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad 
                and td_cal_inac_modalidades.id_modalidad = 'O'
        where nom_actividad = :nom_actividad and td_cal_inac_actividades.id_categoria = :id_categoria 
            and fecha_inicio = :fecha_inicio and td_cal_inac_modalidades.id_modalidad = :id_modalidad 
            and (not td_cal_inac_actividades.id_actividad = :id_actividad)
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::validar_actividades.validar_actividad_con_no_temporales"> 
    <querytext> 
	    select td_cal_inac_actividades.id_actividad 
	    from td_cal_inac_actividades 
	        inner join td_cal_inac_periodosxactividades
	        on td_cal_inac_periodosxactividades.id_actividad = td_cal_inac_actividades.id_actividad
        	    inner join td_admision_periodo 
	            on td_admision_periodo.id_term = td_cal_inac_periodosxactividades.id_periodo
	                inner join dotlrn_terms
	                on dotlrn_terms.term_id = td_admision_periodo.id_term
                	    inner join td_cal_inac_modalidadesxactividad
                	    on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                    	    inner join td_cal_inac_modalidades
                    	    on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
	    where nom_actividad = :nom_actividad and td_cal_inac_actividades.id_categoria = :id_categoria 
	        and fecha_inicio = :fecha_inicio and td_cal_inac_modalidades.id_modalidad = :id_modalidad 
	        and td_admision_periodo.id_term = :id_periodo
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::validar_actividades.validar_actividad_con_no_temporales_especial"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad 
        from td_cal_inac_actividades
            inner join td_cal_inac_modalidadesxactividad
            on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
                inner join td_cal_inac_modalidades
                on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad 
                    and td_cal_inac_modalidades.id_modalidad = 'O'
        where nom_actividad = :nom_actividad and td_cal_inac_actividades.id_categoria = :id_categoria 
            and fecha_inicio = :fecha_inicio and td_cal_inac_modalidades.id_modalidad = :id_modalidad
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::seleccionar_actividades_temporalesseleccionar_actividades_temporales.seleccionar_actividades_temporales"> 
    <querytext> 
	    SELECT id_actividad, nom_actividad, dsc_actividad, nom_categoria, nom_modalidad, nom_periodo,
	      fecha_inicio, fecha_final
      	FROM td_cal_inac_actividades_temporal
    </querytext> 
  </fullquery>
  
  <fullquery name="td_categorias::seleccionar_actividades.seleccionar_actividades"> 
    <querytext> 
	    SELECT id_actividad, nom_actividad, dsc_actividad, nom_categoria, nom_modalidad, nom_periodo,
	      fecha_inicio, fecha_final
      	FROM td_cal_inac_actividades_temporal
    </querytext> 
  </fullquery>
    
 <fullquery name="td_categorias::insertar_actividades_temporales.insertar_actividades_temporales"> 
    <querytext> 
	    INSERT INTO td_cal_inac_actividades_temporal(id_actividad,
            nom_actividad,dsc_actividad,nom_categoria, nom_modalidad, nom_periodo, fecha_inicio, 
            fecha_final,id_calendario,calendario)
        VALUES (:id_actividad,:nom_actividad, :dsc_actividad, :nom_categoria, :nom_modalidad, :nom_periodo, :fecha_inicio, 
            :fecha_final,:id_calendario,:calendario);
    </querytext> 
  </fullquery>
 
 <fullquery name="td_categorias::eliminar_actividad_temporal.eliminar_actividad_temporal"> 
    <querytext> 
 	    DELETE FROM td_cal_inac_actividades_temporal 
 	    WHERE id_actividad = :id_actividad
    </querytext> 
  </fullquery>


 <fullquery name="td_categorias::insertar_actividades_temporales.validar_actividad_temporal"> 
    <querytext> 
 	    SELECT id_actividad 
 	    FROM td_cal_inac_actividades_temporal 
		WHERE (nom_actividad = :nom_actividad AND nom_categoria = :nom_categoria AND nom_modalidad = :nom_modalidad AND nom_periodo = :nom_periodo AND fecha_inicio = :fecha_inicio)
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::seleccionar_actividades_temporales.seleccionar_actividades_temporales"> 
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
		  cal_actividad.id_term_actividad = actividad_term.id_term_actividad 
		  $sql_query
    </querytext> 
  </fullquery>

<fullquery name="td_categorias::submit_actividades.seleccionar_actividades_temporales_para_insertar"> 
    <querytext> 
        select td_cal_inac_actividades_temporal.nom_actividad,td_cal_inac_actividades_temporal.dsc_actividad,
	 	    td_cal_inac_modalidades.id_modalidad, td_cal_inac_categorias.id_categoria, 
	 	    dotlrn_terms.term_id as id_periodo, td_cal_inac_actividades_temporal.fecha_inicio,
	 	    td_cal_inac_actividades_temporal.fecha_final,td_cal_inac_actividades_temporal.id_calendario 
	    from td_cal_inac_actividades_temporal 
	        inner join td_cal_inac_categorias
	        on td_cal_inac_actividades_temporal.nom_categoria = td_cal_inac_categorias.nom_categoria
	            inner join td_cal_inac_modalidades 
	            on td_cal_inac_actividades_temporal.nom_modalidad = td_cal_inac_modalidades.nom_modalidad
	                inner join dotlrn_terms 
	                on td_cal_inac_actividades_temporal.nom_periodo = (dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year)
    </querytext> 
  </fullquery>

<fullquery name="td_categorias::submit_actividades.seleccionar_actividades_especiales_temporales_para_insertar"> 
    <querytext> 
        select  td_cal_inac_actividades_temporal.nom_actividad,td_cal_inac_actividades_temporal.dsc_actividad,
            td_cal_inac_modalidades.id_modalidad, td_cal_inac_categorias.id_categoria,
            td_cal_inac_actividades_temporal.fecha_inicio, td_cal_inac_actividades_temporal.fecha_final,
            td_cal_inac_actividades_temporal.id_calendario 
        from td_cal_inac_actividades_temporal 
            inner join td_cal_inac_categorias
            on td_cal_inac_actividades_temporal.nom_categoria = td_cal_inac_categorias.nom_categoria
                inner join td_cal_inac_modalidades 
                on td_cal_inac_actividades_temporal.nom_modalidad = td_cal_inac_modalidades.nom_modalidad
        where td_cal_inac_modalidades.id_modalidad = 'O'
   </querytext> 
  </fullquery>

  <fullquery name="td_categorias::submit_actividades.insertar_periodoxactividad"> 
    <querytext> 
	    INSERT INTO td_cal_inac_periodosxactividades(id_periodo, id_actividad)
        VALUES (:id_periodo, :id_actividad);
    </querytext>
  </fullquery> 

  <fullquery name="td_categorias::insertar_actividad.insertar_periodoxactividad"> 
    <querytext> 
	    INSERT INTO td_cal_inac_periodosxactividades(id_periodo, id_actividad)
        VALUES (:id_periodo, :id_actividad);
    </querytext>
  </fullquery> 

  <fullquery name="td_categorias::copiar_actividad.insertar_periodoxactividad"> 
    <querytext> 
	    INSERT INTO td_cal_inac_periodosxactividades(id_periodo, id_actividad)
        VALUES (:id_periodo, :id_actividad);
    </querytext>
  </fullquery> 

 <fullquery name="td_categorias::obtener_id_calendario_de_profesores.obtener_id_calendario_de_profesores"> 
    <querytext> 
	    SELECT calendar_id 
	    from calendars 
	    WHERE calendar_name = 'Profesores';
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::obtener_id_calendario_de_estudiantes.obtener_id_calendario_de_estudiantes"> 
    <querytext> 
	    SELECT calendar_id 
	    from calendars 
	    WHERE calendar_name = 'Estudiantes';
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::submit_actividades.insertar_actividad"> 
    <querytext> 
	    insert into td_cal_inac_actividades (nom_actividad,dsc_actividad,id_categoria,
	        fecha_inicio, fecha_final, id_calendario) 
	    values (:nom_actividad,:dsc_actividad,:id_categoria,:fecha_inicio, :fecha_final,:id_calendario) 
	    returning id_actividad;
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividad.insertar_actividad"> 
    <querytext> 
	    INSERT INTO td_sch_cal_inac.actividad (nom_actividad,dsc_actividad,id_categoria) 
		VALUES (:nom_actividad,:dsc_actividad,:id_categoria) 
		RETURNING id_actividad;
    </querytext> 
  </fullquery>

  <fullquery name="td_categorias::insertar_actividad.insertar_actividad_term"> 
    <querytext> 
	    INSERT INTO td_sch_cal_inac.actividad_term (id_actividad, term_id, fecha_inicio, fecha_fin) 
		VALUES (:id_actividad, :id_periodo, :fecha_inicio, :fecha_final)
		RETURNING id_term_actividad;
    </querytext> 
  </fullquery>
  
 <fullquery name="td_categorias::copiar_actividad.insertar_actividad"> 
    <querytext> 
    	insert into td_cal_inac_actividades (nom_actividad,dsc_actividad,id_categoria,fecha_inicio,fecha_final,
    	    id_calendario) 
    	values (:nom_actividad,:dsc_actividad,:id_categoria,:fecha_inicio,:fecha_final,:id_calendario) 
    	returning id_actividad;
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividad.insertar_actividad_publicada"> 
    <querytext> 
	    insert into td_cal_inac_actividades (nom_actividad,dsc_actividad,id_categoria,fecha_inicio,fecha_final,
	        id_calendario,estado_publicacion) 
	    values (:nom_actividad,:dsc_actividad,:id_categoria,:fecha_inicio, :fecha_final,:id_calendario, TRUE) 
	    returning id_actividad;
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividad.insertar_cal_actividad"> 
    <querytext> 
	    INSERT INTO td_sch_cal_inac.cal_actividad (id_term_actividad, calendar_id, estado_publicacion, cal_item_id)
	    VALUES (:id_term_actividad, :calendar_id, :estado_publicacion, :cal_item_id)
    </querytext>
  </fullquery>


 <fullquery name="td_categorias::copiar_actividad.insertar_modalidadxactividad"> 
    <querytext> 
	    INSERT INTO td_cal_inac_modalidadesxactividad(id_actividad, id_modalidad) 
	    VALUES (:id_actividad, :id_modalidad)
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::submit_actividades.insertar_modalidadxactividad"> 
    <querytext> 
	    INSERT INTO td_cal_inac_modalidadesxactividad(id_actividad, id_modalidad) 
	    VALUES (:id_actividad, :id_modalidad)
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividad.insertar_termsxactividad"> 
    <querytext> 
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_funcionario_id);
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::insertar_actividad.insertar_termsxactividad_bueno"> 
    <querytext> 
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_profesor_id);
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_estudiante_id);
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_funcionario_id);
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::submit_actividades.insertar_termsxactividad"> 
    <querytext> 
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_profesor_id);
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_estudiante_id);
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::submit_actividades.eliminar_actividades_temporales"> 
    <querytext> 
	    delete from td_cal_inac_actividades_temporal
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::eliminar_actividades_temporales.eliminar_actividades_temporales"> 
    <querytext> 
	    delete from td_cal_inac_actividades_temporal
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::seleccionar_periodos_por_modalidad.seleccionar_periodos_por_modalidad"> 
    <querytext>	    
		SELECT DISTINCT
			term.term_name, term.term_id
		FROM dotlrn_terms as term,
			 td_sch_cal_inac.modalidad as cali
		WHERE split_part(term.term_name, ' ', 1) = :id_modalidad AND
		term.term_year = :term_year
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::seleccionar_periodo.seleccionar_periodo"> 
    <querytext> 
	    SELECT term_name 
	    from dotlrn_terms 
        where term_id = :term_id
    </querytext> 
  </fullquery>

 <fullquery name="td_categorias::obtener_estado_publicacion.obtener_estado_publicacion"> 
    <querytext> 
	    SELECT estado_publicacion 
	    from td_cal_inac_actividades 
	    where id_actividad = :id_actividad
    </querytext> 
  </fullquery>
  
  
  <fullquery name="td_categorias::modificar_actividad.modificar_actividad"> 
    <querytext>     
	   UPDATE td_sch_cal_inac.actividad 
	   SET nom_actividad = :nom_actividad, dsc_actividad = :dsc_actividad, id_categoria = :id_categoria 
	   WHERE id_actividad = :id_actividad   
    </querytext> 
  </fullquery>
  
  <fullquery name="td_categorias::modificar_actividad.modificar_actividad_term"> 
    <querytext>	  
	   UPDATE td_sch_cal_inac.actividad_term
	   SET term_id = :term_id, fecha_inicio = :fecha_inicio, fecha_fin = :fecha_final
	   WHERE id_actividad = :id_actividad
	   RETURNING id_term_actividad;
    </querytext> 
  </fullquery>
  
   <fullquery name="td_categorias::modificar_actividad.insertar_cal_actividad"> 
    <querytext> 
	    INSERT INTO td_sch_cal_inac.cal_actividad (id_term_actividad, calendar_id, estado_publicacion, cal_item_id)
	    VALUES (:id_term_actividad, :calendar_id, :estado_publicacion, :cal_item_id)
    </querytext>
  </fullquery>
 
   <fullquery name="td_categorias::modificar_actividad.eliminar_cal_actividad"> 
    <querytext> 
	    DELETE FROM td_sch_cal_inac.cal_actividad
	    WHERE id_term_actividad = :id_term_actividad
    </querytext>
  </fullquery>

</queryset> 


