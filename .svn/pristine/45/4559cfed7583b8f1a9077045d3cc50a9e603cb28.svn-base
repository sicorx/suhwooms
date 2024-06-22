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
<c:set var="smInsert"><spring:message code="insert"/></c:set>
<c:set var="smSysStrCd"><spring:message code="sysStrCd"/></c:set>
<c:set var="smSpAddr"><spring:message code="spAddr"/></c:set>
<c:set var="smTelNo"><spring:message code="telNo"/></c:set>
<c:set var="smCntrPower"><spring:message code="cntrPower"/></c:set>
<c:set var="smStrSize"><spring:message code="strSize"/></c:set>

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
var oldGwId = "";
var title = js_er_title ='Error';
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	if( '${newYn}'  == 'Y' ){
		
		$('#authYn_N').attr('checked', true);
		
		dupChk = false;
		
	}else if( '${newYn}'  == 'N' ){
		
		if( '${gmVo.authYn}'  == 'Y' ){
			$('#authYn_Y').attr('checked', true);
		}else{
			$('#authYn_N').attr('checked', true);
		}
		if( '${gmVo.useYn}'  == 'Y' ){
			$('#useYn_Y').attr('checked', true);
		}else{
			$('#useYn_N').attr('checked', true);
		}
		
		dupChk = false;
	}
	
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#gwAddr').val()) || re2.test($('#gwAddr').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	$('#saveForm').validate({
		rules:{
			strCd:{required:true},
			strNm:{required:true},
			viewStrCd:{required:true},
			gwId:{number:true},
			gwAddr:{required:true, maxlength: 12, minlength : 12, checkCd:true},
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

	if(oldGwId != $('#gwId').val()){
		 dupChk = false;
		 $('#dupMsg').html('');
	 }  
}

function fncGwIdDupChk(){
	
	if($('#gwId').valid()){
		var gwId = $('#gwId').val();
		oldGwId = gwId;
		
		$.ajax({
			url:'/checkGwId',
			type:'POST',
			cache:false,
			data : {gwId:gwId},
			dataType:'json',
			success:function(data){
				if(data == true ){
					$('#dupMsg').html('사용 가능');
					$('#dupSkipbtn').hide();
					dupChk = true;
				}else{
					$('#dupMsg').html('중복 정보');
					$('#dupSkipbtn').show();
					dupChk = false;	
				}
			},
			error:function(result){
				$('#dupMsg').html('${smCommMsgUse}');
				dupChk = true;
			}				
		});			
	}
}

function fncGwIdDupChkSkip(){
	
	$('#dupMsg').html('중복 적용');
	dupChk = true;	
}

/*******************
1. 팝업  
********************/

function fncParticularStrSearch(){

	var companyCd = $("#companyCd").val();
	var url = "gwMgntNew";
	
	var args = new Array();
	
	args.push(companyCd);
	args.push(url);
	
	fn_divPop2ndForm("particularStoreSrch", "팝업", 800, 650, "popupForm2", args );
	
}

function fncSetParticularStore(data){
	$("#viewStrCd").val(data.viewStrCd);
	$("#strNm").val(data.strNm);
	$("#strCd").val(data.strCd);
}

function fncParticularStoreClear(){
	$("#strCd").val("");
	$("#viewStrCd").val("");
	$("#strNm").val("");
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSave() {
	
	if($('#saveForm').valid()){		
		
		if(confirm("${smCommMsgSaveCnf}")){
			
			if(!dupChk){
				$('#dupMsg').html('${smCommMsgDupChk}');
				return;
			}
			
			$.ajax({
				url:'/saveGWMgnt',
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
					
				}				
			});
		}
	}
}

function fncCancel() {
	fncDivPop1Close();
}
</script>
<!-- jQuery validate 다국어 메세지 -->
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<form id='popupForm2' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
	<input type="hidden" id="popArg2" name="url"> 
</form>
<div class="r_popup">
	<h1 class="r_popupTitle">GW 등록</h1>	  
 	<div class="r_popupCont">
   		<div class="r_inputTbl r_horizonTbl">    
			<form id="saveForm" name="saveForm" method="post">
				<table>
					<tr>
						<th>${smCompany}<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='companyCd' name='companyCd' value="${userVo.companyCd}" />
							<input type='text' id='companyNm' name='companyNm' style="width:100px;" value="${userVo.companyNm}" class="r_Input r_disable" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>${smStr}<span class="r_required">*</span></th>
						<c:if test="${newYn eq 'Y' }">
							<td>
								<input type='hidden' id='strCd' name='strCd' value='' />
								<input type='text' id='viewStrCd' name='viewStrCd' value='' readonly="readonly" class="r_Input r_disable"  style="width:112px;" />
								<div class="r_innerSearch">
									<input type='text' id='strNm' name='strNm' value='' readonly="readonly" class="r_Input r_disable"  style="width: 112px;" />
									<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncParticularStrSearch();" style="cursor:pointer"/>
									<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncParticularStoreClear();" style="cursor:pointer;right:4px;"/>
								</div>
							</td>
						</c:if>
						<c:if test="${newYn eq 'N' }">
							<td>
								<input type='hidden' id='strCd' name='strCd' value='${gmVo.strCd}' />
								<input type='text' id='viewStrCd' name='viewStrCd' value='${gmVo.viewStrCd}' readonly="readonly" class="r_Input r_disable"  style="width:112px;" />
								<input type='text' id='strNm' name='strNm' value='${gmVo.strNm}' readonly="readonly" class="r_Input r_disable"  style="width: 112px;" />
							</td>
						</c:if>
					</tr>
					<tr>
						<th>GW ID<span class="r_required">*</span></th>
						<td>
							<input type='number' id='gwId' name='gwId' value="${gmVo.gwId}" style="width:145px;" onblur="fncDupInit();" maxlength="10" required/>
							<span class="innerBtn">
								<button onclick="javascript:fncGwIdDupChk(); return false;">${smDupChk}</button>
	      					</span>					
							<p><span id='dupMsg'></span><button id="dupSkipbtn" style="display:none;" onclick="javascript:fncGwIdDupChkSkip(); return false;">중복적용</button></p>
						</td>
					</tr>
					<tr>
						<th>Mac Address</th>
						<td>
							<c:if test="${newYn eq 'Y' }">
								<input type='text' id='gwAddr' name='gwAddr' value="000000000000"  style="width:145px;" maxlength="12" minlength="12" />
								<span> 기본 값 유지(정보 확실할 경우 수정)</span>
							</c:if>
							<c:if test="${newYn eq 'N' }">
								<input type='text' id='gwAddr' name='gwAddr' value="${gmVo.gwAddr}"  style="width:145px;" maxlength="12" minlength="12" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th>인증 여부<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
						   		<input type='radio' name='authYn' id='authYn_Y' value='Y'/><label for="authYn_Y">인증</label>&nbsp;
						    	<input type='radio' name='authYn' id='authYn_N' value='N'/><label for="authYn_N">미인증</label>
							</span>
						</td>
					</tr>
					<tr>
						<th>GW Ver</th>
						<td><input type='text' id='gwSwVer' name='gwSwVer' value="${gmVo.gwSwVer}"  style="width:145px;" class="r_Input r_disable" readonly="readonly" maxlength="10" /></td>
					</tr>
					<tr>
						<th>업데이트 일자</th>
						<td><input type='text' id='updateTime' name='updateTime' value="${gmVo.updateTime}"  style="width:145px;" class="r_Input r_disable" readonly="readonly"  /></td>
					</tr>
					<tr>
						<th>업데이트 성공 여부</th>
						<td><input type='text' id='updateSuccessYn' name='updateSuccessYn' value="${gmVo.updateSuccessYn}"  style="width:145px;" class="r_Input r_disable" readonly="readonly" /></td>
					</tr>
					<tr>
						<th>사용 여부<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
					   			<input type='radio' name='useYn' id='useYn_Y' value='Y' checked/><label for="useYn_Y">사용</label>&nbsp;
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