<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smElecStatus"><spring:message code="elecStatus"/></c:set>
<c:set var="smElec"><spring:message code="elec"/></c:set>
<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smTotal"><spring:message code="total"/></c:set>
<c:set var="smStatus"><spring:message code="status"/></c:set>
<c:set var="smStrCount"><spring:message code="strCount"/></c:set>
<c:set var="smAvgDailyUse"><spring:message code="avgDailyUse"/></c:set>
<c:set var="smAvgDailyUsePerStore"><spring:message code="avgDailyUsePerStore"/></c:set>
<c:set var="smAvgUsePerSpace"><spring:message code="avgUsePerSpace"/></c:set>
<c:set var="smElecUseRatio"><spring:message code="elecUseRatio"/></c:set>
<c:set var="smPredict"><spring:message code="predict"/></c:set>
<c:set var="smActual"><spring:message code="actual"/></c:set>
<c:set var="smMonthlyElecUse"><spring:message code="monthlyElecUse"/></c:set>
<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smLight"><spring:message code="light"/></c:set>
<c:set var="smEtc"><spring:message code="etc"/></c:set>

<script src="https://code.highcharts.com/highcharts.js"></script>

<script type="text/javascript">



/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	
	
	
	
	// 미조치 알람 내역 ( 전체, 오늘, 3시간이내 ) 조치 알람 내역 ( 전체, 오늘 ) 개수
	$.ajax({
		async: false,
		url : "retrieveAlarmResultCntList",
		dataType : "json",
		success : function(data) {
			
			//alert( data );
			
			$('#asNoAllCnt').text( data.asNoAllCnt );
			$('#asNoDayCnt').text( data.asNoDayCnt );
			$('#asNoHourCnt').text( data.asNoHourCnt );
			
			$('#asYesAllCnt').text( data.asYesAllCnt );			
			$('#asYesDayCnt').text( data.asYesDayCnt );
			
			
		}
	});
	
	
	
	fncWatageToCo2Chart();	// CO2 방충량
	fncUseWatage();			// 어제/오늘 사용량
	
	
	
	var tickArr0 = new Array();
	var tickArr1 = new Array();
	var tickArr2 = new Array();
	var tickArr3 = new Array();
		
	
	$.ajax({
		async: false,
		url : "retrieveUseMonth",
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

			fncDrawMainUseChart(tickArr0, tickArr1, tickArr2, tickArr3);
			
			fncPieChart(tickArr1, tickArr2, tickArr3 );
			
		}
	});

	
	
});


function fncDrawMainUseChart(ticks,hac,light,etc) {
	
	
	Highcharts.setOptions({
		lang: {
			weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			}
		});
	
	$('#chrtUseMonth').highcharts('StockChart', {

		chart : {
			borderWidth : 0,
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 420,
			panning : true,
		},
		credits : {
			enabled : false
		},
		colors : ['#D80546', '#F5516C', '#F48AA1'],
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
			data : hac,
			name : '${smTempCtrl}',
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
		},{
			type : 'column',
			data : light,
			name : '${smLight}',
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
		},{
			type : 'column',
			data : etc,
			name : '${smEtc}',
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
		}
		],
		xAxis : {
			type : 'datetime',
			gridLineWidth : 1,
			dateTimeLabelFormats : {
				second : '%H:%M',
				minute : '%m/%d<br>%H:%M',
				hour : '%m/%d<br>%H:%M',
				day : '%m/%d<br>%H:%M',
				week : '%m/%d<br>%H:%M',
				month : '%Y년<br>%m월',
				year : '%Y년<br>%m월'
			},
		},
		yAxis : {
			gridLineDashStyle : 'dash',
			minorTickInterval : 'auto',
		},
	});	
}


function fncUseWatage()
{
	// 어제 / 오늘 전력사용량
	var yesterDayWatage  = Number( '${yesterDayWatage}' ) / 1000; 	// 어제
	var toDayWatage = Number( '${toDayWatage}' ) / 1000; 			// 오늘
	
	
	
	$.jqplot('chrtDashBoardWatage', [[toDayWatage], [yesterDayWatage]], {
		seriesColors: ['#D80546', '#8C98A4', ],
	    seriesDefaults:{
	    	renderer:$.jqplot.BarRenderer,
	    	shadowAngle: 135,
	    	rendererOptions: {
                barDirection: 'horizontal' 
            },
            pointLabels:{show: true, location: 's', formatString: "%'.2d"}
        },
	    series: [
	 	        {
		        	label: '오늘',
		        	fillAlpha: 0.2
		        },
		        {
		        	label: '어제',
		        	fillAlpha: 0.2
		        }
	    ],
	    legend: {
	    	renderer: $.jqplot.EnhancedLegendRenderer,
	    	rendererOptions: {
	    		numberRows: 2
	    	},
	        show: true,
	        location: 'ne',
	        placement: 'outsideGrid'
	    },
	    grid: {
	    	drawGridLines: true,
	    	shadow: false,
	    	background: 'rgba(255, 255, 255, 1)',
	    	borderWidth: 0
	    },
		axes: {
			
			xaxis: {
				tickRenderer: $.jqplot.CanvasAxisTickRenderer,
				tickOptions: {
					formatString: "%'d kW",
					angle: -30,
					markSize: 3
				}
			},			
 			yaxis: {
 				max: 2, 
				min: 0,
				tickOptions: {
					show: false,
					showGridline: false
				}
			}
		}
	});
	
}


function fncPieChart(hac, light, etc )
{
	/*******
	pie chart	
	********/
	var hacWatage 	= Number( (hac[hac.length-1] / 1000).toFixed(1) );
	var lightWatage = Number( (light[light.length-1] / 1000).toFixed(1) );
	var etcWatage 	= Number( (etc[etc.length-1] / 1000).toFixed(1) );
	
	

	
	// Build the chart
    $('#chrtPie').highcharts({
    	chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        credits : {
			enabled : false
		},
        exporting : {
			enabled : false
		},
        title: {
            text: ''
        },
        tooltip: {
        	pointFormat: '{series.name}: <b>  {point.y} ({point.percentage:.1f}%)</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    },
                    connectorColor: 'silver'
                }
            }
        },
        series: [{
            name: '전력사용량',
            data: [                
                { name: '냉난방', y: hacWatage },
                { name: '조명', y: lightWatage },
                { name: '기타', y: etcWatage }
            ]
        }]


    });
	
}


function fncWatageToCo2Chart()
{
	// 어제 / 오늘 전력사용량
	var bYesterDayWatageCo2  = Number( '${bYesterDayWatage}' ) / 1000 / 1000 * 0.4585; 	// 어제
	var yesterDayWatageCo2  = Number( '${yesterDayWatage}' ) / 1000 / 1000 * 0.4585; 	// 어제
	var toDayWatageCo2 = Number( '${toDayWatage}' ) / 1000 / 1000 * 0.4585; 			// 오늘
		
	bYesterDayWatageCo2 = Number( bYesterDayWatageCo2.toFixed(1) );
	yesterDayWatageCo2 = Number( yesterDayWatageCo2.toFixed(1) );
	toDayWatageCo2 = Number( toDayWatageCo2.toFixed(1) );
	
	
	
	$('#chrtWatageToCo2').highcharts({
        chart: {
            type: 'areaspline'
        },
        exporting : {
			enabled : false
		},
        title: {
            text: ''
        },       
        xAxis: {
            categories: [
                '2일전',
                '어제',
                '오늘'                
            ]            
        },
        yAxis: {
        	title: {
                text: ''
            }
        },
        tooltip: {
            shared: true,
            valueSuffix: ' tCO₂eq'
        },
        credits: {
            enabled: false
        },
        plotOptions: {
            areaspline: {
                fillOpacity: 0.5
            },                  
            series: {
                lineColor: '#FF0000',
                fillColor: {
                    linearGradient: [0, 0, 0, 100],
                    stops: [
                        [0, Highcharts.getOptions().colors[5]],
                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                dataLabels: {
                    align: 'left',
                    enabled: true
                }
            }
            
        },
        series: [{     
        	name : 'CO2 방출량',
            data: [bYesterDayWatageCo2, yesterDayWatageCo2, toDayWatageCo2],
            color: '#FF0000'
        }
        ]
    });

}


function fncAlarmResultList(asResultFlag, range)
{
	var args = new Array();
	args.push(asResultFlag);
	args.push(range);

	
	fn_divPop("energyDashBoardList", "팝업", 950, 750, args );
}

</script>


<style>

.boxBtn
{
	 box-shadow:5px 5px black;	  
	 color:white; 
	 border-radius:2px;
	 width:130px; 
	 height:140px;
	 text-align:center;
	 padding:10px;
}

</style>

<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="asResultFlag"> 
    <input type="hidden" id="popArg2" name="range">
</form>



<div id="loadingArea">
	<div class="r_mainStatus">
		<div class="r_halfGridContainer" style="height:280px;">
			
			<div style="float:left; width:20%;">
				<div class="r_inputTbl" >
						<div class="r_inputTblTitle">
						<h3>전력 사용율</h3>	
					</div>
					
					
					<div id="chrtPie" style="height:220px;">
					</div>		
									
				</div>
			</div>
			
			<div style="float:right; width:23%;margin-left:10px;">			
				<div class="r_inputTbl" >
						<div class="r_inputTblTitle">
						<h3>피크 알람 발생 매장</h3>	
					</div>
					
					
					
					<div style="display:inline-block;width:100%;height:220px;text-align:center;vertical-align:middle;border:0px solid;">
							<div style="margin-top:10px;">
								<label style="font-weight:bold; font-size:1.5em;">피크 내역</label>							
							</div>
							<div>
								<div style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(255,187,0,1);">
										<span style="font-size:1.2em;">어제</span>
										<br>
										<span style="font-size:5em;">-</span>
									</div>
								</div>
								<div style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(242,150,97,1);">
										<span style="font-size:1.2em;">오늘</span>
										<br>
										<span style="font-size:5em;">-</span>
									</div>
								</div>								
							</div>
								
					</div>				
				</div>
			</div>
			
			<div style="float:right; width:55%;">			
				<div class="r_inputTbl" >
						<div class="r_inputTblTitle">
							
						<h3>시설물 알람 발생 매장</h3>	
					</div>
					
					<div style="height:220px;border:0px solid;">
						<div style="display:inline-block;width:58%;height:220px;text-align:center;vertical-align:middle;border:0px solid">						
							<div style="margin-top:10px;">
								<label style="font-weight:bold; font-size:1.5em;">미조치 알람 내역</label>							
							</div>
							<div>
								<div onClick="javascript:fncAlarmResultList(0,0);" style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(112,112,122,1);">
										<span style="font-size:1.2em;">전체</span>
										<br>
										<span id="asNoAllCnt" style="font-size:5em;">-</span>
									</div>
								</div>
								<div onClick="javascript:fncAlarmResultList(0,1);" style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(71,76,80,1);">
										<span style="font-size:1.2em;">오늘</span>
										<br>
										<span id="asNoDayCnt" style="font-size:5em;">-</span>
									</div>
								</div>
								<div onClick="javascript:fncAlarmResultList(0,2);" style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(74,140,174,1);">
										<span style="font-size:1.2em;">3시간 이내</span>
										<br>
										<span id="asNoHourCnt" style="font-size:5em;">-</span>
									</div>
								</div>
							</div>							
						</div>
						
						
						<!-- 조치 완료 내역 -->
						<div style="display:inline-block;width:0.3%;height:220px;background-color:rgba(189,189,189,1);text-align:center;vertical-align:middle;">						
						</div>
							
						<div style="display:inline-block;width:40%;height:220px;text-align:center;vertical-align:middle;">
							<div style="margin-top:10px;">
								<label style="font-weight:bold; font-size:1.5em;">조치 완료 내역</label>							
							</div>
							<div>
								<div onClick="javascript:fncAlarmResultList(1,0);" style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(112,112,122,1);">
										<span style="font-size:1.2em;">전체</span>
										<br>										
										<span id="asYesAllCnt" style="font-size:5em;">-</span>
									</div>
								</div>
								<div onClick="javascript:fncAlarmResultList(1,1);" style="display:inline-block;padding:10px;cursor:pointer;">
									<div class="boxBtn" style="background-color:rgba(71,76,80,1);">
										<span style="font-size:1.2em;">오늘</span>
										<br>
										<span id="asYesDayCnt" style="font-size:5em;">-</span>
									</div>
								</div>								
							</div>		
						</div>
								
					</div>				
				</div>
			</div>
			
			
		</div>
		
		
		<div style="float:left; width:68%;">
			<div class="r_inputTbl" >
				<div class="r_inputTblTitle">
					<h3>${smMonthlyElecUse}</h3>
				</div>
			</div>
			<div id="chrtUseMonth"></div>
		</div>
		
		<div style="float:right; width:30%;">
			<div>
				<div class="r_inputTbl" >
					<div class="r_inputTblTitle">
						<h3>어제/오늘 사용량</h3>
					</div>
				</div>
				<div style="height:190px;border:0px solid;">
					<div id="chrtDashBoardWatage" style="height:180px;background-color:rgba(255,255,255,1);"></div>
					
				</div>				
			</div>
			<div>
				<div class="r_inputTbl" >
					<div class="r_inputTblTitle">
						<h3>CO2 방출량( 최근 3일 )</h3>
					</div>
				</div>
					<div id="chrtWatageToCo2" style="height:180px;"></div>		
				</div>
				
			</div>
		</div>
		
		
		
	</div>
	
	
	
	
	
	
	
</div>