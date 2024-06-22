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

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont1").width());
    $("#gridStrList").setGridWidth($("#cont2").width());

}).resize();

 

$(function() {
	$("#scrDateFrom, #scrDateTo").datepicker();
});

$(document).ready(function(){
	
	// 할당된 매장목록
	$("#gridStoreMgnt").jqGrid({
		url:'searchMapedStrList',
		datatype: "local",
		mtype: 'POST',
		colNames:['No', '선택', '매장명', '주소', '설치일자', 'strCd'],
		colModel:[
			{name:'records', index:'records', width:50, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
			{name:'choice', index:'choice', width:50, align:'center', sortable:false, formatter:chboxFormatter1, formatoptions:{disabled:false}, editable:true, edittype:'checkbox', editoptions:{value:"1:0"}},
			{name:'strNm', index:'strNm', width:100, align:'left', sortable:true, editable:false},
			{name:'addr', index:'addr', width:300, align:'left', sortable:true, editable:false},
			{name:'remsStartDt', index:'remsStartDt', width:100, align:'center', sortable:true, editable:false},
			{name:'strCd', index:'strCd', hidden:true}
		],
		jsonReader:{
			repeatitems:false
		},
		rowNum:-1,
		pager:'#gridStoreMgntPager',
		recordtext:"전체 {2} 건",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname:'strNm',
		viewrecords:true,
		sortorder:"asc",
		hidegrid:false,
		shrinkToFit:true,
		autowidth:true,
		height:360,
		loadComplete:function(data) {
			// 페이징 숨기기
			$("#gridStoreMgntPager_center").hide();
		}
	});
	
	// 라디오 버튼 선택
	$("input:radio[name='scrMapYn']:input[value='N']").prop("checked", true);
	
	// 전체버튼 클릭
	func_AllBtn();
	
	// 할당매장선택 목록
	$("#gridStrList").jqGrid({
		url:'searchCompanyStrList',
		datatype: "json",
      	postData : {
			scrCompanyCd:$.trim($("#scrCompanyCd").val()),
			scrStrNm:$.trim($("#scrStrNm").val()),
			scrMapYn:$.trim($(":radio[name='scrMapYn']:checked").val()),
		 	scrDateFrom:$.trim($("#scrDateFrom").val().replace('-','').replace('-','')),
		 	scrDateTo:$.trim($("#scrDateTo").val().replace('-','').replace('-','')) 
	  	},
		mtype: 'POST',
		colNames:['No', '선택', '매장명', '주소', '설치일자', 'strCd'],
		colModel:[
			{name:'records', index:'records', width:50, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
			{name:'choice', index:'choice', width:50, align:'center', sortable:false, formatter:chboxFormatter2, formatoptions:{disabled:false}, editable:true, edittype:'checkbox', editoptions:{value:"1:0"}},
			{name:'strNm', index:'strNm', width:100, align:'left', sortable:true, editable:false},
			{name:'addr', index:'addr', width:300, align:'left', sortable:false, editable:false},
			{name:'remsStartDt', index:'remsStartDt', width:100, align:'center', sortable:true, editable:false},
			{name:'strCd', index:'strCd', hidden:true}
		],
		jsonReader:{
			repeatitems:false
		},
		rowNum:20,
	    rowList:[10,20,50,100],
		pager:'#gridStrListPager',
		recordtext: "{1} 건/페이지  (전체 {2} 건)",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname:'strNm',
		viewrecords:true,
		sortorder:"asc",
		hidegrid:false,
		shrinkToFit:true,
		autowidth:true,
		height:360
	});	
	jqGridResize("gridStrList");
	
	// 셀렉트 선택	
	var ssVenderCd = $.trim("${userVo.vendorCd}");
	$("#scrVendorCd").val(ssVenderCd);	
	if (ssVenderCd != "") $("#scrVendorCd").attr("disabled", "disabled");
		
	// 엔터 키 이벤트
	$("input[name='scrStrNm']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncStrSearch()();
	        }
		}
	});
	
	// 업체 셀렉트 변경시
	$("select[id='scrVendorCd']").on({
		change: function() {
			fncSearch();
		}
	});
	
	// 세션값 있을 경우 자동 검색
	if (ssVenderCd != "") fncSearch();
});

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

// 할당된 매장목록 검색
function fncSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}

	// 업체를 선택하세요.
	var vendorCd = $.trim($("#scrVendorCd").val());	
	if (vendorCd == "") {
		alert("업체를 선택하세요.");
		return false;
	}
	
	$("#gridStoreMgnt").setGridParam({
		datatype : "json",		
		postData : {
			scrCompanyCd:companyCd,
			scrVendorCd:vendorCd
		}
	}).trigger("reloadGrid");
	
	$("#insertedList").val("");
	$("#deletedList").val("");
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

// 할당매장선택 검색
function fncStrSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}

	var scrStrNm = $.trim($("#scrStrNm").val());	
	var scrMapYn = $.trim($(":radio[name='scrMapYn']:checked").val());
	var scrDateFrom = $.trim($("#scrDateFrom").val().replace('-','').replace('-',''));	
	var scrDateTo = $.trim($("#scrDateTo").val().replace('-','').replace('-',''));
	
	if(scrDateFrom > scrDateTo){
		alert("설치일자를 확인해주세요.");
		return false;
	}
	
	$("#gridStrList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStrList").setGridParam({
		datatype : "json",		
		postData : {
			scrCompanyCd:companyCd,
			scrStrNm:scrStrNm,
			scrMapYn:scrMapYn,
			scrDateFrom:scrDateFrom,
			scrDateTo:scrDateTo
		}
	}).trigger("reloadGrid");
}

// 할당된매장 목록에서 할당매장목록으로 >>
function fncUnMappingAll() {
	// 전체 선택
	$("input:checkbox[name='choice_grid_1']").prop("checked", true); 
	onCheckboxClick('1');
	
	fncUnMapping();
}

// 할당된매장 목록에서 할당매장목록으로 >
function fncUnMapping() {
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_1']:checked").size();
	if (chkCnt == 0) {
		alert("할당된매장목록에서 체크박스를 선택하세요.");
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
		rowData = $("#gridStoreMgnt").getRowData(rowid);
		
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소
		remsStartDt = $.trim(rowData.remsStartDt);	// 설치일자
		
		// 매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", strNm:strNm, addr:addr, remsStartDt:remsStartDt, strCd:strCd};
		$("#gridStrList").jqGrid('addRowData', totLastRecords, addRow);
		
		// 색상 유지
		$("#gridStrList tr[id='" + totLastRecords + "'] td").addClass("chk1");
		
		// 할당된매장 목록에 삭제
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

// 할당매장목록에서 할당된매장 목록으로 <<
function fncMappingAll() {
	// 업체 선택 체크
	var scrVendorCd = $.trim($("#scrVendorCd").val());
	if (scrVendorCd == "") {
		alert("업체를 먼저 선택하세요.");
		return false;
	}
	
	// 전체 선택
	$("input:checkbox[name='choice_grid_2']").prop("checked", true);
	onCheckboxClick('2');

	fncMapping();
}

// 할당매장목록에서 할당된매장 목록으로 <
function fncMapping() {	
	// 업체 선택 체크
	var scrVendorCd = $.trim($("#scrVendorCd").val());
	if (scrVendorCd == "") {
		alert("업체를 먼저 선택하세요.");
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
		rowData = $("#gridStrList").getRowData(rowid);
			
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소
		remsStartDt = $.trim(rowData.remsStartDt);	// 설치일자

		// 할당된매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", strNm:strNm, addr:addr, remsStartDt:remsStartDt, strCd:strCd};
		$("#gridStoreMgnt").jqGrid('addRowData', totLastRecords, addRow);
		
		// 색상 유지
		$("#gridStoreMgnt tr[id='" + totLastRecords + "'] td").addClass("chk2");
		
		// 할당매장 목록에 삭제
		$("#gridStrList").delRowData(rowid);
		
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
		rowData = $("#gridStrList").getRowData(rowid);
			
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
	var list = $("#gridStrList").getRowData();
	var cnt = list.length;
	var lastRecord = "";
	
	for (var i = 0; i < cnt; i++) {
		lastRecord = $.trim(list[i].records);
	}
	
	return lastRecord;
}

// 저장
function fncSave() {
	// 업체 선택 체크
	var scrVendorCd = $.trim($("#scrVendorCd").val());
	if (scrVendorCd == "") {
		alert("업체를 먼저 선택하세요.");
		return false;
	}
	
	// 회사 코드
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var insertedList = $.trim($("#insertedList").val());	// 등록 목록
	var deletedList = $.trim($("#deletedList").val());		// 삭제 목록	
	if (insertedList == "" && deletedList == "") {
		alert("변경된 내용이 없습니다.");
		return false;
	}
	
	var msg = "할당된매장목록 정보를 " + "${smCommMsgSaveCnf}";
	if (insertedList != "") insertedList = insertedList.substring(0, insertedList.length - 1);
	if (deletedList != "") {
		deletedList = deletedList.substring(0, deletedList.length - 1);
		msg = "매장 삭제시 엔지니어정보도 삭제됩니다. " + "${smCommMsgSaveCnf}";
	}

	// 파라미터
	var param  = new Object();
	param.companyCd = companyCd;
	param.vendorCd = scrVendorCd;
	param.insertStrCdList = insertedList;
	param.deleteStrCdList = deletedList;
	
	if (confirm(msg)) {
		$.ajax({
			url:'/strMappingVendor',
			type:'POST',
			cache:false,
			data:param,
			dataType:'json',
			success:function(data){
				alert('${smCommMsgSave}');
				fncSearch();
			},
			error:function(result){
				alert("에러가 발생했습니다.");
			}
		});
	}
}

//엑셀 다운로드
function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrCompanyCd = $.trim($("#scrCompanyCd").val());	
	if (scrCompanyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var scrStrNm = $.trim($("#scrStrNm").val());	
	var scrMapYn = $.trim($(":radio[name='scrMapYn']:checked").val());
	var scrDateFrom = $.trim($("#scrDateFrom").val().replace('-','').replace('-',''));	
	var scrDateTo = $.trim($("#scrDateTo").val().replace('-','').replace('-',''));	
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrStrNm);
	$("#excel3").val(scrMapYn);
	$("#excel4").val(scrDateFrom);
	$("#excel5").val(scrDateTo);	
	
	$('#excelDownload').attr("action", "/searchCompanyStrListExcel");
	$("#excelDownload").submit();

}
</script>
<div id="loadingArea">
	<form id="excelDownload" name='excelDownload' method='post'>
		<input type="hidden" id="excel1" name="scrCompanyCd"> 
		<input type="hidden" id="excel2" name="scrStrNm"> 
		<input type="hidden" id="excel3" name="scrMapYn"> 
		<input type="hidden" id="excel4" name="scrDateFrom"> 
		<input type="hidden" id="excel5" name="scrDateTo"> 
	</form>

	<div class="r_halfGridContainer" style="height:500px; display:table !important; width:100% !important;">
	
		<!-- 좌측영역 -->
		<div class="left_grid_two">
		
			<!-- 조회조건 -->
			<div class="r_grid r_inputTblTitle">
				<h3>업체선택</h3>
			</div>
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
						<th>업체</th>	
						<td>
							<select id="scrVendorCd" name="scrVendorCd" class="searchSelect">							
								<option value="">--선택--</option>
							<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
								<option value='${vo.value}'>${vo.name}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<span class="search">
			        <button onclick="javascript:fncSearch();">Search</button>
			    </span>
			</div>
			<!-- //조회조건 -->
			
			<!-- 그리드 -->
			<input type="hidden" id="insertedList" name="insertedList" />
			<input type="hidden" id="deletedList" name="deletedList" />
			<div class="r_grid" id = "cont1">
				<div class="r_gridTitle">
					<h3>업체 할당 매장목록</h3>
				</div>
				<table id="gridStoreMgnt"><tr><td></td></tr></table>
				<div id="gridStoreMgntPager"></div>
			</div>
			<!-- 우그리드 -->
			
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
		
			<!-- 조회조건 타이틀 -->
			<div class="r_grid r_inputTblTitle">
				<h3>SEMS 매장목록</h3>
			</div>
			<!-- //조회조건 타이틀 -->
			
			<!-- 조회조건 -->
			<div class="r_search multiLine">
				<table>
					<tr>
						<th>매장명/코드</th>
						<td>
							<input type='text' id='scrStrNm' name='scrStrNm' value='' style="width:80px; margin-right:12px;" />
							<span class="r_radio">
								<!-- 
								<input id="scrMapYn1" name="scrMapYn" type="radio" value="" /><label for="scrMapYn1">전체</label>
								<input id="scrMapYn2" name="scrMapYn" type="radio" value="Y" /><label for="scrMapYn2">할당</label>
								 -->
								<input id="scrMapYn3" name="scrMapYn" type="radio" value="N" /><label for="scrMapYn3">미할당</label>
							</span>
						</td>
						<th>설치일자</th>
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
			        <button onclick="javascript:fncStrSearch();">Search</button>
			    </span>
			</div>
			<!-- //조회조건 -->
			
			<!-- 그리드 -->
			<div class="r_grid" style="margin-top:5px" id = "cont2">
				<div class="r_gridTitle">
					<!-- 엑셀 download -->
					<div style="text-align:right">
						<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
					</div>
					<!-- //엑셀 download -->
				</div>
				
				<table id="gridStrList"><tr><td></td></tr></table>
				<div id="gridStrListPager"></div>
			</div>
			<!-- //그리드 -->
			
		</div>
		<!-- //우측영역 -->

	</div>
	
</div>