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


// 페이지 사용 ???? 

var dupChk = false;
var oldUserId = "";
var title = js_er_title ='Error';
var gvPopParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	var useYn = "${orgInfo.useYn}";
	
	if(useYn == "Y" || useYn == ""){
		$('#useYn_Y').attr('checked', true);
	}else{
		$('#useYn_N').attr('checked', true);
	}
});

/*******************
1. 기타 필수 스크립트
********************/



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
	
	if(confirm('저장하시겠습니까?')){
		
		$.ajax({
			url:'/saveOrgMgnt',
			type:'POST',
			cache:false,
			data:$('#saveForm').serialize(),
			dataType:'json',
			success:function(data){
				alert('저장되었습니다.');
				fncSearch();
				//changeDepth($("#depthLvl").val()-1);
				fncDivPop1Close();
			},
			error:function(result){
			}				
		});
	}
}

function fncCancel() {
	fncDivPop1Close();
}
</script>
<div class="r_popup">
	<h1 class="r_popupTitle">조직 등록/수정</h1>	  
	<div class="r_popupCont">
    	<div class="r_inputTbl r_horizonTbl">    
			<form id="saveForm" name="saveForm" method="post">
				<table>
					<tr>
						<th>회사명<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='companyCd' name='companyCd' value="${sessionUserVo.sessionCompanyCd}"/>
							<input type='text' id='companyNm' name='companyNm' style="width:100px;" value="${sessionUserVo.sessionCompanyNm}" class="r_Input r_disable" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>depth<span class="r_required">*</span></th>
						<td>
							<input type='text' id='depthLvl' name='depthLvl' style="width:145px;" maxlength="3" value="${depth}" class="r_Input r_disable" readonly="readonly"/>
							<span id='dupMsg'></span>
						</td>
					</tr>
					<tr>
						<th>상위조직명<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='uperOrgCd' name='uperOrgCd' style="width:145px;" maxlength="30" value="${uperOrgCd}" class="r_Input r_disable" readonly="readonly"/>
							<c:if test="${depth > 1 }">
								<input type='text' id='uperOrgNm' name='uperOrgNm' style="width:145px;" maxlength="30" value="${uperOrgNm}" class="r_Input r_disable" readonly="readonly"/>
							</c:if>
							<c:if test="${depth == 1 }">
								<input type='text' id='uperOrgNm' name='uperOrgNm' style="width:145px;" maxlength="30" value="없음(최상위)" class="r_Input r_disable" readonly="readonly"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>조직명<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='orgCd' name='orgCd' value="${orgInfo.orgCd}"/>
							<input type='text' id='orgNm' name='orgNm' maxlength="20"  style="width:145px;" value="${orgInfo.orgNm}" required/>
						</td>
					</tr>
					<tr>
						<th>순서<span class="r_required">*</span></th>
						<td>
							<input type='text' id='seq' name='seq' maxlength="20"  style="width:145px;" value="${orgInfo.seq}" required/>
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