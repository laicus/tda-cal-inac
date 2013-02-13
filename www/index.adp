<master>
  <property name="title">@title;noquote@</property>
  <div>
    <script languaje="javascript">
	
    </script>

    <style type="text/css"> 
    <!-- 

	.twoColFixLtHdr #container { 
	    width: auto;  /* using 20px less than a full 800px width allows for browser chrome and avoids a horizontal scroll bar */
	    background: #FFFFFF;
	    margin: 0 auto; /* the auto margins (in conjunction with a width) center the page */
	    border: 1px solid #000000;
	    /*text-align: center; /* this overrides the text-align: center on the body element. */
	} 
	.twoColFixLtHdr #header {
	    background: #003366;
	    padding: 0 10px 0 20px;  /* this padding matches the left alignment of the elements in the divs that appear beneath it. If an image is used in the #header instead of text, you may want to remove the padding. */
	} 
	.twoColFixLtHdr #header h1 {
	    margin: 0; /* zeroing the margin of the last element in the #header div will avoid margin collapse - an unexplainable space between divs. If the div has a border around it, this is not necessary as that also avoids the margin collapse */
	    padding: 10px 0; /* using padding instead of margin will allow you to keep the element away from the edges of the div */
	    background-color: #003366;
	}
	.twoColFixLtHdr #sidebar1 {
	    float: left; /* since this element is floated, a width must be given */
	    width: 100%; /* the actual width of this div, in standards-compliant browsers, or standards mode in Internet Explorer will include the padding and border in addition to the width */
	    /* background: #EDF5FF; the background color will be displayed for the length of the content in the column, but no further */
	    valign: top;
	    /*align:center;*/
	}
	.twoColFixLtHdr #mainContent { 
	    margin: 0 0 0 250px; /* the left margin on this div element creates the column down the left side of the page - no matter how much content the sidebar1 div contains, the column space will remain. You can remove this margin if you want the #mainContent div's text to fill the #sidebar1 space when the content in #sidebar1 ends. */
	    padding: 0 20px; /* remember that padding is the space inside the div box and margin is the space outside the div box */
	} 
	.twoColFixLtHdr #footer {
	    background:#003366;
	} 
	.twoColFixLtHdr #footer p {
	    margin: 0; /* zeroing the margins of the first element in the footer will avoid the possibility of margin collapse - a space between divs */
	    background-color: #003366;
	}
	.fltrt { /* this class can be used to float an element right in your page. The floated element must precede the element it should be next to on the page. */
	    float: right;
	    margin-left: 8px;
	}
	.fltlft { /* this class can be used to float an element left in your page */
	    float: left;
	    margin-right: 8px;
	}
	.clearfloat { /* this class should be placed on a div or break element and should be the final element before the close of a container that should fully contain a float */
	    clear:both;
            height:0;
            font-size: 1px;
            line-height: 0px;
	}

	.style1 {
	    color: #FFFFFF
	}
	.style2 {
	    color: #666666
	}
    --> 
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
	  <h1 class="style1">Administración Calendario Institucional y Académico</h1>
	  <hr />&nbsp;
	<!-- end #header -->
	</div>
	<div id="sidebar1">
	  <table border="0" width="100%">
	    <tr>
	      <td width="210" valign = "top" bgcolor="#EDF5FF">
		<object data="MenuVersionVertical.swf"  type="application/x-shockwave-flash" halign = "right" align="top" id="Object3" style="width: 200px; height: 300px; title="">
		  <param name="movie" value="MenuVersionVertical.swf" />
          	  <param name="quality" value="high" />
                  <embed src="MenuVersionVertical.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="200" height="200"></embed>
		</object>
	      </td>
              <td valign = "top">
		<div id="recuadro_centro" valign = "top">
			<include src = "informacionGeneral">
		</div>
	      </td>
	    </tr>	     
	  </table>   
          <!-- end #sidebar1 -->
	  </div>

          <!-- This clearing element should immediately follow the #mainContent div in order to force the #container div to contain all child floats -->
	  <br class="clearfloat" />

	  <div id="footer"
	    <p>&nbsp;</p>
	    <!-- end #footer -->
	  </div>
        <!-- end #container -->
	</div>
      </div>
    </div>
