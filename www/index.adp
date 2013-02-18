<master>
  <property name="title">@title;noquote@</property>
  <div>
    
    <style type="text/css"> 
  
    </style>
    
	
  <style>
  .ui-menu {
    width: 200px;
  }
  </style>
  
    <!--[if IE 5]>

	<style type="text/css"> 
	  /* place css box model fixes for IE 5* in this conditional comment */
	  .twoColFixLtHdr #sidebar1 { width: auto; }
        </style>
    <![endif]-->
    <!--[if IE]>
	<style type="text/css"> 
	  /* place css fixes for all versions of IE in this conditional comment */
	  .twoColFixLtHdr #sidebar1 { padding-top: 30px; }
	  .twoColFixLtHdr #mainContent { zoom: 1; }
	  /* the above proprietary zoom property gives IE the hasLayout it needs to avoid several bugs */
        </style>
    <![endif]-->

    <div id="expediente" class="twoColFixLtHdr">
      <div id="container">
	<div id="header" >
	  <BR>	  
	  <h1 class="style1">Administración Calendario Institucional y Académico</h1>
	  
	  <HR width="100%" align="left" class="alt1">
	  <BR>
	<!-- end #header -->
	</div>
	<div id="sidebar1">
	  <table border="0" width="100%">
	    <tr>
	      <td width="210" valign="top" > <!--</td>valign = "top" bgcolor="#EDF5FF">-->
		<!--<object data="MenuVersionVertical.swf"  type="application/x-shockwave-flash" halign = "right" align="top" id="Object3" style="width: 200px; height: 300px; title="">
		  <param name="movie" value="MenuVersionVertical.swf" />
          	  <param name="quality" value="high" />
                  <embed src="MenuVersionVertical.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="200" height="200"></embed>
		</object>-->
		 <!--menu-->
			<ul id="menu" valign = "top">
			  <li><a onclick="cargarURL('informacionGeneral', 'recuadro_centro');">Información general</a></li>
			  <li><a onclick="cargarURL('categorias/ver/pagina', 'recuadro_centro');">Categorías</a></li>
			  <li><a onclick="cargarURL('calendarios/ver/pagina', 'recuadro_centro');">Calendarios</a></li>			  
			  <li><a onclick="cargarURL('actividades/ver/pagina', 'recuadro_centro');">Actividades</a></li>
			</ul>
	      </td>
		  <td valign = "top">
			<!--#div para cargar las aplicaciones-->
			<div id="recuadro_centro" valign = "top"></div>
	      </td>
	    </tr>	     
	  </table>   
          <!-- end #sidebar1 -->
	  </div>

          <!-- This clearing element should immediately follow the #mainContent div in order to force the #container div to contain all child floats -->
	  <br class="clearfloat" />

	  <!--<div id="footer"
	    <p>&nbsp;</p>
	    <!-- end #footer -->
	  <!--</div>-->
        <!-- end #container -->
	</div>
      </div>
    </div>
    
    <script>
		$( "#menu" ).menu();
	</script>
