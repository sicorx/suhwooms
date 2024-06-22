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
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>

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
	// 달력
	$("#scrDateFrom, #scrDateTo").datepicker();
});

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();


$(document).ready(function(){	
	
	// Default Date Setting	
	var toDayDate = gfnTodayDate("-");
	var DateFrom = gfnDateAdd(toDayDate, 'M', -12, '-');	
	var resultYn = ${userVo.resultYn }+'';
	if(resultYn == 1){
		$("#scrAsResultN").prop('checked',true);
	}else if (resultYn == 2){
		$("#scrAsResultY").prop('checked',true);
	}
	
	$( "#scrDateFrom" ).datepicker( "setDate",  DateFrom );
	$( "#scrDateTo" ).datepicker( 	"setDate",  toDayDate );
	
	var scrCloseStore = "";
	if(!$("input:checkbox[id='chkCloseStore']").is(":checked")){
		scrCloseStore = "1";
	}
	
	var param = new Object();
	param.scrCompanyCd = 	$("#scrCompanyCd").val();
	param.scrDateFrom = 	$("#scrDateFrom").val();
	param.scrDateTo = 		$("#scrDateTo").val();
	param.scrEqmt = 		$("#scrEqmt").val();
	param.scrEqmtType = 	$("#scrEqmtType").val();
	param.scrAsVendorNm = 	$("#scrAsVendorNm").val();
	param.scrAsEngineer = 	$("#scrAsEngineer").val();
	param.scrAsResult = 	$(':radio[name="scrAsResult"]:checked').val();
	param.scrCloseStore = 	scrCloseStore;
	
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveEqmtAlarmStatus',
    	datatype: "json",
    	postData : param,
    	mtype: 'POST',
    	colNames:['No', '장비명', '매장명', '알람시작시간', '최종알람시간', '장비유형', '상태', '장애내용','업체명','A/S기사','조치일시','조치방법','조치내용','최근알림','strCd','temonId','temonType','portNo','yyyymmdd','hhmin'],
    	colModel:[
              {name:'records',		index:'records',		width:5,	align:'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10},  key: true},	                
              {name:'deviceLoc',	index:'deviceLoc', 		width:15, 	align:'left', 	sortable:true, editable:false},	                
              {name:'strNm',		index:'strNm', 			width:20, 	align:'left', 	sortable:true, editable:false},
              {name:'alarmDateS',	index:'alarmDateS', 	width:25,	align:'center', sortable:true, editable:false},
              {name:'alarmDateE',	index:'alarmDateE', 	width:25, 	align:'center', sortable:true, editable:false},
              {name:'temonTypeNm',	index:'temonTypeNm',	width:15, 	align:'center', sortable:true, editable:false},
              {name:'asResult',		index:'asResult', 		width:10, 	align:'center', sortable:true, editable:false},
              {name:'alarmMessage',	index:'alarmMessage',	width:40, 	align:'center', sortable:true, editable:false},
              {name:'asVendorNm',	index:'asVendorNm', 	width:15, 	align:'center', sortable:true, editable:false},
              {name:'asEngineer',	index:'asEngineer', 	width:15, 	align:'center', sortable:true, editable:false},
              {name:'asDate',		index:'asDate', 		width:25, 	align:'center', sortable:true, editable:false},
              {name:'asContents',	index:'asContents', 	width:15, 	align:'center',	sortable:true, editable:false},
              {name:'asNote',		index:'asNote', 		width:40, 	align:'left', sortable:true, editable:false},
              {name:'alarmCnt',		index:'alarmCnt', 		width:15, 	align:'center', sortable:true, editable:false},	                
              {name:'strCd',		index:'strCd', 			hidden:true},
              {name:'temonId',		index:'temonId', 		hidden:true},
              {name:'temonType',	index:'temonType', 		hidden:true},
              {name:'portNo',		index:'portNo', 		hidden:true},
              {name:'yyyymmdd',		index:'yyyymmdd', 		hidden:true},
              {name:'hhmin',		index:'hhmin', 			hidden:true}
         ],
		jsonReader : {
			repeatitems:false
		},
   		rowNum:20,
   		rowList:[10,20,50,100],
   		pager: '#gridStoreMgntPager',
   		recordtext: "{1} 건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
   		sortname: 'CONCAT(yyyymmdd,hhmin)',
   		viewrecords: true,
   		sortorder: "desc",	     
   		hidegrid: false,
   		shrinkToFit:true,
		autowidth:true,
		height : 450,
		onSelectRow : function(rowid, iRow, iCol, e) {
		},
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='14'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		
	});	 	
	jqGridResize('gridStoreMgnt');
});



// 달력 기간 버튼
function fncMonthBtn(val)
{
	var DateTo = $( "#scrDateTo" ).val();
	var DateFrom = gfnDateAdd(DateTo, 'M', (val*-1), '-');
	$( "#scrDateFrom" ).datepicker( "setDate",  DateFrom );
}

// 조회 버튼
function fncSearch() 
{
	if($("#scrDateFrom").val() > $("#scrDateTo").val()){
		alert("기간을 확인해주세요.");
		return false;
	}
	
	var scrCloseStore = "";
	if(!$("input:checkbox[id='chkCloseStore']").is(":checked")){
		scrCloseStore = "1";
	}
	
	var param = new Object();
	param.scrCompanyCd 		= $("#scrCompanyCd").val();
	param.scrDateFrom 		= $("#scrDateFrom").val();
	param.scrDateTo 		= $("#scrDateTo").val();
	param.scrEqmt 			= $("#scrEqmt").val();
	param.scrEqmtType 		= $("#scrEqmtType").val();
	param.scrAsVendorNm 	= $("#scrAsVendorNm").val();
	param.scrAsEngineer 	= $("#scrAsEngineer").val();
	param.scrAsResult 		= $(':radio[name="scrAsResult"]:checked').val();
	param.scrCloseStore		= scrCloseStore;
	
	if( param.scrCompanyCd == '' || param.scrCompanyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({		
		postData : param		
	}).trigger("reloadGrid");
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
}

// 조치내용 버튼
function fncConfirm()
{
	var rowKey = getSelectedRow();							// 선택된 리스트 rowKey
	var list = $("#gridStoreMgnt").getRowData(rowKey);		// 선택된 리스트 정보
	
	if( rowKey != '' )							
	{	
		var userNm = $('#userNm').val();
		var popupTitle = "";
		
		var param  = new Object();
		param.strCd			= list.strCd;
		param.temonId		= list.temonId;
		param.temonType		= list.temonType;
		param.portNo		= list.portNo;
		param.yyyymmdd		= list.yyyymmdd;
		param.hhmin			= list.hhmin;
		param.asEngineer	= list.asEngineer;
		param.userNm		= userNm;
		
		if( userNm == list.asEngineer )
		{
			popupTitle = "조치내용 수정";
			param.mode = "MODIFY";
		}
		else
		{
			if( list.asEngineer == "" )
			{
				popupTitle = "조치내용 입력";
				param.mode = "INPUT";
			}
			else
			{
				popupTitle = "조치내용 조회";
				param.mode = "SEARCH";
			}
		}		
		
		fn_divPop("eqmtMessagePop", popupTitle, 650, 550, param);	// 조치내역 입력 팝업
		
		
		
	}
}

//선택된 리스트
function getSelectedRow() 
{
	var grid = $("#gridStoreMgnt");
	var rowKey = grid.jqGrid('getGridParam',"selrow");
	
	if (rowKey)
	{		
		return rowKey;
	}
	else
	{
		alert("선택된 매장이 없습니다.");
		return '';
	}
}

//선택된 리스트
function getSelectedPage() 
{
	var grid = $("#gridStoreMgnt");
	var page = $("#gridStoreMgnt").getGridParam('page'); 
	
	if (page)
	{
		console.log( 'page : ' + page );
		return page;
	}
	else
	{
		alert("선택된 매장이 없습니다.");
		return '';
	}
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrDateFrom = $("#scrDateFrom").val();
	var scrDateTo = $("#scrDateTo").val();
	var scrEqmt = $("#scrEqmt").val();
	var scrEqmtType = $("scrEqmtType").val();
	var scrAsVendorNm = $("#scrAsVendorNm").val();
	var scrAsEngineer = $("#scrAsEngineer").val();
	var scrAsResult = $(':radio[name="scrAsResult"]:checked').val();
	var scrCloseStore = "";
	if(!$("input:checkbox[id='chkCloseStore']").is(":checked")){
		scrCloseStore = "1";
	}
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrDateFrom);
	$("#excel3").val(scrDateTo);
	$("#excel4").val(scrEqmt);
	$("#excel5").val(scrEqmtType);
	$("#excel6").val(scrAsVendorNm);
	$("#excel7").val(scrAsEngineer);
	$("#excel8").val(scrAsResult);
	$("#excel9").val(scrCloseStore);
	
	$('#excelDownload').attr("action", "/downloadeqmtMessageExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">
<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrCompanyCd"> 
	<input type="hidden" id="excel2" name="scrDateFrom"> 
	<input type="hidden" id="excel3" name="scrDateTo"> 
	<input type="hidden" id="excel4" name="scrEqmt">
	<input type="hidden" id="excel5" name="scrEqmtType">
	<input type="hidden" id="excel6" name="scrAsVendorNm">
	<input type="hidden" id="excel7" name="scrAsEngineer">
	<input type="hidden" id="excel8" name="scrAsResult">
	<input type="hidden" id="excel9" name="scrCloseStore">
</form>
	<!-- 조회조건 -->
	<div class="r_search multiLine">		
			<input type='hidden' id='userNm' name='userNm' value='${userVo.userNm}' />
			<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />			
			<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;display:none;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
		<table>
			<tr>
				<th>기간</th>
				<td>
					<input id="scrDateFrom" type="text" placeholder="2017-01-11" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
					~ <input id="scrDateTo" type="text" placeholder="2017-01-11" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
					<!-- <button onclick="javascript:func_AllBtn();" class="ml_5">전체</button> -->
			   		<button onclick="javascript:fncMonthBtn(1);">1m</button>
			   		<button onclick="javascript:fncMonthBtn(6);">6m</button>
			   		<button onclick="javascript:fncMonthBtn(12);">1y</button>
				</td>
				<th>장비선택</th>
				<td>
					<select id="scrEqmt" name="" class="searchSelect" style="width:118px;">
						<option selected="selected" value="">전체</option>
						<c:forEach var="vo" items="${selectVoEqmtList}" varStatus="status" >
							<option value='${vo.value}'>${vo.name}</option>
						</c:forEach>
					</select>
				</td>
				<th>장비유형</th>
				<td>
					<select id="scrEqmtType" name="scrEqmtType" class="searchSelect" style="width:118px;">
						<option selected="selected" value="">전체</option>
						<c:forEach var="vo" items="${selectVoEqmtTypeList}" varStatus="status" >
							<option value='${vo.value}'>${vo.name}</option>
						</c:forEach>
					</select>
				</td>
				<th>
					<input id="chkCloseStore" type="checkbox" />&nbsp;폐점포함
				</th>
			</tr>
			<tr>
				<th>업체</th>
				<td>
					<select id="scrAsVendorNm" name="scrAsVendorNm" class="searchSelect" style="width:108px;">
						<option selected="selected" value="">전체</option>
						<c:forEach var="vo" items="${selectVoVendorList}" varStatus="status" >
							<option value='${vo.name}'>${vo.name}</option>
						</c:forEach>						
						<option></option>
					</select>
				</td>
				<th>A/S기사</th>
				<td>
					<input type='text' id='scrAsEngineer' name='scrAsEngineer' value=""  placeholder="전체" style="width:118px;"/>
				</td>
				<th>조치여부</th>
				<td>
					<span class="r_radio">
						<input id="scrAsResultAll"  name="scrAsResult" type="radio" value=""  checked="true"/>	<label for="scrAsResultAll">전체</label>   
						<input id="scrAsResultY" 	name="scrAsResult" type="radio" value="Y" />				<label for="scrAsResultY">처리</label>
						<input id="scrAsResultN" 	name="scrAsResult" type="radio" value="N"/>					<label for="scrAsResultN">미처리</label>
					</span>					
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">
			<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
			
			<!-- 엑셀 download -->
			 <div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();"/>
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
	<!-- 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">		
		<span class="pageNormal detail">
			<button onclick="javascript:fncConfirm()">조치내용</button>
		</span>
	</div>
	<!-- //버튼 그룹 -->

</div>