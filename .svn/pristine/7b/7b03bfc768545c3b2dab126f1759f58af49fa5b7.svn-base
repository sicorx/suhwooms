<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smElecUsePerSpace"><spring:message code="elecUsePerSpace"/></c:set>
<c:set var="smElecUsePerSpaceK"><spring:message code="elecUsePerSpaceK"/></c:set>
<c:set var="smAvgElecDiff"><spring:message code="avgElecDiff"/></c:set>
<c:set var="smAvgElecDiffK"><spring:message code="avgElecDiffK"/></c:set>
<c:set var="smContElec"><spring:message code="contElec"/></c:set>
<c:set var="smTotal"><spring:message code="total"/></c:set>
<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smLight"><spring:message code="light"/></c:set>
<c:set var="smContElecPerSpaceList"><spring:message code="contElecPerSpaceList"/></c:set>
<c:set var="smPeakStrList"><spring:message code="peakStrList"/></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	$("#gridContExcessList").jqGrid({
		url:'retrieveContExcessList',
		datatype: "json",
		mtype: 'POST',
		postData: {
			orgYyyymm : '${orgYyyymm}',
			sVal : '${orgSval}',
			eVal : '${orgEval}'
		},
		colNames:['', '${smStrCd}', '${smStrNm}', '${smElecUsePerSpace}', '${smAvgElecDiff}', 
			          '${smElecUsePerSpaceK}','${smAvgElecDiffK}',
			          '${smElecUsePerSpaceK}','${smAvgElecDiffK}',
			          '${smElecUsePerSpaceK}','${smAvgElecDiffK}', ''],
		colModel:[
			{name:'strCd',index:'strCd', width:0, align:'center', hidden: true},
			{name:'viewStrCd',index:'viewStrCd', width:70, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'strNm',index:'strNm', width:90, align:'left', sortable:true, editable:false},
			{name:'cont',index:'cont', width:80, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'avgCont',index:'avgCont', width:80, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'total',index:'total', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'avgTotal',index:'avgTotal', width:90, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'temp',index:'temp', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'avgTemp',index:'avgTemp', width:90, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'light',index:'light', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'avgLight',index:'avgLight', width:90, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'yyyymm',index:'yyyymm', width:0, align:'center', hidden: true}
		],
		jsonReader : {
		     repeatitems:false
		},
		formatter : {
	  		number : {
				decimalSeparator: ".",
				thousandsSeparator: ",", 
				decimalPlaces: 1,
				defaultValue: '0'
			}
		},
		rowNum:20,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		//autowidth: true,
		width: 900,
		shrinkToFit: true,
		height: '300'

	});

	$("#gridContExcessList").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		groupHeaders: [
			{startColumnName: 'cont', numberOfColumns: 2, titleText: '${smContElec}'},
		    {startColumnName: 'total', numberOfColumns: 2, titleText: '${smTotal}'},
		    {startColumnName: 'temp', numberOfColumns: 2, titleText: '${smTempCtrl}'},
		    {startColumnName: 'light', numberOfColumns: 2, titleText: '${smLight}'}
		]
	});

	function gapFormatter(cellvalue, options, rowObject) {
		var rslt      = 0.0;
		var formatted = "";
		
		if( options.pos == 4 ) { // 계약전력
			rslt = Math.round( ( parseFloat("${epContOverStoreVo.avgCont}") - cellvalue ) * 10 ) / 10;
		}
		else if( options.pos == 6 ) { // 전체전력량
			rslt = Math.round( ( parseFloat("${epContOverStoreVo.avgTotal}") - cellvalue ) * 10 ) / 10; 
		}
		else if( options.pos == 8 ) { // 냉난방전력량
			rslt = Math.round( ( parseFloat("${epContOverStoreVo.avgTemp}") - cellvalue ) * 10 ) / 10;	
		}
		else if( options.pos == 10 ) { // 조명전력량
			rslt = Math.round( ( parseFloat("${epContOverStoreVo.avgLight}") - cellvalue ) * 10 ) / 10;	
		}
		
		if( rslt > 0 ) {
			formatted = "▼ " + Math.abs( rslt );
		}
		else if( rslt < 0 ) {
			formatted = "▲ " + Math.abs( rslt );
		}
		else {
			formatted = Math.abs( rslt );
		}
		
		return formatted;
	}
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncCancel() {
	$("#gridContExcessList").clearGridData();
	fncDivPop1Close();
}
</script>
<div id="loadingArea">
	<div class="r_popup">
		<c:if test="${orgSval != '' && orgSval != null }">
			<h1 class="r_popupTitle">${smContElecPerSpaceList}</h1>
		</c:if>
		<c:if test="${orgSval == '' || orgSval == null }">
			<h1 class="r_popupTitle">${smPeakStrList}</h1>
		</c:if>	
		<div class="r_popupCont">
			<div class="r_search multiLine">
	    		<input type='hidden' id='companyCd' name='companyCd' value="" />  
				<table>
					<tr>
						<th>${smCollTime}</th>
						<td>
							<c:set var="yyyymm" value="${epContOverStoreVo.yyyymm}" />
							<input type='text' class='r_disable' style='width: 140px;' value='${fn:substring(yyyymm, 0, 4)}${smYear} ${fn:substring(yyyymm, 4, 6)}${smMonth}' readonly />
						</td>
					</tr>
				</table>
			</div>
			<div class='r_grid'>
				<table id="gridContExcessList"><tr><td></td></tr></table>
				<div id="gridContExcessListPager"></div>
			</div>
			<div class="r_pageBtnWrapper">
				<span class="pageNormal">
					<button onclick="javascript:fncCancel()">${smClos}</button>
				</span>
			</div>
		</div>
	</div>
</div>