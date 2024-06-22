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
	
	$("#companyCd").val('${companyCd}');
	
	$("#gridStoreSrch").jqGrid({
		url : 'retrieveStoreSrch',
		datatype : "json",
		mtype : 'POST',
		async: false,
		cache: false,
		colNames : [ '${smSeq}', '${smOrg}', '${smStrCd}', '${smStrNm}', 'strCd' ],
		colModel : [ {
			name : 'records',
			index : 'records',
			width : 50,
			align : 'center',
			sortable : true,
			editable : false,
			editoptions : {
				readonly : true,
				size : 10
			}
		},
		{
			name : 'orgNm',
			index : 'orgNm',
			width : 100,
			align : 'center',
			sortable : true,
			editable : false
			}, {
			name : 'viewStrCd',
			index : 'viewStrCd',
			width : 100,
			align : 'center',
			sortable : true,
			editable : false,
			editoptions : {
				readonly : true,
				size : 10
				}
			}, 
			{
				name : 'strNm',
				index : 'strNm',
				width : 200,
				align : 'left',
				sortable : true,
				editable : false
			}, {
				name : 'strCd',
				index : 'strCd',
				hidden : true
			} ],
			jsonReader : {
				repeatitems : false
			},
			rowNum : 10,
			rowList : [],
			sortname : 'strCd',
			viewrecords : true,
			sortorder : "asc",
			hidegrid : false,				
			shrinkToFit : true,
			//autowidth: true,
			width: '700',
			height : 230,
			pager : '#gridStoreSrchPager',
			postData : {
				srchCompanyCd : $("#companyCd").val(),
				srchViewStrCd : $("#viewStrCd").val(),
				srchStrNm : $("#strNm").val()
			},
			onCellSelect : function(rowid, iCol) {
				var list = $("#gridStoreSrch").getRowData(rowid);
				popParam.strCd     = list.strCd;
				popParam.strNm     = list.strNm;
				popParam.viewStrCd = list.viewStrCd;
			},
			ondblClickRow : function(rowid, iRow, iCol, e) {
				var list = $("#gridStoreSrch").getRowData(rowid);
				popParam.strCd     = list.strCd;
				popParam.strNm     = list.strNm;
				popParam.viewStrCd = list.viewStrCd;
				
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

function fncStrPopupSearch() {
	
	$("#gridStoreSrch").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreSrch").setGridParam({
		datatype : "json",
		postData : {
			srchViewStrCd : $("#viewStrCd").val(),
			srchStrNm : $("#strNm").val()
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
	fncSetStore(popParam);	
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
	
}

function fncCancel() {
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
}
</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<h2 class="r_popupTitle">월별 계약전력사용현황</h2>
	<!-- //팝업 타이틀 -->
	
	<!-- 닫기 버튼 -->
	<p class="close_popup"><a href="#" title="팝업창닫기"><img src="/images/btn_close_popup.png" alt="당기" /></a></p>
	<!-- //닫기버튼 -->
	
	<div class="r_popupCont">
		<h3 class="h3_common_popup_body">G파주조인점 계약전력</h3>
		
		<!-- 본문 출력 영역 -->
		<div class="common_popup_body"></div>
		<!-- //본문 출력 영역 -->
		
		<!-- 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
			<!-- <span class="pageNormal">
				<button onclick="javascript:fncConfirm()">${smCnfm}</button>
			</span> -->
		</div>
		<!-- //버튼 그룹 -->
		
	</div>
</div>
