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

<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/dashboard.css" />

<style>

.ui-jqgrid .ui-jqgrid-bdiv {position: relative; margin: 0; padding:0; overflow: auto; text-align:left;overflow-x: hidden;overflow-y: scroll;}

</style>
<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/
var YYYY, MM, DD, HH, MIN;	    


$(document).ready(function(){
	$("#strCd").val('${userVo.strCd}');
	
	fncSearch();
});

function fncSearch(){
	getDate();
	
	var strCd = $.trim($("#strCd").val());
	
	if( strCd != ""){
		//매장 실시간 날씨
		storeRealData(strCd);
		
		// 대시보드 상단 정보
		MonitoringStoreMstData(strCd);	
		
		// 대시보드 전력사용현황
		MonitoringStoreContPowerData(strCd);	
		
		// 시설물현황
		MonitoringStoreEqmtData(strCd);
		
		//온실가스배출량
		MonitoringGhouseGasMonth();
	}
}

//날짜
function getDate(){
	var d = new Date();	
	var dayoftheweek = d.getDay();
	var YYYY = d.getFullYear();
	var MM = (d.getMonth()+1)>9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1);
	var DD = d.getDate()>9 ? ''+d.getDate() : '0'+d.getDate();
	var HH = d.getHours()>9 ? ''+d.getHours() : '0'+d.getHours();
	var MIN = d.getMinutes()>9 ? ''+d.getMinutes() : '0'+d.getMinutes();
	var ampm = "am";
	
	$('#year_month').text( 		YYYY + "년 " + MM + "월" );
	$('#day').text( 			DD );
	
	if( HH >= 12){
		HH = HH-12;
		ampm = "pm";
	}else{
		ampm = "am";
	}
	$('#week').text(gfnGetWeekDay(dayoftheweek));
	$('#time').text( HH + ":" + MIN + ampm );
}

//매장 실시간 날씨 정보
function storeRealData( strCd )
{
	$.ajax({
		url:'/retrieveStoreRealData',
		type:'POST',
		cache:false,
		datatype: "json",
		data : { strCd:strCd },
		success:function(data){
			/* console.log( "weatherCd : " + data.weatherCd ); */
			
			// 1	맑음
			// 2	구름조금
			// 3	구름많음
			// 4	흐림
			// 5	비온후갬
			// 6	비
			// 7	눈
			// 8	소나기
			// 9	비/눈
			// 10	눈/비
			// 11	낙뢰
			// 12	안개
			
			switch( data.weatherCd )
			{			 
				case '1':  $('#weatherCd').attr('src',	'/images/weather/icon_weather01_web2.png');	break;	// 맑음
				case '2':  $('#weatherCd').attr('src',	'/images/weather/icon_weather02_web2.png');	break;	// 구름조금
				case '3':  $('#weatherCd').attr('src',	'/images/weather/icon_weather03_web2.png');	break;	// 구름많음
				case '4':  $('#weatherCd').attr('src',	'/images/weather/icon_weather04_web2.png');	break;	// 흐림				
				case '5':  $('#weafherCd').attr('src',	'/images/weather/icon_weather05_web2.png');	break;	// 비온후갬
				case '6':  $('#weatherCd').attr('src',	'/images/weather/icon_weather06_web2.png');	break;	// 비
				case '7':  $('#weatherCd').attr('src',	'/images/weather/icon_weather07_web2.png');	break;	// 눈
				case '8':  $('#weatherCd').attr('src',	'/images/weather/icon_weather08_web2.png');	break;	// 소나기
				case '9':  $('#weatherCd').attr('src',	'/images/weather/icon_weather09_web2.png');	break;	// 비/눈
				case '10': $('#weatherCd').attr('src',	'/images/weather/icon_weather10_web2.png');	break;	// 눈/비
				case '11': $('#weatherCd').attr('src',	'/images/weather/icon_weather11_web2.png');	break;	// 낙뢰
				case '12': $('#weatherCd').attr('src',	'/images/weather/icon_weather12_web2.png');	break;	// 안개
				default: $('#weatherCd').attr('src',	'');	break;
			}
			
			if( data.forecastTemp == null )				
				$('#forecastTemp').text( "-" );
			else
				$('#forecastTemp').text( 	data.forecastTemp);
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

//대시보드 - 매장정보
function MonitoringStoreMstData( strCd )
{
	$.ajax({
		url:'/monitoringStoreMstData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			console.log( "monitoringStoreMstData : " + data.strNm );
			console.log( "storeCount : " + data.storeCount );
			
			if( data.strNm == null )
				$('#storeNm').text("-");
			else
				$('#storeNm').text(data.strNm );
			
			if( data.contPower == null )				
				$('#contPower').text("-");
			else
				$('#contPower').text(numberWithCommas(data.contPower));
			
			if( data.totalMain == null )				
				$('#totalMain').text("-");
			else
				$('#totalMain').text(numberWithCommas(data.totalMain));
			
			if( data.freePower == null )
				$('#freePower').text("-");
			else
				$('#freePower').text(numberWithCommas(data.freePower));
			
			if(data.storeCount <= 1)
				$("#btnStoreSrch").hide();
			else
				$("#btnStoreSrch").show();
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

function fncGotoStoreList(){
	var companyCd = '${userVo.companyCd}';
	var userId = '${userVo.userId}';
	
	var args = new Object();
	args.companyCd = companyCd;
	args.userId = userId;
	
	fn_divPop("monitoringStoreSrch", "팝업", 800, 570, args );
}

//팝업에서 넘어온 값 세팅
function fncSetStoreCd(data) {
	$("#strCd").val(data.strCd);
	
	var strCd = $("#strCd").val();
	if( strCd != "" )
		fncSearch();
}

//대시보드 - 전력사용현황
function MonitoringStoreContPowerData( strCd )
{
	$.ajax({
		url:'/retrieveStoreEnergyData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			var contKilo = data.contKilo*1000;		//매장계약전력
			
			var curPredictUsage = data.curPredictUsage;	//이번달예측
			var curMonthUsage = data.curMonthUsage;		//이번달
			var lastMonthUsage = data.lastMonthUsage;	//지난달
			
			var graph_use = lastMonthUsage / contKilo;
			
			$('#graph_use').css( 'width', Math.round(graph_use)+'%' );		// 실사용량 그래프 길이	
			
			Highcharts.setOptions({
		        lang: {
		          thousandsSep: ','
		        }
		    });
			//이번달예측
			$('#curPredictUsage').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    //marginBottom: 55,
				   // maxwidth: 400,
				    height: 80
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['이번달 예측'],
			        labels: {
				        style: {
				        	fontSize: "14px"
				        }
		            }
			    },
			    legend : {
					 enabled: false
				},
			    yAxis: {
			        visible: false,
			        labels:{enabled: false},
			         gridLineWidth: 0,
			         minorGridLineWidth: 0,
			         max : Number(lastMonthUsage),
			        Labels: {
		                enabled: false,
	                    verticalAlign: "middle"
		            },
			        title: {
			            text: ''
			        }
			    },
			    credits : {
					enabled : false
				},
				exporting : {
					enabled : false
				},
			    tooltip: {
			        valueSuffix: '(kWh)'
			    },
			    plotOptions: {
			        bar: {
			            dataLabels: {
			                enabled: true,
		                    verticalAlign: "middle"
			            }
			        }
			    },
			    series: [{
			        name: '이번달 예측',
			        data: [Number(curPredictUsage)],
			        color : '#60B046'
			    }]
			});
			
			//이번달
			$('#curMonthUsage').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    //marginBottom: 55,
				    marginLeft: 99,
				   // maxwidth: 400,
				    height: 80
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['이번달'],
			        labels: {
				        style: {
				        	fontSize: "14px"
				        }
		            }
			    },
			    legend : {
					 enabled: false
				},
			    yAxis: {
			        visible: false,
			        labels:{enabled: false},
			         gridLineWidth: 0,
			         minorGridLineWidth: 0,
			         max : Number(lastMonthUsage),
			        Labels: {
		                enabled: false,
	                    verticalAlign: "middle"
		            },
			        title: {
			            text: ''
			        }
			    },
			    credits : {
					enabled : false
				},
				exporting : {
					enabled : false
				},
			    tooltip: {
			        valueSuffix: '(kWh)'
			    },
			    plotOptions: {
			        bar: {
			            dataLabels: {
			                enabled: true,
		                    verticalAlign: "middle"
			            }
			        }
			    },
			    series: [{
			        name: '이번달',
			        data: [Number(curMonthUsage)],
			        color : '#A50034'
			    }]
			});
			
			//지난달
			$('#lastMonthUsage').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    //marginBottom: 55,
				    marginLeft: 99,
				   // maxwidth: 400,
				    height: 80
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['지난달'],
			        labels: {
				        style: {
				        	fontSize: "14px"
				        }
		            }
			    },
			    legend : {
					 enabled: false
				},
			    yAxis: {
			        visible: false,
			        labels:{enabled: false},
			         gridLineWidth: 0,
			         minorGridLineWidth: 0,
			         max : Number(lastMonthUsage),
			        Labels: {
		                enabled: false,
	                    verticalAlign: "middle"
		            },
			        title: {
			            text: ''
			        }
			    },
			    credits : {
					enabled : false
				},
				exporting : {
					enabled : false
				},
			    tooltip: {
			        valueSuffix: '(kWh)'
			    },
			    plotOptions: {
			        bar: {
			            dataLabels: {
			                enabled: true,
		                    verticalAlign: "middle"
			            }
			        }
			    },
			    series: [{
			        name: '지난달',
			        data: [Number(lastMonthUsage)],
			        color : '#B0B0B0'
			    }]
			});
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

//대시보드 - 시설물현황 grid
function MonitoringStoreEqmtData(strCd)
{
	$.ajax({
		url:'/monitoringStoreEqmtData',
		type: 'POST',
		cache:false,
		datatype: "json",		
		data : {strCd:strCd},
		success:function(data){
			var rowData = data.rows;
	    	var len = rowData.length;
	    	var tx = "";
	    	var color = "";
	    	
			if(len > 0){
				for(var i=0; i<len; i++){
					tx += "<tr>";
					tx +="<td scope='row'>"+rowData[i].records+"</td>";
					tx +="<td>"+rowData[i].deviceLoc+"</td>";
					tx +="<td>"+rowData[i].sensTemp+"</td>";
					
					if(rowData[i].normalYn == "정상"){
						color = "";
					}else{
						color = "color-red";
					}
					tx +="<td class='"+color+"'>"+rowData[i].normalYn+"</td>";
					tx +="</tr>";
				}
			}else{
				tx += "<tr>";
				tx += "<td align='center' colspan='4'>검색 결과가 없습니다.</td>";
				tx += "</tr>";
			}
			$("#tbEqmtStatus").html(tx);
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
		
	 });
}

//하단 온실가스 배출량 영역 컨트롤
$('.dashboard').innerHeight('100%');
$('#dash').innerHeight('100%');
$('.contents').innerHeight('100%');

var $wrap = $('.toggle-division'),
$target = $('.toggle-division-target'),
$trigger = $('.toggle-division-trigger'),
$orbit = $('.toggle-division-orbit .box-body'),
totalHeight = $('.contents').height(),
outHeight = $('.heading').outerHeight(true) + $('.summary').outerHeight(true) + $('.toggle-division-orbit .box-head').innerHeight() + $wrap.innerHeight() +15;

$orbit.innerHeight(totalHeight - outHeight +270);

function fncToggleDivision()
{
	$target.toggle();
    $trigger.toggleClass('actived');

    if ($target.css('display') === 'none') {
        $orbit.innerHeight(totalHeight - outHeight +270);
    } else {
        $orbit.innerHeight(totalHeight - outHeight - $target.innerHeight());
    }
}

//온실가스배출량
function MonitoringGhouseGasMonth()
{
	var tickArr0 = new Array(); // 월별
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
}

//온실가스 배출량
function fncDrawGhouseGasEmitChart(ticks,values) {
	
	Highcharts.setOptions({
		lang: {
				weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
				shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				rangeSelectorZoom : '',
				loading : "Loading...",
			}
		});
	
	var year = "0";
	var month = "0";
	
	if(ticks[0] != null){
		year = ticks[0].substr(0,4);
		month = ticks[0].substr(4,2);
	}

	$('#chrtGhouseGasEmit').highcharts('StockChart', {

		chart : {
			borderWidth : 0,
			plotBorderWidth : 1,
			//spacingRight : 2,
			//spacingLeft : 2,
			height : 250,
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
            pointStart: Date.UTC(Number(year), Number(month)-1, 1),
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
<div class="dashboard">
	<div id="dash">
		<div class="contents">
			<div class="heading clearfix">
				<h1 class="h1 left">전력/시설물 현황</h1>
				<div class="today right">
					<div class="calendar left">
						<div class="left">
							<strong class="calendar-day" id="day">-</strong>
						</div>
						<div class="right">
							<span class="calendar-date"><span id="week">-요일</span><span class="calendar-time" id="time">--:--am</span></span>
							<span class="calendar-date" id="year_month">-년 -월</span>
						</div>
					</div>
					<div class="weather right">
						<div class="left">
							<strong class="weather-symbol"><img id="weatherCd" alt=""></strong>
						</div>
						<div class="right">
							<span class="weather-data weather-temperature" id="forecastTemp">-℃</span>
							<span class="weather-data">실외</span>
						</div>
					</div>
				</div>
			</div>
			<div class="summary">
				<strong class="summary-title">
					<input type='hidden' id='strCd' name='strCd' /><!-- 매장코드 -->
					<span id="storeNm">-</span>
					<button class="summary-setting" id="btnStoreSrch" onclick="javascript:fncGotoStoreList()"><img src="images/ico_innerSearch2.png" alt=""></button>
				</strong>
				<ul class="box summary-lists columns-3">
					<li>
						<strong class="color-green" id="contPower">-</strong>
						<span>계약전력</span>
					</li>
					<li>
						<strong class="color-green" id="totalMain">-</strong>
						<span>최대수요전력</span>
					</li>
					<li>
						<strong class="color-green" id="freePower">-</strong>
						<span>여유전력</span>
					</li>
				</ul>
			</div>
			<div class="row toggle-division-orbit">
				<div class="columns padding-left-0">
					<div class="box">
						<div class="box-head">전력사용현황(kWH)</div>
						<div class="box-body">
							<div style="margin-bottom:-24px;min-width: 750px; float: left;" id="curPredictUsage"></div>
							<div style="margin-bottom:-24px;min-width: 750px; float: left;" id="curMonthUsage"></div>
							<div style="min-width: 750px; float: left;" id="lastMonthUsage"></div>
						</div>
					</div>
				</div>
				<div class="columns padding-right-0">
					<div class="box">
						<div class="box-head">시설물현황</div>
						<div class="box-body">
							<div class="table-scroll">
								<table summary="">
									<caption></caption>
									<colgroup>
										<col width="8%">
										<col width="">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">장비명</th>
											<th scope="col">현재온도</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody id="tbEqmtStatus">
										<tr>
											<td align='center' colspan='4'>검색 결과가 없습니다.</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="toggle-division">
				<button type="button" class="toggle-division-trigger" onclick="javascript:fncToggleDivision();"></button>
				<div class="box toggle-division-target" style="height:525px">
					<div class="box-head">온실가스배출량</div>
					<div class="box-body">
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
							<div class="chrtGhouseGasEmit" id="chrtGhouseGasEmit" style="width: 94%">
							</div>
						</div>
						<!-- //그래프 영역 -->
						
						<!-- 지시문 -->
						<div class="r_infoGroup2">
						    <span class="r_infoTxt"><img src="/images/ico_info_new.png">온실가스 배출량 = Σ[전력사용량(MWh) * 배출계수(tGHG(CO2/CH4/N2O)/MWh) * 지구온난화지수]</span>
						    <span class="r_infoTxt"><img src="/images/ico_info_new.png">배출계수 : 해당연도의 국가 고유 전력배출계수, 전력거래소에서 발표(현재는 2011년 발표한 0.4585(tCO2/MWh기준))</span>
						    <span class="r_infoTxt r_last"><img src="/images/ico_info_new.png">지구온난화 지수 : CO2=1, CH4=21, N2O=310</span>
					    </div>
						<!-- //지시문 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>