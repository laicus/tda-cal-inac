<?xml version="1.0"?>
<queryset> 
  <fullquery name="td_calendarios::seleccionar_calendarios.seleccionar_calendarios"> 
    <querytext> 
		select distinct term_year, term_year as id
		from public.dotlrn_terms;
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

<fullquery name="td_calendarios::obtener_id_cal_items_por_calendario.obtener_id_cal_items_por_calendario"> 
    <querytext> 
	    SELECT cal_item_id 
	    FROM cal_items 
	    WHERE on_which_calendar = :id_calendario;
    </querytext> 
  </fullquery>
</queryset> 
