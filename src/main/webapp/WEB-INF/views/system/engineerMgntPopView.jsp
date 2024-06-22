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
var oldUserId = "";
var title = js_er_title ='Error';

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	if( '${newYn}'  == 'Y' ){
	
		document.getElementById("eulaYn_Y").disabled = true;
		$('#eulaYn_N').attr('checked', true);
		$('#useYn_Y').attr('checked', true);
		
		dupChk = false;
		
	}else if( '${newYn}'  == 'N' ){
		
		if( '${userMgntDtl.eulaYn}'  == 'Y' ){
			$('#eulaYn_Y').prop('checked', true);
		}else{
			$('#eulaYn_N').prop('checked', true);
		}
		if( '${userMgntDtl.useYn}'  == 'Y' ){
			$('#useYn_Y').prop('checked', true);
		}else{
			$('#useYn_N').prop('checked', true);
		}
	
		dupChk = true;
		
	}
	
	$('#saveForm').validate({
		rules:{
			vendorCd:{required:true},
			userId:{required:true, minlength:3},
			userNm:{required:true},
			userPw:{required:true},
			userPwCk:{equalTo: '#userPw' },
			authCd:{required:true},
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

	if(oldUserId != $('#userId').val()){
		 dupChk = false;
		 $('#dupMsg').html('');
	 }  
}

function fncUserIdDupChk(){
	
	if($('#userId').valid()){
		var userId = $('#userId').val();
		oldUserId = userId;
		
		$.ajax({
			url:'/checkUserId',
			type:'POST',
			cache:false,
			data : {userId:userId},
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
				$('#dupMsg').html('${smCommMsgUse}');
				dupChk = true;
			}				
		});			
	}
}

/*******************
1. 팝업  
********************/

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSave() {

	if($('#saveForm').valid()){		
		if(!dupChk){
			$('#dupMsg').html('${smCommMsgDupChk}');
			return;
		}

		if(confirm('${smCommMsgSaveCnf}')){
			
			$.ajax({
				url:'/saveEngineerMgnt',
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
</head>
<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="strCd"> 
	<input type="hidden" id="popArg2" name="viewStrCd"> 
	<input type="hidden" id="popArg3" name="vendorCd"> 
	<input type="hidden" id="popArg4" name="vendorNm"> 
</form>
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<div class="r_popup">
	<h1 class="r_popupTitle">사용자 등록</h1>	  
	<div class="r_popupCont">
    	<div class="r_inputTbl r_horizonTbl">    
			<form id="saveForm" name="saveForm" method="post">
				<table>
					<tr>
						<th>업체명<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='vendorCd' name='vendorCd' value="${userMgntDtl.vendorCd}"/>
							<input type='text' id='vendorNm' name='vendorNm' style="width:100px;" value="${userMgntDtl.vendorCd}" class="r_Input r_disable" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>사용자 ID<span class="r_required">*</span></th>
						<td>
							<c:if test="${newYn eq 'Y' }">
								<input type='text' id='userId' name='userId' value="${userMgntDtl.userId}" style="width:145px;" onblur="fncDupInit();" maxlength="10" required/>
								<span class="innerBtn">
									<button onclick="javascript:fncUserIdDupChk(); return false;">${smDupChk}</button>
		      					</span>					
								<p><span id='dupMsg'></span></p>
							</c:if>
							<c:if test="${newYn eq 'N' }">
								<input type='text' id='userId' name='userId' value="${userMgntDtl.userId}" style="width:145px;" class="r_Input r_disable" readonly="readonly" required/>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>사용자 명<span class="r_required">*</span></th>
						<td>
							<input type='text' id='userNm' name='userNm' value="${userMgntDtl.userNm}" style="width:145px;" maxlength="30" required/>
						</td>
					</tr>
					<tr>
						<th>PW<span class="r_required">*</span></th>
						<td>
							<input type='password' id='userPw' name='userPw' value="${userMgntDtl.userPw}" maxlength="20"  style="width:145px;" required/>
						</td>
					</tr>
					<tr>
						<th>PW 재입력<span class="r_required">*</span></th>
						<td>
							<input type='password' id='userPwCk' name='userPwCk' value="${userMgntDtl.userPw}" maxlength="20"  style="width:145px;" required/>
						</td>
					</tr>
					<tr>
						<th>사용자 동의<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
					    		<input type='radio' name='eulaYn' id='eulaYn_Y' value='Y'/><label for="eulaYn_Y">동의</label>&nbsp;
						    	<input type='radio' name='eulaYn' id='eulaYn_N' value='N'/><label for="eulaYn_N">미동의</label>
							</span>
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