<?xml version="1.0"?>
<queryset>
  <fullquery name="td_inac_procs::seleccionar_modalidades_por_calendario.seleccionar_modalidades_por_calendario">
    <querytext>
        SELECT nom_modalidad, nom_modalidad 
		FROM td_sch_cal_inac.modalidad
		ORDER BY nom_modalidad
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
