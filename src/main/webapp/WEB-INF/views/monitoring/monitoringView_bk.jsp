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


<style>

.ui-jqgrid .ui-jqgrid-bdiv {position: relative; margin: 0; padding:0; overflow: auto; text-align:left;overflow-x: hidden;overflow-y: true;}

</style>
<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/
var YYYY, MM, DD, HH, MIN;	    


$(document).ready(function(){
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
	
	if( HH >= 12)
		ampm = "pm";
	else
		ampm = "am";
	$('#week_time').text( 		gfnGetWeekDay(dayoftheweek) + "/" + HH + ":" + MIN + ampm );
	
	//매장 실시간 날씨
	storeRealData('${userVo.strCd}');
	
	// 대시보드 상단 정보
	MonitoringStoreMstData('${userVo.strCd}');	
	
	// 대시보드 전력사용현황
	MonitoringStoreContPowerData('${userVo.strCd}');	
	
	// 시설물현황
	MonitoringStoreEqmtData( '${userVo.strCd}' );
	
});


$(window).resize(function(){

    $("#gridEqmtStatus").setGridWidth( $("#cont").width() ); 

}).resize();

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
				case '2':  $('#weatherCd').attr('src',	'/images/weather/icon_weather02_web.png');	break;	// 구름조금
				case '3':  $('#weatherCd').attr('src',	'/images/weather/icon_weather03_web2.png');	break;	// 구름많음
				case '4':  $('#weatherCd').attr('src',	'/images/weather/icon_weather04_web.png');	break;	// 흐림				
				case '5':  $('#weafherCd').attr('src',	'/images/weather/icon_weather05_web.png');	break;	// 비온후갬
				case '6':  $('#weatherCd').attr('src',	'/images/weather/icon_weather06_web.png');	break;	// 비
				case '7':  $('#weatherCd').attr('src',	'/images/weather/icon_weather07_web.png');	break;	// 눈
				case '8':  $('#weatherCd').attr('src',	'/images/weather/icon_weather08_web.png');	break;	// 소나기
				case '9':  $('#weatherCd').attr('src',	'/images/weather/icon_weather09_web.png');	break;	// 비/눈
				case '10': $('#weatherCd').attr('src',	'/images/weather/icon_weather10_web.png');	break;	// 눈/비
				case '11': $('#weatherCd').attr('src',	'/images/weather/icon_weather11_web.png');	break;	// 낙뢰
				case '12': $('#weatherCd').attr('src',	'/images/weather/icon_weather12_web.png');	break;	// 안개
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
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
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
			console.log( "MonitoringStoreContPowerData : " + data.contKilo );
			
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
				    marginBottom: 55,
				   // maxwidth: 400,
				    height: 100
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['이번달 예측'],
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
			        color : '#ff717c'
			    }]
			});
			
			//이번달
			$('#curMonthUsage').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    marginBottom: 55,
				   // maxwidth: 400,
				    height: 100
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['이번달'],
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
			        color : '#ffc19e'
			    }]
			});
			
			//지난달
			$('#lastMonthUsage').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    marginBottom: 55,
				   // maxwidth: 400,
				    height: 100
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['지난달'],
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
			        color : '#3ca7db'
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
	$("#gridEqmtStatus").jqGrid({
		url:'/retrieveStoreEqmtData',
		datatype: "json",		
		mtype: 'POST',
		postData : { strCd:strCd },
	    colNames:['No', '장비명', '현재온도(℃)', '상태'],
	    colModel:[
	    	{name:'records',		index:'records', 	width:30, 	align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
            {name:'deviceLoc',		index:'deviceLoc', 	width:250, 	align:'left', 	sortable:true, 	editable:false},	                  
            {name:'sensTemp',		index:'sensTemp', 	width:150, 	align:'center', sortable:true, 	editable:false},
            {name:'normalYn',		index:'normalYn', 	width:150, 	align:'center', sortable:true, 	editable:false},
		],
	 	jsonReader : {
				repeatitems:false
	 	},    		
	 	formatter : {
	  		number : {
			decimalSeparator: ".",
			thousandsSeparator: ",", 
			decimalPlaces: 0,
			defaultValue: '0'
			}
		},
	   	recordtext: "{1} 건/페이지  (전체 {2} 건)",
	   	emptyrecords : "검색 결과가 존재하지 않습니다.",
	   	loadtext: "Loading...",
	   	sortname: 'deviceLoc',
	    viewrecords: true,
	    sortorder: "asc",	     
	    scroll: false,
	    autowidth:true,
	 	height : 150,
	 	gridComplete : function()
		{
	 		$("#gridEqmtStatus tr.jqgrow:even").css("background", "#E0E0E0");
			$("#gridEqmtStatus tr.jqgrow td").css("height", "10px");			
			/*
			jqGridEven('gridEqmtStatus');			 
			var rsltCount = $("#gridEqmtStatus").getGridParam("reccount");	
			if( rsltCount == 0)		// 리스트 0
			{
				//alert('검색된 데이터가 없습니다.');
			}
			else
			{			 
			}
		*/
		}		
	 });
	  //jqGrid Resize	
	jqGridResize('gridEqmtStatus');
}

</script>
<div id="loadingArea">
	<div class="r_mainStatus">
		<!-- 위젯 -->
		<h3 class="blind">위젯으로 전체 현황 보기</h3>
		<!-- 상단타이틀 -->
		<ul style="display:table; margin-bottom:0; width:100%; min-width:1070px; border-bottom:1px solid #dddddd; background-color:#f7f7f7;">
			<li style="display:table-cell;vertical-align: middle;">
				<!-- 날짜 -->
				<div style="position:relative; display:block; width:220px; height:51px;">
					<h4 class="blind">날짜</h4>
					<p id="year_month" style="position:absolute; top:25px; left:111px; margin:0 !important; padding:0 !important; font-family:Malgun Gothic,NanumGothic, Dotum !important; font-size:18px; color:#222222;">-</p>
					<p id="day" style="position:absolute; top:-18px; left:36px; margin:0 !important; padding:0 !important; font-family:Segoe UI; font-size:55px; color:#64768b;">
						16<span class="blind">-</span>
					</p>
					<p id="week_time" style="position:absolute; top:-2px; left:111px; margin:0 !important; padding:0 !important; font-family:Malgun Gothic,NanumGothic, Dotum !important; font-size:14px; color:#222222;">-</p>
				</div> <!-- //날짜 -->
			</li>
			<li style="display:table-cell;background-color:#ffebff;vertical-align: middle;">
				<p style="font-size:36px;font-weight:bold;text-align:center;">전력/시설물 현황</p>
			</li>
			<li style="display:table-cell;width:500px;">
				<!-- 날씨 -->
				<h4 class="blind">날씨</h4>
				<table style="width:314px">
					<tr>
						<td style="width:114px">
							<p class="icon_weather"><img id="weatherCd" src="" /></p>
						</td>
						<td style="width:200px">
							<p id="forecastTemp" style="position:absolute;font-size:30px;color:#bc2424;">-</p>
							<p style="font-size:30px;color:#8c8c8c;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;℃</p>
							<h5>실외</h5>
						</td>
					</tr>
				</table>
				<!-- //날씨 -->
			</li>
		</ul>
		<!-- //상단 타이틀 -->
		
		<!-- 위젯 -->
		<table style="border:1px solid #b2ccff !important;text-align:center;">
			<colgroup>
		    	<col width="25%" />
		    	<col width="25%" />
		    	<col width="25%" />
		    	<col width="25%" />
		    </colgroup>						    
	    	<tbody>
				<tr>
					<td style="font-size:12px; border:1px solid #d9d9db;background-color:#ededed;">
						<h3 style="display:inline-block;font-weight:bold;">매장명</h3>
						<div style="display:inline-block;width:44px;height:39px;">
			            	<a href="#" onclick="javascript:fncGotoMonitoring()">
			            		<span><img src="images/ico_innerSearch.png" alt="Home" /></span>
			            	</a>
			            </div>
					</td>
					<td style="font-size:12px; border:1px solid #d9d9db;background-color:#5aaeff;"><h3 style="font-weight:bold;">계약전력</h3></td>
					<td style="font-size:12px; border:1px solid #d9d9db;background-color:#5aaeff;"><h3 style="font-weight:bold;">최대수요전력</h3></td>
					<td style="font-size:12px; border:1px solid #d9d9db;background-color:#5aaeff;"><h3 style="font-weight:bold;">여유전력</h3></td>
				</tr>
				<tr style="height:50px;">
					<td style="font-size:12px; color:#7a7a7a; border:1px solid #d9d9db;background-color:#8c8c8c;">
						<p id="storeNm" style="font-size:23px;font-weight:bold;color:#ffffff;">-</p>
					</td>
					<td style="font-size:12px; color:#7a7a7a; border:1px solid #d9d9db;background-color:#000000;">
						<p id="contPower" style="font-size:23px;font-weight:bold;color:#ffffff;">-</p>
					</td>
					<td style="font-size:12px; color:#7a7a7a; border:1px solid #d9d9db;background-color:#000000;">
						<p id="totalMain" style="font-size:23px;font-weight:bold;color:#ffffff;">-</p>
					</td>
					<td style="font-size:12px; color:#7a7a7a; border:1px solid #d9d9db;background-color:#000000;">
						<p id="freePower" style="font-size:23px;font-weight:bold;color:#ffffff;">-</p>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //위젯 -->
		
		<!-- 대시보드 본문 -->
		<div class="dashboard_body">
		
			<!-- 1단 -->
			<div class="table_row">
		
				<!-- 계약전력 사용현황 -->
				<div style="position:relative; display:table-cell; padding:23px 20px 20px 30px; width:50%; height:200px;">
					<h3 style="text-align:center;font-size:20px;margin:0 !important; padding:0 !important; padding-bottom:10px !important; font-family:Malgun Gothic,NanumGothic, Dotum !important; color:#222222; border-bottom:1px solid #ececec;">전력사용현황(kWh)</h3>
					<ul style="margin-top:15px;">
						<li class="relative">
							<div>
								<div style="margin-bottom:-64px; min-width: 750px; float: left;" id="curPredictUsage"></div>
								<div style="margin-bottom:-64px; margin-left: 25px;min-width: 750px; float: left;" id="curMonthUsage"></div>
								<div style="margin-left: 25px; min-width: 750px; float: left;" id="lastMonthUsage"></div>
							</div>
						</li>
					</ul>
				</div>
				<!-- //계약전력 사용현황 -->
				
				<!-- 시설물현황 -->
				<div class="notice_area" id="cont">
					<h3>시설물현황</h3>
					<div class="table_use_condition">
						<table class="gridPointer" id="gridEqmtStatus"><tr><td></td></tr></table>
					</div>
				</div>
				<!-- //시설물현황 -->
				
			</div>
			<!-- //1단 -->
			</div>
			
			
			<div style="display:table; width:100%; background-color:#ffffff;">
			<!-- 2단 -->
				<!-- 온실가스 배출 총량 -->
				<div style="position:relative; padding:23px 30px 20px 20px;width:100%;height:253px; border-top:1px solid #ececec; border-bottom:1px solid #ececec;">
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
					
					<p class="more" style="position:absolute; top:27px; right:30px;">
						<a href="javascript:fncMovePeakList()"><img src="/images/btn_more.png" alt="more" /></a>
					</p>
				</div>
				<!-- //온실가스 배출 총량 -->
				
			</div>
			<!-- //2단 -->
			<!-- //대시보드 본문 -->
		
	</div>
</div>