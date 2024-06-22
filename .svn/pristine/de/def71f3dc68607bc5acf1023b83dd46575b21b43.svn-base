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
<style>
.chk1 {
	background: #92D050;
}

.chk2 {
	background: #FFC000;
}
</style>
<script type="text/javascript">
/*******************
1. 기타 필수 전역 변수
********************/
var rowIdx = 0;

$(function() {
	$("#scrDateFrom, #scrDateTo").datepicker();
});

$(window).resize(function(){


    $("#gridUserList").setGridWidth($("#cont1").width());
    $("#gridMapedStr").setGridWidth($("#cont2").width());
    $("#gridStoreMgntList").setGridWidth($("#cont3").width());
    
    
}).resize();


/*******************
1. 선행, 등록 스크립트
********************/
$(document).ready(function(){

	

	// 셀렉트 선택	
	var ssVenderCd = $.trim("${userVo.vendorCd}");
	$("#scrVendorCd").val(ssVenderCd);	
	if (ssVenderCd != "") $("#scrVendorCd").attr("disabled", "disabled");
	
	
	
	
	
	// 엔지니어 목록
	$("#gridUserList").jqGrid({
		url:'searchVendorEngineerList',
	    datatype: "json",
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrUserNm:$("#scrUserNm").val()			
		},
	    mtype: 'POST',
	    colNames:['NO', 'ID', '사용자', '담당매장','회사코드'],
	    colModel:[
	  		{name:'records',index : 'records',width : 50,align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
            {name:'userId',index:'userId', width:200, align:'center', sortable:true, editable:false},
            {name:'userNm',index:'userNm', width:200, align:'left', sortable:true, editable:false},
            {name:'strCnt',index:'strCnt', width:200, align:'center', sortable:true, editable:false},
            {name:'vendorCd',index:'vendorCd', hidden:true}
        ],
   		jsonReader : {
        	repeatitems:false
   		},
		rowNum:20,
   		rowList:[10,20,50,100],
   		pager: '#gridUserListPager',
   		recordtext: "건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
   		sortname: 'userId',
   		viewrecords: true,
   		sortorder: "asc",	     
   		hidegrid: false,
   		shrinkToFit:true,
		autowidth:true,
		height : 360,
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridUserList").getRowData(rowid);
			var userId = $.trim(list.userId);
			var vendorCd = $.trim(list.vendorCd);

			// 엔지니어 할당된 매장 검색
			fncStrMapSearch(userId);
			$("#scrVendorCd").val(vendorCd);
			// 할당매장선택 검색
			fncStrSearch();
		},
   		loadComplete : function(data) {
  			// 엔지니어 할당된 매장 초기화
  			fncStrMapInit();
  			
  			// 할당매장선택 초기화
	    	fncStrInit();
		}
	});
	jqGridResize('gridUserList');

	// 엔지니어 할당된 목록 
	$("#gridMapedStr").jqGrid({
		url:'searchEngineerStrList',
	    datatype: "local",
	    mtype: 'POST',
	    colNames:['No', '선택', '${smStrNm}', '주소', '설치일자', '매장코드'],
	    colModel:[
	    	{name:'records',index : 'records',width : 50,align : 'center',sortable :false, editable : false,editoptions : {readonly : true,size : 10}},
	        {name:'choice',index :'choice',width : 50,align : 'center',sortable :false, formatter :chboxFormatter1,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	        {name:'strNm',index:'strNm', width:120, align:'left', sortable:true, editable:false},
	        {name:'addr',index:'addr', width:200, align:'left', sortable:true, editable:false},
	        {name:'remsStartDt', index:'remsStartDt', width:100, align:'center', sortable:true, editable:false},
	        {name:'strCd',index:'strCd', hidden:true}
		],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:-1,
	    pager: '#gridMapedStrPager',
        recordtext: "전체 {2} 건",
        emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 360,
		loadComplete : function(data) {
	    	// 페이징 숨기기
			$("#gridMapedStrPager_center").hide();
		}
	});

	// 라디오 버튼 선택
	$("input:radio[name='scrMapYn']:input[value='N']").prop("checked", true);
	
	// 전체버튼 클릭
	func_AllBtn();
	
	// 할당매장선택 목록
	$("#gridStoreMgntList").jqGrid({
		url:'searchStrEngineerList',
		datatype: "local",
		mtype: 'POST',
		colNames:['No', '선택', '${smStrNm}', '주소', '설치일자', '매장코드', '주소'],
	    colModel:[
	    		{name:'records',index : 'records',width : 50,align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
	    	  	{name:'choice',index :'choice',width : 50,align : 'center',sortable :false, formatter :chboxFormatter2,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},
	            {name:'strNm',index:'strNm', width:120, align:'left', sortable:true, editable:false},
	            {name:'addr', index:'addr', width:300, align:'left', sortable:false, editable:false},
				{name:'remsStartDt', index:'remsStartDt', width:100, align:'center', sortable:false, editable:false},
	            {name:'strCd',index:'strCd', hidden:true},
	            {name:'addr',index:'addr', hidden:true}
		],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[10,20,50,100],
	    pager: '#gridStoreMgntListPager',
	    recordtext: "건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 360
	});
	
	// 엔터 키 이벤트
	$("input[name='scrUserNm'], input[name='scrStrNm']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncSearch();
	        }
		}
	});
	$("input[name='scrStrCd']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncStrSearch();
	        }
		}
	});
	 
});

/*******************
1. 기타 필수 스크립트
********************/
// 할당된 매장목록 체크박스
function chboxFormatter1(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid_1\" id=\"choice_grid_1_" + options.rowId + "\" rowid=\"" + options.rowId + "\" onclick=\"onCheckboxClick('1')\" />";
	
}

// 할당매장선택 목록 체크박스
function chboxFormatter2(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid_2\" id=\"choice_grid_2_" + options.rowId + "\" rowid=\"" + options.rowId + "\" onclick=\"onCheckboxClick('2')\" />";
}

// 체크시 색상 입히기
function onCheckboxClick(chkId) {
	$("input:checkbox[name='choice_grid_" + chkId + "']").each(function() {
		if (this.checked == true) {
			$(this).closest("tr").find("td").removeClass("chk1").removeClass("chk2").addClass("chk" + chkId);			
		} else {
			$(this).closest("tr").find("td").removeClass("chk" + chkId);			
		}
	});
}

// 엔지니어 검색
function fncSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}

	$("#gridUserList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserList").setGridParam({
		postData : {
			scrCompanyCd:companyCd,
			scrUserNm:$.trim($("#scrUserNm").val()),
			scrVendorCd:$.trim($("#scrVendorCd").val()),
			scrStrNm:$.trim($("#scrStrNm").val())			
		}
	}).trigger("reloadGrid");
	
	$("#insertedList").val("");
	$("#deletedList").val("");
}

// 엔지니어 할당된 매장 목록
function fncStrMapSearch(userId) {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}	
	$("#gridMapedStr").clearGridData();
	$("#gridMapedStr").setGridParam({
		url:'searchEngineerStrList',
		datatype : "json",
		postData : {
			scrCompanyCd:companyCd,
			scrUserId:userId
		}
	 }).trigger("reloadGrid");

	$("#insertedList").val("");
	$("#deletedList").val("");
}

// 엔지니어 할당된 매장 초기화
function fncStrMapInit() {
	$("#gridMapedStr").clearGridData();
	$("#gridMapedStr").setGridParam({
		 datatype : "local"
	 }).trigger("reloadGrid");
}

// 할당매장선택 초기화
function fncStrInit() {
	$("#gridStoreMgntList").clearGridData();
	$("#gridStoreMgntList").setGridParam({
		 datatype : "local"
	 }).trigger("reloadGrid");
}

// 할당매장선택 검색
function fncStrSearch() {
	// 엔지니어 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 엔지니어 선택된 로우
	if (selrow == "") {
		alert("엔지니어를 먼저 선택하세요.");
		return false;
	}

	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var list = $("#gridUserList").getRowData(selrow);
	var userId = $.trim(list.userId);
	var scrStrCd = $.trim($("#scrStrCd").val());	
	var scrMapYn = $.trim($(":radio[name='scrMapYn']:checked").val());
	var scrDateFrom = $.trim($("#scrDateFrom").val().replace('-','').replace('-',''));
	var scrDateTo = $.trim($("#scrDateTo").val().replace('-','').replace('-',''));
	var scrVendorCd = $("#scrVendorCd").val();
	
	if(scrDateFrom > scrDateTo){
		alert("설치일자를 확인해주세요.");
		return false;
	}
	
	$("#gridStoreMgntList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgntList").setGridParam({
		datatype : "json",	
		postData : {
			scrCompanyCd:companyCd,
			scrStrCd:scrStrCd,
			scrMapYn:scrMapYn,
			scrDateFrom:scrDateFrom,
			scrDateTo:scrDateTo,
			scrUserId:userId,
			scrVendorCd:scrVendorCd
		}
	}).trigger("reloadGrid");	
}

// 날짜 버튼
function func_monthBtn(add) {
	$("#scrDateTo").val("${toDay}");
	var date = $.trim($("#scrDateTo").val());	
	var retDate = gfnDateAdd(date, 'M', add * -1, '-');
	
	$("#scrDateFrom").val(retDate);
}

// 날짜 버튼(전체)
function func_AllBtn() {
	$("#scrDateFrom").val("2010-01-01");
	$("#scrDateTo").val("${toDay}");
}

// 할당된 매장목록에서 할당매장선택으로 >>
function fncUnMappingAll() {
	// 전체 선택
	$("input:checkbox[name='choice_grid_1']").prop("checked", true); 
	onCheckboxClick('1');
	
	fncUnMapping();
}

// 할당된 매장목록에서 할당매장선택으로 >
function fncUnMapping() {
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_1']:checked").size();
	if (chkCnt == 0) {
		alert("할당된 매장목록에서 체크박스를 선택하세요.");
		return false;
	}
	
	// 마지막 records 값 리턴
	var lastRecords = fnLastRecords();
	
	var rowid = "";
	var rowData = "";
	var strCd = "";
	var strNm = "";
	var addr = "";
	var remsStartDt = "";
	var addRow = "";
	var totLastRecords = Number(lastRecords) + 1;
	var insertedList = $.trim($("#insertedList").val());	// 등록 목록
	var deletedList = $.trim($("#deletedList").val());		// 삭제 목록

	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_1']:checked").each(function() {
		// 해당 로오의 데이터 가져오기
		rowid = $.trim($(this).attr("rowid"));
		rowData = $("#gridMapedStr").getRowData(rowid);
		
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소
		remsStartDt = $.trim(rowData.addr);			// 설치일자
		
		// 매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", strNm:strNm, addr:addr, remsStartDt:remsStartDt, strCd:strCd};
		$("#gridStoreMgntList").jqGrid('addRowData', totLastRecords, addRow);
		
		// 색상 유지
		$("#gridStoreMgntList tr[id='" + totLastRecords + "'] td").addClass("chk1");
		
		// 할당된 매장목록에 삭제
		$("#gridMapedStr").delRowData(rowid);
		
		totLastRecords = totLastRecords + 1;
		
		// 삭제 목록에 추가
		if (insertedList.indexOf(strCd) == -1) {
			deletedList += strCd + ",";	
		} else {
			insertedList = insertedList.replace(strCd + ",", ""); 
		}
	});
	
	$("#insertedList").val(insertedList);
	$("#deletedList").val(deletedList);
}

// 할당매장선택에서 할당된 매장목록으로 <<
function fncMappingAll() {
	// 엔지니어 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 엔지니어 선택된 로우
	if (selrow == "") {
		alert("엔지니어를 먼저 선택하세요.");
		return false;
	}
	
	// 전체 선택
	$("input:checkbox[name='choice_grid_2']").prop("checked", true);
	onCheckboxClick('2');

	fncMapping();
}

// 할당매장선택에서 할당된 매장목록으로 <
function fncMapping() {	
	// 엔지니어 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 엔지니어 선택된 로우
	if (selrow == "") {
		alert("엔지니어를 먼저 선택하세요.");
		return false;
	}
	
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_2']:checked").size();
	if (chkCnt == 0) {
		alert("할당매장선택에서 체크박스를 선택하세요.");
		return false;
	}
	
	// 매장코드 존재 유무
	// 존재시 retExistStrNm 에 존재하는 매장명 리턴
	// 미존재시 retLastRecord 에 last records 리턴(등록 시 필요)
	var retV = fnExistStrCd();
	var existStrNm = $.trim(retV.retExistStrNm);
	var lastRecords = $.trim(retV.retLastRecord);
	if (existStrNm != "") {
		alert(existStrNm + " 매장이 할당된 매장목록에 이미 존재합니다.");
		return false;
	}
	
	var rowid = "";
	var rowData = "";
	var strCd = "";
	var strNm = "";
	var addr = "";
	var remsStartDt = "";
	var addRow = "";
	var totLastRecords = Number(lastRecords) + 1;
	var insertedList = $.trim($("#insertedList").val());	// 등록 목록
	var deletedList = $.trim($("#deletedList").val());		// 삭제 목록
	
	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_2']:checked").each(function() {
		// 해당 로오의 데이터 가져오기
		rowid = $.trim($(this).attr("rowid"));			
		rowData = $("#gridStoreMgntList").getRowData(rowid);
			
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소
		remsStartDt = $.trim(rowData.remsStartDt);	// 설치일자

		// 할당된 매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", strNm:strNm, addr:addr, remsStartDt:remsStartDt, strCd:strCd};
		$("#gridMapedStr").jqGrid('addRowData', totLastRecords, addRow);
		
		// 색상 유지
		$("#gridMapedStr tr[id='" + totLastRecords + "'] td").addClass("chk2");
		
		// 할당매장 목록에 삭제
		$("#gridStoreMgntList").delRowData(rowid);
		
		totLastRecords = totLastRecords + 1;
		
		// 등록 목록에 추가
		if (deletedList.indexOf(strCd) == -1) {
			insertedList += strCd + ",";	
		} else {
			deletedList = deletedList.replace(strCd + ",", ""); 
		}
	});
	
	$("#insertedList").val(insertedList);
	$("#deletedList").val(deletedList);
}

// 매장코드 존재 유무
function fnExistStrCd() {
	var retExistStrNm = "";
	var retLastRecord = "";
	var list = $("#gridMapedStr").getRowData();
	var cnt = list.length;
	var exiStrCd = "";
	var exiStrNm = "";
	var lastRecord = "";
	var rowid = "";
	var rowData = "";
	var strCd = "";
	
	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_2']:checked").each(function() {
		rowid = $.trim($(this).attr("rowid"));			
		rowData = $("#gridStoreMgntList").getRowData(rowid);
			
		strCd = $.trim(rowData.strCd);		// 매장코드
		
		for (var i = 0; i < cnt; i++) {
			exiStrCd = $.trim(list[i].strCd);
			exiStrNm = $.trim(list[i].strNm);
			lastRecord = $.trim(list[i].records);
			
			// 존재 시
			if (exiStrCd == strCd) {
				retExistStrNm = exiStrNm;
				break;
			}
		}
		
		retLastRecord = lastRecord;
	});
	
	return {
		retExistStrNm:retExistStrNm,
		retLastRecord:retLastRecord
	};
}

// 마지막 records 값 리턴
function fnLastRecords() {
	var list = $("#gridStoreMgntList").getRowData();
	var cnt = list.length;
	var lastRecord = "";
	
	for (var i = 0; i < cnt; i++) {
		lastRecord = $.trim(list[i].records);
	}
	
	return lastRecord;
}

// 저장
function fncSave() {
	// 엔지니어 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 엔지니어 선택된 로우
	if (selrow == "") {
		alert("엔지니어를 먼저 선택하세요.");
		return false;
	}
	
	/*
	var listData = $("#gridMapedStr").getRowData();
	var cnt = listData.length;
	if (cnt < 1) {
		alert("할당된 목록이 없습니다.");
		return false;		
	}
	*/
	
	var insertedList = $.trim($("#insertedList").val());	// 등록 목록
	var deletedList = $.trim($("#deletedList").val());		// 삭제 목록	
	if (insertedList == "" && deletedList == "") {
		alert("변경된 내용이 없습니다.");
		return false;
	}
	
	if (insertedList != "") insertedList = insertedList.substring(0, insertedList.length - 1);
	if (deletedList != "") deletedList = deletedList.substring(0, deletedList.length - 1);
	
	// 회사 코드
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	// 사용자 아이디
	var rowData = $("#gridUserList").getRowData(selrow);
	var userId = $.trim(rowData.userId);
	var records = $.trim(rowData.records);
	
	// 파라미터
	var param  = new Object();
	param.companyCd = companyCd;
	param.userId = userId;
	param.insertStrCdList = insertedList;
	param.deleteStrCdList = deletedList;
	
	if (confirm("할당된 매장목록 정보를 " + "${smCommMsgSaveCnf}")) {
		$.ajax({
			url:'/saveStrMappingEngineer',
			type:'POST',
			cache:false,
			data:param,
			dataType:'json',
			success:function(data){
				fncSearch();
				alert('${smCommMsgSave}');
				$("#gridUserList").jqGrid("setSelection", records);
			},
			error:function(result){
				alert("에러가 발생했습니다.");
			}
		});
	}
}
</script>
<div id="loadingArea">

	<div class="r_halfGridContainer" style="height:500px; display:table !important; width:100% !important;">

		<!-- 좌측영역 -->
		<div class="left_grid_two" style="width:60%;">
		
			<!-- 조회조건 -->
			<div class="r_search multiLine" style="margin-bottom:38px !important">
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
						<th>업체</th>	
						<td>
							<select id="scrVendorCd" name="scrVendorCd" class="searchSelect">							
								<option value="">--전체--</option>
							<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
								<option value='${vo.value}'>${vo.name}</option>
							</c:forEach>
							</select>
						</td>
						<th>사용자명/ID</th>	
						<td>
							<input type='search' id='scrUserNm' name='scrUserNm' value='' style="width:112px;" />
						</td>
					</tr>
				</table>
				<span class="search">
			        <button onclick="javascript:fncSearch()">Search</button>
			    </span>
			</div>
			<!-- //조회조건 -->	
		
			<!-- 좌 그리드 영역 -->
			<div class=r_oneThirdGrid_l2 style="width:400px;height:380px;">
				<div class="r_grid" id="cont1">
					<div class="r_gridTitle">
						<h3>엔지니어목록</h3>
					</div>
					<table id="gridUserList"><tr><td></td></tr></table>
					<div id="gridUserListPager"></div>
				</div>
			</div>
			<!-- //좌 그리드 영역 -->
		
			<!-- 우그리드 영역 -->
			<div class=r_twoThirdGrid_l2 style="width:600px;height:380px;">
				<input type="hidden" id="insertedList" name="insertedList" />
				<input type="hidden" id="deletedList" name="deletedList" />
				<div class="r_grid" id="cont2">
					<div class="r_gridTitle">
						<h3>할당된 매장목록</h3>
					</div>
					<table id="gridMapedStr"><tr><td></td></tr></table>
					<div id="gridMapedStrPager"></div>
				</div>
			</div>
			<!-- //우그리드 영역 -->
		
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
				<li><a href="javascript:;"><img src="images/btn_shuttle_right_all.png" alt="전체추가" onClick="fncUnMappingAll();" /></a></li>
				<li><a href="javascript:;"><img src="images/btn_shuttle_right.png" alt="선택추가" onClick="fncUnMapping();" /></a></li>
				<li><a href="javascript:;"><img src="images/btn_shuttle_left.png" alt="선택삭제" onClick="fncMapping();" /></a></li>
				<li><a href="javascript:;"><img src="images/btn_shuttle_left_all.png" alt="전체삭제" onClick="fncMappingAll();" /></a></li>
			</ul>
		</div>
		<!-- //셔틀영역 -->
		
		<!-- 우측영역 -->
		<div class="right_grid_one">
		
			<!-- 조회조건 -->
			<div class="r_search multiLine">
				<table>
					<tr>
						<th>매장명/코드</th>	
						<td>
							<input type='search' id='scrStrCd' name='scrStrCd' value='' style="width:112px;" />
							<span class="r_radio">
								<input id="scrMapYn1" name="scrMapYn" type="radio" value="" /><label for="scrMapYn1">전체</label>
								<input id="scrMapYn2" name="scrMapYn" type="radio" value="Y" /><label for="scrMapYn2">할당</label>
								<input id="scrMapYn3" name="scrMapYn" type="radio" value="N" /><label for="scrMapYn3">미할당</label>
							</span>
						</td>
					</tr>
					<tr>
						<td>설치일자</td>
						<td>
							<input id="scrDateFrom" name="scrDateFrom" type="text" placeholder="${toDay}" value='${toDay}' style="width:80px;" readonly />
							~ <input id="scrDateTo" name="scrDateTo" type="text" placeholder="${toDay}" value='${toDay}' style="width:80px;" readonly />
							<button onclick="javascript:func_AllBtn();" class="ml_5">전체</button>
					   		<button onclick="javascript:func_monthBtn(1);">1m</button>
					   		<button onclick="javascript:func_monthBtn(6);">6m</button>
					   		<button onclick="javascript:func_monthBtn(12);">1y</button>
						</td>
					</tr>
				</table>		
				<span class="search">
			        <button onclick="javascript:fncStrSearch()">Search</button>
			    </span>
			</div>
			<!-- //조회조건 -->
		
			<!-- 그리드 영역 -->
			<div class="r_grid" id="cont3">
				<div class="r_gridTitle">
					<h3>할당매장선택</h3>
				</div>
				<table id="gridStoreMgntList"><tr><td></td></tr></table>
				<div id="gridStoreMgntListPager"></div>
			</div>
			<!-- //그리드 영역 -->
		
		</div>
		<!-- //우측영역 -->

	</div>

</div>