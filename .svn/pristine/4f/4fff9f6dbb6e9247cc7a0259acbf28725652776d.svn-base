<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smLightElecUseStatus"><spring:message code="lightElecUseStatus"/></c:set>
<c:set var="smWeatherStatus"><spring:message code="weatherStatus"/></c:set>
<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smDay"><spring:message code="day"/></c:set>
<c:set var="smElec"><spring:message code="elec"/></c:set>
<c:set var="smTotal"><spring:message code="total"/></c:set>
<c:set var="smStatus"><spring:message code="status"/></c:set>
<c:set var="smStrCount"><spring:message code="strCount"/></c:set>
<c:set var="smThisMonthElecUse"><spring:message code="thisMonthElecUse"/></c:set>
<c:set var="smAvgUsePerStore"><spring:message code="avgUsePerStore"/></c:set>
<c:set var="smAvgUsePerSpace"><spring:message code="avgUsePerSpace"/></c:set>
<c:set var="smWeather"><spring:message code="weather"/></c:set>
<c:set var="smMonthlyElecUse"><spring:message code="monthlyElecUse"/></c:set>
<c:set var="smLight"><spring:message code="light"/></c:set>
<c:set var="smUse"><spring:message code="use"/></c:set>

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/

//날씨 현황, 월 사용전력량
$(document).ready(function(){

	var tickArr0 = new Array();
	var tickArr1 = new Array();
	
	$.ajax({
		async: false,
		url : "retrieveUseMonthLight",
		dataType : "json",
		success : function(data) {
			$.each(data, function(key, value) {
				if(key == 0) {
					$.each(value, function(idx, val) {
						tickArr0.push(val);
					});
				}
				else if(key == 1) {
					$.each(value, function(idx, val) {						
						tickArr1.push( Number(val) );
					});
				}
			});
			
			fncDrawLightUseChart(tickArr0,tickArr1);
		}
	});
	/*
	$('#chrtUseMonthLight').bind('jqplotDataClick',
		function(ev, seriesIndex, pointIndex, data){
			var target = '4302';
			var type   = '2';
			var mainId = '1';

			fncMove(target, null);
		}
	);
	*/
});


function fncDrawLightUseChart(ticks,values) {

	$('#chrtUseMonthLight').highcharts('StockChart', {

		chart : {
			borderWidth : 0,
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 300,
			panning : true,
		},
		credits : {
			enabled : false
		},
		colors : ['#F5516C', '#D80546', '#F48AA1'],
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
		rangeSelector : {
			inputDateFormat : "%Y-%m"
		},
		series : [ {
			type : 'column',
			name : '${smLight}${smUse}',
			data : values,
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
		<div class="r_halfGridContainer" style="height:300px;">
			<div class="r_grid r_halfGrid_l r_secondTbl">
				<div class="r_inputTblTitle">
					<h3>${smLightElecUseStatus}</h3>	
				</div>
				<table>
					<tr>
						<th>${smCollTime}</th>
						<c:set var="yyyymm" value="${sessionUserVo.sessionYyyyMm }" />
						<td class="r_gridInput r_last">${fn:substring(yyyymm, 0, 4)} - ${fn:substring(yyyymm, 4, 6)}</td>
					</tr>
					<tr>
						<th>${smStrCount}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epLightStatusVo.storeCount}" /></td>
					</tr>
					<tr>
						<th>${smThisMonthElecUse}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epLightStatusVo.lightUse}"  />kWh</td>
					</tr>
					<tr>
						<th>${smAvgUsePerStore}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${epLightStatusVo.avgUse}" />kWh</td>
					</tr>
					<tr>
						<th>${smAvgUsePerSpace}</th>
						<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="1" value="${epLightStatusVo.avgUsePerArea}" />kWh/㎡</td>
					</tr>
				</table>
			</div>
			
			<div class="r_grid r_halfGrid_r r_secondTbl">
				<div class="r_inputTblTitle">
					<h3>${smWeatherStatus}</h3>	
				</div>
				<table>
					<tr>
						<th>${smWeather}</th>
						<c:forEach items="${epWeatherStatus}" var="epWeather">
						<c:set var="yyyymm" value="${epWeather.yyyymm}" />
							<td class="r_gridInput r_last">'${fn:substring(yyyymm, 2, 4)}.${fn:substring(yyyymm, 4, 6)}</td>
						</c:forEach>
					</tr>
					<tr>
						<th><img src="/images/sunny.png" width="40px" height="40px" /></th>
						<c:forEach items="${epWeatherStatus}" var="epWeather">
						<c:set var="sunny" value="${epWeather.sunnyCount}" />
						<c:set var="row" value="${epWeather.rowCount}" />
							<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${(sunny/row)*30}" /> ${smDay}</td>
						</c:forEach>			
					</tr>
					<tr>
						<th><img src="/images/cloudy.png" width="40px" height="40px" /></th>				
						<c:forEach items="${epWeatherStatus}" var="epWeather">
						<c:set var="cloudy" value="${epWeather.cloudyCount}" />
						<c:set var="row" value="${epWeather.rowCount}" />
							<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${(cloudy/row)*30}" /> ${smDay}</td>
						</c:forEach>			
					</tr>
					<tr>
						<th><img src="/images/rainsnow.png" width="40px" height="40px" /></th>
						<c:forEach items="${epWeatherStatus}" var="epWeather">
						<c:set var="sunny" value="${epWeather.sunnyCount}" />
						<c:set var="cloudy" value="${epWeather.cloudyCount}" />
						<c:set var="row" value="${epWeather.rowCount}" />
							<td class="r_gridInput r_last"><fmt:formatNumber type="number" maxFractionDigits="0" value="${((row-cloudy-sunny)/row)*30}" /> ${smDay}</td>
						</c:forEach>							
					</tr>
				</table>
			</div>
		</div>
		
		<div class="r_inputTbl">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyElecUse} : ${smLight}</h3>
			</div>
		</div>
		<div id="chrtUseMonthLight"></div>
	</div>
</div>