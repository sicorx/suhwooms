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

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var dupChk = false;
var oldVendorCd = "";
var title = js_er_title ='Error';
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	if( '${vendorMgntDtl.useYn}' == 'N' ){
		$('#useYn_N').attr('checked', true);
	}else {
		$('#useYn_Y').attr('checked', true);
	}
	
	if( "${newYn}" == "N" ){
		dupChk = true;
		
		if( '${vendorMgntDtl.useYn}' == 'N' ){
			$('#useYn_N').attr('checked', true);
		}else {
			$('#useYn_Y').attr('checked', true);
		}
		
	}else if( "${newYn}" == "Y" ){
		dupChk = false;
		
		$('#useYn_Y').attr('checked', true);
		
	}
	
	
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#vendorCd').val()) || re2.test($('#vendorCd').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	$('#saveForm').validate({
		rules:{
			vendorCd:{required:true, minlength:3, maxlength:10, checkCd:true},
			vendorNm:{required:true},
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
1. 기타 필수 스크립트
********************/

function fncDupInit(){

	if(oldVendorCd != $('#vendorCd').val()){
		 dupChk = false;
		 $('#dupMsg').html('');
	 }
}

function fncVendorCdDupChk(){
	
	if($('#vendorCd').valid()){
		
		oldVendorCd = vendorCd;
		
		var companyCd = $('#companyCd').val();
		var vendorCd = $('#vendorCd').val();
		
		$.ajax({
			url:'/checkVendorCd',
			type:'POST',
			cache:false,
			data : {companyCd:companyCd,vendorCd:vendorCd},
			dataType:'json',
			success:function(data){		
				if(data == true ){
					$('#dupMsg').html('사용 가능');
					dupChk = true;
				}else{
					$('#dupMsg').html('중복 정보');
					dupChk = false;
				}
			},
			error:function(result){
				$('#dupMsg').html('에러 발생');
				dupChk = false;
			}
		});
	}
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/
	
function fncVendorSave() {
	
	if($('#saveForm').valid()){
		
		if(!dupChk){
			$('#dupMsg').html('${smCommMsgDupChk}');
			return;
		}

		if(confirm('${smCommMsgSaveCnf}')){
			$.ajax({
				url:'/saveVendorMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					fncSearch();
					fncDivPop1Close();
				},
				error:function(result){
					alert('에러 발생');
				}
			});
		}
	}
}

function fncVendorCancel() {
	fncDivPop1Close();
}	
</script>
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<body>
<div class="r_popup">
	<h1 class="r_popupTitle">업체 등록/수정</h1>	  
	<div class="r_popupCont">
  		<div class="r_inputTbl r_horizonTbl">    
		<form id="saveForm" name="saveForm" method="post">
			<table>
				<tr>
					<th>${smCompany}<span class="r_required">*</span></th>
					<td>
						<input type='hidden' id='companyCd' name='companyCd' value="${userVo.companyCd}"/>
						<input type='text' id='companyNm' name='companyNm' style="width:100px;" value="${userVo.companyNm}" class="r_Input r_disable" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>업체 코드<span class="r_required">*</span></th>
					<td>
						<input type='text' id='vendorCd' name='vendorCd' style="width:100px;" value="${vendorMgntDtl.vendorCd}" <c:if test="${newYn eq 'N' }">readonly class="r_Input r_disable"</c:if> onblur="fncDupInit();" maxlength=10 required/>
						<c:if test="${newYn eq 'Y'}">
							<span class="innerBtn">
								<button onclick="javascript:fncVendorCdDupChk(); return false;">${smDupChk}</button>
	      					</span>
							<p><span id='dupMsg'></span></p>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>업체 명<span class="r_required">*</span></th>
					<td>
						<input type='text' id='vendorNm' name='vendorNm' style="width:100px;" value="${vendorMgntDtl.vendorNm}" required/>
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
		    	<button onclick="javascript:fncVendorCancel()">${smClos}</button>
	    	</span>
		    <span class="pageNormal">
		    	<button onclick="javascript:fncVendorSave()">${smSave}</button>
		    </span>
		</div>
	</div>
</div>