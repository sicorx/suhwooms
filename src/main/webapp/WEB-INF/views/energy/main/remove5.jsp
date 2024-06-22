<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smElecUsePerSpace"><spring:message code="elecUsePerSpace"/></c:set>
<c:set var="smAvgElecDiff"><spring:message code="avgElecDiff"/></c:set>
<c:set var="smTotal"><spring:message code="total"/></c:set>
<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smLight"><spring:message code="light"/></c:set>
<c:set var="smElecUsePerSpaceList"><spring:message code="elecUsePerSpaceList"/></c:set>
<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smAvg"><spring:message code="avg"/></c:set>
<c:set var="smMax"><spring:message code="max"/></c:set>
<c:set var="smMin"><spring:message code="min"/></c:set>
<c:set var="smStdDev"><spring:message code="stdDev"/></c:set>
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
	
	$("#gridUsedArea").jqGrid({
		
		url:'retrieveUseAreaList',
		datatype: "json",
		async: false,
		cache: false,
		postData: {
			startVal: '${startVal}',
			endVal: '${endVal}',
			orgYyyymm: '${orgYyyymm}'
		},
		mtype: 'POST',
		colNames:['', '${smStrCd}', '${smStrNm}', '${smElecUsePerSpace}', '${smAvgElecDiff}', '${smElecUsePerSpace}', '${smAvgElecDiff}', '${smElecUsePerSpace}', '${smAvgElecDiff}'],
		colModel:[
			{name:'strCd',index:'strCd', width:0, align:'center', hidden: true},			
			{name:'viewStrCd',index:'viewStrCd', width:75, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'strNm',index:'strNm', width:90, align:'left', sortable:true, editable:false},
			{name:'total',index:'total', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'totalGap',index:'totalGap', width:75, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'temp',index:'temp', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'tempGap',index:'tempGap', width:75, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'light',index:'light', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'lightGap',index:'lightGap', width:75, align:'right', formatter:gapFormatter, sortable:true, editable:false}
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
		rowNum:13,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		//autowidth: true,
		width: '850',
		shrinkToFit: true,
		height: '250'
	}).trigger("reloadGrid");
	
	//jqGridResize('gridUsedArea');
	$("#gridUsedArea").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		groupHeaders: [
		               {startColumnName: 'total', numberOfColumns: 2, titleText: '${smTotal}'},
		               {startColumnName: 'temp', numberOfColumns: 2, titleText: '${smTempCtrl}'},
		               {startColumnName: 'light', numberOfColumns: 2, titleText: '${smLight}'}
		               ]
	});
	
});

function gapFormatter(cellvalue, options, rowObject) {
	var rslt      = 0.0;
	var formatted = "";
	
	if( options.pos == 4 ) { // 전체전력량
		rslt = Math.round( ( parseFloat("${epUsedAreaVo.average}") - cellvalue ) * 10 ) / 10;
	}
	else if( options.pos == 6 ) { // 냉난방전력량
		rslt = Math.round( ( parseFloat("${epUsedAreaVo.tempAvg}") - cellvalue ) * 10 ) / 10; 
	}
	else if( options.pos == 8 ) { // 조명전력량
		rslt = Math.round( ( parseFloat("${epUsedAreaVo.lightAvg}") - cellvalue ) * 10 ) / 10;
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

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncCancel() {
	$("#gridUsedArea").clearGridData();
	fncDivPop1Close();
	
}
</script>
<div id="loadingArea">
	<div class="r_popup">
		<h1 class="r_popupTitle">${smElecUsePerSpaceList}</h1>	  
		<div class="r_popupCont">
			<div class="r_search multiLine">
	    		<input type='hidden' id='companyCd' name='companyCd' value="" />  
				<table>
					<tr>
						<th>${smCollTime}</th>
						<td>
							<c:set var="yyyymm" value="${epUsedAreaVo.yyyymm}" />
							<input type='text' class='r_disable' style='width: 140px;' value='${fn:substring(yyyymm, 0, 4)}${smYear} ${fn:substring(yyyymm, 4, 6)}${smMonth}' readonly />
						</td>
					</tr>
				</table>
			</div>
			<div class='r_grid'>
				<table id="gridUsedArea"><tr><td></td></tr></table>
				<table>
					<tr>
						<th>${smAvg}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epUsedAreaVo.average}" /></td>
						<th>${smMax}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epUsedAreaVo.max}" /></td>
						<th>${smMin}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epUsedAreaVo.min}" /></td>
						<th>${smStdDev}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epUsedAreaVo.stdev}" /></td>
					</tr>
				</table>
			</div>
			<div class="r_pageBtnWrapper">
				<span class="pageNormal">
					<button onclick="javascript:fncCancel()">${smClos}</button>
				</span>
			</div>
		</div>
	</div>
	<input id="tempAvg" type="hidden" class="content" value="${epUsedAreaVo.tempAvg}" readonly />
	<input id="lightAvg" type="hidden" class="content" value="${epUsedAreaVo.lightAvg}" readonly />
	<input id="viewStrCd" name="viewStrCd" type="hidden" value="" />
	<input id="strCd" name="strCd" type="hidden" value="" />
	<input id="strNm" name="strNm" type="hidden" value="" />
</div>