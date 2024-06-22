<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smStr"><spring:message code="str" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smStrInq"><spring:message code="strInq" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var popParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	var userId = $.trim($("#popUserId").val());
	
	$("#gridStoreSrch").jqGrid({
		url : 'monitoringRetrieveStoreSrch',
		datatype : "json",
		postData : {
			srcCompanyCd : $.trim($("#popCompanyCd").val()),
			srcOrgCd : $.trim($("#popOrgCd").val()),
			srcSearchType : $.trim($("#popSearchType").val()),
			srcUserId : $.trim($("#popUserId").val())
		},
		mtype : 'POST',
		cache: false,
		colNames : ['No', '매장코드', '매장명', '조직명', 'strCd', 'addr', 'telNo'],
		colModel : [
					{name:'records', index:'records', width:100, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
					{name:'viewStrCd', index:'viewStrCd', width:150, align:'center', sortable:true, editable:false},
					{name:'strNm', index:'strNm', width:200, align:'left', sortable:true, editable:false},
					{name:'orgNm', index:'orgNm', width:200, align:'left', sortable:true, editable:false},
					{name:'strCd', index:'strCd', hidden:true},
					{name:'addr', index:'addr', hidden:true},
					{name:'telNo', index:'telNo', hidden:true}
				   ],
		jsonReader : {
			repeatitems : false
		},
		rowNum : 20,
		rowList:[10,20,50,100],
		pager : '#gridStoreSrchPager',
		recordtext: "건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
		sortname : 'strNm',
		viewrecords : true,
		sortorder : "asc",
		hidegrid : false,				
		shrinkToFit : true,
		//autowidth: true,
		width: '758',
		height : 370,
		onCellSelect : function(rowid, iCol) {
			var list = $("#gridStoreSrch").getRowData(rowid);
			popParam.strCd     = list.strCd;
			popParam.strNm     = list.strNm;
			popParam.viewStrCd = list.viewStrCd;
			popParam.addr = list.addr;
			popParam.telNo = list.telNo;
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridStoreSrch").getRowData(rowid);
			popParam.strCd     = list.strCd;
			popParam.strNm     = list.strNm;
			popParam.viewStrCd = list.viewStrCd;
			popParam.addr = list.addr;
			popParam.telNo = list.telNo;
				
			fncConfirm();
		},
		gridComplete : function(data) {
			 jqGridEven('gridStoreSrch');	
		}				
	}).trigger("reloadGrid");		
	
});


/*******************
1. 기타 필수 스크립트
********************/
// 검색
function fncStrPopupSearch() {
	$("#gridStoreSrch").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreSrch").setGridParam({
		datatype : "json",
		postData : {
			srcCompanyCd : $.trim($("#popCompanyCd").val()),
			srcOrgCd : $.trim($("#popOrgCd").val()),
			srcSearchType : $.trim($("#popSearchType").val()),
			srcUserId : $.trim($("#popUserId").val())
		}
	}).trigger("reloadGrid");	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncConfirm() {
	var selrow = $.trim($("#gridStoreSrch").getGridParam("selrow"));	// 매장 선택된 로우
	if (selrow == "") {
		alert("매장을 먼저 선택하세요.");
		return false;
	}
	
	fncSetStoreCd(popParam);	
	fncDivPop1Close();
}

function fncCancel() {
	fncDivPop1Close();
}
</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<!-- <h2 class="r_popupTitle">${smStrInq}</h2> -->
	<!-- //팝업 타이틀 -->
		  
	<div class="r_popupCont">
	
		<!-- 조회조건 -->
		<div class="r_search multiLine blind">
    		<input type='hidden' id='popCompanyCd' name='popCompanyCd' value="${companyCd}" /><!-- 회사 코드 -->
    		<input type='hidden' id='popOrgCd' name='popOrgCd' value="${orgCd}" /><!-- 조직 코드(조직도에서 호출) -->
    		<input type='hidden' id='popSearchType' name='popSearchType' value="${searchType}" /><!-- 검색 타입(조직도에서 호출) -->
			<table>
				<tr>
					<th>매장명/코드</th>
					<td>
						<input type='text' id='popUserId' name='popUserId' style='width: 115px;' value="${userId}" />
					</td>
				</tr>
			</table>
			<span class="search">
				<button onclick="javascript:fncStrPopupSearch()">Search</button>
			</span>
		</div>
		<!-- //조회조건 -->
		
		<!-- 그리드 영역 -->
		<div class='r_grid'>
			<table id='gridStoreSrch'>
				<tr><td></td></tr>
			</table>
			<div id='gridStoreSrchPager'></div>
		</div>
		<!-- //그리드 영역 -->
		
		<!-- 하단 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
			<span class="pageNormal">
				<button onclick="javascript:fncConfirm()">선택</button>
			</span>
		</div>
		<!-- //하단 버튼 그룹 -->
		
	</div>
	
</div>