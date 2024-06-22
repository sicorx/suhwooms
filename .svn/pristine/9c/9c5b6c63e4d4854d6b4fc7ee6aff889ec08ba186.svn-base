<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
/*******************
1. 기타 필수 전역 변수
********************/

var rowIdx = 0;
var gvPopParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$("#gridUserList").jqGrid({
		url:'searchVendorEngineerList',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['번호', '사용자ID', '사용자명', '지정업체코드', '지정업체'],
	    colModel:[
	              {name:'records',index : 'records',width : 25,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	              {name:'userId',index:'userId', width:60, align:'center', sortable:true, editable:false},
	              {name:'userNm',index:'userNm', width:50, align:'center', sortable:true, editable:false},
	              {name:'vendorCd',index:'vendorCd', width:100, align:'left', sortable:true, editable:false, hidden:true},
	              {name:'vendorNm',index:'vendorNm', width:85, align:'center', sortable:true, editable:false, hidden:true}
        ],
		jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[],
	    pager: '#gridUserListPager',
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		//width:'100%', 
		height : 330,
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrUserNm:$("#scrUserNm").val()
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {
				
			var list = $("#gridUserList").getRowData(rowid);
			var userId = list.userId;
			
			$("#selectedEngineerId").val(userId);
			$("#selectedEngineerNm").val(list.userNm);
			
			$("#gridMapedStr").setGridParam({
				postData : {
					scrUserId:userId
				}
			}).trigger("reloadGrid");
		}
	});
	//jqGrid Resize	
	jqGridResize('gridUserList');	
	  
	$("#gridMapedStr").jqGrid({
		url:'searchEngineerStrList',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['번호', '선택', '점포명', '점포코드', '주소', '사용자아이디'],
	    colModel:[
	    		  {name:'records',index : 'records',width : 30,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	              {name:'choice1',index :'choice1',width : 30,align : 'center',formatter :chboxFormatter1,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	              {name:'strNm',index:'strNm', width:50, align:'center', sortable:true, editable:false},
	              {name:'strCd',index:'strCd', width:80, align:'center', sortable:true, editable:false, hidden:true},
	              {name:'addr',index:'addr', width:85, align:'center', sortable:true, editable:false},
	              {name:'userId',index:'userId', width:85, align:'center', sortable:true, editable:false, hidden:true}
		],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[],
	    pager: '#gridMapedStrPager',
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		//width:'100%', 
		height : 380,
	});
	//jqGrid Resize	
	jqGridResize('gridMapedStr');	 
	  
	$("#gridVendorStrList").jqGrid({
		url:'searchMapedStrList',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['번호', '선택', '점포명', '점포코드', '주소'],
	    colModel:[
	              {name:'records',index : 'records',width : 50,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	              {name:'choice2',index :'choice2',width : 50,align : 'center',formatter :chboxFormatter2,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	              {name:'strNm',index:'strNm', width:85, align:'center', sortable:true, editable:false},
	              {name:'strCd',index:'strCd', width:85, align:'center', sortable:true, editable:false, hidden:true},
	              {name:'addr',index:'addr', width:85, align:'left', sortable:true, editable:false},
        ],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[],
	    pager: '#gridVendorStrListPager',
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		//width:'100%', 
		height : 330,
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			scrMapYn: $('input:radio[name="scrMapYn"]:checked').val()
		}
	});
	//jqGrid Resize	
	jqGridResize('gridVendorStrList');	
	 
});

/*******************
1. 기타 필수 스크립트
********************/

function chboxFormatter(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

function chboxFormatter1(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice1" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

function chboxFormatter2(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice2" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

function onCheckboxClick(rowId){	
	
	var list   = $("#gridUserList").getRowData();	
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

function fncSearchgridMapedStr(){
	
	$("#gridMapedStr").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridMapedStr").setGridParam({
		url:'searchEngineerStrList',
		 postData : {
			 scrUserId:$("#selectedEngineerId").val()
		 }
	 }).trigger("reloadGrid");
}

function fncSearch1ndTblCondition(){
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	$("#gridUserList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserList").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrVendorCd:$("#scrVendorCd").val(),
			 scrUserNm: $('#scrUserNm').val()
		 }
	 }).trigger("reloadGrid");
	
}

// ajax 통신 초기화
function fn_initAjax() {
	$.ajaxSetup({
		cache:false,
		contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
		timeout: 50000,
		dataType: "json",
		async: false,
		type: "POST"
	});
}
//ajax 에러 메세지
function showAjaxErrFnc(xhr, status, e, fncNm){
	var msg = "";
	if (xhr.status == "0") {
		msg = "서버에 접근할 수 없습니다. 네트워크 상태를 확인하시기 바랍니다.";
	}else if(xhr.status == "400"){
		msg = "잘못된 요청입니다.";
	}	else if(xhr.status == "403"){
		msg = "요청하신 페이지의 사용권한이 없습니다.";
	}else if(xhr.status == "404"){
		msg = "요청하신 페이지를 찾을 수 없습니다.";
	}else if(xhr.status == "500"){
		//내부서버 오류
		msg = "해당 서비스 접속이 원활하지 않습니다.";
	}else if(xhr.status == "501"){
		msg = "해당 요청에 대한 페이지나 서비스가 존재 하지 않습니다.";
	}else if(xhr.status == "503"){
		msg = "서버 과부하 또는 사용자 폭주로 인해 접속이 원활하지 않습니다.";
	}else{
		msg = "알수 없는 오류가 발생했습니다. \nSTATUS CODE : " + xhr.status +  "\nstatus : " + status + "\nERROR :" + e ;
	}
	alert("ERROR FUNCTION : "+fncNm + "\n" + msg);
}

function fncMapping(){
	var list   = $("#gridVendorStrList").getRowData();
	var chkCnt = 0;
	var choiceCnt = 0;
	var strCd = new Array();
	$('input:checkbox[name="choice2"]').each(function(){
		
		if(this.checked){
			strCd[chkCnt] = list[choiceCnt].strCd;
			chkCnt++;
		}
		choiceCnt++;
	});
	
	if(chkCnt > 0){
				
		//var companyCd = list[rowIdx-1].companyCd;	
		
		if(confirm("선택된 매장을 엔지니어("+$("#selectedEngineerNm").val()+")에게 지정하시겠습니까?")){
			$.ajax({
				url:'/strMappingEngineer',
				type:'POST',
				cache:false,
				data : {strCd:strCd, userId:$("#selectedEngineerId").val()},
				dataType:'text',
				success:function(data){
					if(data == "SUCCESS"){
						alert("매장 지정 작업을 완료하였습니다.");	
					}else{
						alert("매장 지정중 오류가 발생했습니다. 엔지니어지정 매장 리스트를 확인하시기 바랍니다.");
					}
					fncSearchgridMapedStr();
				},
				error:function(xhr, status, e) {
					showAjaxErrFnc(xhr, status, e, "fncMapping");
				}				
			});
		}
		
	}else{
		alert("엔지니어에게 지정할 매장을 선택하세요");		
	}
}

function fncUnMapping(){
	var list   = $("#gridMapedStr").getRowData();
	var chkCnt = 0;
	var choiceCnt = 0;
	var strCd = new Array();
	var vendorCd = new Array();
	$('input:checkbox[name="choice1"]').each(function(){
		
		if(this.checked){
			strCd[chkCnt] = list[choiceCnt].strCd;
			chkCnt++;
		}
		choiceCnt++;
	});
	
	if(chkCnt > 0){
				
		//var companyCd = list[rowIdx-1].companyCd;	
		
		if(confirm("선택된 매장을 엔지니어("+$("#selectedEngineerNm").val()+")에게서 지정 해제 하시겠습니까?")){
			$.ajax({
				url:'/strUnMappingEngineer',
				type:'POST',
				cache:false,
				data : {strCd:strCd, userId:$("#selectedEngineerId").val()},
				dataType:'text',
				success:function(data){
					if(data == "SUCCESS"){
						alert("매장 지정 해제 작업을 완료하였습니다.");	
					}else{
						alert("매장 지정 해제중 오류가 발생했습니다. 엔지니어지정 매장 리스트를 확인하시기 바랍니다.");
					}
					fncSearchgridMapedStr();
				},
				error:function(xhr, status, e) {
					showAjaxErrFnc(xhr, status, e, "fncUnMapping");
				}				
			});
		}
		
	}else{
		alert("${smCommMsgSel}");		
	}
}

function fncSearchVendorStrList(){
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	if( $("#scrOrgNm").val() == "" || $("#scrOrgNm").val() == null ) {
		$("#scrOrgCd").val('');
	}
	
	if($("#scrVendorCd").val() == ""){
		alert("유지보수 업체를 선택해주세요.");
		return;
	}
	
	
	$("#gridVendorStrList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridVendorStrList").setGridParam({
		 postData : {
			 scrVendorCd:$("#scrVendorCd").val()
		 }
	 }).trigger("reloadGrid");
}


/*******************
1. 팝업 
********************/

function fncOrgSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
	
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd);
	$("#scrOrgNm").val(data.orgNm);
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var vendorCd  = $("#scrVendorCd").val();
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	if( vendorCd == '' || vendorCd == null ) {
		alert("업체를 선택하세요");
		return false;
	}
	
	$("#gridUserList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserList").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrVendorCd:$("#scrVendorCd").val()
		 }
	 }).trigger("reloadGrid");
	
	// 달력
	$( "#search_dateFrom, #search_dateTo" ).datepicker({  
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true,		
		// 달력 아이콘  
	    showOn: "button",  
	    buttonImage: "/images/btn_calendar_new.png",  
	    buttonImageOnly: true,  
	    // 달력 하단의 종료와 오늘 버튼 Show  
	    showButtonPanel: true,  
	    // date 포멧  
	    showAnim : "",  
	    // 다른 달의 일 보이기, 클릭 가능  
	    numberOfMonths: 1,  
	    showButtonPanel: true,		    
	});
	
	if('${scrValue.scrDateFrom}' == "" )
	{		
		// Default Date Setting
		var DateFrom = func_makeDate(31);
		$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );		
	}
	else
	{		
		$('#scrDateFrom').val( 		'${scrValue.scrDateFrom}' );
	}
	
	if('${scrValue.scrDateTo}' == "" )
	{
		var DateTo = func_toDate();
		$( "#search_dateTo" ).datepicker( "setDate", DateTo );
	}
	else
	{
		$('#scrDateTo').val( 		'${scrValue.scrDateTo}' );	
	}
}
</script>
<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
</form>
<div id="loadingArea">
	   
	<div class="r_halfGridContainer" style="height:500px; display:table !important; width:100% !important;">
	
		<!-- 좌측영역 -->
		<div class="left_grid_two">
		
			<!-- 조회조건 -->
			<div class="r_grid r_inputTblTitle">
				<h3>엔지니어선택</h3>
			</div>
			<div class="r_search multiLine">
				<table>
					<tr>
						<th>업체</th>	
						<td>
							<select id="" name="" class="searchSelect" style="width:100px;">
								<option selected="selected">전체</option>
								<option></option>
							</select>
						</td>
						<th>ID/사용자</th>	
						<td>
							<input type='search' id='scrUserNm' name='scrUserNm' value='' style="width:100px;" />
						</td>
					</tr>
				</table>
				<span class="search">
			        <button onclick="javascript:fncSearch()">Search</button>
			    </span>
			</div>
			<!-- //조회조건 -->
			
			<!-- 좌그리드 -->
			<div class=r_oneThirdGrid_l2 style="padding-top:14px; height:380px;">		
				<div class="r_grid">
					<div class="r_gridTitle">
						<h3>엔지니어목록</h3>
					</div>
					<table id="gridUserList"><tr><td></td></tr></table>
					<div id="gridUserListPager"></div>
				</div>
			</div>
			<!-- //좌그리드 -->
			
			<!-- 우그리드 -->
			<div class=r_twoThirdGrid_l2 style="padding-top:14px; height:380px;">
				<div class="r_grid">
					<div class="r_gridTitle">
						<h3>할당된 매장목록</h3>
					</div>
					<table id="gridMapedStr"><tr><td></td></tr></table>
					<div id="gridMapedStrPager"></div>
				</div>
			</div>
			<!-- //우그리드 -->
			
			<!-- 하단 버튼 그룹 -->
			<div class="r_pageBtnWrapper border_none m_0">
			 	<span class="pageNormal">
			    	<button onclick="javascript:fncSave();">${smSave}</button>
			   	</span>	
			</div>
			<!-- //하단 버튼 그룹 -->
		
		</div>
		<!-- //좌측영역 -->
		
		<!-- 셔틀영역 -->
		<div class="shuttle">
			<ul>
				<li><a href="#"><img src="images/btn_shuttle_right_all.png" alt="전체추가" /></a></li>
				<li><a href="#"><img src="images/btn_shuttle_right.png" alt="선택추가" /></a></li>
				<li><a href="#"><img src="images/btn_shuttle_left.png" alt="선택삭제" /></a></li>
				<li><a href="#"><img src="images/btn_shuttle_left_all.png" alt="전체삭제" /></a></li>
			</ul>
		</div>
		<!-- //셔틀영역 -->
		
		<!-- 우측영역 -->
		<div class="right_grid_one">
		
			<!-- 조회조건 타이틀 -->
			<div class="r_grid r_inputTblTitle">
				<h3>할당매장선택</h3>
			</div>
			<!-- //조회조건 타이틀 -->
			
			<!-- 조회조건 -->
			<div class="r_search multiLine">
				<table>
					<col width="10%" />
					<col width="90%" />
					<tr>
						<td>매장명</td>
						<td>
							<input type='text' id='' name='' value='' style="width:80px; margin-right:12px;" />
							<input id="a" name="" type="checkbox" value="" checked="true" /><label for="a">전체</label>
							<input id="b" name="" type="checkbox" value="" checked="true" /><label for="b">할당</label>
							<input id="c" name="" type="checkbox" value="" checked="true" /><label for="c">미할당</label>
						</td>
					</tr>
					<tr>
						<td>설치일자</td>
						<td>
							<input id="search_dateFrom" type="text" placeholder="2017-01-11" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
							~ <input id="search_dateTo" type="text" placeholder="2017-01-11" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
							<!-- <button onclick="javascript:func_AllBtn();" class="ml_5">전체</button> -->
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
			<!-- //조회조건 -->
			
			<!-- 그리드 -->
			<div class="r_grid mt_20">
				<table id="gridVendorStrList"><tr><td></td></tr></table>
				<div id="gridVendorStrListPager"></div>
			</div>
			<!-- //그리드 -->
			
		</div>
		<!-- //우측영역 -->

	</div>
	
</div>