<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smEqmtStatus"><spring:message code="eqmtStatus"/></c:set>
<c:set var="smEqmt"><spring:message code="eqmt"/></c:set>
<c:set var="smStatus"><spring:message code="status"/></c:set>
<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smEqmtWorkingState"><spring:message code="eqmtWorkingState"/></c:set>
<c:set var="smDefrostCycle"><spring:message code="defrostCycle"/></c:set>
<c:set var="smDefrostTime"><spring:message code="defrostTime"/></c:set>
<c:set var="smTempC"><spring:message code="tempC"/></c:set>
<c:set var="smMonthlyAlarmRaiseCnt"><spring:message code="monthlyAlarmRaiseCnt"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smAlarmCnt"><spring:message code="alarmCnt"/></c:set>

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	//menuLoadImgShow("loadingArea");
	//menuLoadImgHide("loadingArea");
	
	
	alert('여기여기');
	
	var tickArr0 = new Array();
	var tickArr1 = new Array();
	var tickArr2 = new Array();
	var tickArr3 = new Array();

	$.ajax({
		async: false,
		url : "retrieveAlarmCntMonth",
		dataType : "json",
		success : function(data) {
			
			
			
			$.each(data, function(key, value) {
				if(key == 0){
					$.each(value, function(idx, val) {
						tickArr0.push(val);
					});
				}else if(key == 1){
					$.each(value, function(idx, val) {						
						tickArr1.push( Number(val) );
					});
				}else if(key == 2){
					$.each(value, function(idx, val) {						
						tickArr2.push( Number(val) );
					});
				}else if(key == 3){
					$.each(value, function(idx, val) {						
						tickArr3.push( Number(val) );
					});
				}
			});	

			fncDrawAlarmCntChart(tickArr0, tickArr1, tickArr2, tickArr3);
		}
	});
		
});


function fncDrawAlarmCntChart(ticks,rif,wic,osc) {
	
	$('#chrtAlarmCntMonth').html('');
	$('#chrtAlarmCntMonth').highcharts('StockChart', {

		chart : {
			borderWidth : 1,
			borderColor : "#E8E8E8",
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 400,
			panning : true,
		},
		credits : {
			enabled : false
		},
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'center'

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
			data : rif,
			name : 'RIF',
            pointStart: Date.UTC(Number(ticks[0].substr(0,4)), Number(ticks[0].substr(4,2))-1, 1),
			pointInterval : 1,
            pointIntervalUnit: 'month',			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' 회',
				positioner : function() {
					return {
						x : 10,
						y : 40
					};
				},
			}			
		},{
			type : 'column',
			data : wic,
			name : 'WIC',
            pointStart: Date.UTC(Number(ticks[0].substr(0,4)), Number(ticks[0].substr(4,2))-1, 1),
			pointInterval : 1,
            pointIntervalUnit: 'month',			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' 회',
				positioner : function() {
					return {
						x : 10,
						y : 40
					};
				},
			}			
		},{
			type : 'column',
			data : osc,
			name : 'OSC',
            pointStart: Date.UTC(Number(ticks[0].substr(0,4)), Number(ticks[0].substr(4,2))-1, 1),
			pointInterval : 1,
            pointIntervalUnit: 'month',			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' 회',
				positioner : function() {
					return {
						x : 10,
						y : 40
					};
				},
			}			
		}
		],
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
	<div class="r_halfGridContainer" style="height:250px;">
		<div class="r_grid r_halfGrid_l r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smEqmtStatus}</h3>	
			</div>
			<table>
				<tr>
					<th>${smCollTime}</th>
					<c:set var="yyyymm" value="${sessionUserVo.sessionYyyyMm }" />
					<td class="r_gridInput r_last">${fn:substring(yyyymm, 0, 4)}${smYear} ${fn:substring(yyyymm, 4, 6)}${smMonth}</td>
				</tr>
				<c:forEach items="${plantStatus}" var="plantStatus">
					<tr>
						<c:if test="${plantStatus.device == 'O' }">
							<th>OSC</th>
						</c:if>
						<c:if test="${plantStatus.device == 'W' }">
							<th>WIC</th>
						</c:if>
						<c:if test="${plantStatus.device == 'R' }">
							<th>RIF</th>
						</c:if>
						<c:if test="${plantStatus.device == 'C' }">
							<th>Comp.</th>
						</c:if>
						<c:if test="${plantStatus.device == 'I' }">
							<th>ICE</th>
						</c:if>
	          				<td class="r_gridInput r_last">${plantStatus.count}</td>
	           		</tr>
				</c:forEach>
				<c:if test="${plantStatus == '' }">
					<tr>
						<th>OSC</th>
						<td class="r_gridInput r_lasat">0</td>
					</tr>
					<tr>
						<th>WIC</th>
						<td class="r_gridInput r_lasat">0</td>					
					</tr>
					<tr>
						<th>RIF</th>
						<td class="r_gridInput r_lasat">0</td>
					</tr>
					<tr>
						<th>Comp.</th>
						<td class="r_gridInput r_lasat">0</td>
					</tr>					
				</c:if>						
			</table>
		</div>
		<div class="r_grid r_halfGrid_r r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smEqmtWorkingState}</h3>	
			</div>
			<table>
				<tr>
					<th>${smEqmt}</th>
					<th>${smDefrostCycle}</th>
					<th>${smDefrostTime}</th>
					<th>${smTempC}</th>
				</tr>
				<c:forEach items="${plantOperateUse}" var="plantOperateUse">
				<tr>
					<th class="r_gridInput r_lasat">${plantOperateUse.c_01}</th>						
					<td class="r_gridInput r_lasat">${plantOperateUse.c_02}</td>
					<td class="r_gridInput r_lasat">${plantOperateUse.c_04}</td>
					<td class="r_gridInput r_lasat">${plantOperateUse.c_03}</td>						
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="r_inputTbl">
		<div class="r_inputTblTitle">
			<h3>${smMonthlyAlarmRaiseCnt}</h3>
		</div>
	</div>
	<div class="r_hacChart">
		<div id="chrtAlarmCntMonth"></div>
	</div>
</div>