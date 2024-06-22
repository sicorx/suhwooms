<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smArea"><spring:message code="area"/></c:set>
<c:set var="smStartDt"><spring:message code="startDt"/></c:set>
<c:set var="smEndDt"><spring:message code="endDt"/></c:set>
<c:set var="smUseYn"><spring:message code="useYn"/></c:set>
<c:set var="smRegiId"><spring:message code="regiId"/></c:set>
<c:set var="smRegiNm"><spring:message code="regiNm"/></c:set>
<c:set var="smFinalModDt"><spring:message code="finalModDt"/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smDupChk"><spring:message code="dupChk"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smNew"><spring:message code="new"/></c:set>
<c:set var="smUpdate"><spring:message code="update"/></c:set>
<c:set var="smDelete"><spring:message code="delete"/></c:set>
<c:set var="smSave"><spring:message code="save"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<title>REMS</title>

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/ui.jqgrid.css" />" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/common.css" />" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/jquery.jqplot.css" />" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/smoothness/jquery-ui.css" />" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/rems_global.css" />" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/rems_page.css" />" />
 	
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery-ui.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.json-2.4.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.cookie.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/rsh.compressed.js" />" type="text/javascript"></script>		
	
<script src="<c:url value="/resources/js/i18n/grid.locale-kr.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.jqGrid.min.js" />" type="text/javascript"></script>

<!--[if lt IE 10]>
<script src="<c:url value="/resources/js/excanvas.js" />" type="text/javascript"></script>
<![endif]-->
<script src="<c:url value="/resources/js/jquery.jqplot.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.barRenderer.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.categoryAxisRenderer.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.pointLabels.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.highlighter.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.canvasTextRenderer.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.canvasAxisTickRenderer.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.canvasAxisLabelRenderer.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.cursor.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.dateAxisRenderer.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jqplot.enhancedLegendRenderer.min.js" />" type="text/javascript"></script>

<script src="<c:url value="/resources/js/jquery.mousewheel.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/globalize.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.easing.1.3.js" />" type="text/javascript"></script>

<script src="<c:url value="/resources/js/bootstrap.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.validate.js" />" type="text/javascript"></script>
<script src="<c:url value="/resources/js/popup.js" />" type="text/javascript"></script>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var popParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	if( '${companyMgntDtl.useYn}'  == 'Y' ){
		$('#useYn_Y').attr('checked', true);
	}else{
		$('#useYn_N').attr('checked', true);
	}

	$('#saveForm').validate({
		rules:{
			companyCd:{required:true},
			companyNm:{required:true},
			companyStrCd:{required:true, minlength:3, maxlength:3},
			countryCd:{required:true},
			useYn:{required:true},						
		},			
		showErrors: function(errorMap, errorList) {	          
	          $.each(this.validElements(), function (index, element) {
	              var $element = $(element);
	              $element.data("title", "").removeClass("error").tooltip("destroy");
	          });
	          $.each(errorList, function (index, error) {
	              var $element = $(error.element);
	              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
	          });
	      }
	});
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSave() {			
	if($('#saveForm').valid()){		
		
		if(confirm("${smCommMsgSaveCnf}")){
			
			$.ajax({
				url:'/saveCompanyMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					opener.fncSearch();
					self.close();
				},
				error:function(result){
					
				}				
			});
		}
	}
}

function fncCancel() {
	self.close();
}
</script>
</head>
<!-- post 방식 window open -->
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<body style="overflow-y:hidden">
<div class="r_popup">
	<h1 class="r_popupTitle">회사 수정</h1>	  
	<div class="r_popupCont">
   		<div class="r_inputTbl r_horizonTbl">    
			<form id="saveForm" name="saveForm" method="post">
				<table>
					<tr>
						<th>${smCompany}<span class="r_required">*</span></th>
						<td>
							<input type="text" id="companyCd" name="companyCd" style="width:100px;" value="${companyMgntDtl.companyCd}" class="r_Input r_disable" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>회사 명<span class="r_required">*</span></th>
						<td>
							<input type='text' id='companyNm' name='companyNm' style="width:100px;" value="${companyMgntDtl.companyNm}" required/>
						</td>
					</tr>
					<tr>
						<th>회사 매장 코드<span class="r_required">*</span></th>
						<td>
							<input type='text' id='companyStrCd' name='companyStrCd' style="width:100px;" value="${companyMgntDtl.companyStrCd}" class="r_Input r_disable" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>국가<span class="r_required">*</span></th>
						<td>
							<select id="countryCd" name="countryCd" style="width:100px;" class="tblSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.name}' <c:if test="${companyMgntDtl.countryCd == vo.name}">selected</c:if> >${vo.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>사용 여부<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
					    		<input type='radio' name='useYn' id='useYn_Y' value='Y'/><label for="useYn_Y">사용</label>&nbsp;
						    	<input type='radio' name='useYn' id='useYn_N' value='N'/><label for="useYn_N">미사용</label>
							</span>
						</td>
					</tr>
				</table>	
			</form>
   		</div>
    	<div class="r_pageBtnWrapper">
		    <span class="pageNormal">
		    	<button onclick="javascript:fncCancel()">${smClos}</button>
		   	</span>
		    <span class="pageNormal">
		    	<button onclick="javascript:fncSave()">${smSave}</button>
		    </span>
		</div>
	</div>
</div>
</body>
</html>