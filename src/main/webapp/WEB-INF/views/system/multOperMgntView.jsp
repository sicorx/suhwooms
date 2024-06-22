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

/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridUserList").setGridWidth($("#cont1").width());
    $("#gridStoreMgnt").setGridWidth($("#cont2").width());
    $("#gridStoreMgntList").setGridWidth($("#cont3").width());
    

}).resize();


$(document).ready(function(){
	
	  // 사용자 정보
	  $("#gridUserList").jqGrid({
	      url:'multOperUserList',
	      datatype: "json",
	      postData : {
			 scrCompanyCd:$.trim($("#scrCompanyCd").val()),
			 scrUserNm:$.trim($("#scrUserNm").val()),
			 scrStrNm:$.trim($("#scrStrNm").val()),
			 scrAreaNm:$.trim($("#scrAreaNm").val())
		  },
	      mtype: 'POST',
	      colNames:['No', '${smUserId}', '${smUserNm}', '소유매장수'],
	      colModel:[
	    	  		{name:'records',index:'records',width:10,	align:'center', sortable:false },
	                {name:'userId',	index:'userId', width:50, 	align:'center' },
	                {name:'userNm',	index:'userNm', width:50,	align:'center' },
	                {name:'strCnt',	index:'strCnt', width:30, 	align:'center' },
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
		 rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridUserListPager',
	     recordtext: "{1} 건/페이지  (전체 {2} 건)",
		 emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'userNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 360,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridUserList").getRowData(rowid);
			var userId = $.trim(list.userId);
			
			// 소유매장 검색
			fncStrMapSearch(userId);
			
			// 전체매장 검색
			fncStrSearch();
		 },
		 gridComplete : function()
		 {
				jqGridEven('gridUserList');			 
				var rsltCount = $("#gridUserList").getGridParam("reccount");			
				
				if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
				{								
					$("#gridUserList >tbody").append("<tr><td align='center' colspan='4'>검색 결과가 없습니다.</td></tr>");
				}	
		 },
	     loadComplete : function(data) {
	    	// 소유매장 초기화
	    	fncStrMapInit();
	    	
	    	// 전체매장 초기화
	    	fncStrInit();
		 }
	  });
	  jqGridResize('gridUserList');
	  
	 // 소유매장 목록 
	 $("#gridStoreMgnt").jqGrid({
	      url:'multOperRemsStoreMgnt',
	      datatype: "local",
	      mtype: 'POST',
	      colNames:['No', '선택', '${smStrCd}', '${smStrNm}', '주소', '매장코드'],
	      colModel:[
	                {name:'records',	index:'records',	width:10,	align:'center',sortable :false, editable : false },
	                {name:'choice',		index:'choice',		width:10,	align:'center',sortable :false, formatter :chboxFormatter1,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	                {name:'viewStrCd',	index:'viewStrCd', 	width:30, 	align:'center' },
	                {name:'strNm',		index:'strNm', 		width:50, 	align:'center' },
	                {name:'addr',		index:'addr', 		width:80, 	align:'left' },
	                {name:'strCd',		index:'strCd', 		hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:-1,
	     pager: '#gridStoreMgntPager',
         recordtext: "{1} 전체 {2} 건",
         emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'strNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 360,
		 gridComplete : function()
		 {
			 	/*
				jqGridEven('gridStoreMgnt');			 
				var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
				
				if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
				{								
					$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='5'>검색 결과가 없습니다.</td></tr>");
				}
				*/
		 },
		 loadComplete : function(data) {
	    	// 페이징 숨기기
	    	$("#gridStoreMgntPager_center").hide();
		 }
	 });
	  
	  // 전체매장 목록
	  $("#gridStoreMgntList").jqGrid({
	      url:'operRemsStoreMgnt',
	      datatype: "local",
	      mtype: 'POST',
	      colNames:['No', '선택', '${smStrCd}', '${smStrNm}', '경영주수', '매장코드', '주소'],
	      colModel:[
			    	{name:'records',	index:'records',	width:10,	align:'center',sortable :false, editable : false },
		            {name:'choice',		index:'choice',		width:10,	align:'center',sortable :false, formatter :chboxFormatter2,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
		            {name:'viewStrCd',	index:'viewStrCd', 	width:30, 	align:'center' },
		            {name:'strNm',		index:'strNm', 		width:50, 	align:'left' },
					{name:'strCnt',		index:'strCnt', 	width:30, 	align:'center' },
					{name:'addr',		index:'addr', 		hidden:true},
	                {name:'strCd',		index:'strCd', 		hidden:true}
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
		 height : 360,
		 gridComplete : function()
		 {
			 	/*
				jqGridEven('gridStoreMgntList');			 
				var rsltCount = $("#gridStoreMgntList").getGridParam("reccount");			
				
				if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
				{								
					$("#gridStoreMgntList >tbody").append("<tr><td align='center' colspan='5'>검색 결과가 없습니다.</td></tr>");
				}
				*/
		 }
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
function chboxFormatter1(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid_1\" id=\"choice_grid_1_" + options.rowId + "\" rowid=\"" + options.rowId + "\" onclick=\"onCheckboxClick('1')\" />";
	
}

function chboxFormatter2(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid_2\" id=\"choice_grid_2_" + options.rowId + "\" rowid=\"" + options.rowId + "\" onclick=\"onCheckboxClick('2')\" />";
}

function onCheckboxClick(chkId) {
	$("input:checkbox[name='choice_grid_" + chkId + "']").each(function() {
		if (this.checked == true) {
			$(this).closest("tr").find("td").removeClass("chk1").removeClass("chk2").addClass("chk" + chkId);			
		} else {
			$(this).closest("tr").find("td").removeClass("chk" + chkId);			
		}
	});
}

// 경영주 검색
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
			scrStrNm:$.trim($("#scrStrNm").val()),
			scrAreaNm:$.trim($("#scrAreaNm").val())
		}
	}).trigger("reloadGrid");
	
	$("#insertedList").val("");
	$("#deletedList").val("");
}

// 소유매장 검색
function fncStrMapSearch(userId) {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({
		 datatype : "json",		
		 postData : {
			 scrCompanyCd:companyCd,
			 scrUserId:userId
		 }
	 }).trigger("reloadGrid");
	
	$("#insertedList").val("");
	$("#deletedList").val("");
}

// 소유매장 초기화
function fncStrMapInit() {
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({
		 datatype : "local"
	 }).trigger("reloadGrid");
}

// 전체매장 초기화
function fncStrInit() {
	$("#gridStoreMgntList").clearGridData();
	$("#gridStoreMgntList").setGridParam({
		 datatype : "local"
	 }).trigger("reloadGrid");
}

// 전체매장 검색
function fncStrSearch() {
	// 경영주 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영주 선택된 로우
	if (selrow == "") {
		alert("경영주를 먼저 선택하세요.");
		return false;
	}
	
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var list = $("#gridUserList").getRowData(selrow);
	var userId = $.trim(list.userId);
	  
	$("#gridStoreMgntList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgntList").setGridParam({
		datatype : "json",	
		postData : {
			scrCompanyCd:companyCd,
			scrStrCd:$.trim($("#scrStrCd").val()),
			scrStrKd:$.trim($("#scrStrKd").val()),
			scrUserId:userId
		}
	}).trigger("reloadGrid");	
}

// 소유매장 목록에서 매장목록으로 >>
function fncUnMappingAll() {
	// 전체 선택
	$("input:checkbox[name='choice_grid_1']").prop("checked", true); 
	onCheckboxClick('1');
	
	fncUnMapping();
}

// 소유매장 목록에서 매장목록으로 >
function fncUnMapping() {
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_1']:checked").size();
	if (chkCnt == 0) {
		alert("소유매장목록에서 체크박스를 선택하세요.");
		return false;
	}
	
	// 마지막 records 값 리턴
	var lastRecords = fnLastRecords();
	
	var rowid = "";
	var rowData = "";
	var strCd = "";
	var viewStrCd = "";
	var strNm = "";
	var addr = "";
	var addRow = "";
	var totLastRecords = Number(lastRecords) + 1;
	var insertedList = $.trim($("#insertedList").val());	// 등록 목록
	var deletedList = $.trim($("#deletedList").val());		// 삭제 목록

	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_1']:checked").each(function() {
		// 해당 로오의 데이터 가져오기
		rowid = $.trim($(this).attr("rowid"));
		rowData = $("#gridStoreMgnt").getRowData(rowid);
		
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		viewStrCd = $.trim(rowData.viewStrCd);		// 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소
		
		// 매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", viewStrCd:viewStrCd, strNm:strNm, addr:addr, strCd:strCd};
		$("#gridStoreMgntList").jqGrid('addRowData', totLastRecords, addRow);
		
		// 색상 유지
		$("#gridStoreMgntList tr[id='" + totLastRecords + "'] td").addClass("chk1");
		
		// 소유매장 목록에 삭제
		$("#gridStoreMgnt").delRowData(rowid);
		
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

// 매장목록에서 소유매장 목록으로 <<
function fncMappingAll() {
	// 경영주 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영주 선택된 로우
	if (selrow == "") {
		alert("경영주를 먼저 선택하세요.");
		return false;
	}
	
	// 전체 선택
	$("input:checkbox[name='choice_grid_2']").prop("checked", true);
	onCheckboxClick('2');

	fncMapping();
}

// 매장목록에서 소유매장 목록으로 <
function fncMapping() {	
	// 경영주 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영주 선택된 로우
	if (selrow == "") {
		alert("경영주를 먼저 선택하세요.");
		return false;
	}
	
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_2']:checked").size();
	if (chkCnt == 0) {
		alert("매장목록에서 체크박스를 선택하세요.");
		return false;
	}
	
	// 매장코드 존재 유무
	// 존재시 retExistStrNm 에 존재하는 매장명 리턴
	// 미존재시 retLastRecord 에 last records 리턴(등록 시 필요)
	var retV = fnExistStrCd();
	var existStrNm = $.trim(retV.retExistStrNm);
	var lastRecords = $.trim(retV.retLastRecord);
	if (existStrNm != "") {
		alert(existStrNm + " 매장이 목록에 이미 존재합니다.");
		return false;
	}
	
	var rowid = "";
	var rowData = "";
	var strCd = "";
	var viewStrCd = "";
	var strNm = "";
	var addr = "";
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
		viewStrCd = $.trim(rowData.viewStrCd);		// 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소

		// 소유매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", viewStrCd:viewStrCd, strNm:strNm, addr:addr, strCd:strCd};
		$("#gridStoreMgnt").jqGrid('addRowData', totLastRecords, addRow);
		
		// 색상 유지
		$("#gridStoreMgnt tr[id='" + totLastRecords + "'] td").addClass("chk2");
		
		// 매장 목록에 삭제
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
	var list = $("#gridStoreMgnt").getRowData();
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
	// 경영주 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영주 선택된 로우
	if (selrow == "") {
		alert("경영주를 먼저 선택하세요.");
		return false;
	}
	
	var listData = $("#gridStoreMgnt").getRowData();
	var cnt = listData.length;
	if (cnt < 1) {
		alert("소유매장목록이 없습니다.");
		return false;		
	}
	
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
	
	if (confirm("소유매장목록 정보를 " + "${smCommMsgSaveCnf}")) {
		$.ajax({
			url:'/saveStrMapMgnt',
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
		<div class="left_grid_two" style="width:67%;">
		
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
						<th>사용자명/ID</th>	
						<td>
							<input type='search' id='scrUserNm' name='scrUserNm' value='' placeholder="전체" style="width:112px;" />
						</td>
						<th>매장명/코드</th>	
						<td>
							<input type='search' id='scrStrNm' name='scrStrNm' value='' placeholder="전체" style="width:112px;" />
						</td>
					</tr>
					<tr>
						<th>지역(시도)</th>	
						<td colspan="3">
							<select id="scrAreaNm" name="scrAreaNm" style="width:112px;" class="searchSelect">
								<option value=''>--전체--</option>
							<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
								<option value='${vo.areaNm}'>${vo.areaNm}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<span class="search">
			        <button onclick="javascript:fncSearch()">Search</button>
			    </span>
			</div>
			<!-- //조회조건 -->	
		
			<!-- 좌 그리드 영역 -->
			<div class=r_oneThirdGrid_l2 style="width:500px;height:380px;">
				<div class="r_grid" id="cont1">
					<div class="r_gridTitle">
						<h3>경영주 선택</h3>
					</div>
					<table class="gridPointer" id="gridUserList"><tr><td></td></tr></table>
					<div id="gridUserListPager"></div>
				</div>
			</div>
			<!-- //좌 그리드 영역 -->
		
			<!-- 우그리드 영역 -->
			<div class=r_twoThirdGrid_l2 style="width:620px;height:380px;">
				<input type="hidden" id="insertedList" name="insertedList" />
				<input type="hidden" id="deletedList" name="deletedList" />
				<div class="r_grid" id="cont2">
					<div class="r_gridTitle">
						<h3>소유매장목록</h3>
					</div>
					<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
					<div id="gridStoreMgntPager"></div>
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
							<input type='search' id='scrStrCd' name='scrStrCd' value='' style="width:112px;" placeholder="전체" />
						</td>
					</tr>
					<tr>
						<th>매장종류</th>	
						<td>
							<select id="scrStrKd" name="scrStrKd" class="searchSelect">
								<option value="">--전체--</option>
								<!-- <option value="0">미할당매장</option> -->
								<option value="1">단일경영주매장</option>
								<option value="2">복수경영주매장</option>
							</select>
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
					<h3>매장목록</h3>
				</div>
				<table class="gridPointer" id="gridStoreMgntList"><tr><td></td></tr></table>
				<div id="gridStoreMgntListPager"></div>
			</div>
			<!-- //그리드 영역 -->
		
		</div>
		<!-- //우측영역 -->

	</div>
	
</div>