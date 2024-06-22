<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
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
	
	// 장비 개수 셋팅
	var temon = $("#temon").val(	'${cnt.temon}');
	var zigbee = $("#zigbee").val(	'${cnt.zigbee}');
	var almon = $("#almon").val(	'${cnt.almon}');

	$("#temonType").find("option").remove().end().append("<option value=''>--"+'${smSelect}'+"--</option> ");
	
	//console.log( temon );
	//console.log( zigbee );
	//console.log( almon );
	
	if( '${cnt.temon}' > 0 ){
		$("#temonType").append("<option value='T'>TE-MON</option>");
	}
	if( '${cnt.zigbee}' > 0 ){
		$("#temonType").append("<option value='Z'>ZIGBEE</option>");
	}
	if( '${cnt.almon}' > 0 ){
		$("#temonType").append("<option value='A'>AL-MON</option>");
	}
	
	
	$('#dialog-confirm').css('overflow', 'auto');
	
	jQuery.validator.addClassRules({       
	        numberVal: {
	            number: true,
	            min: -50,
	            max: 50,
	            maxlength: 5
	        }
	});
		
	$('#saveListForm').validate({
						
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

// 장치 변경시
function fncTemonTypeChg(obj){
	
	var type = obj.value;
	var idx = 0;
	
	if(type == 'T'){
		idx = $('#temon').val();			
	}else if(type == 'Z'){
		idx = $('#zigbee').val();	
	}else{
		idx = $('#almon').val();	
	}
	
	$("#temonId").find("option").remove().end().append("<option value=''>--"+'${smSelect}'+"--</option> ");
	for(var i=0;i<idx;i++)
	{
		if( i == 0 )			
			$("#temonId").append("<option value='"+(i+1)+"' selected >"+(i+1)+"</option>");
		else
			$("#temonId").append("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
	}
	
	
}

// 테몬,지그비,알몬 포트 조회
function fncSearch_List(){
	
	if($('#temonType').val() == ''){
		alert('${smPartSrch}');
		$('#temonType').focus();
		return;
	}
	if($('#temonId').val() == ''){
		alert('${smPartIdSrch}');
		$('#temonId').focus();
		return;
	}
	
	var strCd = $('#strCd').val();
	var temonId = $('#temonId').val();
	var type = $('#temonType').val();
	var idx = 16;
	
	$.ajax({		
		url:'/retrieveStoreFcltyMgntListDtl',
		type:'POST',
		cache:false,
		data : {strCd:strCd,temonType:type,temonId:temonId},
		dataType:'json',
		success:function(data){
			
			for(var i = 0 ; i < 16 ; i++){
				
				$("#temonId"+(i+1)).val('');
				$("#temonType"+(i+1)).val('');
				$("#portNo"+(i+1)).val('');
				$("#useYn"+(i+1)).val('');
				$("#deviceType"+(i+1)).val('');
				$("#deviceLoc"+(i+1)).val('');
				$("#content"+(i+1)).val('');
				$("#maxTemp"+(i+1)).val('');
				$("#minTemp"+(i+1)).val('');
				$("#delayTime"+(i+1)).val('');
				$("#tempConf"+(i+1)).val('');
				$("#pushTerm"+(i+1)).val('');
				$("#sensTemp"+(i+1)).val('');	
				
				$("#useYn"+(i+1)).prop("checked", false);
				$("#deviceType"+(i+1)).removeAttr("disabled");
				$("#deviceLoc"+(i+1)).removeAttr("disabled");
				$("#content"+(i+1)).removeAttr("disabled");
				$("#maxTemp"+(i+1)).removeAttr("disabled");
				$("#minTemp"+(i+1)).removeAttr("disabled");
				$("#delayTime"+(i+1)).removeAttr("disabled");
				$("#tempConf"+(i+1)).removeAttr("disabled");
				$("#pushTerm"+(i+1)).removeAttr("disabled");
				$("#sensTemp"+(i+1)).removeAttr("disabled");	

			}

			if( data.length > 0 ){
				
				for(var i = 0 ; i < 16 ; i++){
					
					$("#temonId"+(i+1)).val(data[i].temonId);
					$("#temonType"+(i+1)).val(data[i].temonType);
					$("#portNo"+(i+1)).val(data[i].portNo);
					$("#useYn"+(i+1)).val(data[i].useYn);
					$("#deviceType"+(i+1)).val(data[i].deviceType);
					$("#deviceLoc"+(i+1)).val(data[i].deviceLoc);
					$("#content"+(i+1)).val(data[i].content);
					$("#maxTemp"+(i+1)).val(data[i].maxTemp);
					$("#minTemp"+(i+1)).val(data[i].minTemp);
					$("#delayTime"+(i+1)).val(data[i].delayTime);
					$("#tempConf"+(i+1)).val(data[i].tempConf);
					$("#pushTerm"+(i+1)).val(data[i].pushTerm);
					$("#sensTemp"+(i+1)).val(data[i].sensTemp);		
					
					if( data[i].useYn == "N" ){
						
						$("#useYn"+(i+1)).prop("checked", false);
						$("#deviceType"+(i+1)).attr("disabled", "disabled");
						$("#deviceLoc"+(i+1)).attr("disabled", "disabled");
						$("#content"+(i+1)).attr("disabled", "disabled");
						$("#maxTemp"+(i+1)).attr("disabled", "disabled");
						$("#minTemp"+(i+1)).attr("disabled", "disabled");
						$("#delayTime"+(i+1)).attr("disabled", "disabled");
						$("#tempConf"+(i+1)).attr("disabled", "disabled");
						$("#pushTerm"+(i+1)).attr("disabled", "disabled");
						$("#sensTemp"+(i+1)).attr("disabled", "disabled");	
						$("#selPort"+(i+1)).css("background-color", "rgba(235,235,235,1)");
						$("#deviceType"+(i+1)).css("background-color", "rgba(235,235,235,1)");						
					}else if( data[i].useYn == "Y" ){
						$("#useYn"+(i+1)).prop("checked", true);
						$("#selPort"+(i+1)).css("background-color", "rgba(255,255,255,1)");
						$("#deviceType"+(i+1)).css("background-color", "rgba(255,255,255,1)");
					}
				}
				$('#tbody').show();
				
			}else{
				
				var temonId = $('#temonId').val();
				var type = $('#temonType').val();
				
				// 디폴트일 경우
				for(var i = 0 ; i < 16 ; i++){
					
					if( type == "T" || type == "Z" )
					{					
						$("#temonId"+(i+1)).val(temonId);
						$("#temonType"+(i+1)).val(type);
						$("#portNo"+(i+1)).val((i+1));
						$("#useYn"+(i+1)).val("N");
						$("#maxTemp"+(i+1)).val(50);
						$("#minTemp"+(i+1)).val(-50);
						$("#delayTime"+(i+1)).val(90);
						$("#tempConf"+(i+1)).val(0);
						$("#pushTerm"+(i+1)).val(180);
						$("#sensTemp"+(i+1)).val("-");
						// 신규매장 임시 16개 포트 개방
						$("#useYn"+(i+1)).val("N");
						$("#deviceType"+(i+1)).val('R');
						$("#deviceLoc"+(i+1)).val('미지정'+(i+1));
					}
					
					if( type == "A" )
					{
						$("#temonId"+(i+1)).val(temonId);
						$("#temonType"+(i+1)).val(type);
						$("#portNo"+(i+1)).val((i+1));
						$("#useYn"+(i+1)).val("N");
						$("#maxTemp"+(i+1)).val(0);
						$("#minTemp"+(i+1)).val(0);
						$("#delayTime"+(i+1)).val(0);
						$("#tempConf"+(i+1)).val(0);
						$("#pushTerm"+(i+1)).val(180);
						$("#sensTemp"+(i+1)).val("-");		
						
						
						// 신규매장 임시 16개 포트 개방
						$("#useYn"+(i+1)).val("N");
						$("#deviceType"+(i+1)).val('C');
						$("#deviceLoc"+(i+1)).val('미지정'+(i+1));
					}					
				}
				
				for(var i = 0 ; i < 16 ; i++){
					
					if( $("#useYn"+(i+1)).val() != "Y" ){
						
						$("#useYn"+(i+1)).prop("checked", false);
						$("#deviceType"+(i+1)).attr("disabled", "disabled");
						$("#deviceLoc"+(i+1)).attr("disabled", "disabled");
						$("#content"+(i+1)).attr("disabled", "disabled");
						$("#maxTemp"+(i+1)).attr("disabled", "disabled");
						$("#minTemp"+(i+1)).attr("disabled", "disabled");
						$("#delayTime"+(i+1)).attr("disabled", "disabled");
						$("#tempConf"+(i+1)).attr("disabled", "disabled");
						$("#pushTerm"+(i+1)).attr("disabled", "disabled");
						$("#sensTemp"+(i+1)).attr("disabled", "disabled");	
						$("#selPort"+(i+1)).css("background-color", "rgba(235,235,235,1)");
						$("#deviceType"+(i+1)).css("background-color", "rgba(235,235,235,1)");		
					}else{												
						$("#useYn"+(i+1)).prop("checked", true); 
						$("#selPort"+(i+1)).css("background-color", "rgba(255,255,255,1)");
						$("#deviceType"+(i+1)).css("background-color", "rgba(255,255,255,1)");		
					}
				}
				$('#tbody').show();
				
			}
		},
		error:function(result){
			$('#strPopup').hide();
			
		}			
	});	

}

// CheckBox 선택
function fncTemonUseYnClick(idx){
	
	var idx = idx
	var useYnId = 'useYn'+idx
	var checkYn = $("input:checkbox[id='"+useYnId+"']").is(":checked");
	
	if( checkYn == true ){
		$("#deviceType"+idx).removeAttr("disabled");
		$("#deviceLoc"+idx).removeAttr("disabled");
		$("#content"+idx).removeAttr("disabled");
		$("#maxTemp"+idx).removeAttr("disabled");
		$("#minTemp"+idx).removeAttr("disabled");
		$("#delayTime"+idx).removeAttr("disabled");
		$("#tempConf"+idx).removeAttr("disabled");
		$("#pushTerm"+idx).removeAttr("disabled");
		$("#sensTemp"+idx).removeAttr("disabled");		
		$("#selPort"+idx).css("background-color", "rgba(255,255,255,1)");
		$("#deviceType"+idx).css("background-color", "rgba(255,255,255,1)");
	}else{
		$("#deviceType"+idx).attr("disabled", "disabled");
		$("#deviceLoc"+idx).attr("disabled", "disabled");
		$("#content"+idx).attr("disabled", "disabled");
		$("#maxTemp"+idx).attr("disabled", "disabled");
		$("#minTemp"+idx).attr("disabled", "disabled");
		$("#delayTime"+idx).attr("disabled", "disabled");
		$("#tempConf"+idx).attr("disabled", "disabled");
		$("#pushTerm"+idx).attr("disabled", "disabled");
		$("#sensTemp"+idx).attr("disabled", "disabled");	
		$("#selPort"+idx).css("background-color", "rgba(235,235,235,1)");
		$("#deviceType"+idx).css("background-color", "rgba(235,235,235,1)");
	}
}

// 저장 버튼
function fncSave() {			

	var temonIdArry = new Array();
	var temonTypeArry = new Array();
	var porNoArry = new Array();
	var useYnArry = new Array();
	var deviceTypeArry = new Array();
	var deviceLocArry = new Array();
	var contentArry = new Array();
	var maxTempArry = new Array();
	var minTempArry = new Array();
	var delayTimeArry = new Array();
	var tempConfArry = new Array();
	var pushTermArry = new Array();
	
	//행의수 확인
	if($("#tbody").find('tr').length == 0){
		alert('${smInqry}');
		return;
	}
	
	if($('#saveListForm').valid()){		
		
		$('input:checkbox[name="useYn"]').each(function(i){
			if(this.checked){
				$('#useYn'+(i+1)).val('Y');
			}else{
				$('#useYn'+(i+1)).val('N');
			}
			
			temonIdArry.push($('#temonId'+(i+1)).val());
			temonTypeArry.push($('#temonType'+(i+1)).val());
			porNoArry.push($('#portNo'+(i+1)).val());
			useYnArry.push($('#useYn'+(i+1)).val());
			deviceTypeArry.push($('#deviceType'+(i+1)).val());
			deviceLocArry.push($('#deviceLoc'+(i+1)).val());
			contentArry.push($('#content'+(i+1)).val());
			maxTempArry.push($('#maxTemp'+(i+1)).val());
			minTempArry.push($('#minTemp'+(i+1)).val());
			delayTimeArry.push($('#delayTime'+(i+1)).val());
			tempConfArry.push($('#tempConf'+(i+1)).val());
			pushTermArry.push($('#pushTerm'+(i+1)).val());
			
		});	
		
		
		$('#temonIds').val(temonIdArry);
		$('#temonTypes').val(temonTypeArry);
		$('#portNos').val(porNoArry);
		$('#deviceTypes').val(deviceTypeArry);
		$('#deviceLocs').val(deviceLocArry);
		$('#useYns').val(useYnArry);
		$('#contents').val(contentArry);
		$('#maxTemps').val(maxTempArry);
		$('#minTemps').val(minTempArry);
		$('#delayTimes').val(delayTimeArry);
		$('#tempConfs').val(tempConfArry);
		$('#pushTerms').val(pushTermArry);
		
		$('#strCd2').val($('#strCd').val() );

		if(confirm('${smCommMsgSaveCnf}')){
			
			$.ajax({
				url:'/saveStoreFcltyMgnt',
				type:'POST',
				cache:false,
				data:$('#saveListForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');						
				},
				error:function(result){
					
				}				
			});
		}
	}
}

// 이전 버튼
function fncCancel() {
	if(confirm('이전으로 가시겠습니까?'))
	{	
		var param  = new Object();
		param.mode 			= "BACK";
		param.scrStrNm 		= '${history.scrStrNm}';		
		param.scrOrgCd 		= '${history.scrOrgCd}';		
		fncCallPage('4204', param);
	}
}

</script>

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
			<tr>
				<th>장치 수량</th>
				<td>${smTemon} : 
					<input type='text' id='temon' name='temon' value="${cnt.temon}" style="width:75px;" disabled="disabled"/>							
					${smZigbee} : 
					<input type='text' id='zigbee' name='zigbee' value="${cnt.zigbee}"  style="width:75px;" disabled="disabled"/>				
					${smAlmon} :
					<input type='text' id='almon' name='almon' value="${cnt.almon}"  style="width:75px;" disabled="disabled"/>
				</td>
			</tr>
		</table>		
	</div>
	<!-- //조회조건 -->

	<div class="r_inputTbl r_secondTbl">
				<div class="r_inputTblTitle">
			<h3>${smDevDePortInfoInUpt}</h3>
		</div>
		<div class="r_search multiLine">
			<table>
				<tr style="background-color:transparent !important;">
					<th>${smDevice}</th>
					<td>
						<select id="temonType" name="temonType" style="width:100px;" class="searchSelect" onchange="fncTemonTypeChg(this);">								
						</select>
					</td>
					<th>${smDevice}ID</th>
					<td>
						<select id="temonId" name="temonId" class="searchSelect" style="width:100px;">
							<option value=''>--${smSelect}--</option>			
						</select>
					</td>
				</tr>
			</table>
			<span class="search">
				<button onclick="javascript:fncSearch_List()">Search</button>
			</span>
		</div>
	</div>
	
	<!--  -->
	<div class="r_inputTbl r_secondTbl">
		<form id="saveListForm" name="saveListForm" method="post">
			<input type='hidden' id="strCd2" name='strCd' value=""/>
			<input type='hidden' id='mode' name='mode' value=''/>	
			<input type='hidden' id='temonIds' name='temonIds' value=""/>
			<input type='hidden' id='temonTypes' name='temonTypes' value=""/>
			<input type='hidden' id='portNos' name='portNos' value=""/>
			<input type='hidden' id='deviceTypes' name='deviceTypes' value=""/>
			<input type='hidden' id='deviceLocs' name='deviceLocs' value=""/>
			<input type='hidden' id='useYns' name='useYns' value=""/>
			<input type='hidden' id='contents' name='contents' value=""/>
			<input type='hidden' id='maxTemps' name='maxTemps' value=""/>
			<input type='hidden' id='minTemps' name='minTemps' value=""/>
			<input type='hidden' id='delayTimes' name='delayTimes' value=""/>
			<input type='hidden' id='tempConfs' name='tempConfs' value=""/>
			<input type='hidden' id='pushTerms' name='pushTerms' value=""/>
			<table>
				<caption>Grid Table</caption>
				<col width="5%" />
			    <col width="5%" />
			    <col width="10%" />
			    <col width="20%" />
			    <col width="10%" />
			    <col width="8%" />
			    <col width="8%" />
			    <col width="8%" />
			    <col width="8%" />
			    <col width="8%" />			    
				<thead>
					<tr>
						<th scope="col">${smPortNo}</th>
						<th scope="col">${smUseYn}</th>
						<th scope="col">장비종류</th>
						<th scope="col">용도(식별 가능 설명)</th>
						<th scope="col">비고</th>
						<th scope="col">${smUpperLimit}</th>
						<th scope="col">${smLowerLimit}</th>
						<th scope="col">감지딜레이(분)</th>						
						<th scope="col">푸시주기(분)</th>
						<th scope="col">검침온도</th>
					</tr>
				</thead>
				<tbody id="tbody" style="display:none">
				<c:forEach begin="1" end="16" step="1" var="i">
					<tr id='selPort${i}'>
				    	<td>
				    		${i}
				    		<input type='hidden' id='temonId${i}' name='temonId${i}' style='width: 20px; border : 0px; text-align:center;' readonly='readonly' value=''/>
				    		<input type='hidden' id='temonType${i}' name='temonType${i}' value='' style='width: 20px; border : 0px; text-align:center;' readonly='readonly' />
							<input type='hidden' id='portNo${i}' name='portNo${i}' value='' style='width: 40px; border : 0px; text-align:center;' readonly='readonly' />
							<input type='hidden' id='tempConf${i}' name='tempConf${i}' value='' style='width: 50px;' maxlength='3' class='numberVal'/>
						</td>
						<td>
							<input type='checkbox' id='useYn${i}' name='useYn' onclick='javascript:fncTemonUseYnClick(${i})'/>
						</td>
						<td class='r_gridInput'>
							<select id='deviceType${i}' name='deviceType${i}' class='tblSelect' style='width:100px;'>
								<option value=''>--선택--</option>
								<c:forEach var='vo' items='${selectVoList}' varStatus='status' >
									<option value='${vo.value}'>${vo.name}</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<input type='text' id='deviceLoc${i}' name='deviceLoc${i}' value='' style='width: 140px;' maxlength='10'/>
						</td>
						<td>
							<input type='text' id='content${i}' name='content${i}' value='' style='width: 100px;' maxlength='20' />
						</td>
						<td>
							<input type='number' id='maxTemp${i}' name='maxTemp${i}' value='' style='width: 50px;' maxlength='3' class='numberVal'/>
						</td>
						<td>
							<input type='number' id='minTemp${i}' name='minTemp${i}' value='' style='width: 50px;' maxlength='3' class='numberVal'/>
						</td>
						<td>
							<input type='number' id='delayTime${i}' name='delayTime${i}' value='' style='width: 50px;' maxlength='3' class='number' maxlength='3'/>
						</td>						
						<td>
							<input type='number' id='pushTerm${i}' name='pushTerm${i}' value='' style='width: 50px;' maxlength='3' class='number' maxlength='100'/>
						</td>
						<td>
							<input type='text' id='sensTemp${i}' name='sensTemp${i}' value='' style='width: 50px;' maxlength='5'  maxlength='100' readonly />
						</td>
						
					</tr>
				</c:forEach>
				</tbody>			
			</table>
		</form>
	</div>
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal">
			<button onclick="javascript:fncCancel()">이전</button>
		</span>
		<span class="pageNormal">
			<button onclick="javascript:fncSave()">${smSave}</button>
		</span>		
	</div>	
</div>