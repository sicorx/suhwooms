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
	
	if('${scrValue.ssAuthId}' != '1'){
		 $('#authId').attr('disabled', true); 
	}else{
		$('.r_pageBtnWrapper').css("display","block");
	}
	
	if('${scrValue.scrDateFrom}' == "" ){		
		var DateFrom = func_makeDate(31);
		$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );		
	}else{		
		$('#scrDateFrom').val( 		'${scrValue.scrDateFrom}' );
	}
	
	if('${scrValue.scrDateTo}' == "" ){
		var DateTo = func_toDate();
		$( "#search_dateTo" ).datepicker( "setDate", DateTo );
	}else{
		$('#scrDateTo').val( 		'${scrValue.scrDateTo}' );	
	}
		
	// Grid 출력
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveNotice',
      	datatype: "json",
      	mtype: 'POST',
      	postData : {
	 		title:$("#title").val(),
			noticeTypeCd:$("#noticeTypeCd option:selected").val(),
			authId:$("#authId option:selected").val(), 
			scrDateFrom: $("#search_dateFrom").val(),
			scrDateTo: $("#search_dateTo").val()			 
	  	},
		colNames:['No', '제목', '게시여부', '게시자', '게시일', '게시시작일', '게시종료일', '공지종류', '공지대상', '조회건수', '공지사항ID'],
		colModel:[ 	  		
			{name:'records',		index:'records',		width:15,	align:'center',	sortable:true, editable:false, editoptions:{readonly:true, size:10}},
		    {name:'title',			index:'title',			width:70,	align:'left',	sortable:true, editable:false},
	        {name:'pubYn',			index:'pubYn', 			width:20, 	align:'center', sortable:true, editable:false},
	        {name:'userNm',			index:'userNm', 		width:20, 	align:'center', sortable:true, editable:false},	                  
	        {name:'pubDttm',		index:'pubDttm', 		width:25, 	align:'center', sortable:true, editable:false},
	        {name:'pubStartDt',		index:'pubStartDt', 	width:25, 	align:'center', sortable:true, editable:false},
	        {name:'pubEndDt',		index:'pubEndDt', 		width:25, 	align:'center', sortable:true, editable:false},                
	        {name:'noticeTypeNm',	index:'noticeTypeNm', 	width:20, 	align:'center', sortable:true, editable:false},	                
	        {name:'targetNames',	index:'targetNames', 	width:60, 	align:'left', 	sortable:true, editable:false},
	        {name:'viewCnt',		index:'viewCnt', 		width:15, 	align:'right', 	sortable:true, editable:false},
			{name:'noticeId',		index:'noticeId', 		hidden:true}
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
	    sortname: 'pubEndDt',
	    viewrecords: true,
	    sortorder: "desc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 360,		 
		onClickRow : function(rowid, iRow, iCol, e ) {
			 
		},	
	   	ondblClickRow: function (rowid,iRow,iCol,e) {
			var data = $('#gridStoreMgnt').getRowData(rowid);
			fncNoticePop(data);
		},
		loadComplete : function(data){
			var list = $("#gridStoreMgnt").getRowData();
			var rowCnt = list.length;
			if(rowCnt > 0) {
				$("#gridStoreMgnt").jqGrid('setSelection', 1);
			}else{
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='10'>검색 결과가 없습니다.</td></tr>");
			}
		}		
	 }); 
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
	var DateTo = $( "#search_dateTo" ).val();
	var DateFrom = gfnDateAdd(DateTo, 'M', (value*-1), '-');
	$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );
}

// 신규버튼
function fncAdd(){	
	var param  = new Object();
	param.mode = "NEW";	
	
	menuLoadImgShow("loadingArea");		// show 로딩바
	
	$.ajax({
		type : "POST",
		cache : false,
		url : '/noticeNew',
		data : param,
		success : function(data) {
			$("#r_contents").html(data);
		},
		error:function(result){
			alert('에러가 발생하였습니다.');
		},
		complete : function()
		{
			menuLoadImgHide("loadingArea");		// 로딩바
		}
	});
}

// 수정 버튼
function fncUpt() {	
	var rowKey = getSelectedRow();							// 선택된 리스트 rowKey
	var list = $("#gridStoreMgnt").getRowData(rowKey);		// 선택된 리스트 정보
	
	if(rowKey != '' ) {
		var param  = new Object();
		param.mode			= "MODIFY";					// 수정 모드
		param.noticeId   	= list.noticeId;			// 공지사항ID
		param.title   		= $("#title").val();
		param.noticeTypeCd  = $("#noticeTypeCd option:selected").val();	
		param.authId   		= $("#authId option:selected").val();
		param.pubStartDt   	= $("#search_dateFrom").val();	
		param.pubEndDt   	= $("#search_dateTo").val();	
		
		menuLoadImgShow("loadingArea");		// 로딩바
		
		console.log('ModifyBtn()');
		console.log( param );
		
		$.ajax({
			type : "POST",
			cache : false,
			url : '/noticeNew',
			data : param,
			success : function(data) {
				$("#r_contents").html(data);
			},
			error:function(result){
				alert('에러가 발생하였습니다.');
			},
			complete : function(){
				menuLoadImgHide("loadingArea");		// 로딩바
			}
		});
	}
}


// 선택된 리스트
function getSelectedRow() {
	var grid = $("#gridStoreMgnt");
	var rowKey = grid.jqGrid('getGridParam',"selrow");
	
	if (rowKey){
		return rowKey;
	}
	else{
		alert("선택된 공지사항이 없습니다.");
		return '';
	}
}

// 조회 버튼
function fncSearch() {
	if($("#search_dateFrom").val() > $("#search_dateTo").val()){
		alert("게시기간을 확인해주세요.");
		return false;
	}
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 title:$("#title").val(),
			 noticeTypeCd:$("#noticeTypeCd option:selected").val(),
			 authId:$("#authId option:selected").val(), 
			 scrDateFrom: $("#search_dateFrom").val(),
			 scrDateTo: $("#search_dateTo").val(),	
		 }
	 }).trigger("reloadGrid");
}

//공지사항팝업
function fncNoticePop(data) {
	
	var args = new Object();
	args.noticeId = data.noticeId;

	fn_divPop("retrieveNoticePopup", "공지사항 상세", 800, 520, args );
}

</script>

<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="vendorCd"> 
	<input type="hidden" id="popArg2" name="vendorNm">
	<input type="hidden" id="popArg3" name="userId"> 
</form>
<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type='text' id='title' name='title' value='${scrValue.title}' style="width:220px;" />
				</td>
				<th>공지종류</th>
				<td>
					<select id="noticeTypeCd" name="noticeTypeCd" style="width:130px;" class="tblSelect">
						<option value=''>--전체--</option>
							<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
								<option value='${vo.code}' <c:if test="${scrValue.noticeTypeCd == vo.code}">selected</c:if>>${vo.commCdNm}</option>
							</c:forEach>
					</select>	
				</td>
			</tr>
			<tr>
				<th>게시기간</th>
				<td>
					<input id="search_dateFrom" type="text" placeholder="" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
					~ <input id="search_dateTo" type="text" placeholder="" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
			   		<button onclick="javascript:func_monthBtn(1);">1m</button>
			   		<button onclick="javascript:func_monthBtn(6);">6m</button>
			   		<button onclick="javascript:func_monthBtn(12);">1y</button>
				</td>
				<th>공지대상</th>	
				<td>
					<select id="authId" name="authId" style="width:130px;" class="tblSelect">
						<option value=''>--전체--</option>
							<c:forEach var="vo" items="${authNmList}" varStatus="status" >
								<option value='${vo.authId}'<c:if test="${scrValue.authId == vo.authId}">selected</c:if>>${vo.authNm}</option>
							</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">${smRetrieve}</button>
	    </span>
	</div>
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">			
			<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png"/>
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
		
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none"  style="display:none;">		
	 	<span class="pageNormal">
	    	<button onclick="javascript:fncUpt();">${smUpdate}</button>
	   	</span>	
	   	<span class="pageNormal">
	    	<button onclick="javascript:fncAdd();">${smNew}</button>
	   	</span>
	</div>
	<!-- //하단 버튼 그룹 -->
</div>