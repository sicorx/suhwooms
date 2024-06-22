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
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smNew"><spring:message code="new"/></c:set>
<c:set var="smUpdate"><spring:message code="update"/></c:set>
<c:set var="smDelete"><spring:message code="delete"/></c:set>
<c:set var="smSave"><spring:message code="save"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smPartSrch"><spring:message code="partSrch"/></c:set>
<c:set var="smPartIdSrch"><spring:message code="partIdSrch"/></c:set>
<c:set var="smPartQtySrch"><spring:message code="partQtySrch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smAlmon"><spring:message code="almon"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>
<c:set var="smDevice"><spring:message code="device"/></c:set>
<c:set var="smPortNo"><spring:message code="portNo"/></c:set>
<c:set var="smContents"><spring:message code="contents"/></c:set>
<c:set var="smUpperLimit"><spring:message code="upperLimit"/></c:set>
<c:set var="smLowerLimit"><spring:message code="lowerLimit"/></c:set>
<c:set var="smDetDelay"><spring:message code="detDelay"/></c:set>
<c:set var="smTempComp"><spring:message code="tempComp"/></c:set>
<c:set var="smUseYn"><spring:message code="useYn"/></c:set>
<c:set var="smMinute"><spring:message code="minute"/></c:set>
<c:set var="smPeriod"><spring:message code="period"/></c:set>
<c:set var="smDevDePortInfoInUpt"><spring:message code="devDePortInfoInUpt"/></c:set>
<c:set var="smDevQtyIns"><spring:message code="devQtyIns"/></c:set>
<c:set var="smStrFcltyInsUpt"><spring:message code="strFcltyInsUpt"/></c:set>
<c:set var="smInqry"><spring:message code="inqry"/></c:set>
<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var title = js_er_title ='Error';

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	// 포트 셋팅
	
	if( "${gsimVo.get(0).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_1']").attr("checked", true);
	}
	else
	{
		$("#hubId_1").attr("disabled", "disabled");
		$("#portNo_1").attr("disabled", "disabled");		
		$("#deviceType_1").attr("disabled", "disabled");
		$("#deviceLoc_1").attr("disabled", "disabled");		
		$("#contents_1").attr("disabled", "disabled");
		$("#pushTerm_1").attr("disabled", "disabled");			
		$("#selPort1").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_1").css("background-color", "rgba(235,235,235,1)");		
	}
	
	if("${gsimVo.get(1).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_2']").attr("checked", true);
	}
	else
	{
		$("#hubId_2").attr("disabled", "disabled");
		$("#portNo_2").attr("disabled", "disabled");		
		$("#deviceType_2").attr("disabled", "disabled");
		$("#deviceLoc_2").attr("disabled", "disabled");		
		$("#contents_2").attr("disabled", "disabled");
		$("#pushTerm_2").attr("disabled", "disabled");			
		$("#selPort2").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_2").css("background-color", "rgba(235,235,235,1)");
	}
	
	if("${gsimVo.get(2).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_3']").attr("checked", true);
	}
	else
	{
		$("#hubId_3").attr("disabled", "disabled");
		$("#portNo_3").attr("disabled", "disabled");		
		$("#deviceType_3").attr("disabled", "disabled");
		$("#deviceLoc_3").attr("disabled", "disabled");		
		$("#contents_3").attr("disabled", "disabled");
		$("#pushTerm_3").attr("disabled", "disabled");			
		$("#selPort3").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_3").css("background-color", "rgba(235,235,235,1)");
	}
	
	if("${gsimVo.get(3).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_4']").attr("checked", true);
	}
	else
	{
		$("#hubId_4").attr("disabled", "disabled");
		$("#portNo_4").attr("disabled", "disabled");		
		$("#deviceType_4").attr("disabled", "disabled");
		$("#deviceLoc_4").attr("disabled", "disabled");		
		$("#contents_4").attr("disabled", "disabled");
		$("#pushTerm_4").attr("disabled", "disabled");			
		$("#selPort4").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_4").css("background-color", "rgba(235,235,235,1)");
	}
	
	if("${gsimVo.get(4).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_5']").attr("checked", true);
	}
	else
	{
		$("#hubId_5").attr("disabled", "disabled");
		$("#portNo_5").attr("disabled", "disabled");		
		$("#deviceType_5").attr("disabled", "disabled");
		$("#deviceLoc_5").attr("disabled", "disabled");		
		$("#contents_5").attr("disabled", "disabled");
		$("#pushTerm_5").attr("disabled", "disabled");			
		$("#selPort5").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_5").css("background-color", "rgba(235,235,235,1)");
	}
	
	if("${gsimVo.get(5).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_6']").attr("checked", true);
	}
	else
	{
		$("#hubId_6").attr("disabled", "disabled");
		$("#portNo_6").attr("disabled", "disabled");		
		$("#deviceType_6").attr("disabled", "disabled");
		$("#deviceLoc_6").attr("disabled", "disabled");		
		$("#contents_6").attr("disabled", "disabled");
		$("#pushTerm_6").attr("disabled", "disabled");			
		$("#selPort6").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_6").css("background-color", "rgba(235,235,235,1)");
	}
	
	if("${gsimVo.get(6).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_7']").attr("checked", true);
	}
	else
	{
		$("#hubId_7").attr("disabled", "disabled");
		$("#portNo_7").attr("disabled", "disabled");		
		$("#deviceType_7").attr("disabled", "disabled");
		$("#deviceLoc_7").attr("disabled", "disabled");		
		$("#contents_7").attr("disabled", "disabled");
		$("#pushTerm_7").attr("disabled", "disabled");			
		$("#selPort7").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_7").css("background-color", "rgba(235,235,235,1)");
	}
	
	if("${gsimVo.get(7).useYn }" == "Y" ){
		$("input:checkbox[id='useYn_8']").attr("checked", true);
	}
	else
	{
		$("#hubId_8").attr("disabled", "disabled");
		$("#portNo_8").attr("disabled", "disabled");		
		$("#deviceType_8").attr("disabled", "disabled");
		$("#deviceLoc_8").attr("disabled", "disabled");		
		$("#contents_8").attr("disabled", "disabled");
		$("#pushTerm_8").attr("disabled", "disabled");			
		$("#selPort8").css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_8").css("background-color", "rgba(235,235,235,1)");
	}
	
	
	
	
	$('#saveForm').validate({
		rules:{
			pushTerm_1 :{required:true, number:true},
			pushTerm_2 :{required:true, number:true},
			pushTerm_3 :{required:true, number:true},
			pushTerm_4 :{required:true, number:true},
			pushTerm_5 :{required:true, number:true},
			pushTerm_6 :{required:true, number:true},
			pushTerm_7 :{required:true, number:true},
			pushTerm_8 :{required:true, number:true},
			
			deviceType_1 :{required:true},
			deviceType_2 :{required:true},
			deviceType_3 :{required:true},
			deviceType_4 :{required:true},
			deviceType_5 :{required:true},
			deviceType_6 :{required:true},
			deviceType_7 :{required:true},
			deviceType_8 :{required:true},
			
			deviceLoc_1 :{required:true},
			deviceLoc_2 :{required:true},
			deviceLoc_3 :{required:true},
			deviceLoc_4 :{required:true},
			deviceLoc_5 :{required:true},
			deviceLoc_6 :{required:true},
			deviceLoc_7 :{required:true},
			deviceLoc_8 :{required:true},
			
			pushTerm_1 :{required:true, number:true},
			pushTerm_2 :{required:true, number:true},
			pushTerm_3 :{required:true, number:true},
			pushTerm_4 :{required:true, number:true},
			pushTerm_5 :{required:true, number:true},
			pushTerm_6 :{required:true, number:true},
			pushTerm_7 :{required:true, number:true},
			pushTerm_8 :{required:true, number:true}
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
		
		for( var i = 1 ; i < 9 ; i++ ){
			
			id = "#useYn_"+i; 
			
			if( $(id).is(":checked") )
			{
				$(id).val("Y");
			}else{
				$(id).val("N");
			}
		}
		
		var hubIdList = "";
		var portNoList = "";
		var deviceTypeList = "";
		var deviceLocList = "";
		var contentsList = "";
		var pushTermList = "";
		var useYnList = "";
		
		for(var i= 1 ; i < 9 ; i++ ){
			
			hubIdList = hubIdList + $("#hubId_"+i+"").val()+":";
			portNoList = portNoList + $("#portNo_"+i+"").val()+":";
			deviceTypeList = deviceTypeList + $("#deviceType_"+i+"").val()+":";
			deviceLocList = deviceLocList + $("#deviceLoc_"+i+"").val()+":";
			contentsList = contentsList + $("#contents_"+i+"").val()+":";
			pushTermList = pushTermList + $("#pushTerm_"+i+"").val()+":";
			useYnList = useYnList + $("#useYn_"+i+"").val()+":";
			
			//alert( $("#useYn_"+i+"").val() );
		}		
		
		$("#hubIdList").val(hubIdList);
		$("#portNoList").val(portNoList);
		$("#deviceTypeList").val(deviceTypeList);
		$("#deviceLocList").val(deviceLocList);
		$("#contentsList").val(contentsList);
		$("#pushTermList").val(pushTermList);
		$("#useYnList").val(useYnList);
		
		if(confirm('${smCommMsgSaveCnf}')){
			
			$.ajax({
				url:'/saveStoreInverterMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					if(data){
						alert('${smCommMsgSave}');
					}else{
						alert('저장에 실패 했습니다');
					}
				},
				error:function(result){
				}
			});
		}
		
	}

	
}


//CheckBox 선택
function fncTemonUseYnClick(idx){
	
	var idx = idx
	var useYnId = 'useYn_'+idx
	var checkYn = $("input:checkbox[id='"+useYnId+"']").is(":checked");
	
	
	if( checkYn == true ){		
		$("#hubId_"+idx).removeAttr("disabled");
		$("#portNo_"+idx).removeAttr("disabled");
		//$("#useYn_"+idx).removeAttr("disabled");
		$("#deviceType_"+idx).removeAttr("disabled");
		$("#deviceLoc_"+idx).removeAttr("disabled");		
		$("#contents_"+idx).removeAttr("disabled");
		$("#pushTerm_"+idx).removeAttr("disabled");				
		$("#selPort"+idx).css("background-color", "rgba(255,255,255,1)");
		$("#deviceType_"+idx).css("background-color", "rgba(255,255,255,1)");
	}else{
		$("#hubId_"+idx).attr("disabled", "disabled");
		$("#portNo_"+idx).attr("disabled", "disabled");
		//$("#useYn_"+idx).attr("disabled", "disabled");
		$("#deviceType_"+idx).attr("disabled", "disabled");
		$("#deviceLoc_"+idx).attr("disabled", "disabled");		
		$("#contents_"+idx).attr("disabled", "disabled");
		$("#pushTerm_"+idx).attr("disabled", "disabled");			
		$("#selPort"+idx).css("background-color", "rgba(235,235,235,1)");
		$("#deviceType_"+idx).css("background-color", "rgba(235,235,235,1)");
	}
	
}


//이전 버튼
function fncCancel() {
	if(confirm('이전으로 가시겠습니까?'))
	{	
		var param  = new Object();
		param.mode 			= "BACK";
		param.scrStrNm 		= '${history.scrStrNm}';		
		param.scrOrgCd 		= '${history.scrOrgCd}';		
		param.scrOrgNm 		= '${history.scrOrgNm}';
		fncCallPage('4205', param);
	}
}


</script>
<form id='popupForm2' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
	<input type="hidden" id="popArg2" name="url">
</form>
<!-- jQuery validate 다국어 메세지 -->
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<div id="loadingArea">
	<!-- 조회조건 -->
	<div class="r_search multiLine">
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
		<table>
			<tr>
				<th>매장명/코드</th>
				<td>
					<input type='hidden' id='strCd' name='strCd' value="${userVo.strCd}" />
					<input type='hidden' id='viewStrCd' name='viewStrCd' value="${userVo.viewStrCd}"  style="width:100px; text-align:left;" class="r_Input r_disable" readonly="readonly" />&nbsp;
					<div class="r_innerSearch"> 
						<input type='text' id='strNm' name='strNm' value="${userVo.strNm}(${userVo.viewStrCd})"  style="width:145px;" maxlength="30" class="r_Input r_disable" readonly="readonly" />									
					</div>
				</td>				
			</tr>
		</table>		
	</div>
	<!-- //조회조건 -->
	
	<!-- 테이블 영역 -->
	<form id="saveForm" name="saveForm" method="post">
		<input type='hidden' id='strCd' name='strCd' value="${userVo.strCd}" />
		<input type="hidden" id="hubIdList" name="hubIdList" ></input>
		<input type="hidden" id="portNoList" name="portNoList" ></input>
		<input type="hidden" id="deviceTypeList" name="deviceTypeList" ></input>
		<input type="hidden" id="deviceLocList" name="deviceLocList" ></input>
		<input type="hidden" id="contentsList" name="contentsList" ></input>
		<input type="hidden" id="pushTermList" name="pushTermList" ></input>				
		<input type="hidden" id="useYnList" name="useYnList" ></input>
		<div class="r_inputTbl r_horizonTbl">
			<div class="r_gridTitle">
				<h3>인버터 허브 포트 정보</h3>	
			</div>
			<table>
				<colgroup>
			       	<col width="5%"  />				        
			        <col width="10%" />
			        <col width="10%" />
			        <col width="15%" />
			        <col width="20%" />
			        <col width="20%" />
			        <col width="10%" />
			    </colgroup>
		        <thead>
	        	<tr>					            
		            <th scope="col" class="tcenter">HUB_ID</th>
		            <th scope="col" class="tcenter">포트번호</th>
		            <th scope="col" class="tcenter">사용여부</th>
		            <th scope="col" class="tcenter">장비 종류</th>
		            <th scope="col" class="tcenter">용도(식별 가능 설명)</th>
		            <th scope="col" class="tcenter">비고</th>
		            <th class="r_last tcenter" scope="col">푸시주기(분)</th>
	        	</tr>
		        </thead>
		        <tbody>
			        <c:forEach begin="1" end="8" step="1" var="i">
						<tr id='selPort${i}'>						          					            
				            <td class="tcenter"><input type="hidden" id="hubId_${i}" name="hubId_${i}" value="${gsimVo.get(i-1).hubId}" readonly="readonly"/>${gsimVo.get(i-1).hubId}</td>
				            <td class="tcenter"><input type="hidden" id="portNo_${i}" name="portNo_${i}" value="${gsimVo.get(i-1).portNo}" />${gsimVo.get(i-1).portNo}</td>
				            <td class="tcenter"><input type="checkbox" id="useYn_${i}" name="useYn_${i}" onclick='javascript:fncTemonUseYnClick(${i})'/></td>
				            <td class="r_gridInput tcenter">
								<select id="deviceType_${i}" name="deviceType_${i}" class="tblSelect" style="width:100px;">
									<option value=''>--선택--</option>
										<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
											<option value='${vo.value}' <c:if test="${gsimVo.get(i-1).deviceType == vo.value}">selected</c:if> >${vo.name}</option>
										</c:forEach>
								</select>
							</td>
				            <td class="tcenter"><input type="text" id="deviceLoc_${i}" name="deviceLoc_${i}" value="${gsimVo.get(i-1).deviceLoc}" maxlength="10" /></td>
				            <td class="tcenter"><input type="text" id="contents_${i}" name="contents_${i}" value="${gsimVo.get(i-1).contents}" maxlength="20" /></td>
				            <td class="tcenter"><input type="number" id="pushTerm_${i}" name="pushTerm_${i}"  value="${gsimVo.get(i-1).pushTerm}" style="width:80px;text-align:right" required/></td>
						</tr>
					</c:forEach>							
					</tbody>					
			</table>
		</div>
	</form>
	<!-- //테이블 영역 -->

	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
	     <span class="pageNormal">
	     	<button onclick="javascript:fncCancel()">이전</button>
	     </span>
	     <span class="pageNormal">
	     	<button onclick="javascript:fncSave()">${smSave}</button>
	     </span>
	</div>
	<!-- //하단 버튼 그룹 -->
	
</div>
