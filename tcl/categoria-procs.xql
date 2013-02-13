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
    
  <fullquery name="td_categorias::seleccionar_categorias_por_modalidad.seleccionar_categorias_por_modalidad"> 
    <querytext> 
   	select td_cal_inac_categorias.nom_categoria, td_cal_inac_categorias.id_categoria 
   	from td_cal_inac_categorias
	    inner join td_cal_inac_modalidadesxcategorias 
	    on td_cal_inac_categorias.id_categoria = td_cal_inac_modalidadesxcategorias.id_categoria
	        inner join td_cal_inac_modalidades 
	        on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxcategorias.id_modalidad
	where td_cal_inac_modalidades.id_modalidad = :id_modalidad
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
        FROM td_cal_inac_categorias 
        order by especial, nom_categoria
    </querytext> 
  </fullquery>
  <fullquery name="td_categorias::seleccionar_categorias_para_grid.seleccionar_categorias"> 
    <querytext> 
        SELECT nom_categoria, id_categoria, dsc_categoria 
        FROM td_sch_cal_inac.categoria
        order by especial, nom_categoria;
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
	    from td_cal_inac_actividades 
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
        SELECT id_modalidad, nom_modalidad, can_periodos 
        FROM td_cal_inac_modalidades 
        order by es_especial
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
        DELETE FROM td_cal_inac_modalidadesxcategorias 
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
	    select td_cal_inac_actividades.id_actividad from td_cal_inac_actividades 
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
                            	inner join td_cal_inac_categorias
                            	on td_cal_inac_categorias.id_categoria = td_cal_inac_actividades.id_categoria
	    where nom_actividad = :nom_actividad and nom_categoria = :nom_categoria 
	        and fecha_inicio = :fecha_inicio and (term_name || ' ' || term_year) = :nom_periodo 
	        and nom_modalidad = :nom_modalidad
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

  <fullquery name="td_categorias::seleccionar_actividades_temporales.seleccionar_actividades_temporales"> 
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
 	    SELECT id_actividad, nom_actividad, dsc_actividad, nom_categoria, nom_modalidad, nom_periodo, 
 	        fecha_inicio, fecha_final, id_calendario, calendario 
 	    FROM td_cal_inac_actividades_temporal
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
	    insert into td_cal_inac_actividades (nom_actividad,dsc_actividad,id_categoria,fecha_inicio,fecha_final,
	        id_calendario) 
	    values (:nom_actividad,:dsc_actividad,:id_categoria,:fecha_inicio, :fecha_final,:id_calendario) 
	    returning id_actividad;
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

 <fullquery name="td_categorias::insertar_actividad.insertar_modalidadxactividad"> 
    <querytext> 
	    INSERT INTO td_cal_inac_modalidadesxactividad(id_actividad, id_modalidad) 
	    VALUES (:id_actividad, :id_modalidad)
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
	    SELECT (term_name || ' ' || cast(num_ano as varchar)) as periodo,term_id 
	    from dotlrn_terms 
	        inner join td_admision_periodo 
	        on td_admision_periodo.id_term = dotlrn_terms.term_id 
	    where cod_modalidad like :id_modalidad and td_admision_periodo.id_calendario = :id_calendario 
        order by num_ano,term_name 
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
</queryset> 
