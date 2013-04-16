<?xml version="1.0"?>

<queryset>

   <!--Consultas dinamicas para el grid de actividades -->
   <partialquery name="sql_query_calendario">
	  <querytext>         
		AND dotlrn_terms.term_year = $id_calendario 
	  </querytext>
   </partialquery>
   
   <partialquery name="sql_query_modalidades">
	  <querytext>         
		 AND split_part(dotlrn_terms.term_name,' ',1) = $id_modalidad
	  </querytext>
   </partialquery>
   
   <partialquery name="sql_query_periodo">
	  <querytext>         
		AND dotlrn_terms.term_id = $periodo 
	  </querytext>
   </partialquery>
   
   <partialquery name="sql_query_categoria">
	  <querytext>         
		AND categoria.id_categoria = $id_calendario
	  </querytext>
   </partialquery>  
   
   <fullquery name="obtener_actividades"> 
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
  
</queryset>
