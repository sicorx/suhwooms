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
<c:set var="smStrFcltyAlrmHis"><spring:message code="strFcltyAlrmHis"/></c:set>

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

$(function() {

	$("#scrYyyymmdd").datepicker({
		dateFormat: 'yymmdd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true
	});
	
	
});

$(document).ready(function(){
	
	  $("#gridStoreMgnt").jqGrid({
	      url:'retrieveStoreFcltyAlrmHis',
	      datatype: "json",
	      mtype: 'POST',
	      colNames:['${smSeq}',  '${smDate}', '${smTime}', '${smContents}', '${smMeasTemp}', '${smUpperLimit}', '${smLowerLimit}', '${smAlarm}', 'strCd'],
	      colModel:[
	                {name:'records',index : 'records',width : 50,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	               // {name:'choice',index :'choice',width : 50,align : 'center',formatter :chboxFormatter,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	                {name:'yyyymmddView',index:'yyyymmddView', width:80, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	                {name:'hhminView',index:'hhminView', width:60, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	                {name:'deviceLoc',index:'deviceLoc', width:120, align:'center', sortable:true, editable:false},
	                {name:'sensTemp',index:'sensTemp', width:80, align:'center', sortable:true, editable:false},
	                {name:'maxTemp',index:'maxTemp', width:80, align:'center', sortable:true, editable:false},
	                {name:'minTemp',index:'minTemp', width:80, align:'center', sortable:true, editable:false},
	                {name:'alarmYn',index:'alarmYn', width:80, align:'center', sortable:true, editable:false},
	                {name:'strCd',index:'strCd', hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     rowList:[],
	     pager: '#gridStoreMgntPager',
	     sortname: 'strCd',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 230,
		 postData : {
			 scrStrCd:$("#scrStrCd").val(),
			 scrPortNo:$("#scrPortNo").val(),
			 scrYyyymmdd:$("#scrYyyymmdd").val()
		 },
		 onCellSelect: function(rowid, iCol){
			 
		 },
		 gridComplete : function(data) {			
			 jqGridEven('gridStoreMgnt');	
		 }	 
	 });
	  
	
});


/*
 * 조회
 */
function fncSearch() {
	
	
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrStrCd:$("#scrStrCd").val(),
			 scrPortNo:$("#scrPortNo").val(),
			 scrYyyymmdd:$("#scrYyyymmdd").val()
		 }
	 }).trigger("reloadGrid");
}

function chboxFormatter(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

/*
 * 선택버튼 체크시 
 */
var rowIdx = 0;
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



</script>
<div id="loadingArea">
	<div class="r_popup">
	     <h1 class="r_popupTitle">${smStrFcltyAlrmHis}</h1>	  
		  <div class="r_popupCont">
		    <div class="r_search multiLine">   
		      <table>
		      <tr>
		        <th width="30">${smDevice}</th>
		        <td>
		        <input type='hidden' id='scrStrCd' name='scrStrCd' value='RG0000000' />
		        <select id="scrPortNo" name="scrPortNo" class="searchSelect"  style="width:200px;">
					<option value=''>--${smSelect}--</option>
					<c:forEach var="vo" items="${selectVoList}" varStatus="status">
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
				</select>
		        </td>
		        <th>${smDate}</th>
				<td>
				<input type='text' id='scrYyyymmdd' name='scrYyyymmdd' value='' style="width:90px;" />
				</td>       
		      </tr>
		      </table>
		        <span class="search">
		          <button onclick="javascript:fncSearch()">Search</button>
		        </span>
	    	</div>    
		 <div class="r_grid">
			<table id="gridStoreMgnt"><tr><td></td></tr></table>
			<div id="gridStoreMgntPager"></div>		
		</div>
		
		<div class="r_pageBtnWrapper">
		     <span class="pageNormal">
		     	<button onclick="javascript:fncCancel()">${smClos}</button>
		     </span>
		</div>
		</div>	
	 </div>
</div>