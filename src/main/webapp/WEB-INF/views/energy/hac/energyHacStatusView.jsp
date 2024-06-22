<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smCurMonth"><spring:message code="curMonth"/></c:set>
<c:set var="smSameMonthLastYear"><spring:message code="sameMonthLastYear"/></c:set>
<c:set var="smHacElecUseStatus"><spring:message code="hacElecUseStatus"/></c:set>
<c:set var="smElec"><spring:message code="elec"/></c:set>
<c:set var="smStatus"><spring:message code="status"/></c:set>
<c:set var="smHacCount"><spring:message code="hacCount"/></c:set>
<c:set var="smAvgDailyUse"><spring:message code="avgDailyUse"/></c:set>
<c:set var="smAvgDailyUsePerStore"><spring:message code="avgDailyUsePerStore"/></c:set>
<c:set var="smAvgUsePerSpace"><spring:message code="avgUsePerSpace"/></c:set>
<c:set var="smMonthlyElecUse"><spring:message code="monthlyElecUse"/></c:set>
<c:set var="smOutdoorTemp"><spring:message code="outdoorTemp"/></c:set>
<c:set var="smIndoorTemp"><spring:message code="indoorTemp"/></c:set>
<c:set var="smMonthlyElecUse"><spring:message code="monthlyElecUse"/></c:set>
<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smUse"><spring:message code="use"/></c:set>

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	var tickArr1 = new Array();	//년월
	var tickArr2 = new Array();	//값

	$.ajax({
		async: false,
		url : "retrieveEnergyUsePerMonth",
		dataType : "json",
		success : function(data) {
			$.each(data, function(key, value) {
				if(key == 0) {												
					$.each(value, function(idx, val) {
						tickArr1.push(val);
					});
				}
				else if(key == 1) {
					$.each(value, function(idx, val) {
						tickArr2.push( Number(val) );
					});
				}
			});

			fncDrawHacUseChart(tickArr1, tickArr2);
		}
	});

	/*
	$('#chrtMonth').bind('jqplotDataClick',
		function(ev, seriesIndex, pointIndex, data){
			var target = '4202';
			var type   = '2';
			var mainId = '1';
			var param  = new Object();
			
			param.orgYyyymm = "20" + tickArr1[pointIndex].replace("'", "").replace(".", "");

			fncMove(target, param);
		}
	);
	*/
});



function fncDrawHacUseChart(ticks,values) {
	//월 사용전력량(kWh) : 냉난방
	$('#chrtMonth').html('');	
	$('#chrtMonth').highcharts('StockChart', {

		chart : {
			borderWidth : 0,
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 400,
			panning : true,
		},
		credits : {
			enabled : false
		},
		colors : ['#D80546', '#F5516C', '#F48AA1'],
		exporting : {
			enabled : false
		},
		loading : {
			style : {
				backgroundColor : 'silver'
			},
			labelStyle : {
				color : 'white'
			}
		},
		plotOptions : {
			column : {
				stacking : 'normal'
			}
		},
		rangeSelector : {
			inputDateFormat : "%Y-%m"
		},
		series : [ {
			type : 'column',
			data : values,
			name : '${smTempCtrl}${smUse}',
            pointStart: Date.UTC(Number(ticks[0].substr(0,4)), Number(ticks[0].substr(4,2))-1, 1),
			pointInterval : 1,
            pointIntervalUnit: 'month',			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' kWh',
				positioner : function() {
					return {
						x : 10,
						y : 40
					};
				},
			}			
		}],
		xAxis : {
			type : 'datetime',
			gridLineWidth : 1
		},
		yAxis : {
			gridLineDashStyle : 'dash',
			minorTickInterval : 'auto',
		},
	});	
}
</script>
<div id="loadingArea">
	<div class="r_hacStatus">
		<div class="r_halfGridContainer" style="height:250px;">
			<div class="r_grid r_halfGrid_l r_secondTbl">
				<div class="r_inputTblTitle">
					<h3>${smHacElecUseStatus}</h3>	
				</div>
				<table>
					<tr>
						<th>${smCollTime}</th>
						<c:set var="yyyymm" value="${sessionUserVo.sessionYyyyMm }" />
						<td class="r_gridInput r_last">${fn:substring(yyyymm, 0, 4)} - ${fn:substring(yyyymm, 4, 6)}</td>
					</tr>
					<tr>
						<th>${smHacCount}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhStatusVo.hacCount}" /></td>
					</tr>
					<tr>
						<th>${smAvgDailyUse}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhStatusVo.tempUse}"  />kWh</td>
					</tr>
					<tr>
						<th>${smAvgDailyUsePerStore}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${anhStatusVo.avgUse}" />kWh</td>
					</tr>
					<tr>
						<th>${smAvgUsePerSpace}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="1" value="${anhStatusVo.avgUsePerArea}" />kWh/㎡</td>
					</tr>
				</table>
			</div>
			
			<div class="r_grid r_halfGrid_r r_secondTbl">
				<div class="r_inputTblTitle">
					<h3>${smOutdoorTemp}</h3>	
				</div>
				<table>
					<tr>
						<th>${smCurMonth}</th>
						<td class="r_gridInput r_last">${anhTempVo.outTmTemp}</td>
					</tr>
					<tr>
						<th>${smSameMonthLastYear}</th>
						<td class="r_gridInput r_last">${anhTempVo.outOmTemp}</td>
					</tr>
				</table>
	
				<div class="r_inputTblTitle" style="margin-top:3px;">
					<h3>${smIndoorTemp}</h3>	
				</div>
				<table>
					<tr>
						<th>${smCurMonth}</th>
						<td class="r_gridInput r_last">${anhTempVo.inTmTemp}</td>
					</tr>
					<tr>
						<th>${smSameMonthLastYear}</th>
						<td class="r_gridInput r_last">${anhTempVo.inOmTemp}</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="r_inputTbl">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyElecUse} : ${smTempCtrl}</h3>
			</div>
		</div>
		<div id="chrtMonth"></div>
	</div>
</div>