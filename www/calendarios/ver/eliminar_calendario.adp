<formtemplate id = "calendario"></formtemplate>
<div class="portlet-header">
<div class="portlet-title-no-controls"> Eliminar Calendario. </div>
</div>
<div class="portlet" id = "pagina">
<table border="0" width="100%">
	    <tr>
	      <td width="210" valign = "top">
		<include src="encabezado">
	      </td>
              <td valign = "top">
		<div id = "grid_informacion" align = "left">
			<div class="portlet-header">
				<div class="portlet-title-no-controls"> Lista de actividades que se eliminarán al borrar este calendario.</div>
			</div>
			<div class="portlet">
				<listtemplate name="grid_actividades"></listtemplate>
			</div>
			<br/>
			<div class="portlet-header">
				<div class="portlet-title-no-controls"> Lista de actividades que se eliminarán al borrar este calendario.</div>
			</div>
			<div class="portlet">
				<listtemplate name="grid_periodos"></listtemplate>

			</div>
		</div>
	      </td>
	    </tr>	     
	  </table>   
</div>


