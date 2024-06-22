<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smCnfm"><spring:message code="cnfm"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smAgree"><spring:message code="agree"/></c:set>
<c:set var="smDeny"><spring:message code="deny"/></c:set>
<c:set var="smUserAgreement"><spring:message code="userAgreement"/></c:set>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<title>REMS</title>

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/ui.jqgrid.css" />" />
	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/common.css" />" />
	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/smoothness/jquery-ui.css" />" />
	 	
	<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />" type="text/javascript"></script>
	<script src="<c:url value="/resources/js/jquery-ui.min.js" />" type="text/javascript"></script>
	<script src="<c:url value="/resources/js/jquery.json-2.4.min.js" />" type="text/javascript"></script>
	<script src="<c:url value="/resources/js/jquery.cookie.js" />" type="text/javascript"></script>

	<!--[if lt IE 10]>
	<script src="<c:url value="/resources/js/excanvas.js" />" type="text/javascript"></script>
	<![endif]-->

	<script src="<c:url value="/resources/js/jquery.mousewheel.js" />" type="text/javascript"></script>
	<script src="<c:url value="/resources/js/globalize.js" />" type="text/javascript"></script>
	<script src="<c:url value="/resources/js/jquery.easing.1.3.js" />" type="text/javascript"></script>
	
	
	<script type="text/javascript">
	$(document).ready(function(){
		
		$('#loading').css('display', 'none');
		$("#body").css("opacity", 1);
		
		fncShowAjaxPage();
		fncEulaPopupOpen();
	});
	
	
	function fncShowAjaxPage() {
		
		var param = new Object();
		
		param.pagePath = "eula";
		param.pageName = "${loc}";
		
		$('#memberAgreement').empty();
		
		$.ajax({
			type : "POST",
			cache : false,
			url : "showAjaxPage",
			data : param,
			success : function(data) {
				$('#memberAgreement').html(data);
			}
		});
	}
	
	
	function fncEulaPopupOpen() {

		$("#dialog").dialog({
			open: function(event, ui) {
				  $(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').hide();
			},
			resizable: false,
			modal : true,
			autoOpen : true,
			height : 500,
			width : 500
		});
	}
	
	
	function fncCancel() {
		
		$("#radEulaDeny").prop( "checked", true );
		$("#radEulaAgree").prop( "checked", false );
		
		$('#dialog').dialog('close');
		
		fncSaveEulaYn( "N" );
	}

	
	function fncConfirm() {

		var eulaYn = $("input[type='radio'][name='radEula']:checked").val();
		
		$('#dialog').dialog('close');
		
		fncSaveEulaYn( eulaYn );
	}	
	
	
	function fncSaveEulaYn(val) {

		if( val == "Y" ) {
			
			$('#loading').css('display', 'inherit');
			$("#body").css("opacity", 0.2);
			
			document.formEula.method = 'POST';
			document.formEula.submit();
		}
		else {
			location.href = "/j_spring_security_logout";
		}
	}
	</script>
	
</head>

<body>
	<div class="container">	    
 		<div class="column">
			<div id="loading" style="z-index: 9999; width: 100%; height: 100%;">
				<p style="position: absolute; left: 48%; top: 450%;">loading...</p>
			</div>
			<div id="dialog" title="${smUserAgreement}" style="display:none;">
				<div id="memberAgreement" class="component">
					<!--  <textarea id="taEula" readonly>asdf</textarea> -->
				</div>
				<br/>
				<div>
					<form name="formEula" action="/saveEulaYn" enctype="application/x-www-form-urlencoded">
					<table>
						<tr>
							<td><input type='radio' id='radEulaAgree' name='radEula' value='Y' />${smAgree}</td>
						</tr>
						<tr>
							<td><input type='radio' id='radEulaDeny' name='radEula' value='N' checked/>${smDeny}</td>
						</tr>
					</table>
					</form>
					<hr/>
					<div style="text-align:center;">
						<input type='button' value='${smCnfm}' onclick='fncConfirm()'/>
						<input type='button' value='${smClos}' onclick='fncCancel()'/>
					</div>
				</div>
			</div>					
		</div>		
    </div>
</body>
</html>







