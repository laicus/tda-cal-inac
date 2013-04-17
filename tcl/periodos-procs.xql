<?xml version="1.0"?>
<queryset> 
<fullquery name="td_periodos::obtener_id_periodo.id_periodo">
    <querytext>
        select t.term_id
        from dotlrn_terms t
        where t.term_name = :nom_periodo and term_year = :anio
    </querytext>
  </fullquery>
