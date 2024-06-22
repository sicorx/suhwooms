<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="smUser"><spring:message code="user" /></c:set>
<c:set var="smUserId"><spring:message code="userId" /></c:set>
<c:set var="smUserNm"><spring:message code="userNm" /></c:set>
<c:set var="smStr"><spring:message code="str" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smAuth"><spring:message code="auth" /></c:set>
<c:set var="smOrg"><spring:message code="org" /></c:set>
<c:set var="smInq"><spring:message code="inq" /></c:set>

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
	
	$("#gridUserSrch").jqGrid({
		url : 'retrieveUserSrch',
		datatype : "json",
		mtype : 'POST',
		async: false,
		cache: false,
		colNames : [ '${smSeq}', '${smAuth}', '${smOrg}', '${smUserId}', '${smUserNm}' ],
			colModel : [ {name : 'records',	index : 'records',	width : 50,	align : 'center', sortable : true, editable : false, editoptions : { readonly : true,size : 10}},
			             {name : 'authNm', index : 'authNm',	width : 100, align : 'center', sortable : true, editable : false}, 
			             {name : 'orgNm', index : 'orgNm', width : 200, align : 'center', sortable : true, editable : false},
			             {name : 'userId', index : 'userId', width : 100, align : 'center',	sortable : true, editable : false, editoptions : { readonly : true,size : 10}},
			             {name : 'userNm', index : 'userNm', width : 200, align : 'left',	sortable : true, editable : false} ],
			jsonReader : {
				repeatitems : false
			},
			rowNum : 10,
			rowList : [],
			sortname : 'userId',
			viewrecords : true,
			sortorder : "asc",
			hidegrid : false,				
			shrinkToFit : true,
			//autowidth: true,
			width: '700',
			height : 230,
			pager : '#gridUserSrchPager',
			postData : {
				srchCompanyCd : $("#companyCd").val(),
				srchUserId : $("#userId").val(),
				srchUserNm : $("#userNm").val()
			},
			onCellSelect : function(rowid, iCol) {
				var list = $("#gridUserSrch").getRowData(rowid);
				popParam.userId     = list.userId;
				popParam.userNm     = list.userNm;
			},
			ondblClickRow : function(rowid, iRow, iCol, e) {
				var list = $("#gridUserSrch").getRowData(rowid);
				popParam.userId     = list.userId;
				popParam.userNm     = list.userNm;

				fncConfirm();
			},
			gridComplete : function(data) {			
				 jqGridEven('gridUserSrch');	
			}				
		});
});

/*******************
1. 기타 필수 스크립트
********************/

function fncUserPopupSearch() {
	$("#gridUserSrch").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserSrch").setGridParam({
		datatype : "json",
		postData : {
			srchUserId : $("#userId").val(),
			srchUserNm : $("#userNm").val()
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
	fncSetUser(popParam);
	fncDivPop1Close();
}

function fncCancel() {
	fncDivPop1Close();
}
</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<!-- <h2 class="r_popupTitle">${smUser}${smInq}</h2> -->
	<!-- //팝업 타이틀 -->
	
	<div class="r_popupCont">
	
		<!-- 조회조건 -->
    	<div class="r_search multiLine">
    		<input type='hidden' id='companyCd' name='companyCd' value="${companyCd}" />
			<table>
				<tr>
					<th>${smUserId}</th>
					<td>
						<input type='search' id='userId' name='userId' style='width: 115px;' /></td>
					<th>${smUserNm}</th>
					<td>
						<input type='search' id='userNm' name='userNm' style='width: 115px;' />
					</td>			
				</tr>
			</table>
			<span class="search">
				<button onclick="javascript:fncUserPopupSearch()">${smRetrieve}</button>
			</span>
		</div>
		<!-- //조회조건 -->
		
		<!-- 그리드 영역 -->
		<div class='r_grid'>
			<table id='gridUserSrch'><tr><td></td></tr>
			</table>
			<div id='gridUserSrchPager'></div>
		</div>
		<!-- //그리드 영역 -->
		
		<!-- 하단 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
		    	<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
			<span class="pageNormal">
				<button onclick="javascript:fncConfirm()">${smCnfm}</button>
			</span>
		</div>
		<!-- //하단 버튼 그룹 -->
		
	</div>
</div>
