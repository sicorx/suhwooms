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
	
	$('#dialog-confirm-2nd').css('overflow', 'hidden');
	
	$("#companyCd2depth").val('${companyCd}');
	
	$("#gridStoreSrch2depth").jqGrid({
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
			pager : '#gridStoreSrchPager2depth',
			postData : {
				srchCompanyCd : $("#companyCd").val(),
				srchViewStrCd : $("#viewStrCd").val(),
				srchStrNm : $("#strNm").val()
			},
			onCellSelect : function(rowid, iCol) {
				var list = $("#gridStoreSrch2depth").getRowData(rowid);
				popParam.strCd     = list.strCd;
				popParam.strNm     = list.strNm;
				popParam.viewStrCd = list.viewStrCd;
			},
			ondblClickRow : function(rowid, iRow, iCol, e) {
				var list = $("#gridStoreSrch2depth").getRowData(rowid);
				popParam.strCd     = list.strCd;
				popParam.strNm     = list.strNm;
				popParam.viewStrCd = list.viewStrCd;

				fncConfirm2depth();
			},
			gridComplete : function(data) {
				 jqGridEven('gridStoreSrch2depth');	
			}				
		}).trigger("reloadGrid");		
	
});


/*******************
1. 기타 필수 스크립트
********************/

function fncStrPopupSearch2depth() {
	$("#gridStoreSrch2depth").setGridParam({
		datatype : "json",
		postData : {
			srchViewStrCd : $("#viewStrCd2depth").val(),
			srchStrNm : $("#strNm2depth").val()
		}
	}).trigger("reloadGrid");	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncConfirm2depth() {
	fncSetStore2depth(popParam);
	fncDivPop2Close();
}

function fncCancel2depth() {
	fncDivPop2Close();
}
</script>
<div class="r_popup">
	<h1 class="r_popupTitle">${smStrInq}</h1>	  
	<div class="r_popupCont">
		<div class="r_search multiLine">
    		<input type='hidden' id='companyCd2depth' name='companyCd2depth' value="" />  
			<table>
				<tr>
					<th>${smStrCd}</th>
					<td>
						<input type='search' id='viewStrCd2depth' name='viewStrCd2depth' style='width: 115px;' />
					</td>
					<th>${smStrNm}</th>	
					<td>
						<input type='search' id='strNm2depth' name='strNm2depth' style='width: 115px;' />
					</td>
				</tr>
			</table>
			<span class="search">
				<button onclick="javascript:fncStrPopupSearch2depth()">${smRetrieve}</button>
			</span>
		</div>
		<div class='r_grid'>
			<table id='gridStoreSrch2depth'>
				<tr><td></td>	</tr>
			</table>
			<div id='gridStoreSrchPager2depth'></div>
		</div>
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel2depth()">${smClos}</button>
			</span>
			<span class="pageNormal">
				<button onclick="javascript:fncConfirm2depth()">${smCnfm}</button>
			</span>
		</div>
	</div>
</div>
