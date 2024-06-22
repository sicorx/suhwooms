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
var gvPopParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
    if('${newYn}' == "N" ){
    	
    	$('input[type=radio][name=authSp]').on('change', function(){
    		
    	    if( '${userMgntDtl.authSp}'  == 'H' ){
    			$('#authSp_H').prop('checked', true);
    		}else if( '${userMgntDtl.authSp}'  == 'M' ){
    			$('#authSp_M').prop('checked', true);
    		}else if( '${userMgntDtl.authSp}'  == 'S' ){
    			$('#authSp_S').prop('checked', true);
    		}
    	});
    	
    	if( '${userMgntDtl.authSp}'  == 'H' ){
    		$('#authSp_H').prop('checked', true);
            $('#orgPopup').show();
            $('#strPopup').hide();
            $('#hAuth').show();
            $('#mAuth').hide();
            $('#sAuth').hide();
            $('#vendorList').hide();
    	}else if( '${userMgntDtl.authSp}'  == 'M' ){
    		$('#authSp_M').prop('checked', true);
        	$('#orgPopup').hide();
        	$('#strPopup').hide();
        	$('#hAuth').hide();
        	$('#mAuth').show();
        	$('#sAuth').hide();
        	$('#vendorList').show();
    	}else if( '${userMgntDtl.authSp}'  == 'S' ){
    		$('#authSp_S').prop('checked', true);
        	$('#orgPopup').hide();
        	$('#strPopup').show();
        	$('#hAuth').hide();
        	$('#mAuth').hide();
        	$('#sAuth').show();
        	$('#vendorList').hide();
    	}	
    	
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
    	
    }else if('${newYn}' == "Y" ){
    	
    	$('#authSp_S').attr('checked', true);
    	
        $("input[type=radio][name='authSp']").on('change', function(){
        	
    	    switch($(this).val()){
    	        case 'H' :
    	            $('#orgPopup').show();
    	            $('#strPopup').hide();
    	            $('#hAuth').show();
    	            $('#mAuth').hide();
    	            $('#sAuth').hide();
    	            $('#vendorList').hide();
    	            break;
    	        case 'M' :
    	            $('#orgPopup').hide();
    	            $('#strPopup').hide();
    	            $('#hAuth').hide();
    	            $('#mAuth').show();
    	            $('#sAuth').hide();
    	            $('#vendorList').show();
    	            break;
    	        case 'S' :
    	            $('#orgPopup').hide();
    	            $('#strPopup').show();
    	            $('#hAuth').hide();
    	            $('#mAuth').hide();
    	            $('#sAuth').show();
    	            $('#vendorList').hide();
    	            break;
    	    }
    	});
    	
    	document.getElementById("eulaYn_Y").disabled = true;
    	$('#eulaYn_N').attr('checked', true);
    	$('#useYn_Y').attr('checked', true);	
    	
    }
    
	
	
	$('#saveForm').validate({
		rules:{
			companyCd:{required:true},
			userId:{required:true, minlength:3},
			userNm:{required:true},
			userPw:{required:true},
			userPwCk:{equalTo: '#userPw' },
			authSp:{required:true},
			authCd:{required:true},
			authCd1:{required:true},
			authCd2:{required:true},
			authCd3:{required:true},
			vendorCd:{required:true},
			viewStrCd:{required:true},
			useYn:{required:true}
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

function fncOrgSearch2depth(){
	
	var companyCd  = $("#companyCd").val();
	
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop2ndForm("orgSrch2depth", "팝업", 800, 650, "popupForm2", args );
}

function fncSetOrg2depth(data){
	$("#orgCd").val(data.orgCd);
	$("#orgNm").val(data.orgNm);
}

function fncStrSearch2depth(obj){
	
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop2ndForm("storeMngSrch2depth", "팝업", 800, 650, "popupForm2", args );
	
}

function fncSetStore2depth(data){
	$("#strCd").val(data.strCd);
	$("#viewStrCd").val(data.viewStrCd);
	$("#strNm").val(data.strNm);
}

function fncStoreClear2depth(){
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

	var authCd = "";
	
	if( $(":radio[name='authSp']:checked").val() == 'H' ){
		authCd = $('#authCd1').val();
	}else if( $(":radio[name='authSp']:checked").val() == 'M' ){
		authCd = $('#authCd2').val();
	}else if( $(":radio[name='authSp']:checked").val() == 'S' ){
		authCd = $('#authCd3').val();
	}
	
	$('#authCd').val(authCd);
	
	if($('#saveForm').valid()){
		if(!dupChk){
			$('#dupMsg').html('${smCommMsgDupChk}');
			return;
		}

		if(confirm('${smCommMsgSaveCnf}')){
			
			$.ajax({
				url:'/saveUserMgnt',
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
<form id='popupForm2' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
</form>
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<div class="r_popup">
	<h1 class="r_popupTitle">사용자 등록/수정</h1>
	<div class="r_popupCont">
    	<div class="r_inputTbl r_horizonTbl">    
			<form id="saveForm" name="saveForm" method="post">
				<table>
					<tr>
						<th>${smCompany}<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='companyCd' name='companyCd' value="${companyCd}"/>
							<input type='text' id='companyNm' name='companyNm' style="width:100px;" value="${companyNm}" class="r_Input r_disable" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>사용자 ID<span class="r_required">*</span></th>
						<td>
							<input type='text' id='userId' name='userId' style="width:145px;" value="${userMgntDtl.userId}" <c:if test="${newYn == 'N'}">class="r_Input r_disable" readonly="readonly"</c:if> onblur="fncDupInit();" maxlength="10" required/>
							<c:if test="${newYn == 'Y'}">
								<span class="innerBtn">
									<button onclick="javascript:fncUserIdDupChk(); return false;">${smDupChk}</button>
			      				</span>					
								<p><span id='dupMsg'></span></p>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>사용자 명<span class="r_required">*</span></th>
						<td>
							<input type='text' id='userNm' name='userNm' style="width:145px;" value="${userMgntDtl.userNm}" maxlength="30" required/>
						</td>
					</tr>
					<tr>
						<th>PW<span class="r_required">*</span></th>
						<td>
							<input type='password' id='userPw' name='userPw' maxlength="20"  value="${userMgntDtl.userPw}" style="width:145px;" required/>
						</td>
					</tr>
					<tr>
						<th>PW 재입력<span class="r_required">*</span></th>
						<td>
							<input type='password' id='userPwCk' name='userPwCk' maxlength="20" value="${userMgntDtl.userPw}" style="width:145px;" required/>
						</td>
					</tr>
					<tr>
						<th>권한 구분<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
					    		<input type='radio' name='authSp' id='authSp_H' value='H' /><label for="authSp_H">본사 직원</label>&nbsp;
						    	<input type='radio' name='authSp' id='authSp_M' value='M' /><label for="authSp_M">유지 보수</label>&nbsp;
						    	<input type='radio' name='authSp' id='authSp_S' value='S' /><label for="authSp_S">매장 직원</label>
							</span>
							<input type='hidden' name='authCd' id='authCd' value=''/>
						</td>
					</tr>
					<tr id="hAuth" style="display:none">
						<th>사용자 권한<span class="r_required">*</span></th>
						<td>
							<select id="authCd1" name="authCd1" style="width:130px;" class="tblSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.name}' <c:if test="${userMgntDtl.authCd == vo.name}">selected</c:if> >${vo.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="mAuth" style="display:none">
						<th>사용자 권한<span class="r_required">*</span></th>
						<td>
							<select id="authCd2" name="authCd2" style="width:130px;" class="tblSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
									<option value='${vo.name}' <c:if test="${userMgntDtl.authCd == vo.name}">selected</c:if> >${vo.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="sAuth">
						<th>사용자 권한<span class="r_required">*</span></th>
						<td>
							<select id="authCd3" name="authCd3" style="width:130px;" class="tblSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList3}" varStatus="status" >
									<option value='${vo.name}' <c:if test="${userMgntDtl.authCd == vo.name}">selected</c:if> >${vo.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<!--
					<tr id="orgPopup" style="display:none">
						<th>${smOrg}<span class="r_required">*</span></th>
						<td colspan="2"><input type='hidden' id='orgCd' name='orgCd' value="" />
							<div class="r_innerSearch">
							<input type='text' id='orgNm' name='orgNm' value=""  style="width:112px;" class="r_Input r_disable" readonly="readonly"/>
							<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" style="cursor:pointer"/>
							</div>
						</td>
					</tr>
					-->
					<tr id="vendorList" style="display:none">
						<th>업체명<span class="r_required">*</span></th>
						<td>
							<select id="vendorCd" name="vendorCd" style="width:130px;" class="tblSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList4}" varStatus="status" >
									<option value='${vo.value}' <c:if test="${userMgntDtl.vendorCd == vo.value}">selected</c:if> >${vo.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="strPopup">
						<th>${smStr}<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='strCd' name='strCd' value='' />
							<input type='text' id='viewStrCd' name='viewStrCd' value='' readonly="readonly" class="r_Input r_disable"  style="width:112px;" />
							<div class="r_innerSearch">
								<input type='text' id='strNm' name='strNm' value='' readonly="readonly" class="r_Input r_disable"  style="width: 112px;" />
								<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncStrSearch2depth();" style="cursor:pointer"/>
								<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear2depth();" style="cursor:pointer;right:4px;"/>
							</div>
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
						<th>사용자 여부<span class="r_required">*</span></th>
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