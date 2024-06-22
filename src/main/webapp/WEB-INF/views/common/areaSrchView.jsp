<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smSeq"><spring:message code="seq" /></c:set>
<c:set var="smAreaNm"><spring:message code="areaNm" /></c:set>
<c:set var="smCityNm"><spring:message code="cityNm" /></c:set>
<c:set var="smDongNm"><spring:message code="dongNm" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smSelect"><spring:message code="select" /></c:set>
<c:set var="smArea"><spring:message code="area" /></c:set>
<c:set var="smInq"><spring:message code="inq" /></c:set>

<c:set var="smRegnCd"><spring:message code="regnCd"/></c:set>
<c:set var="smRegnNm"><spring:message code="regnNm"/></c:set>
<c:set var="smRegnList"><spring:message code="regnList"/></c:set>
<c:set var="smRegn"><spring:message code="regn"/></c:set>
<c:set var="smSrch"><spring:message code="srch"/></c:set>
<c:set var="smCnfm"><spring:message code="cnfm"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var popParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	$("#gridAreaSrch").jqGrid({
		url : 'retrieveAreaSrch',
		datatype : "json",
		postData : {
			companyCd : $.trim($("#companyCd").val()),			
			localAreaNm : $.trim($("#srcLocalAreaNm").val())	
		},
		mtype : 'POST',
		cache: false,
		colNames : ['No', '시도', '시군구', '동면리', 'fullAreaNm', 'areaCd'],
		colModel : [
					{name:'records', index:'records', width:50, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
					{name :'areaNm', index:'areaNm', align:'right', sortable:true, editable:false},
					{name :'cityNm', index:'cityNm', align:'right', sortable:true, editable:false}, 
					{name :'dongNm', index:'dongNm', align:'right', sortable:true, editable:false}, 
					{name :'fullAreaNm', index:'fullAreaNm', hidden:true},
					{name :'areaCd', index:'areaCd', hidden:true} 
				   ],
		jsonReader : {
			repeatitems : false
		},
		rowNum : 20,
		rowList:[10,20,50,100],
		pager : '#gridAreaSrchPager',
		recordtext: "{1} 건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
		sortname : 'areaNm',
		viewrecords : true,
		sortorder : "asc",
		hidegrid : false,
		shrinkToFit : true,
		//autowidth : true,
		width: '758',
		height : 350,
		onCellSelect : function(rowid, iCol) {
			var list = $("#gridAreaSrch").getRowData(rowid);			
			popParam.areaCd = list.areaCd;
			popParam.areaNm = list.fullAreaNm;			
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridAreaSrch").getRowData(rowid);			
			popParam.areaCd = list.areaCd;
			popParam.areaNm = list.fullAreaNm;

			fncAreaConfirm();
		},
		gridComplete : function(data) {						
			jqGridEven('gridAreaSrch');
		}
	}).trigger("reloadGrid");
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/
// 검색
function fncAreaPopupSearch() {
	$("#gridAreaSrch").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridAreaSrch").setGridParam({
		datatype : "json",
		postData : {
			companyCd : $.trim($("#companyCd").val()),			
			localAreaNm : $.trim($("#srcLocalAreaNm").val())
			
		}
	}).trigger("reloadGrid");
}

function fncAreaConfirm() {
	var selrow = $.trim($("#gridAreaSrch").getGridParam("selrow"));	// 기상지역 선택된 로우
	if (selrow == "") {
		alert("기상지역을 먼저 선택하세요.");
		return false;
	}
	
	fncSetArea(popParam);
	fncDivPop1Close();
}

function fncAreaCancel() {
	fncDivPop1Close();
}

//동/면/리 입력 Enter 시 수행
$("#srcLocalAreaNm").keyup(function(event){	
	
	if(event.which == 13)		// Enter Key Press
	{		
		fncAreaPopupSearch();		// 동/면/리 조회				
	}
});

</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<!-- <h2 class="r_popupTitle">${smArea}${smInq}</h2> -->
	<!-- //팝업 타이틀  -->
	
	<div class="r_popupCont">
	
		<!-- 조회조건 -->
		<div class="r_search multiLine">
	    	<input type='hidden' id='companyCd' name='companyCd' value="${companyCd}" /><!-- 회사 코드 -->
			<table>
				<tr>
					<th>동면리</th>
					<td>
						<input type='search' id='srcLocalAreaNm' name='srcLocalAreaNm' value="${localAreaNm}" style='width: 115px;' />
					</td>
				</tr>
			</table>
			<span class="search">
				<button onclick="javascript:fncAreaPopupSearch()">Search</button>
			</span>
		</div>
		<!-- //조회조건 -->
		
		<!-- 그리드 영역 -->
		<div class="r_grid mt_15">
			<table id="gridAreaSrch"><tr><td></td></tr></table>
			<div id="gridAreaSrchPager"></div>
		</div>
		<!-- //그리드 영역 -->
		
		<!-- 하단 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
		    	<button onclick="javascript:fncAreaCancel()">${smClos}</button>
			</span>
			<span class="pageNormal">
				<button onclick="javascript:fncAreaConfirm()">선택</button>
			</span>
		</div>
		<!-- //하단 버튼 그룹 -->
		
	</div>
	
</div>
