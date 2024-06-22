<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smArea"><spring:message code="area"/></c:set>
<c:set var="smStartDt"><spring:message code="startDt"/></c:set>
<c:set var="smEndDt"><spring:message code="endDt"/></c:set>
<c:set var="smUseYn"><spring:message code="useYn"/></c:set>
<c:set var="smRegiId"><spring:message code="regiId"/></c:set>
<c:set var="smRegiNm"><spring:message code="regiNm"/></c:set>
<c:set var="smFinalModDt"><spring:message code="finalModDt"/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smDupChk"><spring:message code="dupChk"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smNew"><spring:message code="new"/></c:set>
<c:set var="smUpdate"><spring:message code="update"/></c:set>
<c:set var="smDelete"><spring:message code="delete"/></c:set>
<c:set var="smSave"><spring:message code="save"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>
<style type="text/css">
.ui-jqgrid .ui-jqgrid-bdiv {
	  position: relative; 
	  margin: 0em; 
	  padding:5; 
	  /*overflow: auto;*/ 
	  overflow-x:auto; 
	  overflow-y:scroll; 
	  text-align:left;
}
.ui-jqgrid-hbox{
	overflow-y:auto;
}
</style>
<script type="text/javascript">
/*******************
1. 기타 필수 전역 변수
********************/


// 페이지 사용 - jooyoung

var selTab = "a";

/*******************
1. function
********************/

$(window).resize(function(){
	grid_resize();

});

function grid_resize(){
 	$("#gridUsedArea").setGridWidth($("#cont1").width());
	$("#gridUsedDailyArea").setGridWidth($("#cont2").width());
	$("#gridMonthDemandList").setGridWidth($("#cont3").width());
	$("#gridDayDemandList").setGridWidth($("#cont4").width());
	$("#gridFacilityList").setGridWidth($("#cont5").width());
	$("#gridStoreMgnt").setGridWidth($("#cont6").width());
	$("#gridEqmtStatus").setGridWidth($("#cont7").width()); 
}

$(function() {
	$('#scrDateBFrom, #scrDateBTo, #scrDateCFrom, #scrDateCTo').monthpicker({
		pattern: 'yyyy-mm',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
/*	    
        selectedYear: ${toDayYear}, 
*/
        startYear: 2010,
	    finalYear: 2050,
	    openOnFocus: false
	});			
	
	$('#scrDateBFromBtn').bind('click', function () {
		$('#scrDateBFrom').monthpicker('show');
	});
	$('#scrDateBToBtn').bind('click', function () {
		$('#scrDateBTo').monthpicker('show');
	});
	$('#scrDateCFromBtn').bind('click', function () {
		$('#scrDateCFrom').monthpicker('show');
	});
	$('#scrDateCToBtn').bind('click', function () {
		$('#scrDateCTo').monthpicker('show');
	});
	
	$("#scrYyyymmdd, #scrDateEFrom, #scrDateETo").datepicker();
});

/*******************
1. document ready
********************/
$(document).ready(function() {
	// 초기화
	init_A();	// 최초 실행
	init_B();
	init_C();
	init_D();
	init_E();
	
	// 탭
	$('.tab_tab').click(function(e) {
		var strCd = $.trim($("#strCd").val());
		if (strCd == "") {
			alert("매장명/코드를 먼저 검색하세요.");
			return false;
		}

		e.preventDefault();
		
		var id = $(this).attr('id');
		var selId = id.substring(0, id.length - "_tab".length);		
		if( selTab == selId )
			return;
		
		if (selTab) $("#" + selTab).attr("style", "display:none;");
		$(this).tab('show');
		
		
		
		var id = $.trim($(this).attr('id'));
		if (id == "a_tab") {			
			fncSearch_A();
		} else if(id == "b_tab") {
			fncSearch_B();
		} else if (id == "c_tab") {
			fncSearch_C();
		} else if (id == "d_tab") {
			fncSearch_D();
		} else if (id == "e_tab") {
			fncSearch_E();
		}
		
	}).on('shown', function(e) {
		var id = $(this).attr('id');
		var selId = id.substring(0, id.length - "_tab".length);
		$("#" + selId).attr("style", "display:block;");
		selTab = selId;

		grid_resize();
	});
	
	// 엔터 키 이벤트
	$("input[name='strNm']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncStoreSearchBtn();
	        }
		}
	});
});

function fncSearch_A()
{
	var strCd = $.trim($("#strCd").val());

	if( strCd != "")
	{
		// 1단 매장정보
		storeMstData( strCd );		
		// 2단 상단정보
		storeRealData( strCd );		
		// 3단-1 에너지 사용현황
		// 3단-1 에너지 사용현황 그래프
		storeEnergyData( strCd );
		// 4단 시설물 알람 처리 현황
		storeAlarmData( strCd );
		// 시설물 현황
		storeEqmtData( strCd );
		
		$("#gridEqmtStatus").setGridParam({
			datatype : "json",		
			postData : {strCd:strCd}	
		}).trigger("reloadGrid");
		
	}
	else
	{
		
	}
	
	
	
}

// 첫번째 탭 초기화
function init_A()
{
	fncSearch_A();
}

// 첫번째 탭 -	 매장 기본 정보
function storeMstData( strCd )
{
	$.ajax({
		url:'/retrieveStoreMstData',
		type:'POST',
		cache:false,
		datatype: "json",
		data : { strCd:strCd },
		success:function(data){			
			
			if( data.strNm == null )				
				$('#strNm').text( "-" );
			else
				$('#strNm').text( 		data.strNm );
			
			if( data.viewStrCd == null )				
				$('#viewStrCd').text( "-" );
			else
				$('#viewStrCd').text( 	data.viewStrCd );
			
			if( data.addr == null )				
				$('#addr').text( "-" );
			else
				$('#addr').text( 		data.addr );
			
			if( data.telNo == null )
				$('#telNo').text( "-" );
			else
				$('#telNo').text( 		data.telNo );
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
	
	
}

// 첫번째 탭 - 매장 실시간 정보
function storeRealData( strCd )
{	
	$.ajax({
		url:'/retrieveStoreRealData',
		type:'POST',
		cache:false,
		datatype: "json",
		data : { strCd:strCd },
		success:function(data){
			//console.log( "weatherCd : " + data.weatherCd );
			
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
				case '1':  $('#weatherCd').attr('src',	'/images/weather/icon_weather01_web.png');	break;	// 맑음
				case '2':  $('#weatherCd').attr('src',	'/images/weather/icon_weather02_web.png');	break;	// 구름조금
				case '3':  $('#weatherCd').attr('src',	'/images/weather/icon_weather03_web.png');	break;	// 구름많음
				case '4':  $('#weatherCd').attr('src',	'/images/weather/icon_weather04_web.png');	break;	// 흐림				
				case '5':  $('#weatherCd').attr('src',	'/images/weather/icon_weather05_web.png');	break;	// 비온후갬
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
				$('#forecastTemp').text( "- ℃" );
			else
				$('#forecastTemp').text( 	data.forecastTemp + '℃' );
			
			if( data.tSensorTemp == null )				
				$('#tSensorTemp').text( "- ℃" );
			else
				$('#tSensorTemp').text( 	data.tSensorTemp + '℃' );
			
			if( data.tempStat == null )
				$('#tempStat').text( "-" );
			else
			{
				$('#tempStat').removeClass("on off");				
				$('#tempStat').text( 		data.tempStat );
				
				if( "ON" == data.tempStat )
					$('#tempStat').addClass("on");
				if( "OFF" == data.tempStat )
					$('#tempStat').addClass("off");
				
			}
			
			if( data.tempUnitStat == null )
				$('#tempUnitStat').text( "-" );
			else
			{
				$('#tempUnitStat').removeClass("on off");
				$('#tempUnitStat').text( 	data.tempUnitStat );
				
				if( "정상" == data.tempUnitStat )
					$('#tempUnitStat').addClass("on");
				if( "비정상" == data.tempUnitStat )
					$('#tempUnitStat').addClass("off");
			}

			if( data.signStat == null )
				$('#signStat').text( "-" );
			else
			{
				$('#signStat').removeClass("on off");
				$('#signStat').text( 	data.signStat );
				
				if( "ON" == data.signStat )
					$('#signStat').addClass("on");
				if( "OFF" == data.signStat )
					$('#signStat').addClass("off");
			}

			
			if( data.semsStat == null )
				$('#semsStat').text( "-" );
			else
			{
				$('#semsStat').removeClass("on off");
				$('#semsStat').text( 	data.semsStat );
				
				if( "정상" == data.semsStat )
					$('#semsStat').addClass("on");
				if( "비정상" == data.semsStat )
					$('#semsStat').addClass("off");
			}

			
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
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

// 첫번째 탭 - 전력사용량
function storeEnergyData( strCd )
{
	$.ajax({
		url:'/retrieveStoreEnergyData',
		type:'POST',
		cache:false,
		datatype: "json",
		data : { strCd:strCd },
		success:function(data){
			if( data.contKilo == null )				
				$('#contKilo').text( "0" );
			else
				$('#contKilo').text( 			numberWithCommas( data.contKilo ) );
			
			if( data.lastMonthUsage == null )				
				$('#lastMonthUsage').text( "0" );
			else
				$('#lastMonthUsage').text( 		numberWithCommas( data.lastMonthUsage ) );
			
			if( data.curMonthUsage == null )				
				$('#curMonthUsage').text( "0" );
			else
				$('#curMonthUsage').text( 		numberWithCommas(data.curMonthUsage) );
			
			if( data.curPredictUsage == null )				
				$('#curPredictUsage').text( "0" );
			else
				$('#curPredictUsage').text( 	numberWithCommas(data.curPredictUsage) );
			
			
			var d = new Date();	

			YYYY = d.getFullYear();
			MM = (d.getMonth()+1)>9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1);
			DD = d.getDate()>9 ? ''+d.getDate() : '0'+d.getDate();
			HH = d.getHours()>9 ? ''+d.getHours() : '0'+d.getHours();
			MIN = d.getMinutes()>9 ? ''+d.getMinutes() : '0'+d.getMinutes();	
		    
		    $('#inquiry_time').text( "조회시간 : " + YYYY + "/" + MM + "/" + DD + " " + HH + ":" + MIN );
		    
		    fncEnergyChart( strCd );
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}





//pie그래프
function storeAlarmData( strCd )
{
	var yResult = 0;
	var nResult = 0;
	var resultCnt = 0;
	var percentVal = 100;
	
	$.ajax({
		url:'/retrieveStoreAlarmData',
		type:'POST',
		cache:false,
		async:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			drawPieChart(data);
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
   	$('#myChart1').highcharts( {
   		
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
			      y:-15,
			      style: { color: '#FF6384', fontWeight: 'normal', fontSize : '25'}
			      
		},
		credits : {
			enabled : false
		},
		colors : ['#36A2EB' , '#FF6384'],
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
                showInLegend: true,
                innerSize: 90,
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
	
	//var ctx = $("#myChartPop");
/* 	Chart.defaults.global.defaultFontColor = "orange";
	Chart.defaults.global.defaultFontFamily = "나눔 고딕";
	Chart.defaults.global.defaultFontSize = 7;
	Chart.defaults.global.defaultFontStyle = "bold";
	
	
	Chart.defaults.global.tooltips.backgroundColor = "grey";
	
	
	Chart.defaults.global.tooltips.bodyFontSize = 5;
	Chart.defaults.global.tooltips.bodyFontStyle = "normal";
	
	Chart.defaults.global.tooltips.intersect = true;
	
	Chart.defaults.global.elements.arc.backgroundColor = "red";
	Chart.defaults.global.elements.arc.borderColor = "red";
	Chart.defaults.global.elements.arc.borderWidth = 50;
	
	var data = {
	    labels: [ "미조치", "조치완료" ],
	    datasets: [{
	    	data: [nResult, yResult],
    	    backgroundColor: [ "#FF6384", "#36A2EB" ],
            borderColor : ["#ffffff", "#ffffff"],
            borderWidth : [1, 1],
            hoverBackgroundColor: [ "#FF6384", "#36A2EB" ],
	        //hoverBorderColor : [],
	        //hoverBorderWidth : [,],
	        hoverRadius : [10, 50]
	        
	    }]
	};
	var data1 = {
		    labels: [ "미조치", "조치완료" ],
		    datasets: [{
		    	data: [0, 0],
	    	    backgroundColor: [ "#FF6384", "#36A2EB" ],
	            borderColor : ["#ffffff", "#ffffff"],
	            borderWidth : [1, 1],
	            hoverBackgroundColor: [ "#FF6384", "#36A2EB" ],
		        //hoverBorderColor : [],
		        //hoverBorderWidth : [,],
		        hoverRadius : [10, 50]
		        
		    }]
		};
	
	Chart.pluginService.register({
		  beforeDraw: function(chart) {
		    var width = chart.chart.width,
		        height = chart.chart.height,
		        ctx = chart.chart.ctx,
		        type = chart.config.type;
			
		    
		    var pageType = $("#myChart1").text();
		    
		    console.log( 'pageType : ' + pageType );
		    if (type == 'doughnut'){
		    	
		    	var percent = percentVal;							
				var oldFill = ctx.fillStyle;
				var fontSize = ((height - chart.chartArea.top) / 100).toFixed(2);
		      
				ctx.restore();
				ctx.font = fontSize + "em 나눔 고딕";
				ctx.textBaseline = "middle"								
			
				var text;
				console.log( "per : " + percent );
				if( percent == 100 )						
				{
					text = "완료";
				}
				else
				{
					text = percent + "%";
				}
				if(percent == 0){
					nResult=0; 
					yResult=0;
				}
				var textX = Math.round((width - ctx.measureText(text).width) / 2);
				var textY = (height + chart.chartArea.top) / 2 - 20;
				ctx.fillStyle = chart.config.data.datasets[0].backgroundColor[0];
				ctx.clearRect(0,0,width,height);	
				ctx.fillText(text, textX, textY);
				ctx.width =	ctx.width;
				ctx.fillStyle = oldFill;
				ctx.save();
		    }
		  }
		});
	
	var options = {
		cutoutPercentage : 80,
		responsiveAnimationDuration : 500,
		display: false,
			responsive: true,
			legend: {
   			position: 'bottom',
			},
			title: {
   			display: false,
   			text: 'Doughnut Chart'
			},
	    	tooltips: {enabled: false }, 
	    	hover: {mode: null}, 
	    	
	    animation: {
	    	animateScale: false,
	        animateRotate: true,
	        onComplete: function () {
	        	
				//var ctx = this.chart.ctx;
				for (var key in this.data.datasets) { //오브젝트 obj
					   if (this.data.datasets.hasOwnProperty(key)) { 
					       var data = this.data.datasets[key];
					       console.log(data);

					   }
					}
				 this.data.datasets.forEach(function (dataset) {
				
					for (var i = 0; i < dataset.data.length; i++) {
				    	var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
				        var total = dataset._meta[Object.keys(dataset._meta)[0]].total;
				        var mid_radius = model.innerRadius + (model.outerRadius - model.innerRadius)/2;
				        var start_angle = model.startAngle;
				        var end_angle = model.endAngle;
				        var mid_angle = start_angle + (end_angle - start_angle)/2;
				        mid_angle=0;
				        end_angle=0;
				        start_angle=0;
				      	var x = mid_radius * Math.cos(mid_angle)-5;
				      	var y = mid_radius * Math.sin(mid_angle);
				
				      	//ctx.fillStyle = '#ffffff';

				      	var val = dataset.data[i];
						var percent = String(Math.round(val/total*100)) + "%";
				
						if(val != 0) {
				        	//ctx.fillText(dataset.data[i], model.x + x, model.y + y);
				        	//ctx.fillText(percent, model.x + x, model.y + y + 15);
				      	}
				    }
					delete dataset;
				});  
			}
		},
	};
	var ctx =document.getElementById("myChart1");
	var myChart = new Chart(ctx, {
		type: 'doughnut',
		data: data,
		options: options
	});
	if(resultCnt == 0){
		var myChart = new Chart(ctx, {
			type: 'doughnut',
			data: data1,
			options: options
		});
	} */
}

// 첫번째 탭 - 시설물 알람 처리 현황
function storeAlarmData2343( strCd )
{
	$.ajax({
		url:'/retrieveStoreAlarmData',
		type:'POST',
		cache:false,
		datatype: "json",
		data : { strCd:strCd },
		success:function(data){
			var yResult = numberWithCommas( 	data.yResult );
			var nResult = numberWithCommas( 	data.nResult );
			var resultCnt = numberWithCommas( 	data.resultCnt );
			
						
			if( data.yResult == null )				
				$('#yResult').text( "0" );
			else
				$('#yResult').text( 			yResult );
			
			if( data.nResult == null )				
				$('#nResult').text( "0" );
			else
				$('#nResult').text( 			nResult );

			if( data.resultCnt == null )				
				$('#resultCnt').text( "0" );
			else
				$('#resultCnt').text( 			resultCnt );
			
			
			console.log( yResult );
		
			$('#chrtPie').highcharts( {

				chart : {
					plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        width : 150,
					height : 200,					
			        type: 'pie'
				},
				credits : {
					enabled : false
				},
				colors : [ '#F45B5B', '#7cb5ec'],
				exporting : {
					enabled : false
				},				
				title : {
					text : ""
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
		                showInLegend: true
		            }
		        },
				series: [{
			        name: '매장수 : ',
			        colorByPoint: true,
			        data: [{
			            name: '미조치',
			            y: Number(nResult)
			        }, {
			            name: '조치완료',
			            y: Number(yResult)            
			        }]
			    }]			
				
			});		
      	
		},
		error:function(result){
			//alert("에러가 발생했습니다.");							
			$('#yResult').text( "0" );
			$('#nResult').text( "0" );
			$('#resultCnt').text( "0" );
		}
	});
}



// 첫번째 탭 - 시설물 현황
function storeEqmtData( strCd )
{
	// Grid 출력
	$("#gridEqmtStatus").jqGrid({
		url:'retrieveStoreEqmtData',		
		mtype: 'POST',
		datatype: "local",
	    colNames:['No', '장비명', '온도', '상태', '최근한달알림' ],
     	colModel:[
               {name:'records',			index:'records',	hidden:true},
               {name:'deviceLoc',		index:'deviceLoc', 	width:'auto', 	align:'left', 	sortable:true, 	editable:false},	                  
               {name:'sensTemp',		index:'sensTemp', 	width:'auto', 	align:'center', sortable:true, 	editable:false},
               {name:'normalYn',		index:'normalYn', 	width:'auto', 	align:'center', 	sortable:true, 	editable:false},
               {name:'alarmCnt',		index:'alarmCnt',	width:'auto', 	align:'center', 	sortable:true, 	editable:false}
		],
    	jsonReader : {
			repeatitems:false
    	},    			   	
	   	recordtext: "건/페이지  (전체 {2} 건)",
	   	emptyrecords : "검색 결과가 존재하지 않습니다.",
	   	loadtext: "Loading...",
	   	sortname: 'deviceLoc',
	    viewrecords: true,
	    sortorder: "desc",	     
	    hidegrid: false,
	    shrinkToFit:true,
	 	autowidth : true,
	 	height : 170,	 	
		gridComplete : function()
		{
			$("#gridEqmtStatus tr.jqgrow:even").css("background", "#E0E0E0");
			
			
			
		}	
	 });
	  //jqGrid Resize	
	jqGridResize('gridEqmtStatus');
}


// 첫번째 탭 - 에너지사용현황 차트
function fncEnergyChart( strCd ) 
{
	
	var yyyymm 	= new Array();						
	var total 		= new Array();	
	var temp 		= new Array();
	var etc 		= new Array();
	var tick 		= new Array();
	
	var chartDataTemp	= new Array();		// 차트 냉난방 데이터
	var chartDataEtc	= new Array();		// 차트 기타 데이터
	
	
	// 에너지사용현황 데이터
	$.ajax({
		url:'/retrieveStoreEnergyChartData',
		type:'POST',
		cache:false,
		async: false,
		datatype: "json",
		data : { strCd:strCd },
		success:function(data){
			$.each(data, function(key, value) {
				if(key == 0) {			// yyyymm
					$.each(value, function(idx, val) {						
						yyyymm.push(val);
					});
				}
				else if(key == 1) {		// total
					$.each(value, function(idx, val) {
						if( val < 0 )
							total.push( 0 );
						else
							total.push( val );
					});
				}
				else if(key == 2) {		// temp
					$.each(value, function(idx, val) {
						if( val < 0 )							
							temp.push( 0 );
						else
							temp.push( val );
					});
				}
				else if(key == 3) {		// etc( total-temp)
					$.each(value, function(idx, val) {	
						if( val < 0 )
							etc.push( 0 );
						else
							etc.push( val );
					});
				}
			});
			if(yyyymm.length == 1){
				for(var i=0; i<2;i++) 
				{					
					var getDateTime = Date.UTC(Number( (String)(yyyymm[0]).substr(0,4) ), Number( (String)(yyyymm[0]).substr(4,2))-1, "01", "00", "000");
					var getDateTime1 = Date.UTC(Number( (String)(yyyymm[0]).substr(0,4) ), Number( (String)(yyyymm[0]).substr(4,2))-2, "01", "00", "000");
					tick.push( getDateTime );
					if(i==0){
						chartDataTemp.push( [ getDateTime1, Number(0) ]  );
						chartDataEtc.push( 	[ getDateTime1, Number(0) ]  );
					}else{
						chartDataTemp.push( [ getDateTime, Number( temp[0] ) ]  );
						chartDataEtc.push( 	[ getDateTime, Number( etc[0] ) ]  );
					}
				}
			}else{
				for(var i=0; i<yyyymm.length;i++) 
				{					
					var getDateTime = Date.UTC(Number( (String)(yyyymm[i]).substr(0,4) ), Number( (String)(yyyymm[i]).substr(4,2))-1, "01", "00", "000");
					tick.push( getDateTime );		
					chartDataTemp.push( [ getDateTime, Number( temp[i] ) ]  );
					chartDataEtc.push( 	[ getDateTime, Number( etc[i] ) ]  );
				}
		}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
	
	
	
	Highcharts.setOptions({
		lang: {
				weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
				shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			}
		});
	
	$('#chrtEnergy').highcharts('StockChart', {

		chart : {
			borderWidth : 0,
			borderColor : "#E8E8E8",
			plotBorderWidth : 0,			
			
			height : 150,
			panning : true,
		},
		credits : {
			enabled : false
		},
		colors : [ '#F45B5B', '#7cb5ec'],	
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'left'

		},
		rangeSelector: {
	    	enabled: false,
			/*  buttons: [{
				type: 'minute',
				count: 60,
				text: '1시간'
			}, {
				type: 'day',
				count: 1,
				text: '하루'
			}, {
				type: 'day',
				count: 7,
				text: '일주일'
			},
				{
				type: 'all',
				text: '전체'
			}], */
			selected: 1 

	    },
		loading : {
			style : {
				backgroundColor : 'silver'
			},
			labelStyle : {
				color : 'white'
			}
		},
		navigator : {
			enabled : false,
		},
		scrollbar : {
			enabled : false,
		},
		plotOptions : {
			column : {
				stacking : 'normal'
			}
		},				
		series : [{
			name : '냉난방',
			type : 'column',
			color : '#FF0000',
			data : chartDataTemp,			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' kW',
				positioner : function() {
					return {
						x : 10,
						y : 40
						};
					},
				}			
			},
			{
			name : '기타',
			type : 'column',
			color : '#00D8FF',
			data : chartDataEtc,			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' kW',
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
			type: 'datetime',
			dateTimeLabelFormats: {
				//second: '%Y-%m-%d<br/>%H:%M:%S',
				//minute: '%Y-%m-%d<br/>%H:%M',
				//hour: '%Y-%m-%d<br/>%H:%M',
				//day: '%d일',
				//week: '%Y<br/>%m-%d',
				month: '%y.%m',
				year: '%Y'
			},
		},
		yAxis : {
			labels: {
				enabled : false,				
				allowDecimals : 'true',
				align: 'left',			
	    		formatter: function() {
	    			return (this.value > 0 ? '' : '') + this.value + 'kW';
	    		}
	    	},
	    	min: 0,
	    	
		},		
	});		
}


// 두번째 탭 초기화
function init_B() {
	// 1년 기준
	func_monthBtn(12, 'scrDateB');
	// 월별 전력량
	$("#gridUsedArea").jqGrid({
		url:'retrieveEnergyMonthStatus',  
		datatype: "local",
		mtype: 'POST',
		colNames:['년월', '전체전력량(kWh)', '냉난방전력량(kWh)', '실외온도(℃)'], 
		colModel:[
			/* {name:'yyyymm',index:'yyyymm', width:120,align:'center', resizable    : false,sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', align:'right',width:227, formatter:'number',resizable    : false, formatoptions:{decimalPlaces:0}, sortable:true, editable:false},
			{name:'temp',index:'temp' , align:'right',  width:227, formatter:'number',resizable    : false, formatoptions:{decimalPlaces:0}, sortable:true, editable:false},
			{name:'forecastTemp',index:'forecastTemp', width:225, align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:0}, sortable:true, editable:false}	 */
			{name:'yyyymm',index:'yyyymm',  width:'auto',align:'center', resizable    : false,sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', align:'right', width:'auto', formatter:'number',resizable    : false, formatoptions:{decimalPlaces:0}, sortable:true, editable:false},
			{name:'temp',index:'temp' , align:'right',   width:'auto', formatter:'number',resizable    : false, formatoptions:{decimalPlaces:0}, sortable:true, editable:false},
			{name:'forecastTemp',index:'forecastTemp',  width:'auto', align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:0}, sortable:true, editable:false}	
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
		rowNum:-1,
		pager:'#gridUsedAreaPager',
		recordtext:"전체 {2} 건",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname: 'yyyymm',
		viewrecords: true,
		sortorder: "desc",
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,	
		height: '200',
		onSelectRow : function(rowid, status, e) {
			var list   = $("#gridUsedArea").getRowData(rowid);
			var yyyymm = list.yyyymm.replace("-", "");
			fncRetrieveUsedDailyArea(yyyymm);		// 일별 사용량 Gird 출력
		},
		loadComplete : function(data) {
			// 페이징 숨기기
			$("#gridUsedAreaPager_center").hide();
			
			var list   = $("#gridUsedArea").getRowData();
			var rowCnt = list.length;
			// 첫번째 row를 선택
			if( rowCnt > 0 ) {
				$("#gridUsedArea").jqGrid('setSelection', 1);
			}
		}		
	});
	
	// 일자별 전력량 
	$("#gridUsedDailyArea").jqGrid({
		url:'retrieveEnergyDayStatus_tab',
		datatype: "local", 	// 월이 선택되면 수행
		mtype: 'POST',
		colNames:['일자', '전체전력량(kWh)', '냉난방전력량(kWh)', '실내온도(℃)', '실외온도(℃)', 'yyyymmdd'],
		colModel:[
			/*  {name:'dd',index:'dd',  width:100, align:'center',resizable    : false, sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', width:175,align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp', width:175,align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'tSensorTemp',index:'tSensorTemp', width:175, align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'forecastTemp',index:'forecastTemp', width:175, align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'yyyymmdd',index:'yyyymmdd', hidden:true}  */
			 {name:'dd',index:'dd',  width:'auto', align:'center',resizable    : false, sortable:true, editable:false, editoptions:{readonly:true,size:10}},
				{name:'total',index:'total', width:'auto',align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
				{name:'temp',index:'temp', width:'auto',align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
				{name:'tSensorTemp',index:'tSensorTemp', width:'auto', align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
				{name:'forecastTemp',index:'forecastTemp', width:'auto', align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
				{name:'yyyymmdd',index:'yyyymmdd', hidden:true} 
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
		rowNum:-1,
		pager:'#gridUsedDailyAreaPager',
		recordtext:"전체 {2} 건",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname: 'dd',
		viewrecords: true,
		sortorder: "desc",
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '200',		
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list   = $("#gridUsedDailyArea").getRowData(rowid);
			var yyyymmdd = list.yyyymmdd;

			fncRetrieveDailyChart(yyyymmdd);		// 일별 상세 전력량 차트
		},
		loadBeforeSend : function() {
		},
		loadComplete : function(data) {
			// 페이징 숨기기
			$("#gridUsedDailyAreaPager_center").hide();
			
			var list   = $("#gridUsedDailyArea").getRowData();
			var rowCnt = list.length;
			// 첫번째 row를 선택
			if (rowCnt > 0) {
				$("#gridUsedDailyArea").jqGrid('setSelection', 1);
			} 
		}
	});
	jqGridResize('gridUsedArea');
	jqGridResize('gridUsedDailyArea');
}

// 두번째 탭 조회버튼
function fncSearch_B() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var strCd = $.trim($("#strCd").val());
	var scrDateFrom = $.trim($("#scrDateBFrom").val());
	var scrDateTo = $.trim($("#scrDateBTo").val());
	
	if(scrDateFrom > scrDateTo){
		alert("기간을 확인해주세요.");
		return false;
	}
	
	$("#gridUsedArea").clearGridData();
	$("#gridUsedDailyArea").clearGridData();
	$('#chrtMain').html('');
	
	 $("#gridUsedArea").setGridParam({
		datatype : "json",		
		postData : {
			scrStrCd:strCd,
			scrDateFrom:scrDateFrom,
			scrDateTo:scrDateTo
		}
	}).trigger("reloadGrid"); 
}

// 두번째 탭 일별 전력량
function fncRetrieveUsedDailyArea(yyyymm) {
	var strCd = $.trim($("#strCd").val());
	
	$('#chrtMain').html('');						// 차트 지우기
	$("#gridUsedDailyArea").clearGridData();		// 일별 grid 지우기
	
	$("#gridUsedDailyArea").setGridParam({
		datatype : "json",
		postData : {
			scrStrCd:strCd,
			scrYyyymm : yyyymm
		}
	}).trigger("reloadGrid");
}

// 두번째 탭 일별 상세 전력량
function fncRetrieveDailyChart(yyyymmdd) {
	var strCd = $.trim($("#strCd").val());
	
	var param = new Object();	
	param.scrStrCd = strCd;
	param.scrYyyymmdd = yyyymmdd;		
	
	$.ajax({
		async: false,
		url : "retrieveEnergyDayStatusChart",
		dataType : "json",
		data : param,
		success : function(data) {
			fncDailyChart(data);
		}
	});
}

// 두번째 탭 일별 상세 전력량 그래프
function fncDailyChart(data) {
	$('#chrtMain').html('');
	
	var list = data.rows;
	var rowCnt = list.length;

	var chartDataTemp	= new Array();		// 차트 냉난방 데이터
	var chartDataEtc	= new Array();		// 차트 기타 데이터
	
	var yy = "";
	var mm = "";
	var dd = "";
	var hh = "";
	var mi = "";
	var getDateTime = "";
			
	/*
	for (var i = rowCnt -1; i >= 0; i--) {
		
		yy = Number((String)(list[i].yyyymmdd).substr(0, 4));
		mm = Number((String)(list[i].yyyymmdd).substr(4, 2)) -1;
		dd = Number((String)(list[i].yyyymmdd).substr(6, 2));
		hh = Number((String)(list[i].hh));
		mi = "0";
		
		console.log( yy, mm, dd, hh, mi );
		getDateTime = Date.UTC(yy, mm, dd, hh, mi);
		
		if( list[i].temp < 0 )
			chartDataTemp.push([getDateTime, Number(0)]);
		else
			chartDataTemp.push([getDateTime, Number(list[i].temp)]);
		
		if( list[i].etc < 0 )
			chartDataEtc.push([getDateTime, Number(0)]);
		else
			chartDataEtc.push([getDateTime, Number(list[i].etc)]);		
	}
	*/
	for (var i = 0; i < rowCnt; i++) {
		
		yy = Number((String)(list[i].yyyymmdd).substr(0, 4));
		mm = Number((String)(list[i].yyyymmdd).substr(4, 2)) -1;
		dd = Number((String)(list[i].yyyymmdd).substr(6, 2));
		hh = Number((String)(list[i].hh));
		mi = "0";
		
		getDateTime = Date.UTC(yy, mm, dd, hh, mi);
		
		if( list[i].temp < 0 )
			chartDataTemp.push([Number(getDateTime), Number(0)]);
		else
			chartDataTemp.push([Number(getDateTime), Number(list[i].temp)]);
		
		if( list[i].etc < 0 )
			chartDataEtc.push([Number(getDateTime), Number(0)]);
		else
			chartDataEtc.push([Number(getDateTime), Number(list[i].etc)]);		
	}
	
	Highcharts.setOptions({
		lang: {
			weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		}
	});

	$('#chrtMain').highcharts('StockChart', {
		chart : {
			borderWidth : 1,
			borderColor : "#E8E8E8",
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 300,
			panning : true,
		},
		credits : {
			enabled : false
		},
		colors : [ '#F45B5B', '#7cb5ec'],
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'center'
		},
		rangeSelector: {
	    	enabled: false,
			buttons: [{
				type: 'minute',
				count: 60,
				text: '1시간'
			}, {
				type: 'day',
				count: 1,
				text: '하루'
			}, {
				type: 'day',
				count: 7,
				text: '일주일'
			}, {
				type: 'month',
				count: 1,
				text: '한달'
			}, {
				type: 'all',
				text: '전체'
			}],
			selected: 1
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
		series : [{
			name : '냉난방',
			type : 'column',
			data : chartDataTemp,			
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
			},
			{
				name : '기타',
				type : 'column',
				data : chartDataEtc,				
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
			type: 'datetime',
			dateTimeLabelFormats: {
				//second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%H시',
				hour: '%H시',
				day: '%d일',
				//week: '%Y<br/>%m-%d',
				//month: '%Y-%m',
				//year: '%Y'
			},
		},
		yAxis : {
			labels: {
				allowDecimals : 'true',
				align: 'left',			
	    		formatter: function() {
	    			return (this.value > 0 ? '' : '') + this.value + 'Kw';
	    		}
	    	},
	    	min: 0,	    	
		},		
	});			
}

// 세번째 탭 초기화
function init_C() {
	// 1년 기준
	func_monthBtn(12, 'scrDateC');
	// 월별 계약전력량
	$("#gridMonthDemandList").jqGrid({
		url:'retrieveDemandEnergyMonthStatus',
		datatype: "local",
		mtype: 'POST',
		colNames:['년월', '계약전력(KW)', '최대수요전력(KW)','여유전력(KW)', '최대냉난방전력(KW)'],
		colModel:[
			/* {name:'yyyymm',index:'yyyymm', width:120,  align:'center',resizable    : false, sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'contPower',index:'contPower', width:165, align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'total',index:'total', width:172,  align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'freePower',index:'freePower',  width:164, align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp', width:172,  align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false}			 */
			{name:'yyyymm',index:'yyyymm', width:'auto',  align:'center',resizable    : false, sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'contPower',index:'contPower', width:'auto', align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'total',index:'total', width:'auto',  align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'freePower',index:'freePower',  width:'auto', align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp', width:'auto',  align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false}			
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
		rowNum:-1,
		pager:'#gridMonthDemandListPager',
		recordtext:"전체 {2} 건",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname: 'yyyymm',
		viewrecords: true,
		sortorder: "desc",
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,	
		height: '200',
		onSelectRow : function(rowid, status, e) {
			var list   = $("#gridMonthDemandList").getRowData(rowid);
			var yyyymm = list.yyyymm.replace("-", "");
			fncRetrieveDayDemandList(yyyymm);		// 일별 계약전력 대비 사용량 Gird 출력
		},
		loadComplete : function(data) {
			// 페이징 숨기기
			$("#gridMonthDemandListPager_center").hide();
			
			var list   = $("#gridMonthDemandList").getRowData();
			var rowCnt = list.length;
						
			// 첫번째 row를 선택
			if( rowCnt > 0 ) {
				$("#gridMonthDemandList").jqGrid('setSelection', 1);
			}
		}		
	});
	
	// 일자별 계약전력 대비 사용량 
	$("#gridDayDemandList").jqGrid({
		url:'retrieveEnergyDayStatus',
		datatype: "local", 	// 월이 선택되면 수행
		mtype: 'POST',
		colNames:['일자', '최대수요전력(KW)', '여유전력(KW)', '최대냉난방전력(KW)', 'yyyymmdd'],
		colModel:[
			/* {name:'dd',index:'dd', width:111, align:'center',resizable    : false, sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total',width:230,  align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'contMinusTotal', width:230, index:'contMinusTotal',resizable    : false, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp',width:230, align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
		//	{name:'tSensorTemp',index:'tSensorTemp', width:230, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'yyyymmdd',index:'yyyymmdd', hidden:true} */
			{name:'dd',index:'dd', width:'auto', align:'center',resizable    : false, sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total',width:'auto',  align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'contMinusTotal', width:'auto', index:'contMinusTotal',resizable    : false, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp',width:'auto', align:'right',resizable    : false, formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
		//	{name:'tSensorTemp',index:'tSensorTemp', width:230, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'yyyymmdd',index:'yyyymmdd', hidden:true}
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
		rowNum:-1,
		pager:'#gridDayDemandListPager',
		recordtext:"전체 {2} 건",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname: 'dd',
		viewrecords: true,
		sortorder: "desc",
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '200',		
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list   = $("#gridDayDemandList").getRowData(rowid);
			var yyyymmdd = list.yyyymmdd;

			fncRetrieveDemandChart(yyyymmdd);		// 일별 상세 계약전력량 차트
		},
		loadBeforeSend : function() {
		},
		loadComplete : function(data) {
			// 페이징 숨기기
			$("#gridDayDemandListPager_center").hide();
			
			var list   = $("#gridDayDemandList").getRowData();
			var rowCnt = list.length;
							
			// 첫번째 row를 선택
			if (rowCnt > 0) {
				$("#gridDayDemandList").jqGrid('setSelection', 1);
			}
		}
	});

}

// 세번째 탭 조회버튼
function fncSearch_C() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var strCd = $.trim($("#strCd").val());
	var scrDateFrom = $.trim($("#scrDateCFrom").val());
	var scrDateTo = $.trim($("#scrDateCTo").val());
	
	if(scrDateFrom > scrDateTo){
		alert("기간을 확인해주세요.");
		return false;
	}
	
	$("#gridMonthDemandList").clearGridData();
	$("#gridDayDemandList").clearGridData();
	$('#chrtDemand').html('');

	$("#gridMonthDemandList").setGridParam({
		datatype : "json",		
		postData : {
			scrStrCd:strCd,
			scrDateFrom:scrDateFrom,
			scrDateTo:scrDateTo
		}
	}).trigger("reloadGrid");
}

// 세번째 탭 일별 계약전력 대비 사용량
function fncRetrieveDayDemandList(yyyymm) {
	var strCd = $.trim($("#strCd").val());
	
	$('#chrtDemand').html('');						// 차트 지우기
	$("#gridDayDemandList").clearGridData();		// 일별 grid 지우기
	
	$("#gridDayDemandList").setGridParam({
		datatype : "json",
		postData : {
			scrStrCd:strCd,
			scrYyyymm : yyyymm
		}
	}).trigger("reloadGrid");
}

// 세번째 탭 일별 상세 계약전력량
function fncRetrieveDemandChart(yyyymmdd) {
	var strCd = $.trim($("#strCd").val());
	
	var param = new Object();	
	param.scrStrCd = strCd;
	param.scrYyyymmdd = yyyymmdd;		
	
	$.ajax({
		async: false,
		url : "retrieveDemandEnergyDayStatusChart",
		dataType : "json",
		data : param,
		success : function(data) {
			fncDemandChart(data);
		}
	});
}

// 세번째 탭 일별 상세 계약전력량 그래프
function fncDemandChart(data) {
	$('#chrtDemain').html('');
	
	var list = data.rows;
	var rowCnt = list.length;
	
	var chartDataContPower		= new Array();	// 차트 계약전력
	var chartDataMaxContPower	= new Array();	// 차트 최대수요전력
	
	var yy = "";
	var mm = "";
	var dd = "";
	var hh = "";
	var mi = "";
	var getDateTime = "";
	
	/*
	for (var i = rowCnt -1; i >= 0; i--) {
		yy = Number((String)(list[i].yyyymmdd).substr(0, 4));
		mm = Number((String)(list[i].yyyymmdd).substr(4, 2)) -1;
		dd = Number((String)(list[i].yyyymmdd).substr(6, 2));
		hh = Number((String)(list[i].hh));
		mi = Number((String)(list[i].qrt));
	
		getDateTime = Date.UTC(yy, mm, dd, hh, 0);
	
		chartDataContPower.push([getDateTime, Number(list[i].contPower)]);
		chartDataMaxContPower.push([getDateTime, Number(list[i].total)]);
	}
	*/
	for (var i = 0; i < rowCnt; i++) {
		yy = Number((String)(list[i].yyyymmdd).substr(0, 4));
		mm = Number((String)(list[i].yyyymmdd).substr(4, 2)) -1;
		dd = Number((String)(list[i].yyyymmdd).substr(6, 2));
		hh = Number((String)(list[i].hh));
		mi = Number((String)(list[i].qrt));
	
		getDateTime = Date.UTC(yy, mm, dd, hh, 0);
	
		chartDataContPower.push([getDateTime, Number(list[i].contPower)]);
		chartDataMaxContPower.push([getDateTime, Number(list[i].total)]);
	}
	
		
	Highcharts.setOptions({
		lang: {
			weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		}
	});

	$('#chrtDemand').highcharts('StockChart', {
		chart : {
			borderWidth : 1,
			borderColor : "#E8E8E8",
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 300,
			panning : true,
		},
		credits : {
			enabled : false
		},
		//colors : ['#D80546', '#F5516C'],
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'center'
		},
		rangeSelector: {
	    	enabled: false,
			buttons: [{
				type: 'minute',
				count: 60,
				text: '1시간'
			}, {
				type: 'day',
				count: 1,
				text: '하루'
			}, {
				type: 'day',
				count: 7,
				text: '일주일'
			},
				{
				type: 'all',
				text: '전체'
			}],
			selected: 1
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
		series : [{
			name : '계약전력',
			type : 'line',
			data : chartDataContPower,			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' kW',
				positioner : function() {
					return {
						x : 10,
						y : 40
						};
					},
				}			
			},
			{
			name : '최대수요전력',
			type : 'line',
			data : chartDataMaxContPower,			
			tooltip : {
				valueDecimals : 1,
				shared : false,
				valueSuffix : ' kW',
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
			type: 'datetime',
			dateTimeLabelFormats: {
				//second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%H시',
				hour: '%H시',
				day: '%d일',
				//week: '%Y<br/>%m-%d',
				//month: '%Y-%m',
				//year: '%Y'
			},
		},
		yAxis : {
			labels: {
				allowDecimals : 'true',
				align: 'left',			
	    		formatter: function() {
	    			return (this.value > 0 ? '' : '') + this.value + 'Kw';
	    		}
	    	},
	    	min: 0,
		},		
	});
}

// 네번째 탭 초기화
function init_D() {
	// 시설물 목록
	$("#gridFacilityList").jqGrid({
		url:'retrieveFacilityStatus',
		datatype: "local",
		mtype: 'POST',
	    colNames:['No', '장비명', '장비유형', '최고온도(℃)', '최저온도(℃)', '최근한달알림', 'strCd', 'temonType','portNo','temonId', 'yyyymmdd'],
	    colModel:[
	    	{name:'records', index:'records', width:170, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
	        {name:'deviceLoc', index:'deviceLoc', width:300, align:'left', sortable:true, editable:false},
	        {name:'temonTypeName', index:'temonTypeName', width:300, align:'center', sortable:true, editable:false},	                	                
	        {name:'maxSensTemp', index:'maxSensTemp', width:300, align:'right', sortable:true, editable:false, formatter:'number', formatoptions:{decimalPlaces:0}},	                
	        {name:'minSensTemp', index:'minSensTemp', width:300, align:'right', sortable:true, editable:false, formatter:'number', formatoptions:{decimalPlaces:0}},	                
	        {name:'alarmCnt', index:'alarmCnt', width:300, align:'center', sortable:true, editable:false},
	        {name:'strCd', index:'strCd', hidden:true},
	        {name:'temonType', index:'temonType', hidden:true},
	        {name:'portNo', index:'portNo', hidden:true},
	        {name:'temonId', index:'temonId', hidden:true},
	        {name:'yyyymmdd', index:'yyyymmdd', hidden:true}
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
		rowNum:-1,
		pager:'#gridFacilityListPager',
		recordtext:"전체 {2} 건",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname: 'deviceLoc',
		viewrecords: true,
		sortorder: "asc",
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,	
		height: '200',
		onSelectRow : function(rowid, status, e) {
			var list   = $("#gridFacilityList").getRowData(rowid);
			fncRetrieveFacilityChart(list);		// 시설물온도 차트
		},
		gridComplete : function()
		{
			jqGridEven('gridFacilityList');			 
			var rsltCount = $("#gridFacilityList").getGridParam("reccount");			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridFacilityList >tbody").append("<tr><td align='center' colspan='6'>검색 결과가 없습니다.</td></tr>");
			}	
		},			
		loadComplete : function(data) {
			// 페이징 숨기기
			$("#gridFacilityListPager_center").hide();
			
			var list   = $("#gridFacilityList").getRowData();
			var rowCnt = list.length;
			// 첫번째 row를 선택
			if( rowCnt > 0 ) {
				$("#gridFacilityList").jqGrid('setSelection', 1);
			}
		}		
	});
}

// 네번째 탭 조회버튼
function fncSearch_D() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var strCd = $.trim($("#strCd").val());
	var scrYyyymmdd = $.trim($("#scrYyyymmdd").val());
	
	$("#gridFacilityList").clearGridData();
	$('#chrtFacility').html('');

	$("#gridFacilityList").setGridParam({
		datatype : "json",		
		postData : {
			scrStrCd:strCd,
			scrYyyymmdd:scrYyyymmdd
		}
	}).trigger("reloadGrid");
}

// 네번째 탭 시설물온도 차트
function fncRetrieveFacilityChart(list) {
	var strCd = $.trim($("#strCd").val());	
	var yyyymmdd = list.yyyymmdd.replace("-", "");
	var temonId = list.temonId;
	var temonType = list.temonType;
	var portNo = list.portNo;
	
	var param = new Object();	
	param.scrStrCd = strCd;
	param.scrTemonId = temonId;
	param.scrTemonType = temonType;
	param.scrPortNo = portNo;
	param.scrYyyymmdd = yyyymmdd;		
	
	$.ajax({
		async: false,
		url : "retrieveFacilityStatusChart",
		dataType : "json",
		data : param,
		success : function(data) {
			fncFacilityChart(data);
		}
	});
}

// 네번째 탭 시설물 온도 그래프
function fncFacilityChart(data) {
	$('#chrtFacility').html('');
	
	var list = data.rows;
	var rowCnt = list.length;
	
	var chartData		= new Array();	// 차트 데이터
	
	var yy = "";
	var mm = "";
	var dd = "";
	var hh = "";
	var mi = "";
	var getDateTime = "";
	
	for (var i = 0; i < rowCnt; i++) {
		yy = Number((String)(list[i].yyyymmdd).substr(0, 4));
		mm = Number((String)(list[i].yyyymmdd).substr(4, 2)) -1;
		dd = Number((String)(list[i].yyyymmdd).substr(6, 2));
		hh = Number((String)(list[i].hhmin).substr(0, 2));
		mi = Number((String)(list[i].hhmin).substr(2, 2));
		
		getDateTime = Date.UTC(yy, mm, dd, hh, mi);
		
		if( Number(list[i].sensTemp) <= -50 || Number(list[i].sensTemp) >= 50  )
			chartData.push([ Number(getDateTime), null]);
		else
			chartData.push([ Number(getDateTime), Number(list[i].sensTemp)]);		
		
	}
	
	var selrow = $.trim($("#gridFacilityList").getGridParam("selrow"));
	var rowData = $("#gridFacilityList").getRowData(selrow);
	var deviceLocName = $.trim(rowData.deviceLoc);

	Highcharts.setOptions({
		lang: {
			weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		}
	});

	$('#chrtFacility').highcharts('StockChart', {
		chart : {
			borderWidth : 1,
			borderColor : "#E8E8E8",
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 300,
			panning : true,
		},
		credits : {
			enabled : false
		},
		//colors : ['#D80546', '#F5516C'],
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'center'
		},
		rangeSelector: {
	    	enabled: false,
			buttons: [{
				type: 'minute',
				count: 180,
				text: '3시간'
			}, {
				type: 'minute',
				count: 360,
				text: '6시간'
			}, {
				type: 'all',
				text: '전체'
			}],
			selected: 3,
			inputEnabled: false
	    },
		loading : {
			style : {
				backgroundColor : 'silver'
			},
			labelStyle : {
				color : 'white'
			}
		},						
		series : [{
			name : deviceLocName,
			type : 'spline',
			data : chartData,			
			tooltip : {				
				shared : false,
				valueSuffix : ' ℃',
				positioner : function() {
					return {
						x : 10,
						y : 40
						};
					},
				}			
			},			
		],		
		xAxis : {
			type: 'datetime',
			dateTimeLabelFormats : {
				second : '%H:%M',
				minute : '%H:%M',
				hour : '%H시',
				day : '%H:%M',
				week : '%H:%M',
				month : '%H:%M',
				year : '%H:%M',
			},
			tickInterval: 1 * 3600 * 1000,
			gridLineWidth : 1,
			labels : {
				style : {
					fontSize : '1em'
				},
			},
		},
		yAxis : {			
			labels: {				
				align: 'left',			
	    		formatter: function() {
	    			return this.value + '℃';
	    		}
	    	},
	    	min: -50,	    
	    	max: 50,
		},		
		
		
	});	
}

// 다섯번째 탭 초기화
function init_E() {
	// 라디오버튼 선택
	$("input:radio[name='scrAsResult']:input[value='']").prop("checked", true);
	
	// 1년 기준
	func_monthBtn(12, 'scrDateE');
	
	// 시설물 목록
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveAlarmStatus',
		datatype: "local",
		mtype: 'POST',
		colNames:['No', '장비명', '알람시작시간', '최종알람시간', '상태', '장애내용', '업체명', 'A/S기사', '조치일시', '조치방법', '조치내용', '최근알림', 'strCd', 'temonId', 'temonType', 'portNo', 'yyyymmdd', 'hhmin'],
    	colModel:[
			{name:'records',		index:'records',		width:50,	align:'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},	                
			{name:'deviceLoc',		index:'deviceLoc', 		width:110, 	align:'center',	sortable:true, editable:false},	                
			{name:'alarmDateS',		index:'alarmDateS', 	width:140,	align:'center', sortable:true, editable:false},
			{name:'alarmDateE',		index:'alarmDateE', 	width:140, 	align:'center', sortable:true, editable:false},
			{name:'asResult',		index:'asResult', 		width:70, 	align:'center', sortable:true, editable:false},
			{name:'alarmMessage',	index:'alarmMessage',	width:300, 	align:'left', sortable:false, editable:false},
			{name:'asVendorNm',		index:'asVendorNm', 	width:150, 	align:'center', sortable:false, editable:false},
			{name:'asEngineer',		index:'asEngineer', 	width:100, 	align:'center', sortable:false, editable:false},
			{name:'asDate',			index:'asDate', 		width:140, 	align:'center', sortable:false, editable:false},
			{name:'asContents',		index:'asContents', 	width:90, 	align:'center',	sortable:false, editable:false},
			{name:'asNote',			index:'asNote', 		width:300, 	align:'left', sortable:false, editable:false},
			{name:'alarmCnt',		index:'alarmCnt', 		width:80, 	align:'center', sortable:false, editable:false},	                
			{name:'strCd',			index:'strCd', 			hidden:true},
			{name:'temonId',		index:'temonId', 		hidden:true},
			{name:'temonType',		index:'temonType', 		hidden:true},
			{name:'portNo',			index:'portNo', 		hidden:true},
			{name:'yyyymmdd',		index:'yyyymmdd', 		hidden:true},
			{name:'hhmin',			index:'hhmin', 			hidden:true}
        ],
		jsonReader : {
		     repeatitems:false
		},
		rowNum:20,
	    rowList:[10,20,50,100],
		pager:'#gridStoreMgntPager',
		recordtext: "{1}건/페이지  (전체 {2} 건)",
		emptyrecords:"검색 결과가 존재하지 않습니다.",
		loadtext:"Loading...",
		sortname: 'deviceLoc',
		viewrecords: true,
		sortorder: "asc",
		hidegrid: false,
		autowidth: true,
		shrinkToFit: false,	
		height: '400',
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='12'>검색 결과가 없습니다.</td></tr>");
			}	
		},	
		loadComplete : function(data) {
			var list   = $("#gridStoreMgnt").getRowData();
			var rowCnt = list.length;
			// 첫번째 row를 선택
			if( rowCnt > 0 ) {
				$("#gridStoreMgnt").jqGrid('setSelection', 1);
			}
		}		
	});
}

// 다섯번째 탭 조회버튼
function fncSearch_E() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var strCd = $.trim($("#strCd").val());
	var scrDateFrom = $.trim($("#scrDateEFrom").val());
	var scrDateTo = $.trim($("#scrDateETo").val());
	var scrEqmt = $.trim($("#scrEqmt").val());
	var scrAsResult = $.trim($(":radio[name='scrAsResult']:checked").val());
	var scrVendorNm = $.trim($("#scrVendorNm").val());
	
	if(scrDateFrom > scrDateTo){
		alert("기간을 확인해주세요.");
		return false;
	}
	
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		datatype : "json",		
		postData : {
			scrStrCd:strCd,
			scrDateFrom:scrDateFrom,
			scrDateTo:scrDateTo,
			scrEqmt:scrEqmt,
			scrAsResult:scrAsResult,
			scrVendorNm:scrVendorNm
		}
	}).trigger("reloadGrid");
}

// 조치내용 버튼
function fncAlarmConfirm() {
	var selrow = $.trim($("#gridStoreMgnt").getGridParam("selrow"));	// 알림 선택된 로우
	if (selrow == "") {
		alert("알림 목록을 먼저 선택하세요.");
		return false;
	}

	var list = $("#gridStoreMgnt").getRowData(selrow);					// 선택된 리스트 정보
	var userNm = $.trim($('#userNm').val());
	var popupTitle = "";

	var args = new Object();
	args.strCd			= list.strCd;
	args.temonId		= list.temonId;
	args.temonType		= list.temonType;
	args.portNo			= list.portNo;
	args.yyyymmdd		= list.yyyymmdd;
	args.hhmin			= list.hhmin;
	args.asEngineer		= list.asEngineer;
	args.userNm			= userNm;
	
	if (userNm == $.trim(list.asEngineer)) {
		popupTitle = "조치내용 수정";
		args.mode = "MODIFY";
	} else {
		if ($.trim(list.asEngineer) == "") {
			popupTitle = "조치내용 입력";
			args.mode = "INPUT";
		} else {
			popupTitle = "조치내용 조회";
			args.mode = "SEARCH";
		}
	}		

	fn_divPop("eqmtMessagePop", popupTitle, 650, 550, args);			// 조치내역 입력 팝업
}

// 선택된 리스트(팝업용)
function getSelectedRow() {
	var grid = $("#gridStoreMgnt");
	var rowKey = grid.jqGrid('getGridParam', "selrow");
	if (rowKey) {		
		return rowKey;
	} else {
		alert("선택된 알림이 없습니다.");
		return '';
	}
}

// 선택된 페이지(팝업용)
function getSelectedPage() {
	var page = $("#gridStoreMgnt").getGridParam('page'); 
	
	if (page) {
		return page;
	} else {
		alert("선택된 알림이 없습니다.");
		return '';
	}
}

//매장명 검색
function fncStoreSearchBtn() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var strNm = $.trim($("#strNm").val());
	
	var param = new Object();
	param.companyCd 	= companyCd;
	param.strNm 		= strNm;
	
	$.ajax({
		url:'/retrieveStoreCnt',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
			
			var strCnt = data.strCnt;
			// 0개 일때
			if (strCnt == "0") {
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (strCnt == "1") {
				$("#strCd").val(data.strCd);
				var strCd = $("#strCd").val();
				$("#strNm").val(data.strNm);
				$("#viewStrCd").val(data.viewStrCd);
				$("#addr").val(data.addr);
				$("#telNo").val(data.telNo);
				
				if( strCd != "" )
					if(selTab == "a"){
						fncSearch_A();
					}else if(selTab == "b"){
						fncSearch_B();
					}else if(selTab == "c"){
						fncSearch_C();
					}else if(selTab == "d"){
						fncSearch_D();
					}else if(selTab == "e"){
						fncSearch_E();
					}
					//fncSearch_A();
			// 2개 이상일때	
			} else {
				// 조직 팝업
				fncStoreSearch();
			}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}

// 매장명/코드 팝업
function fncStoreSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#strNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;
	
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );
}

// 팝업에서 넘어온 값 세팅
function fncSetStore(data) {
	$("#strCd").val(data.strCd);
	var strCd = $("#strCd").val();
	$("#strNm").val(data.strNm);
	$("#viewStrCd").val(data.viewStrCd);
	$("#addr").val(data.addr);
	$("#telNo").val(data.telNo);	
	
	if( strCd != "" ){
		if(selTab == "a"){
			fncSearch_A();
		}else if(selTab == "b"){
			fncSearch_B();
		}else if(selTab == "c"){
			fncSearch_C();
		}else if(selTab == "d"){
			fncSearch_D();
		}else if(selTab == "e"){
			fncSearch_E();
		}
	}
	//fncSearch_A();

}

// 매장명/코드 클리어
function fncStoreClear() {
	$("#strCd").val("");
	$("#strNm").val("");
	$("#viewStrCd").val("");
	$("#addr").val("");
	$("#telNo").val("");
}

// 날짜(월) 버튼
function func_monthBtn(add, obj) {
	var date = "";
	if (obj == "scrDateE") {
		date = $.trim($("#" + obj + "To").val());
	} else {
		date = $.trim($("#" + obj + "To").val()) + "-01";
	}
	var retDate = gfnDateAdd(date, 'M', add * -1, '-');
	
	if (obj != "scrDateE") retDate = retDate.substring(0, 7);
	$("#" + obj + "From").val(retDate);
}

// 날짜(월) 버튼(전체)
function func_AllBtn(obj) {
	if (obj == "scrDateE") {
		$("#" + obj + "From").val("2010-01-01");
		$("#" + obj + "To").val("${toDay}");
	} else {
		$("#" + obj + "From").val("2010-01");
		$("#" + obj + "To").val("${toDayMonth}");
	}
}

// 날짜(일) 버튼
function func_dayBtn(type) {
	var date = $.trim($("#scrYyyymmdd").val());	
	var addNum = 0;
	if (type == "prev") {
		addNum = -1;
	} else if (type == "next") {
		addNum = 1;
	}

	var retDate = gfnDateAdd(date, 'D', addNum, '-');
	$("#scrYyyymmdd").val(retDate);
}
</script>

<div id="loadingArea">


	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<input type='hidden' id='userNm' name='userNm' value='${userVo.userNm}' />
		<c:if test="${selectVoListCnt == 1 }">
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />
		</c:if>
		<c:if test="${selectVoListCnt > 1 }">			
			<select id="scrCompanyCd" name="scrCompanyCd" style="display:none;">
				<option value=''>--선택--</option>
					<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
			</select>
		</c:if>
		<table>
			<tr>
				<th>매장명/코드</th>
				<td>
					<div class="r_innerSearch">
						<input type='hidden' id='strCd' name='strCd' value="${strInfo.strCd}" /><!-- 매장코드 -->
						<input type='text' id='strNm' name='strNm' value="${strInfo.strNm}" style="width:118px;" class="r_Input r_disable" required />
						<img src="/images/ico_remove2.png" alt="inner search" onclick="javascript:fncStoreClear();" style="cursor:pointer; right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncStoreSearch();" class="icon_search" />
					<input type='text' id='viewStrCd' name='viewStrCd' value="${strInfo.viewStrCd}" style="width:51px;" class="r_Input r_disable" readonly="readonly" required />
					<input type='text' id='addr' name='addr' value="${strInfo.addr}" style="width:250px;" class="r_Input r_disable" readonly="readonly" required />
					<input type='text' id='telNo' name='telNo' value="${strInfo.telNo}" style="width:188px;" class="r_Input r_disable" readonly="readonly" required />
				</td>
			</tr>
		</table>
	</div>
	<!-- //조회조건 -->
	
	<!-- 탭 전체 그룹 -->
	<div class="tab_group">
		<ul class="nav nav-tabs" id="myTab">
			<li class="active"><a href="#a" id="a_tab" class="tab_tab" onfocus="this.blur()">Dashboard</a></li>
		  	<li><a href="#b" id="b_tab" class="tab_tab" onfocus="this.blur()">에너지사용현황</a></li>
		  	<li><a href="#c" id="c_tab" class="tab_tab" onfocus="this.blur()">계약전력</a></li>
		  	<li><a href="#d" id="d_tab" class="tab_tab" onfocus="this.blur()">시설물현황</a></li>
		  	<li><a href="#e" id="e_tab" class="tab_tab" onfocus="this.blur()">알림현황</a></li>
		</ul>
		 
		<div class="tab-content">
		  	<div class="tab-pane dashboard active" id="a">
		  
				<!-- 위젯 -->
				<h3 class="blind">위젯으로 전체 현황 보기</h3>
				<ul class="tab_widgets">
					<li class="date_weather_group">
						<!-- 날짜 -->
						<table>
						<tr>
							<th>
						<div class="date">
							<h4 class="blind">날짜</h4>
							<p id="year_month" class="year_month">2016년/12월</p>
							<p id="day" class="day">16<span class="blind">일</span></p>
							<p id="week_time" class="week_time">금요일/01:52pm</p>
						</div>
						</th>
						<!-- //날짜 -->
						<!-- 날씨 -->
						<th>
						<div class="weather">
							<h4 class="blind">날씨</h4>
							<p class="icon_weather"><img id="weatherCd" src="" /></p>
							<h5 class="outside">실외</h5>
							<p id="forecastTemp" class="outside_temperature">-℃</p>
							<h5  class="interior">실내</h5>
							<p id="tSensorTemp" class="interior_temperature">-℃</p>
						</div>
						</th>
						</tr>
						</table>
						<!-- //날씨 -->
					</li>
					<li><img src="/images/tab_line_widgets_01.png" alt="" /></li>
					<li class="air_heat">
						<p id="tempStat" class="on">-</p>
						<h4>냉난방</h4>
					</li>
					<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
					<li class="refrigerator">
						<p id="tempUnitStat" class="on">-</p>
						<h4>냉장비</h4>
					</li>
					<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
					<li class="sign">
						<p id="signStat" class="on">-</p>
						<h4>간판</h4>
					</li>
					<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
					<li class="sems">
						<p id="semsStat" class="on">-</p>
						<h4>REMS</h4>
					</li>
				</ul>
				<!-- //위젯 -->
		  	
			  	<!-- 대시보드 본문 -->
				<div class="tab_dashboard_body">
			
					<!-- 1단 -->
					<div class="level_01">
			
						<!-- 에너지사용량 -->
						<div class="energy_area">
							<h3>에너지사용량</h3>
							<!-- 
							<p class="btn_month_day">
								<a href="#" title="day"><img src="images/btn_month.png" alt="month" /></a>
								<a href="#" title="month"><img src="images/btn_day.png" alt="month" /></a> 
							</p>
							 -->
							<div class="table_block">
								<ul class="energy_list">
									<li>
										<p class="title"><span class="pr_10">매장계약전력(kW)</span></p>
										<p class="num_gray"><span id="contKilo" class="pl_10">-</span></p>
									</li>
									<li>
										<p class="title"><span class="pr_10">지난달(kWh)</span></p>
										<p class="num_gray"><span id="lastMonthUsage" class="pl_10">-</span></p>
									</li>
									<li>
										<p class="title"><span class="pr_10">이번달(kWh)</span></p>
										<p class="num_blue"><span id="curMonthUsage" class="pl_10">-</span></p>
									</li>
									<li>
										<p class="title"><span class="pr_10">이번달 예측(kWh)</span></p>
										<p class="num_gray"><span id="curPredictUsage" class="pl_10">-</span></p>
									</li>
									<li>
										<p id="inquiry_time" class="inquiry_time">-</p>
									</li>
								</ul>							
								<div class="graph_area">								
									<div id="chrtEnergy"></div>
								</div>
							</div>
							
						</div>
						<!-- //에너지사용량 -->
					
					</div>
					<!-- //1단 -->
				
					<!-- 2단 -->
					<div class="level_02">
				
						<!-- 시설물 알림 처리현황 -->
						<div class="message_condition">
							<h3>시설물 알림 처리현황</h3>
							<ul class="graph_area">
								<li>
									<div id="canvas-holder" style="width:180px;">
				  						<div id="myChart1"></div>
									</div>
								</li>
								<li>
									<div class="inactions">
										<h4 class="title_inactions">미조치</h4>
										<p id="nResult" class="num_Inactions">-</p>
									</div>
								</li>
								<li>
									<div class="action">
										<h4 class="title_action">조치완료</h4>
										<p id="yResult" class="num_action">-</p>
									</div>
								</li>
								<li>
									<div class="total">
										<h4 class="title_total">총건수</h4>
										<p id="resultCnt" class="num_total">-</p>
									</div>
								</li>
							</ul>
						</div>
						<!-- //시설물 알림 처리현황 -->

						<!-- 시설물현황 -->
						<div class="use_condition" id="cont7">
							<h3>시설물현황</h3>
							<div class="table_use_condition">
								<table class="gridPointer" id="gridEqmtStatus"><tr><td></td></tr></table>
							</div>
						</div>
						<!-- //시설물현황 -->
					
					</div>
					<!-- //2단 -->
				
				</div>
				<!-- //대시보드 본문 -->
		  	
			</div>
		  	<div class="tab-pane" id="b" style="display:none;">
		  
				<!-- 탭  조회조건 -->
			  	<div class="r_search multiLine">
					<table>
						<tr>
							<th>기간</th>
							<td>
								<input id="scrDateBFrom" name="scrDateBFrom" type="text" placeholder="" value='' style="width:80px;" readonly />
								<button class="monthBtn" id="scrDateBFromBtn"><img src="/images/btn_calendar_new.png"></button>
								~ <input id="scrDateBTo" name="scrDateBTo" type="text" placeholder="${toDayMonth}" value='${toDayMonth}' style="width:80px;" readonly />
								<button class="monthBtn" id="scrDateBToBtn"><img src="/images/btn_calendar_new.png"></button>
								<button onclick="javascript:func_AllBtn('scrDateB');" class="ml_5">전체</button>
						   		<button onclick="javascript:func_monthBtn(1, 'scrDateB');">1m</button>
						   		<button onclick="javascript:func_monthBtn(6, 'scrDateB');">6m</button>
						   		<button onclick="javascript:func_monthBtn(12, 'scrDateB');">1y</button>
							</td>
						</tr>
					</table>
					<span class="search">
				        <button onclick="javascript:fncSearch_B()">Search</button>
				    </span>
				</div>
				<!-- //탭  조회조건 -->
			
				<!-- 좌우그리드그룹 -->
				<div class="r_halfGridContainer">
					<div class="r_grid r_halfGrid_l r_secondTbl" id="cont1"  style="float: left; width: 50%;">
						<div class="r_inputTblTitle mt_10">
							<h3>월별 전력량</h3>
						</div>
						<table class="gridPointer" id="gridUsedArea"><tr><td></td></tr></table>
						<div id="gridUsedAreaPager"></div>
					</div>
					<div class="r_grid r_halfGrid_l r_secondTbl" id="cont2"  style="float: right; width: 50%;">
						<div class="r_inputTblTitle mt_10">
							<h3>일별 전력량</h3>
						</div>
						<table class="gridPointer" id="gridUsedDailyArea"><tr><td></td></tr></table>
						<div id="gridUsedDailyAreaPager"></div>
					</div>
				</div>
				<!-- //좌우그리드그룹 -->
			
				<!-- 그래프 영역 -->
				<div class="common_section">
					<div class="common_section_title">
						<h3 class="float_n">일별 상세 전력량</h3>
					</div>
					<div id="chrtMain"></div>
				</div>
				<!-- //그래프 영역 -->
		  
		  	</div>
			<div class="tab-pane" id="c" style="display:none;">
		  
				<!-- 탭  조회조건 -->
				<div class="r_search multiLine">
					<table>
						<tr>
							<th>기간</th>
							<td>
								<input id="scrDateCFrom" type="text" placeholder="" value='' style="width:80px;" readonly />
								<button class="monthBtn" id="scrDateCFromBtn"><img src="/images/btn_calendar_new.png"></button>
								~ <input id="scrDateCTo" type="text" placeholder="${toDayMonth}" value='${toDayMonth}' style="width:80px;" readonly />
								<button class="monthBtn" id="scrDateCToBtn"><img src="/images/btn_calendar_new.png"></button>
								<button onclick="javascript:func_AllBtn('scrDateC');" class="ml_5">전체</button>
						   		<button onclick="javascript:func_monthBtn(1, 'scrDateC');">1m</button>
						   		<button onclick="javascript:func_monthBtn(6, 'scrDateC');">6m</button>
						   		<button onclick="javascript:func_monthBtn(12, 'scrDateC');">1y</button>
							</td>
						</tr>
					</table>
					<span class="search">
				        <button onclick="javascript:fncSearch_C()">Search</button>
				    </span>
				</div>
				<!-- //탭  조회조건 -->
			
				<!-- 좌우그리드그룹 -->
				<div class="r_halfGridContainer" >
					<div class="r_grid r_halfGrid_l r_secondTbl"  id="cont3" style="float: left; width: 50%;">
						<div class="r_inputTblTitle mt_10" >
							<h3>월별 계약전력량 (KW)</h3>
						</div>
						<table class="gridPointer" id="gridMonthDemandList"><tr><td></td></tr></table>
						<div id="gridMonthDemandListPager" ></div>
					</div>
					<div class="r_grid r_halfGrid_l r_secondTbl"  id="cont4" style="float: right; width: 50%;">
						<div class="r_inputTblTitle mt_10" >
							<h3>일별 계약전력 대비 사용량 (KW)</h3>
						</div>
						<table class="gridPointer" id="gridDayDemandList" ><tr><td></td></tr></table>
						<div id="gridDayDemandListPager"></div>
					</div>
				</div>
				<!-- //좌우그리드그룹 -->
			
				<!-- 그래프 영역 -->
				<div class="common_section">
					<div class="common_section_title">
						<h3 class="float_n">일별 상세 계약전력량</h3>
					</div>
					<div id="chrtDemand"></div>
				</div>
				<!-- //그래프 영역 -->		  
		  
		  	</div>
		  	<div class="tab-pane" id="d" style="display:none;">
		  	
				<!-- 탭  조회조건 -->
				<div class="r_search multiLine">
					<table>
						<tr>
							<th>일자</th>
							<td>
								<input id="scrYyyymmdd" type="text" placeholder="${toDay}" value='${toDay}' style="width:80px;" readonly />
								<button onclick="javascript:func_dayBtn('prev');" class="ml_5">◀</button>
								<button onclick="javascript:func_dayBtn('next');">▶</button>
							</td>
						</tr>
					</table>
					<span class="search">
				        <button onclick="javascript:fncSearch_D()">Search</button>
				    </span>
				</div>
				<!-- //탭  조회조건 -->
				
				<!-- 그리드 영역 -->
				<div class="r_grid" id="cont5">
					<div class="r_gridTitle">
						<h3>시설물 목록</h3>
					</div>
					<table class="gridPointer" id="gridFacilityList"><tr><td></td></tr></table>
					<div id="gridFacilityListPager"></div>
				</div>
				<!-- //그리드 영역 -->
				
				<!-- 그래프 영역 -->
				<div class="common_section">
					<div class="common_section_title">
						<h3 class="float_n">시설물 온도</h3>
					</div>
					<div id="chrtFacility"></div>
				</div>
				<!-- //그래프 영역 -->
						  	
		  	</div>
		  	<div class="tab-pane" id="e" style="display:none;">
		  	
		  		<!-- 탭  조회조건 -->
				<div class="r_search multiLine">
					<table>
						<tr>
							<th>기간</th>
							<td>
								<input id="scrDateEFrom" type="text" placeholder="" value='' style="width:80px;" readonly />
								~ <input id="scrDateETo" type="text" placeholder="${toDay}" value='${toDay}' style="width:80px;" readonly />
								<button onclick="javascript:func_AllBtn('scrDateE');" class="ml_5">전체</button>
						   		<button onclick="javascript:func_monthBtn(1, 'scrDateE');">1m</button>
						   		<button onclick="javascript:func_monthBtn(6, 'scrDateE');">6m</button>
						   		<button onclick="javascript:func_monthBtn(12, 'scrDateE');">1y</button>
							</td>
							<th>장비</th>
							<td>
								<select id="scrEqmt" name="scrEqmt" class="searchSelect" style="width:118px;">
									<option value="">--전체--</option>
									<c:forEach var="vo" items="${selectVoEqmtList}" varStatus="status" >
										<option value='${vo.value}'>${vo.name}</option>
									</c:forEach>
								</select>
							</td>
							<th>조치여부</th>
							<td>
								<span class="r_radio">
									<input id="scrAsResultAll" name="scrAsResult" type="radio" value="" /><label for="scrAsResultAll">전체</label>
									<input id="scrAsResultY" name="scrAsResult" type="radio" value="Y" /><label for="scrAsResultY">조치완료</label>
									<input id="scrAsResultN" name="scrAsResult" type="radio" value="N"/><label for="scrAsResultN">미조치</label>
								</span>					
							</td>
							<th>업체</th>
							<td>
								<select id="scrVendorNm" name="scrVendorNm" class="searchSelect" style="width:108px;">
									<option value="">--전체--</option>
									<c:forEach var="vo" items="${selectVoVendorList}" varStatus="status" >
										<option value='${vo.name}'>${vo.name}</option>
									</c:forEach>						
									<option></option>
								</select>
							</td>
						</tr>
					</table>
					<span class="search">
				        <button onclick="javascript:fncSearch_E()">Search</button>
				    </span>
				</div>
				<!-- //탭  조회조건 -->
		  	
		  		<!-- 그리드 영역 -->
				<div class="r_grid" id="cont6">
					<div class="r_gridTitle">
						<h3>알림 목록</h3>
					</div>
					<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
					<div id="gridStoreMgntPager"></div>
				</div>
				<!-- //그리드 영역 -->
				
				<!-- 버튼 그룹 -->
				<div class="r_pageBtnWrapper mr_0 ml0 border_none">		
					<span class="pageNormal detail">
						<button onclick="javascript:fncAlarmConfirm();">조치내용</button>
					</span>
				</div>
				<!-- //버튼 그룹 -->
				
		  	</div>
		</div>
		
	</div>
	<!-- 탭 전체 그룹 -->
	
</div>