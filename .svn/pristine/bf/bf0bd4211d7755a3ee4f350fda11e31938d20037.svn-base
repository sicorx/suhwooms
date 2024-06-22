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

<style>
#gridStoreMgnt { cursor : pointer; }
.ui-jqgrid .ui-jqgrid-bdiv {
	  position: relative; 
	  margin: 0em; 
	  padding:0; 
	  /*overflow: auto;*/ 
	  overflow-x:hidden; 
	  overflow-y:true; 
	  text-align:left;
}
</style>


<script type="text/javascript">

$(function() {
	// 달력
	$("#search_dateFrom, #search_dateTo").datepicker();
});


$(document).ready(function(){		
	init();			// 초기 셋팅 	
});

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();

function init(){
	
	if('${scrValue.scrDateFrom}' == "" ){		
		var DateFrom = func_makeDate(31);
		$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );		
	}else{		
		$('#scrDateFrom').val('${scrValue.scrDateFrom}');
	}
	
	if('${scrValue.scrDateTo}' == "" ){
		var DateTo = func_toDate();
		$( "#search_dateTo" ).datepicker( "setDate", DateTo );
	}else{
		$('#scrDateTo').val('${scrValue.scrDateTo}');	
	}	
	
		
	// Grid 출력
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveStoreLog',
	    datatype: "json",
	    mtype: 'POST',
	    postData : {
	    	scrStrNm:$("#scrStrNm").val(),
			scrDateFrom: $("#search_dateFrom").val(),
			scrDateTo: $("#search_dateTo").val(), 		 
		  },
	      colNames:['No', '장비벤더', '사용자ID', '사용자명', '매장코드', '매장명', '테스트일자', '테스트내용', 'GW수량', '테몬수량', '온도줄센서수량', '하콘수량', '티센서수량', '미터수량', 'CT수량'],
	      colModel:[ 	  		
	    	  		{name:'records', 			index:'records', 			width:15, align:'center', 	sortable:true, editable:false, editoptions:{readonly:true, size:10}},
	    	  		{name:'remsDeivceVendor', 	index:'remsDeivceVendor', 	width:50, align:'center',	editable:false},
	                {name:'userId', 			index:'userId', 			width:30, align:'center', 	editable:false},
	                {name:'userNm', 			index:'userNm', 			width:40, align:'left', 	editable:false},
	                {name:'strCd',				index:'strCd',				width:60, align:'center', 	editable:false},	                  
	                {name:'strNm',				index:'strNm', 	 			width:50, align:'left',		editable:false},
	                {name:'testDt',				index:'testDt',				width:60, align:'center',	editable:false},
	                {name:'contents', 			index:'contents', 			width:60, align:'left',		editable:false},
	                {name:'cntGw', 				index:'cntGw', 				width:30, align:'center',	editable:false},
	                {name:'cntTemon', 			index:'cntTemon', 			width:30, align:'center',	editable:false},
	                {name:'cntLine', 			index:'cntLine', 			width:30, align:'center',	editable:false},
	                {name:'cntHacon', 			index:'cntHacon', 			width:30, align:'center',	editable:false},
	                {name:'cntTsensor', 		index:'cntTsensor', 		width:30, align:'center',	editable:false},
	                {name:'cntMeter', 			index:'cntMeter', 			width:30, align:'center',	editable:false},
	                {name:'cntCt', 				index:'cntCt', 				width:30, align:'center',	editable:false},
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridStoreMgntPager',
	     recordtext: "건/페이지  (전체 {2} 건)",
	     emptyrecords : "검색 결과가 존재하지 않습니다.",
	     loadtext: "Loading...",
	     sortname: 'testDt',
	     viewrecords: true,
	     sortorder: "desc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 360,		 
		 onClickRow : function(rowid, iRow, iCol, e ) {
			 
		 },	
	   	ondblClickRow: function (rowid,iRow,iCol,e) {

		},
		gridComplete : function(){
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
		
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='15'>검색 결과가 없습니다.</td></tr>");
			}	
		}
	 });
	  //jqGrid Resize	
	  jqGridResize('gridStoreMgnt');	 
}

// 조회 버튼
function fncSearch() {

	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		postData : {
	    	scrStrNm:$("#scrStrNm").val(),
			scrDateFrom: $("#search_dateFrom").val(),
			scrDateTo: $("#search_dateTo").val(), 
		 }
	 }).trigger("reloadGrid");
}


// 현재 시간
function func_toDate() {
    var YYYY, MM, DD;	    
    var d = new Date();	
    
    YYYY = d.getFullYear();	    
    
    //한자릿수 월 앞에 0을 붙이기 위한 if문
    if(d.getMonth() < 9)	        
    	MM = '0'+(d.getMonth()+1);
    else
    	MM = d.getMonth()+1;	    
 
    if(d.getDate() < 9)
        DD = '0'+(d.getDate());
    else
        DD = d.getDate();	    
    
    return YYYY+"-"+ MM +"-"+ DD;
}

// 하루전, 한달전, 계산 
function func_makeDate(day){		 
    var YYYY, MM, DD;
    var date = new Date();
    var d = new Date(Date.parse(date)-86400000*day);	
    
    YYYY = d.getFullYear();	    
    
    //한자릿수 월 앞에 0을 붙이기 위한 if문
    if(d.getMonth() < 9)	        
    	MM = '0'+(d.getMonth()+1);
    else
    	MM = d.getMonth()+1;	    
 
    if(d.getDate() < 9)
        DD = '0'+(d.getDate());
    else
        DD = d.getDate();	    
    
    return YYYY+"-"+ MM +"-"+ DD;
}

function func_monthBtn(value){
	
	var DateFrom = func_makeDate(31*value);
	var DateTo = func_toDate();
	
	$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );
	$( "#search_dateTo" ).datepicker( "setDate", DateTo );
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	var scrStrNm = $("#scrStrNm").val();
	var scrDateFrom = $("#search_dateFrom").val();
	var scrDateTo = $("#search_dateTo").val();
	
	$("#excel1").val(scrStrNm);
	$("#excel2").val(scrDateFrom);
	$("#excel3").val(scrDateTo);
	
	$('#excelDownload').attr("action", "/downloadEqmtStoreLogExcel");
	$("#excelDownload").submit();

}
</script>


<div id="loadingArea">
<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrStrNm"> 
	<input type="hidden" id="excel2" name="scrDateFrom"> 
	<input type="hidden" id="excel3" name="scrDateTo"> 
</form>

	<div class="r_search multiLine">
		<table>
			<tr>
				<th>매장명/코드</th>
				<td>
					<input type='search' id='scrStrNm' name='scrStrNm' value='' placeholder="전체"  style="width:118px;" />
				</td>	
				<th>테스트일자<span class="r_required">*</span></th>
				<td>
					<input id="search_dateFrom" type="text" placeholder="" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
					~ <input id="search_dateTo" type="text" placeholder="" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
			   		<button onclick="javascript:func_monthBtn(1);">1m</button>
			   		<button onclick="javascript:func_monthBtn(6);">6m</button>
			   		<button onclick="javascript:func_monthBtn(12);">1y</button>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	
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
		<table id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
		
</div>