<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
<c:set var="smUser"><spring:message code="user"/></c:set>
<c:set var="smUserId"><spring:message code="userId" /></c:set>
<c:set var="smUserNm"><spring:message code="userNm" /></c:set>
<c:set var="smAuth"><spring:message code="auth" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smUserInfo"><spring:message code="userInfo" /></c:set>
<c:set var="smMultStrList"><spring:message code="multStrList" /></c:set>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<c:set var="smUserSrch"><spring:message code="userSrch"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smInqry"><spring:message code="inqry"/></c:set>

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('#saveForm').validate({
		rules:{
			mm1:{required:true},
			mm2:{required:true},
			mm3:{required:true},
			mm4:{required:true},
			mm5:{required:true},
			mm6:{required:true},
			mm7:{required:true},
			mm8:{required:true},
			mm9:{required:true},
			mm10:{required:true},
			mm11:{required:true},
			mm12:{required:true}
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
	
	fncSearch();
	  
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}

	$.ajax({
		url:'/retrieveSeasonPolicyMgnt',
		type:'POST',
		cache:false,
		data : {companyCd:companyCd},
		dataType:'json',
		success:function(data){
			$('#mm1').val(data.m1 );
			$('#mm2').val(data.m2 );
			$('#mm3').val(data.m3 );
			$('#mm4').val(data.m4 );
			$('#mm5').val(data.m5 );
			$('#mm6').val(data.m6 );
			$('#mm7').val(data.m7 );
			$('#mm8').val(data.m8 );
			$('#mm9').val(data.m9 );
			$('#mm10').val(data.m10 );
			$('#mm11').val(data.m11 );
			$('#mm12').val(data.m12 );
			$('#companyCd').val(data.companyCd );
		},
		error:function(result){
			$('#mm1').val("");
			$('#mm2').val("");
			$('#mm3').val("");
			$('#mm4').val("");
			$('#mm5').val("");
			$('#mm6').val("");
			$('#mm7').val("");
			$('#mm8').val("");
			$('#mm9').val("");
			$('#mm10').val("");
			$('#mm11').val("");
			$('#mm12').val("");
			$('#companyCd').val($('#scrCompanyCd').val() );
		}
	});

}

function fncSave() {			
	
	var monthTempList = "";
	for(var i=1 ; i < 13 ; i++){
		monthTempList = monthTempList + $("#mm"+i+"").val()+":"; 
		
	}

	$('#monthTempList').val(monthTempList);

	if($('#saveForm').valid()){
		if(confirm("냉난방제어기준을 " + "${smCommMsgSaveCnf}")){
			
			$.ajax({
				url:'/saveAirConditionPolicyMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					fncSearch();
				},
				error:function(result){
					alert("에러가 발생했습니다.");
				}				
			});
		}
	}
}
</script>
<div id="loadingArea">
	<c:if test="${selectVoListCnt == 1 }">
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />
	</c:if>
	<c:if test="${selectVoListCnt > 1 }">			
		<select id="scrCompanyCd" name="scrCompanyCd" style="display:none;">
			<option value=''>--선택--</option>
				<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
					<option value='${vo.value}'>${vo.name}</option>
				</c:forEach>
		</select>
	</c:if>
	
	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>냉난방제어기준</h3>
		</div>
		<form id="saveForm" name="saveForm" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="" />
			<input type="hidden" id="monthTempList" name="monthTempList" value="" />
			<table>
				<caption>Grid Table</caption>
				<colgroup>
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
	       	 	<thead>
	        		<tr>
						<c:forEach begin="1" end="12" step="1" var="i">
							<th class="tcenter" scope="col"<c:out value="${i eq 12 ? ' class=tcenter' : ''}" />>${i}월</th>
						</c:forEach>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="tcenter">
							<select id="mm1" name="mm1">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm2" name="mm2">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm3" name="mm3">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm4" name="mm4">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm5" name="mm5">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm6" name="mm6">
								<option value="">--선택--</option>
								<option value="C">냉방</option>
								<option value="H">난방</option>
								<option value="N">환절기</option>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm7" name="mm7">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm8" name="mm8">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm9" name="mm9">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm10" name="mm10">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="tcenter">
							<select id="mm11" name="mm11">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
						<td class="r_last tcenter">
							<select id="mm12" name="mm12">
								<option value="">--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
									<option value='${vo.code}'>${vo.commCdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal">
	   		<button onclick="javascript:fncSave();">${smSave}</button>
		</span>
	</div>
	<!-- //하단 버튼 그룹 -->
	
	<!-- 지시문 -->
	<div class="r_infoGroup">
	    <span class="r_infoTxt"><img src="/images/ico_info_new.png" />냉방 : 해당 월을 냉방으로 제어</span>
	    <span class="r_infoTxt"><img src="/images/ico_info_new.png" />난방 : 해당 월을 난방으로 제어</span>
	    <span class="r_infoTxt r_last"><img src="/images/ico_info_new.png" />환절기 : 해당 월은 냉난방 제어 하지 않음</span>
	</div>
	<!-- //지시문 -->
	
</div>