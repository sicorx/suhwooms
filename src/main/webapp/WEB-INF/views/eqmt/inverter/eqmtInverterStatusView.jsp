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
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smMainMeter"><spring:message code="mainMeter"/></c:set>
<c:set var="smExcldMeter"><spring:message code="excldMeter"/></c:set>
<c:set var="smSubMeterLight"><spring:message code="subMeterLight"/></c:set>
<c:set var="smSubMeterTemp"><spring:message code="subMeterTemp"/></c:set>
<c:set var="smDimmer"><spring:message code="dimmer"/></c:set>
<c:set var="smHacon"><spring:message code="hacon"/></c:set>
<c:set var="smTSensor"><spring:message code="tSensor"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smSign"><spring:message code="sign"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>
<c:set var="smAlarm"><spring:message code="alarm"/></c:set>
<c:set var="smAll"><spring:message code="all"/></c:set>
<c:set var="smDate"><spring:message code="date"/></c:set>
<c:set var="smTime"><spring:message code="time"/></c:set>
<c:set var="smContents"><spring:message code="contents"/></c:set>
<c:set var="smMeasTemp"><spring:message code="measTemp"/></c:set>
<c:set var="smUpperLimit"><spring:message code="upperLimit"/></c:set>
<c:set var="smLowerLimit"><spring:message code="lowerLimit"/></c:set>
<c:set var="smDevice"><spring:message code="device"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smFailInfo"><spring:message code="failInfo"/></c:set>

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

var rowIdx = 0;

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$("#scrYyyyMmDd").datepicker({
		dateFormat: 'yymmdd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true
	});
	
	$('input:radio[name="scrAlarmYn"]').eq(0).attr('checked', true);	
	
	  $("#gridStoreMgnt").jqGrid({
	      url:'retrieveInverterStatusList',
	      datatype: "json",
	      mtype: 'POST',
	      colNames:['${smSeq}',  '${smDate}', '${smTime}', '${smContents}', '${smMeasTemp}', '${smUpperLimit}', '${smLowerLimit}', '${smFailInfo}', 'strCd', 'yyyyMmDd', 'hhMin', 'hubId', 'portNo', 'strCd', 'highTemp', 'lowTemp', 'inSensor', 'deSensor', 'highPressure', 'lowPressure', 'comp', 'link', 'temp1', 'temp2', 'temp3', 'temp4', 'temp5', 'temp6', 'temp7', 'temp8'],
	      colModel:[
	                {name:'records',index : 'records',width : 50,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	               // {name:'choice',index :'choice',width : 50,align : 'center',formatter :chboxFormatter,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	                {name:'yyyyMmDdView',index:'yyyyMmDdView', width:80, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	                {name:'hhMinView',index:'hhMinView', width:60, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	                {name:'deviceLoc',index:'deviceLoc', width:120, align:'center', sortable:true, editable:false},
	                {name:'sensTemp',index:'sensTemp', width:80, align:'center', sortable:true, editable:false},
	                {name:'maxTemp',index:'maxTemp', width:80, align:'center', sortable:true, editable:false},
	                {name:'minTemp',index:'minTemp', width:80, align:'center', sortable:true, editable:false},
	                {name:'failInfo',index:'failInfo', width:93, align:'center', sortable:true, editable:false},
	                {name:'strCd',index:'strCd', hidden:true},
	                {name:'yyyyMmDd',index:'yyyyMmDd', hidden:true},
	                {name:'hhMin',index:'hhMin', hidden:true},
	                {name:'hubId',index:'hubId', hidden:true},
	                {name:'portNo',index:'portNo', hidden:true},
	                {name:'strCd',index:'strCd', hidden:true},
	                {name:'highTemp',index:'highTemp', hidden:true},
	                {name:'lowTemp',index:'lowTemp', hidden:true},
	                {name:'inSensor',index:'inSensor', hidden:true},
	                {name:'deSensor',index:'deSensor', hidden:true},
	                {name:'highPressure',index:'highPressure', hidden:true},
	                {name:'lowPressure',index:'lowPressure', hidden:true},
	                {name:'comp',index:'comp', hidden:true},
	                {name:'link',index:'link', hidden:true},
	                {name:'temp1',index:'temp1', hidden:true},
	                {name:'temp2',index:'temp2', hidden:true},
	                {name:'temp3',index:'temp3', hidden:true},
	                {name:'temp4',index:'temp4', hidden:true},
	                {name:'temp5',index:'temp5', hidden:true},
	                {name:'temp6',index:'temp6', hidden:true},
	                {name:'temp7',index:'temp7', hidden:true},
	                {name:'temp8',index:'temp8', hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     rowList:[],
	     pager: '#gridStoreMgntPager',
	     sortname: 'hhMin',
	     viewrecords: true,
	     sortorder: "desc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 360,
		 postData : {
			 scrStrCd:$("#scrStrCd").val(),
			 scrPortNo:$("#scrPortNo").val(),
			 scrYyyyMmDd:$("#scrYyyyMmDd").val(),
			 scrAlarmYn:$(':radio[name="scrAlarmYn"]:checked').val()
		 },
		 loadComplete : function(data) {
			 
			var list   = $("#gridStoreMgnt").getRowData();
			var rowCnt = list.length;
			
			for(var i=0;i<rowCnt;i++){
				
				var failInfo = "";
					
				if(list[i].highTemp != 0){						
					failInfo =  failInfo + "[고온] ";
				}
				if(list[i].lowTemp != 0){						
					failInfo =  failInfo + "[저온] ";
				}
				if(list[i].inSensor != 0){						
					failInfo =  failInfo + "[온도센서] ";
				}
				if(list[i].deSensor != 0){
					failInfo =  failInfo + "[제상센서] ";
				}
				if(list[i].highPressure != 0){						
					failInfo =  failInfo + "[고압] ";
				}
				if(list[i].lowPressure != 0){						
					failInfo =  failInfo + "[저압] ";
				}
				if(list[i].comp != 0){						
					failInfo =  failInfo + "[콤프레셔] ";
				}
				if(list[i].link != 0){						
					failInfo =  failInfo + "[통신] ";
				}
				$("#gridStoreMgnt").setCell((i+1),'failInfo',failInfo,'');		
			}	
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {

			var list = $("#gridStoreMgnt").getRowData(rowid);

			onCheckboxDbClick(rowid);

			var strCd = list.strCd;
			var yyyyMmDd = list.yyyyMmDd;
			var hhMin = list.hhMin;
			var hubId = list.hubId;
			var portNo = list.portNo;
			
			var args = new Array();
			args.push(strCd);
			args.push(yyyyMmDd);
			args.push(hhMin);
			args.push(hubId);
			args.push(portNo);
			
			fn_divPop("retrieveInverterStatusDtl", "팝업", 900, 500, args);
			
		 },
		 gridComplete : function(data) {
			 jqGridEven('gridStoreMgnt');
		 }
	 });
});

/*******************
1. 기타 필수 스크립트
********************/

function onCheckboxClick(rowId){	

	rowIdx = rowId; 
	$('input:checkbox[name="choice"]').each(function(i){
		if(this.id == 'choice_'+rowId && !this.checked){
			this.checked = false;
		}else if(this.id == 'choice_'+rowId && this.checked){
			this.checked = true;
		}else{
			this.checked = false;
		}
	});		
}

function onCheckboxDbClick(rowId){	
	
	rowIdx = rowId; 
	$('input:checkbox[name="choice"]').each(function(i){
		if(this.id == 'choice_'+rowId){
			this.checked = true;		
		}else{
			this.checked = false;
		}
	});
}

function chboxFormatter(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

function fncChartPopUp(){
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	if( $("#scrStrCd").val() == "" || $("#scrStrCd").val() == null ){
		
		alert("매장을 선택하세요.");
		return false;
	}
	if( $("#scrYyyyMmDd").val() == "" || $("#scrYyyyMmDd").val() == null ){
		
		alert("일자를 선택하세요.");
		return false;
	}
	
	var args = new Array();
	
	args.push($("#scrStrCd").val());
	args.push($("#scrYyyyMmDd").val());
	args.push('');
	args.push(1);
	args.push($("#scrPortNo").val());
	
	fn_divPop("retrieveInverterTempChart", "팝업", 900, 700, args);
}

/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#scrStrNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;
	
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );	
}

function fncSetStore(data){

	$("#scrViewStrCd").val(data.viewStrCd);
	$("#scrStrNm").val(data.strNm);
	$("#scrStrCd").val(data.strCd);
	
	
	var scrStrCd = $("#scrStrCd").val();
	
	$.ajax({
		url:'/retrieveInverterList',
		type:'POST',
		cache:false,
		data : {scrStrCd:scrStrCd},
		dataType:'json',
		success:function(data){
			
			var optionConts = "";
			optionConts += "<option value=''>--선택--</option>";
			for (var i = 0; i < data.length; i++) {
				
				var value = $.trim(data[i].value);		// 코드
				var name = $.trim(data[i].name);					// 설명
				optionConts += "<option value='" + value + "' \">" + name + "</option>";
				
				$("#scrPortNo").html(optionConts);
			}
		},
		error:function(result){
			alert('error');
		}				
	});
}

function fncStoreClear(){
	$("#scrViewStrCd").val("");
	$("#scrStrNm").val("");
	$("#scrStrCd").val("");
}

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
	
	if( $("#scrStrCd").val() == "" || $("#scrStrCd").val() == null ){
		
		alert("매장을 선택하세요.");
		return false;
	}
	if( $("#scrYyyyMmDd").val() == "" || $("#scrYyyyMmDd").val() == null ){
		
		alert("일자를 선택하세요.");
		return false;
	}
		
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrStrCd:$("#scrStrCd").val(),
			 scrPortNo:$("#scrPortNo").val(),
			 scrYyyyMmDd:$("#scrYyyyMmDd").val(),
			 scrAlarmYn:$(':radio[name="scrAlarmYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
	
}

</script>
<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'>
	<input type="hidden" id="popArg1" name="strCd">
	<input type="hidden" id="popArg2" name="yyyyMmDd">
	<input type="hidden" id="popArg3" name="hhMin">
	<input type="hidden" id="popArg4" name="hubId">
	<input type="hidden" id="popArg5" name="portNo">
	<input type="hidden" id="popArg6" name="companyCd">
</form>
<div id="loadingArea">
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
				<th>${smStr}</th>
				<td>
					<input type='hidden' id='scrStrCd' name='scrStrCd' value='${userVo.strCd}' />
					<input type='text' id='scrViewStrCd' name='scrViewStrCd' value='${userVo.viewStrCd}' style="width:100px;" class="r_Input r_disable" readonly />
					<div class="r_innerSearch">
						<input type='text' id='scrStrNm' name='scrStrNm' value='${userVo.strNm}' style="width:100px;" class="r_Input r_disable" readonly />
						<img src="/images/ico_innerSearch.png" alt="inner search" id="innerSearch"  onclick="javascript:fncStrSearch();" style="cursor:pointer"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
					</div>
				</td>
			</tr>
	    	<tr>
	        	<th width="30">${smDevice}</th>
				<td>
					<select id="scrPortNo" name="scrPortNo" class="searchSelect"  style="width:200px;">
						<option value=''>--선택--</option>
						<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
							<option value='${vo.value}'>${vo.name}</option>
						</c:forEach>
					</select>
	      		</td>
	      		<th>${smDate}</th>
				<td>
					<input type='text' id='scrYyyyMmDd' name='scrYyyyMmDd' value='${userVo.yyyyMmDd}' style="width:90px;" />
				</td>
				<th>${smAlarm}</th>
				<td>
					<span class="r_radio">
						<input type='radio' id="scrAlarmYn1" name='scrAlarmYn' value='Y'/>
						<label for="scrAlarmYn1">${smAlarm}</label>&nbsp;
						<input type='radio' id="scrAlarmYn2" name='scrAlarmYn' value='N' />
						<label for="scrAlarmYn2">${smAll}</label>
					</span>
				</td>
	    	</tr>
	    </table>
	    <span class="search">
	    	<button onclick="javascript:fncSearch()">${smRetrieve}</button>
	    </span>
	</div>    
	<div class="r_grid">
		<table id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>		
	</div>
	<div class="r_pageBtnWrapper">
		<span class="pageNormal">
	   		<button onclick="javascript:fncChartPopUp();">차트</button>
		</span>	
	</div>
</div>