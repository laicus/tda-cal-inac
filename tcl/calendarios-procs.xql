<?xml version="1.0"?>
<queryset> 
  <fullquery name="td_calendarios::seleccionar_calendarios.seleccionar_calendarios"> 
    <querytext> 
	    select num_ano, id_calendario 
	    from td_sch_cal_inac.calendario;
    </querytext> 
  </fullquery> 

  <fullquery name="td_calendarios::seleccionar_calendarios_para_grid.seleccionar_calendarios_para_grid"> 
    <querytext> 
	    select num_ano, id_calendario,fecha_publicacion,ultima_actualizacion 
	    from td_sch_cal_inac.calendario; 
    </querytext> 
  </fullquery> 

   <fullquery name="td_calendarios::verificar_calendario.verificar_calendario"> 
    <querytext> 
	    select 1 
	    from td_cal_inac_calendarios 
	    where num_ano = :anio  
    </querytext> 
  </fullquery>

   <fullquery name="td_calendarios::insertar_calendario.insertar_calendario"> 
    <querytext> 
	    insert into td_cal_inac_calendarios (num_ano,fecha_publicacion,ultima_actualizacion)
	    values (:anio,:fecha_publicacion,date_trunc('minutes',now())) 
	    returning id_calendario; 
    </querytext> 
  </fullquery>

   <fullquery name="td_calendarios::modificar_calendario.modificar_calendario"> 
    <querytext> 
	    update td_cal_inac_calendarios set num_ano= :anio ,fecha_publicacion = :fecha_publicacion, 
	        ultima_actualizacion = date_trunc('minutes',now()) 
	    where id_calendario=:id_calendario  
    </querytext> 
  </fullquery>

   <fullquery name="td_calendarios::verificar_calendario_para_modificar.verificar_calendario_para_modificar"> 
    <querytext> 
	    select 1 
	    from td_cal_inac_calendarios where num_ano = :anio and (not id_calendario=:id_calendario) 
    </querytext> 
  </fullquery>

   <fullquery name="td_calendarios::sacar_anio.sacar_anio"> 
    <querytext>
	    select num_ano 
	    from td_cal_inac_calendarios 
	    where id_calendario=:id_calendario  
    </querytext> 
  </fullquery>

   <fullquery name="td_calendarios::seleccionar_calendario_para_anio.seleccionar_calendario_para_anio"> 
    <querytext> 
        select id_calendario 
        from td_cal_inac_calendarios 
        where num_ano=:num_ano 
    </querytext> 
  </fullquery>

 <fullquery name="td_calendarios::seleccionar_actividades_no_publicadas.seleccionar_actividades_no_publicadas"> 
    <querytext> 
	    select td_cal_inac_actividades.id_actividad, nom_actividad, dsc_actividad,
	        td_cal_inac_modalidades.id_modalidad, id_categoria, dotlrn_terms.term_id, fecha_inicio, fecha_final, 
	        td_cal_inac_actividades.id_calendario from td_cal_inac_actividades 
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
	    where estado_publicacion = FALSE and td_cal_inac_actividades.id_calendario = :id_calendario
    </querytext> 
  </fullquery> 
 <fullquery name="td_calendarios::seleccionar_actividades_especiales_no_publicadas.seleccionar_actividades_especiales_no_publicadas"> 
    <querytext> 
        select td_cal_inac_actividades.id_actividad, nom_actividad, dsc_actividad, 
            td_cal_inac_modalidades.id_modalidad, id_categoria, fecha_inicio, fecha_final, 
            td_cal_inac_actividades.id_calendario from td_cal_inac_actividades 
        inner join td_cal_inac_modalidadesxactividad
        on td_cal_inac_modalidadesxactividad.id_actividad = td_cal_inac_actividades.id_actividad
            inner join td_cal_inac_modalidades
            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
        where estado_publicacion = FALSE and td_cal_inac_modalidades.id_modalidad = 'O'
    </querytext> 
  </fullquery>

 <fullquery name="td_calendarios::publicar_actividad.publicar_actividad"> 
    <querytext> 
    	update td_cal_inac_actividades 
    	set estado_publicacion = TRUE 
    	where id_actividad = :id_actividad 
    </querytext> 
  </fullquery>

 <fullquery name="td_calendarios::despublicar_actividad.despublicar_actividad"> 
    <querytext> 
	    update td_cal_inac_actividades 
	    set estado_publicacion = FALSE where id_actividad = :id_actividad 
    </querytext> 
  </fullquery>

 <fullquery name="td_calendarios::insertar_relacion_actividades_comunidades.insertar_relacion_actividades_comunidades"> 
    <querytext> 
	    insert into td_cal_inac_actividadesxterms(id_actividad, cal_item_id) 
	    VALUES (:id_actividad, :cal_item_funcionario_id);
    </querytext> 
  </fullquery>

 <fullquery name="td_calendarios::setear_fecha_actualizacion.setear_fecha_actualizacion"> 
    <querytext> 
	    update td_cal_inac_calendarios 
	    set ultima_actualizacion = (SELECT date_trunc('minute', now())) 
	    where id_calendario = :id_calendario;
    </querytext> 
  </fullquery>

 <fullquery name="td_calendarios::seleccionar_actividades_a_publicar_por_calendario.seleccionar_actividades_a_publicar_por_calendario"> 
    <querytext> 
        select  td_cal_inac_actividades.id_actividad, td_cal_inac_modalidades.es_especial, nom_actividad,dsc_actividad, fecha_inicio, fecha_final from td_cal_inac_actividades 
        inner join td_cal_inac_modalidadesxactividad
        on td_cal_inac_actividades.id_actividad = td_cal_inac_modalidadesxactividad.id_actividad
            inner join td_cal_inac_modalidades 
            on td_cal_inac_modalidades.id_modalidad = td_cal_inac_modalidadesxactividad.id_modalidad
                inner join td_cal_inac_categorias
                on td_cal_inac_actividades.id_categoria = td_cal_inac_categorias.id_categoria 
        where estado_publicacion = FALSE and id_calendario = :id_calendario
    </querytext> 
  </fullquery>

<fullquery name="td_calendarios::obtener_id_cal_item_a_eliminar_por_calendario.obtener_id_cal_item_a_eliminar_por_calendario"> 
    <querytext> 
	    select cal_item_id from td_cal_inac_actividadesxterms
	    inner join td_cal_inac_actividades 
	    on td_cal_inac_actividadesxterms.id_actividad = td_cal_inac_actividades.id_actividad 
	        and td_cal_inac_actividades.id_calendario = :id_calendario 
	        and td_cal_inac_actividades.estado_publicacion = TRUE
    </querytext> 
  </fullquery>

<fullquery name="td_calendarios::eliminar_calendario.eliminar_calendario"> 
    <querytext> 
    	delete from td_cal_inac_calendarios 
    	where id_calendario = :id_calendario
    </querytext> 
  </fullquery>

<fullquery name="td_calendarios::seleccionar_terms_a_borrar.seleccionar_terms_a_borrar"> 
    <querytext> 
	    select id_term 
	    from td_admision_periodo 
	    where id_calendario = :id_calendario 
    </querytext> 
  </fullquery>

<fullquery name="td_calendarios::eliminar_term.eliminar_term"> 
    <querytext> 
	    delete from dotlrn_terms 
	    where term_id = :term_id
    </querytext> 
  </fullquery>

<fullquery name="td_calendarios::seleccionar_actividad_para_publicar.seleccionar_actividad_para_publicar"> 
    <querytext> 
	    select td_cal_inac_actividades.id_actividad, nom_actividad,dsc_actividad, fecha_inicio, fecha_final 
	    from td_cal_inac_actividades where id_actividad = :id_actividad
    </querytext> 
  </fullquery>

<fullquery name="td_calendarios::obtener_id_cal_items_por_calendario.obtener_id_cal_items_por_calendario"> 
    <querytext> 
	    select cal_item_id 
	    from cal_items 
	    where on_which_calendar = :id_calendario;
    </querytext> 
  </fullquery>
</queryset> 
