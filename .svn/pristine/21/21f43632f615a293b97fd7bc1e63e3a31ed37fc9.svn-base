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

.ui-jqgrid .ui-jqgrid-bdiv {position: relative; margin: 0; padding:0; overflow: auto; text-align:left;overflow-x: hidden;overflow-y: true;}

</style>
<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/
var YYYY, MM, DD, HH, MIN;	    


$(document).ready(function(){

	//$("#companyCd").val('${companyCd}');
	//console.log( "companyCd : " + companyCd );	

	
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
	
	// 대시보드 상단 정보
	DashStoreMstData();	
	
	// 대시보드 계약전력사용현황
	DashStoreContPowerData();	
	
	// 시설물 알람처리 현황
	//DashStoreAlarmData();
	DashStoreAlarmData();
	
	//실시간알람갯수
	DashDataCount();	
});


$(window).resize(function(){

    $("#gridContPowerStatus").setGridWidth( $("#cont").width()/1.03 );

}).resize();

//대시보드 - 매장정보
function DashStoreMstData()
{
	$.ajax({
		url:'/retrieveDashStoreMstData',
		type:'POST',
		cache:false,
		//data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			//console.log( "retrieveDashStoreMstData : " + data.strNm );
			
			if( data.storeCount == null )				
				$('#storeCount').text( "-" );
			else
				$('#storeCount').text( 		numberWithCommas(data.storeCount) );
			
			if( data.totalAvgUse == null )				
				$('#totalAvgUse').text( "-" );
			else
				$('#totalAvgUse').text( 	numberWithCommas(data.totalAvgUse) );
			
			if( data.avgUse == null )				
				$('#avgUse').text( "-" );
			else
				$('#avgUse').text( 		numberWithCommas(data.avgUse) );
			
			/*if( data.semsAbnormalStrCnt == null )
				$('#semsAbnormalStrCnt').text( "-" );
			else
				$('#semsAbnormalStrCnt').text( 		numberWithCommas(data.semsAbnormalStrCnt) );*/
			
			var totalUse = data.totalUse;		// 사용량
			var curPredictUsage = data.curPredictUsage;
			var maxNum = 5000;
			if(curPredictUsage != 0){
				maxNum = curPredictUsage;
			}
			
			var graph_use = curPredictUsage / totalUse;

			$('#graph_use').css( 'width', Math.round(graph_use)+'%' );		// 실사용량 그래프 길이	
			
			Highcharts.setOptions({
		        lang: {
		          thousandsSep: ','
		        }
		    });
			$('#powerused').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    marginBottom: 10,
				    marginLeft: 95,
				   // maxwidth: 400,
				    height: 100
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['실사용량'],
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
			         max : Number(maxNum),
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
			        name: '실사용량',
			        data: [Number(totalUse)],
			        color : '#222222'
			    }]
			});
			$('#powerprdt').highcharts( {
				chart: {
			        type: 'bar',
			        backgroundColor: null,
			        plotBorderWidth: 0,
				    marginBottom: 10,
				   // maxwidth: 400,
				    height: 100
			    },
			    title: {
			        text: ''
			    },
			    xAxis: {
			        categories: ['예상사용량'],
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
			         max : Number(maxNum),
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
		                    verticalAlign: "middle",
			            }
			        }
			    },
			    series: [{
			        name: '예상사용량',
			        data: [Number(curPredictUsage)],
			        color : '#4fa217'
			    } ]
			});
			// 사용량-예측 전력 그래프
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

//대시보드 - 계약전력 grid
function DashStoreContPowerData()
{	
	$("#gridContPowerStatus").jqGrid({
		url:'retrieveStoreContPowerData',
		datatype: "json",		
		mtype: 'POST',
  	//postData : { strCd:strCd },
	    colNames:['No', '매장명', '계약전력(kW)', '최대수요전력(kW)', '여유전력(kW)', '최대냉난방전력(kW)', 'strCd' ],
  	colModel:[
            {name:'records',		index:'records',	hidden:true},
            {name:'strNm',		index:'strNm', 		width:30, 	align:'left', 	sortable:true, 	editable:false},	                  
            {name:'contPower',	index:'contPower', 	width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:1}},
            {name:'totalMain',	index:'totalMain', 	width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:1}},
            {name:'freePower',	index:'freePower', 	width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:1}},
            {name:'temp',		index:'temp',		width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:1}},
            {name:'strCd',		index:'strCd',		hidden:true}
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
	   	sortname: '(B.CONT_DEMAND_POWER - MAX(A.TOTAL_USE_WATAGE))',
	    viewrecords: true,
	    sortorder: "asc",	     
	    scroll: false,
	    autowidth:true,
	 	height : 201,	
	 	onSelectRow : function(rowid, iRow, iCol, e) {
			 
			var list = $("#gridContPowerStatus").getRowData(rowid);	
			
			var param = new Object();
			param.strCd = list.strCd;
			param.strNm	= list.strNm;
			
			fn_divPop("contDemandPop", list.strNm + " 계약전력 현황", 600, 500, param );		// 매장별 계약전력 팝업
			 
		},	 		
	 	gridComplete : function()
		{
	 		$("#gridContPowerStatus tr.jqgrow:even").css("background", "#E0E0E0");
			$("#gridContPowerStatus tr.jqgrow td").css("height", "10px");			
		}		
	 });
	  //jqGrid Resize	
	jqGridResize('gridContPowerStatus');
}

//실시간알람 개수
function DashDataCount()
{
	var title = "";
	var noticeTypeCd = "";
	var authId = '${userVo.authId}';
	
	$.ajax({
		url:'/retrieveDashDataCount',
		type:'POST',
		cache:false,
		data : {
				authId:authId,
				},
		dataType:'json',
		success:function(data){
			
			/*data.eqmtCnt;		// 비정상
			data.zeroCnt;		// dd전력0
			data.peakCnt;		// 피크
			data.eqstCnt;		// 시설물장애
			data.notiCnt;		// 공지사항*/
			
			$('#eqmtStoreCount').text( data.eqmtCnt );
			$('#zeroStoreCount').text( data.zeroCnt );
			$('#peakStoreCount').text( data.peakCnt );
			$('#eqmtStatusCount').text( data.eqstCnt );
			$('#noticeCount').text( data.notiCnt );
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

//pie그래프
function DashStoreAlarmData()
{
	$.ajax({
		url:'/retrieveDashStoreAlarmData',
		type:'POST',
		cache:false,
//		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			
			//console.log( "yResult : " + 	data.yResult );
			//console.log( "nResult : " + 	data.nResult );
			//console.log( "resultCnt : " + 	data.resultCnt );
			
			drawPieChart(data);
			/*		
			var yResult = numberWithCommas( 	data.yResult );
			var nResult = numberWithCommas( 	data.nResult );
			var resultCnt = numberWithCommas( 	data.resultCnt );
			*/			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");							
			$('#yResult').text( "0" );
			$('#nResult').text( "0" );
			$('#resultCnt').text( "0" );
			
			var data = new Object();
			
			data.yResult = 0;
			data.nResult = 0;
			data.resultCnt = 0;
			
			drawPieChart(data);
		},
		complete:function(result){
		}
	});
}

//파이차트 그리기
function drawPieChart( data )
{
	$('#myChart').html('');
	$('#myChart').text("1");
	
	var nResult = data.nResult;
	var yResult = data.yResult;
	var resultCnt = data.resultCnt;
	
	if( data.nResult == null )				
		$('#nResult').text( "0" );
	else
		$('#nResult').text( numberWithCommas(nResult) );
				
	if( data.yResult == null )				
		$('#yResult').text( "0" );
	else
		$('#yResult').text( numberWithCommas(yResult) );

	if( data.resultCnt == null )
		$('#resultCnt').text( "0" );
	else
		$('#resultCnt').text( numberWithCommas(resultCnt) );
	
	//console.log( "df"+resultCnt);
	
	var percentVal = 0;
	if( resultCnt != 0  )
		percentVal =  Math.round( (yResult / resultCnt ) * 100);
	
	if(percentVal == 100){
		percentVal = "완료";
	}else {
		percentVal+='%';
	}
	
	if( resultCnt == 0 ){
		nResult = 1;
		resultCnt = 1;
	}
   	$('#myChart').highcharts( {
   		
		chart : {
			plotBackgroundColor: null,
	        plotBorderWidth: null,
	        plotShadow: false,
	        width : 200,
			height : 200,					
	        type: 'pie'
		},
		title : {
			      text: percentVal,
			      align: 'center',
			      verticalAlign: 'middle',
			      y:3,
			      style: { color: '#C00C3F', fontWeight: 'normal', fontSize : '25px'}
			      
		},
		credits : {
			enabled : false
		},
		colors : ['#60B046' , '#C00C3F'],
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
		plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: false,
                innerSize: 100,
            }
        },
		series: [{
	        name: '알림 현황',
	        colorByPoint: true,
	        data: [{
	        	name: '조치완료',
	            y: Number(yResult) 
	        }, {
	             name: '미조치',
	            y: Number(nResult)
	        }]
	    }]
		
	});		
}

function fncConfirm() {		
	fncDivPop1Close();
	
	// 페이지 이동
	$.ajax({
		url:'/',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			console.log( "retrieveStoreMstData : " + data.strNm );		
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});	
	
}

//닫기 버튼
function fncCancel() {
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
}

//통합관제현황 - 시설물 - 시설물알림
function fncMoveEqmtMessageList(resultYn)
{	
	if( resultYn == 0 )		// 전체
		fncCallPage('/retrieveEqmtMessageList?resultYn=0', {subText: "시설물알림", midText: "시설물", topText:"통합관제현황"} );
	if( resultYn == 1 )		// 미조치
		fncCallPage('/retrieveEqmtMessageList?resultYn=1', {subText: "시설물알림", midText: "시설물", topText:"통합관제현황"} );
	if( resultYn == 2 )		// 조치
		fncCallPage('/retrieveEqmtMessageList?resultYn=2', {subText: "시설물알림", midText: "시설물", topText:"통합관제현황"} );
}

//분석 - 비정상매장
function moveEqmtStore()
{	
	fncCallPage('/retrieveStoreList', {subText: "비정상매장", midText: "분석"} );
}

//분석 - 데이터비정상매장
function moveElecZeroStore()
{	
	fncCallPage('/retrieveElecStoreList', {subText: "데이터비정상매장", midText: "분석"} );
}

//통합관제현황 - 피크제어매장
function fncMovePeakList()
{	
	fncCallPage('/retrievePeakControlStore', {subText: "피크제어매장", midText: "통합관제현황"} );
}

//통합관제현황 - 시설물 - 시설물알림
function moveEqmtStatusList()
{
	//fncCallPage('/retrieveEqmtMessageList', {subText: "시설물알림", midText: "시설물", topText:"통합관제현황"} );
	fncCallPage('/retrieveEqmtMessageList?resultYn=1', {subText: "시설물알림", midText: "시설물", topText:"통합관제현황"} );
}

//시스템관리 - 공지사항 관리 - 공지사항
function fncMoveNoticeList()
{	
	fncCallPage('/retrieveNoticeList', {subText: "공지사항", midText: "공지사항관리", topText:"시스템관리"} );
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
		                    <span class="calendar-date"><span id="week">-요일</span> <span class="calendar-time" id="time">--:--pm</span></span>
		                    <span class="calendar-date" id="year_month">-년 -월</span>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="summary">
		        <ul class="box summary-lists columns-4">
		            <li>
		                <strong id="storeCount">-</strong>
		                <span>전체매장수</span>
		            </li>
		            <li>
		                <strong class="color-green" style="padding-top: 12px;">일평균(kWh)</strong>
		            </li>
		            <li>
		                <strong class="color-green" id="totalAvgUse">-</strong>
		                <span>총사용량</span>
		            </li>
		            <li>
		                <strong class="color-green" id="avgUse">-</strong>
		                <span>매장별 사용량</span>
		            </li>
		        </ul>
		    </div>
		    <div class="row" style="height:290px;">
		        <div class="columns padding-left-0">
		            <div class="box-size">
		                <div class="box-head">당월누적 전력사용량</div>
		                <div class="box-body">
		                    <div class="graph1" id="powerused" style="margin-bottom:-19px;min-width: 750px;"></div>
		                    <div class="graph1" id="powerprdt" style="min-width: 750px;"></div>
		                </div>
		            </div>
		        </div>
		        <div class="columns padding-right-0">
		            <div class="box-size">
		                <div class="box-head">당월장애처리현황</div>
		                <div class="box-body">
		                    <div class="graph2">
		                        <div class="graph2-graph" id="myChart">
		                        </div>
		                        <div class="graph2-data">
		                            <ul>
		                                <li>
		                                    <strong>미조치</strong>
		                                    <span class="color-red" id="nResult">-</span>
		                                </li>
		                                <li>
		                                    <strong>조치완료</strong>
		                                    <span class="color-green" id="yResult">-</span>
		                                </li>
		                                <li>
		                                    <strong>총건수</strong>
		                                    <span id="resultCnt">-</span>
		                                </li>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="alarm">
		        <strong class="alarm-title">
		            <img src="images/ico_bell.png" alt="">
		            <span>장애 알람</span>
		        </strong>
		        <ul class="alarm-lists">
		             <li>
		                <strong class="gridPointer" id="zeroStoreCount" onclick="javascript:moveElecZeroStore();">-</strong>
		                <span>Data비정상 매장</span>
		            </li>
		            <li>
		                <strong class="gridPointer" id="peakStoreCount" onclick="javascript:fncMovePeakList();">-</strong>
		                <span>피크 매장</span>
		            </li>
		            <li>
		                <strong class="gridPointer" id="eqmtStatusCount" onclick="javascript:moveEqmtStatusList();">-</strong>
		                <span>미조치 장애 건수(누적)</span>
		            </li>
		            <li>
		                <strong class="gridPointer" id="noticeCount" onclick="javascript:fncMoveNoticeList();">-</strong>
		                <span>공지사항</span>
		            </li>
		        </ul>
		    </div>
		</div>
	</div>
</div>