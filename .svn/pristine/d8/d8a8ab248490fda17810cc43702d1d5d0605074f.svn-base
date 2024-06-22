<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smGhouseGasEmit"><spring:message code="ghouseGasEmit"/></c:set>
<c:set var="smMonthTotal"><spring:message code="monthTotal"/></c:set>
<c:set var="smGhouseGasCal"><spring:message code="ghouseGasCal"/></c:set>
<c:set var="smEmitCorel"><spring:message code="emitCorel"/></c:set>
<c:set var="smGhouseDegree"><spring:message code="ghouseDegree"/></c:set>

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	var tickArr0 = new Array();						// 월별
	var tickArr1 = new Array();	
	var totalGas = 0;
	
	$.ajax({
		async: false,
		url : "retrieveGhouseGasMonth",
		dataType : "json",
		success : function(data) {

			$.each(data, function(key, value) {
				if(key == 0) {
					$.each(value, function(idx, val) {
						var	tmp = val.toString().substr(0, 6);
						tickArr0.push(tmp);
					});
				}
				else if(key == 1) {
					$.each(value, function(idx, val) {						
						tickArr1.push( Number(val) );
					});
				}
			});
			
			for(var i = 0; i < tickArr1.length; i++) {
				var tmp = tickArr1[i];
				
				tickArr1[i] = tmp / 1000 * 0.4585;
				
				totalGas += tickArr1[i];
			}

			$("#totalGas").text( numberWithCommas( Math.round(totalGas) ) );					
			
			fncDrawGhouseGasEmitChart(tickArr0, tickArr1);
		}
	});
});


function fncDrawGhouseGasEmitChart(ticks,values) {
	
	Highcharts.setOptions({
		lang: {
				weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
				shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				rangeSelectorZoom : '',
				loading : "Loading...",
			}
		});

	$('#chrtGhouseGasEmit').highcharts('StockChart', {

		chart : {
			borderWidth : 0,
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 500,
			panning : true,
		},
		credits : {
			enabled : false
		},
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
			inputDateFormat : "%Y-%m",
			enabled: true,
			buttons: [{
				type: 'month',
				count: 3,
				text: '3달'
			}, {
				type: 'month',
				count: 6,
				text: '6달'
			}, {
				type: 'all',
				text: '전체'
			}],
			selected: 3,
			inputEnabled : false,
		},	
		series : [ {
			type : 'column', 
			name : '${smGhouseGasEmit}',
			data : values,
            pointStart: Date.UTC(Number(ticks[0].substr(0,4)), Number(ticks[0].substr(4,2))-1, 1),
			pointInterval : 1,
            pointIntervalUnit: 'month',			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : '  tCO₂eq',
				positioner : function() {
					return {
						x : 10,
						y : 40
					};
				},
			}			
		}],
		xAxis : {
			type: 'datetime',
			dateTimeLabelFormats: {
				second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%Y-%m-%d<br/>%H:%M',
				hour: '%Y-%m-%d<br/>%H:%M',
				day: '%d일일',
				week: '%Y<br/>%m-%d',
				month: '%Y-%m',
				year: '%Y'
			},
		},
		yAxis : {
			gridLineDashStyle : 'dash',
			minorTickInterval : 'auto',
		},
	});		
}
</script>

<div id="loadingArea">

	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<form id="saveForm" name="saveForm" method="post">
			<div class="r_gridTitle top_table">
				<h3>온실가스 배출 총량</h3>
			</div>
			<table>
				<colgroup>
			    	<col width="129" />
			    	<col width="*" />
			    </colgroup>
		    	<tbody>
		       		<tr>
		         		<th>온실가스 배출량</th>
		         		<td class="tleft">
		         		<span id="totalGas" style="font-weight:bold;"></span>
		         		tCO eq(12개월)</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->

	<!-- 그래프 영역 -->
	<div class="common_section">
		<div class="common_section_title">
			<h3 class="float_n">월별 온실가스 배출 현황</h3>
		</div>
		<div class="chrtGhouseGasEmit" id="chrtGhouseGasEmit">			
		</div>
	</div>
	<!-- //그래프 영역 -->
	
	<!-- 지시문 -->
	<div class="r_infoGroup">
	    <span class="r_infoTxt"><img src="/images/ico_info_new.png">온실가스 배출량 = Σ[전력사용량(MWh) * 배출계수(tGHG(CO2/CH4/N2O)/MWh) * 지구온난화지수]</span>
	    <span class="r_infoTxt"><img src="/images/ico_info_new.png">배출계수 : 해당연도의 국가 고유 전력배출계수, 전력거래소에서 발표(현재는 2011년 발표한 0.4585(tCO2/MWh기준))</span>
	    <span class="r_infoTxt r_last"><img src="/images/ico_info_new.png">지구온난화 지수 : CO2=1, CH4=21, N2O=310</span>
    </div>
	<!-- //지시문 -->
	
</div>