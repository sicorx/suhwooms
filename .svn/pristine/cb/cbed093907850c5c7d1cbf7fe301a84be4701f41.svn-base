<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

	
<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>
<c:set var="smInvalidSession"><spring:message code="invalidSession"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var='sm_layout'><spring:message code='layout'/></c:set>
<c:set var='sm_str'><spring:message code='str'/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var='smRetrieve'><spring:message code='retrieve'/></c:set>

<c:set var="smSeq"><spring:message code="seq"/></c:set>

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

<c:set var="smDupChk"><spring:message code="dupChk"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smNew"><spring:message code="new"/></c:set>
<c:set var="smUpdate"><spring:message code="update"/></c:set>
<c:set var="smDelete"><spring:message code="delete"/></c:set>
<c:set var="smSave"><spring:message code="save"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smAlmon"><spring:message code="almon"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>

<c:set var="smStrCdExtSrch"><spring:message code="strCdExtSrch"/></c:set>

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

var gvPopParam = new Object(); // 팝업 파라미터 저장 변수

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){

	$("#viewStrCd").bind('change', function(e) {
		fncClearInput("C");
	});
	
	$("#strNm").bind('change', function(e) {
		fncClearInput("N");
	});
	
	var strCd = "${orgStrCd}"
	
	$("#strCd").val( strCd );
	$("#strNm").val("${orgStrNm}");
		 
	if( strCd != '' && strCd != null) {
		fncSearch();
	}	
});

/*******************
1. 기타 필수 스크립트
********************/

function fncClearInput(param){

	$("#strCd").val("");
	
	if( param == "C" ) {
		$("#strNm").val("");	
	}
	else if( param == "N") {
		$("#viewStrCd").val("");	
	}
}

/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}

	gvPopParam.viewStrCd = $("#viewStrCd").val();
	gvPopParam.strNm = $("#strNm").val();
	gvPopParam.companyCd = $("#scrCompanyCd").val();
	
	fncWindowPopup('storeMngSrch');
}

function fncSetStore(data){
	$("#viewStrCd").val(data.viewStrCd);
	$("#strNm").val(data.strNm);
	$("#strCd").val(data.strCd);
}

function fncOrgSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	gvPopParam.companyCd = $("#scrCompanyCd").val();
	fncWindowPopup('showOrgSrch');
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd);
	$("#scrOrgNm").val(data.orgNm);
}

function fncAlarmPopup(obj) {

	gvPopParam = obj;
	fncWindowPopup('eqmtAlarmSrch?srchStrCd=' + $("#eqmtLocation").data("strcd"), obj, 500, 600);	
} 

function fncTempTrendPopup(obj) {

	gvPopParam = obj;
	fncWindowPopup('eqmtTempSrch?srchStrCd=' + $("#eqmtLocation").data("strcd"), obj, 500, 600);	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var strCd  = $("#strCd").val();

	if( strCd == '' || strCd == null ) {
		alert("${smStrCdSrch}");
		return false;
	}

	$('#eqmtLocation').html('');

	$.ajax({
		type : "POST",
		cache : false,
		url : "retrieveStoreEqmtLayout",
		data : {srchStrCd : strCd},
		success : function(data) {
			$('#storeEqmtLayout').html(data);
		},
		complete : function(data) {
		}
	});	
}

</script>

<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="strCd"> 
    <input type="hidden" id="popArg2" name="viewStrCd"> 
    <input type="hidden" id="popArg3" name="companyCd"> 
    <input type="hidden" id="popArg4" name="companyNm"> 
</form>
<div class="r_search multiLine">	  
	<table>
		<tr>
			<th>${smCompany}</th>
			<td>
			 	<c:if test="${selectVoListCnt == 1 }">
					<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
					<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
				</c:if>
				<c:if test="${selectVoListCnt > 1 }">			
					<select id="'scrCompanyCd'" name="scrCompanyCd'" style="width:100px;" class="searchSelect">
						<option value=''>--선택--</option>
							<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
								<option value='${vo.name}'>${vo.value}</option>
							</c:forEach>
					</select>
				</c:if>
			</td>
			<th>${smOrg}</th>
			<td colspan="2"><input type='hidden' id='scrOrgCd' name='scrOrgCd' value='' />
				<div class="r_innerSearch">
					<input type='text' id='scrOrgNm' name='scrOrgNm' value='' class="r_Input r_disable" style="width:100px;" readonly="readonly" />
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" style="cursor:pointer"/>
				</div>
			</td>
		</tr>
			
		<tr>
			<th>${smStr}</th>
			<td>
				<input type='hidden' id='strCd' name='strCd' value='${orgStrCd}' />
				<input class="r_Input r_disable" type='text' id='viewStrCd' name='viewStrCd' value='${orgViewStrCd}' style="width:100px;" />
				<div class="r_innerSearch">
					<input type='text' id='strNm' name='strNm' value='${strNm}' style="width:150px;" />
					<img src="/images/ico_innerSearch.png" id="innerSearch" onclick="fncStrSearch(this);"/>
				</div>
			</td>
		</tr>
	</table>
	
	<span class="search">
        <button onclick="javascript:fncSearch()">${smRetrieve}</button>
    </span>
</div>
    
<div id="storeEqmtLayout" class="r_eqmtLayout"></div>