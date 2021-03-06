<formtemplate id = "actividad"></formtemplate>
<div class="portlet-header">
    <div class="portlet-title-no-controls"> Eliminar Actividad. </div>
</div>
<div class="portlet" id = "pagina">
	<div id="viewadp-cal-table" class="margin-form margin-form-div">
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Nombre:</strong>
			</div>
			<div class="form-widget">                  
				@nombre_actividad@
			</div>	  
		</div>
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Descripción:</strong>
			</div>

			<div class="form-widget">                  
				@dsc_actividad;noquote@
			</div>  
		</div>
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Calendario:</strong>
			</div>

			<div class="form-widget">                  
				@id_calendario;noquote@
			</div>  
		</div>	
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Modalidad:</strong>
			</div>

			<div class="form-widget">                  
				@modalidad;noquote@
			</div>  
		</div>	
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Período:</strong>
			</div>

			<div class="form-widget">                  
				@periodo;noquote@
			</div>  
		</div>
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Categoría:</strong>
			</div>

			<div class="form-widget">                  
				@categoria;noquote@
			</div>  
		</div>
		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Fecha inicio:</strong>
			</div>

			<div class="form-widget">                  
				@fecha_inicio;noquote@
			</div>  
		</div>

		<div class="form-item-wrapper">
			<div class="form-label">
				<strong>Fecha final:</strong>
			</div>

			<div class="form-widget">                  
				@fecha_final;noquote@
			</div>  
		</div>		

	</div>
	<h2 style='color:#000066'>¿Está seguro que desea eliminar esta actividad?</h2>
	<div class="form-button">
				<a href="javascript:eliminar_actividad()" title="Si" class="button">Si</a>
				<a href="javascript:volver_ver_actividades();" title="Volver" class="button">Volver</a>
			</div>
</div>

