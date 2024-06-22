<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smElecUsePerSpace"><spring:message code="elecUsePerSpace"/></c:set>
<c:set var="smAvgElecDiff"><spring:message code="avgElecDiff"/></c:set>
<c:set var="smOutdoorTempC"><spring:message code="outdoorTempC"/></c:set>
<c:set var="smAvgTempDiff"><spring:message code="avgTempDiff"/></c:set>
<c:set var="smIndoorTempC"><spring:message code="indoorTempC"/></c:set>
<c:set var="smHacCount"><spring:message code="hacCount"/></c:set>
<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smIndoorTemp"><spring:message code="indoorTemp"/></c:set>
<c:set var="smOutdoorTemp"><spring:message code="outdoorTemp"/></c:set>
<c:set var="smGridDblClick"><spring:message code="gridDblClick"/></c:set>
<c:set var="smHacElecUsePerSpaceList"><spring:message code="hacElecUsePerSpaceList" /></c:set>
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
		url:'retrieveAnhAreaDistList',
		datatype: "json",
		mtype: 'POST',
		async: false,
		cache: false,
		postData: {
			orgStartVal: '${orgStartVal}',
			orgEndVal: '${orgEndVal}',
			orgYyyymm: '${orgYyyymm}'
		},
		colNames:['', '${smStrCd}', '${smStrNm}', '${smElecUsePerSpace}', '${smAvgElecDiff}', '${smOutdoorTempC}', '${smAvgTempDiff}', '${smIndoorTempC}', '${smAvgTempDiff}', '${smHacCount}'],
		colModel:[
			{name:'strCd',index:'strCd', width:0, align:'center', hidden: true},
			{name:'viewStrCd',index:'viewStrCd', width:70, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'strNm',index:'strNm', width:90, align:'center', sortable:true, editable:false},
			{name:'temp',index:'temp', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'tempGap',index:'tempGap', width:70, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'forecastTemp',index:'forecastTemp', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'forecastGap',index:'forecastGap', width:90, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'senseTemp',index:'senseTemp', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'senseGap',index:'senseGap', width:90, align:'right', formatter:gapFormatter, sortable:true, editable:false},
			{name:'hacCount',index:'hacCount', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:0}, sortable:true, editable:false}			
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

	function gapFormatter(cellvalue, options, rowObject) {
		var rslt      = 0;
		var formatted = "";
		
		if( options.pos == 4 ) { // 냉난방전력량
			rslt = Math.round( ( parseFloat("${anhAreaDistVo.average}") - cellvalue ) * 10 ) / 10;
		}
		else if( options.pos == 6 ) { // 실외온도
			rslt = Math.round( ( parseFloat("${anhAreaDistVo.avgForecastTemp}") - cellvalue ) * 10 ) / 10; 
		}
		else if( options.pos == 8 ) { // 실내온도
			rslt = Math.round( ( parseFloat("${anhAreaDistVo.avgSenseTemp}") - cellvalue ) * 10 ) / 10;	
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
	
	$("#gridUsedArea").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		groupHeaders: [
		               {startColumnName: 'temp', numberOfColumns: 2, titleText: '${smTempCtrl}'},
		               {startColumnName: 'forecastTemp', numberOfColumns: 2, titleText: '${smOutdoorTemp}'},
		               {startColumnName: 'senseTemp', numberOfColumns: 2, titleText: '${smIndoorTemp}'}
		               ]
	});			
});

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
		<h1 class="r_popupTitle">${smHacElecUsePerSpaceList}</h1>	  
		<div class="r_popupCont">
			<div class="r_search multiLine">
	    		<input type='hidden' id='companyCd' name='companyCd' value="" />  
				<table>
					<tr>
						<th>${smCollTime}</th>
						<td>
							<c:set var="yyyymm" value="${anhAreaDistVo.yyyymm}" />
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
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhAreaDistVo.average}" /></td>
						<th>${smMax}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhAreaDistVo.max}" /></td>
						<th>${smMin}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhAreaDistVo.min}" /></td>
						<th>${smStdDev}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhAreaDistVo.stdev}" /></td>
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
	<input id="viewStrCd" name="viewStrCd" type="hidden" value="" />
	<input id="strCd" name="strCd" type="hidden" value="" />
	<input id="strNm" name="strNm" type="hidden" value="" />
</div>