<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smStr"><spring:message code="str" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smStrInq"><spring:message code="strInq" /></c:set>



<style>
.ui-jqgrid .ui-jqgrid-bdiv {
	  position: relative; 
	  margin: 0em; 
	  padding:5; 
	  /*overflow: auto;*/ 
	  overflow-x:auto;
	  overflow-y:scroll; 
	  text-align:left;
}

canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
    
</style>





<script type="text/javascript">







/*******************
1. 기타 필수 전역 변수
********************/

var popParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

var YYYY, MM, DD, HH, MIN;	    
	

$(document).ready(function(){
	
	
	var strCd = '${param.strCd}';
	console.log( "strCd : " + strCd );	
	$('#dialog-confirm').css('overflow', 'hidden');	
	$("#companyCd").val('${companyCd}');
	
	// 1단 매장정보
	storeMstData( strCd );	
	
	// 2단 상단정보
	storeRealData( strCd );	
	
	// 3단-1 에너지 사용현황
	// 3단-1 에너지 사용현황 그래프
	storeEnergyData( strCd );	
	
	// 4단 시설물 알람 처리 현황
	//storeAlarmData( strCd );
	pieChart(strCd);
	
	// 시설물 현황
	storeEqmtData( strCd );
	
});

// pie그래프
function pieChart(strCd)
{
	
	
	
	$.ajax({
		url:'/retrieveStoreAlarmData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			
			console.log( "yResult : " + 	data.yResult );
			
			
			//$('#myChart').html('');
			
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
			
			
			//$('#myChart').html('');
			
			
			
			drawPieChart(data);
			
		},
		complete:function(result){
				
			
		}
		
		
	});
	
}

// 파이차트 그리기
function drawPieChart( data )
{
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
	
	console.log( "df"+resultCnt);
	
	var percentVal = 0;
	if( resultCnt != 0  )
		percentVal =  Math.round( (yResult / resultCnt ) * 100);
	
	if(percentVal == 100){
		percentVal = "완료";
	}else {
		percentVal+='%';
	}
    	$('#myChart2').highcharts( {
    		
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

	//console.log( "11 : " +percent);
	
	
	console.log( yResult );
	
	
	
	/* //var ctx = $("#myChartPop");
	Chart.defaults.global.defaultFontColor = "orange";
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
	
	
	Chart.pluginService.register({
		  beforeDraw: function(chart) {
		    var width = chart.chart.width,
		        height = chart.chart.height,
		        ctx = chart.chart.ctx,
		        type = chart.config.type;
			
		    
		    var pageType = $("#myChart2").text();
		    
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
				var textX = Math.round((width - ctx.measureText(text).width) / 2);
				var textY = (height + chart.chartArea.top) / 2 - 20;
					
					
				ctx.fillStyle = chart.config.data.datasets[0].backgroundColor[0];
				ctx.clearRect(0,0,width,height);	
				ctx.fillText(text, textX, textY);
				ctx.fillStyle = oldFill;
				ctx.save();
		    	
		    }
		  }
		 
		  
		  
		});
	
	var options = {
		cutoutPercentage : 80,
		responsiveAnimationDuration : 500,
			responsive: true,
			legend: {
   			position: 'bottom',
			},
			title: {
   			display: false,
   			text: 'Doughnut Chart'
			},
	    animation: {
	    	animateScale: false,
	        animateRotate: true,
	        onComplete: function () {
	        	
				var ctx = this.chart.ctx;
				
				this.data.datasets.forEach(function (dataset) {
				
					for (var i = 0; i < dataset.data.length; i++) {
				    	var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
				        var total = dataset._meta[Object.keys(dataset._meta)[0]].total;
				        var mid_radius = model.innerRadius + (model.outerRadius - model.innerRadius)/2;
				        var start_angle = model.startAngle;
				        var end_angle = model.endAngle;
				        var mid_angle = start_angle + (end_angle - start_angle)/2;
				      
				      	var x = mid_radius * Math.cos(mid_angle)-5;
				      	var y = mid_radius * Math.sin(mid_angle);
				
				      	ctx.fillStyle = '#ffffff';

				      	var val = dataset.data[i];
						var percent = String(Math.round(val/total*100)) + "%";
				
						if(val != 0) {
				        	//ctx.fillText(dataset.data[i], model.x + x, model.y + y);
				        	//ctx.fillText(percent, model.x + x, model.y + y + 15);
				      	}
				    }
				    
				}); 
				
				
			}
		},
		
	};
	
	var ctx =document.getElementById("myChart2");
	var myChart = new Chart(ctx, {
		type: 'doughnut',
		data: data,
		options: options
	});
	
	 */
}


// 1단 매장정보
function storeMstData( strCd )
{
	$.ajax({
		url:'/retrieveStoreMstData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			console.log( "retrieveStoreMstData : " + data.strNm );
			
			if( data.strNm == null )				
				$('#strNm').text( "0" );
			else
				$('#strNm').text( 		data.strNm );
			
			if( data.viewStrCd == null )				
				$('#viewStrCd').text( "0" );
			else
				$('#viewStrCd').text( 	data.viewStrCd );
			
			if( data.addr == null )				
				$('#addr').text( "0" );
			else
				$('#addr').text( 		data.addr );
			
			if( data.telNo == null )
				$('#telNo').text( "0" );
			else
				$('#telNo').text( 		data.telNo );
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
	
	
}

//1단 매장 실시간 정보
function storeRealData( strCd )
{	
	

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
	
	
	
	$.ajax({
		url:'/retrieveStoreRealData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			console.log( "retrieveStoreRealData : " + data );
			console.log( "weatherCd : " + data.weatherCd );
			
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
				case 1:  $('#weatherCd').attr('src',	'/images/weather/icon_weather01_web.png');	break;	// 맑음
				case 2:  $('#weatherCd').attr('src',	'/images/weather/icon_weather02_web.png');	break;	// 구름조금
				case 3:  $('#weatherCd').attr('src',	'/images/weather/icon_weather03_web.png');	break;	// 구름많음
				case 4:  $('#weatherCd').attr('src',	'/images/weather/icon_weather04_web.png');	break;	// 흐림				
				case 5:  $('#weatherCd').attr('src',	'/images/weather/icon_weather05_web.png');	break;	// 비온후갬
				case 6:  $('#weatherCd').attr('src',	'/images/weather/icon_weather06_web.png');	break;	// 비
				case 7:  $('#weatherCd').attr('src',	'/images/weather/icon_weather07_web.png');	break;	// 눈
				case 8:  $('#weatherCd').attr('src',	'/images/weather/icon_weather08_web.png');	break;	// 소나기
				case 9:  $('#weatherCd').attr('src',	'/images/weather/icon_weather09_web.png');	break;	// 비/눈
				case 10: $('#weatherCd').attr('src',	'/images/weather/icon_weather10_web.png');	break;	// 눈/비
				case 11: $('#weatherCd').attr('src',	'/images/weather/icon_weather11_web.png');	break;	// 낙뢰
				case 12: $('#weatherCd').attr('src',	'/images/weather/icon_weather12_web.png');	break;	// 안개
				default: $('#weatherCd').attr('src',	'');	break;
			}
			
			/*
			if( data.weatherCd == null )				
				$('#weatherCd').text( "" );
			else
				$('#weatherCd').text( 		data.weatherCd );
			*/
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



			
			
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

//1단 전력사용량 - 전력량
function storeEnergyData( strCd )
{
	
	
	var d = new Date();	
	var dayoftheweek = d.getDay();
	var YYYY = d.getFullYear();
	var MM = (d.getMonth()+1)>9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1);
	var DD = d.getDate()>9 ? ''+d.getDate() : '0'+d.getDate();
	var HH = d.getHours()>9 ? ''+d.getHours() : '0'+d.getHours();
	var MIN = d.getMinutes()>9 ? ''+d.getMinutes() : '0'+d.getMinutes();
	var ampm = "am";
	
	
	$.ajax({
		url:'/retrieveStoreEnergyData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			console.log( data.contKilo );		
			
			
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
			 
		    
			
			
		    $('#inquiry_time').text( "조회시간 : " + YYYY + "/" + MM + "/" + DD + " " + HH + ":" + MIN );
		     
		    fncEnergyChart( strCd );
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
}

//1단 시설물 알람 처리 현황 - 미사용
function storeAlarmData( strCd )
{
	$.ajax({
		url:'/retrieveStoreAlarmData',
		type:'POST',
		cache:false,
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			
			console.log( "yResult : " + 	data.yResult );
			
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

// 시설물 현황
function storeEqmtData( strCd )
{
	
	
// Grid 출력
	$("#gridEqmtStatus").jqGrid({
		url:'retrieveStoreEqmtData',
		datatype: "json",		
		mtype: 'POST',
     	postData : {
     				strCd:strCd,		 
		},
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
	    scroll: false,
	 	width : 450,
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
	jqGridResize('gridStoreMgnt');
	  
	  
	
}




// 에너지사용현황 차트
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
		data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			
			
			$.each(data, function(key, value) {
				if(key == 0) {			// yyyymm
					$.each(value, function(idx, val) {						
						yyyymm.push(val);
						console.log( val );
					});
				}
				else if(key == 1) {		// total
					$.each(value, function(idx, val) {						
						total.push( val );
					});
				}
				else if(key == 2) {		// temp
					$.each(value, function(idx, val) {						
						temp.push( val );
					});
				}
				else if(key == 3) {		// etc( total-temp)
					$.each(value, function(idx, val) {						
						etc.push( val );
					});
				}
			});
			
			for(var i=0; i<yyyymm.length;i++) 
			{					
				var getDateTime = Date.UTC(Number( (String)(yyyymm[i]).substr(0,4) ), Number( (String)(yyyymm[i]).substr(4,2))-1, "01", "00", "000");
				tick.push( getDateTime );		
				
				chartDataTemp.push( [ getDateTime, Number( temp[i] ) ]  );
				chartDataEtc.push( 	[ getDateTime, Number( etc[i] ) ]  );
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
			width : 450,
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
				second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%Y-%m-%d<br/>%H:%M',
				hour: '%Y-%m-%d<br/>%H:%M',
				day: '%d일',
				week: '%Y<br/>%m-%d',
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
	    			return (this.value > 0 ? '' : '') + this.value + 'Kw';
	    		}
	    	},
	    	min: 0,
	    	
		},		
	});		
}












// 상세정보 버튼
function fncConfirm() {		
	
	
	var strCd = '${param.strCd}';
	
	fncDivPop1Close();	
	$.ajax({
		type : "POST",
		cache : false,
		url : '/retrieveStoreStatus',
		data : {strCd:strCd},
		success : function(data) {			
			$("#r_contents").html(data);			
		},
		error:function(result){
			alert('에러가 발생하였습니다.');
		},
		complete : function()
		{
			
		}
	});
}

// 닫기 버튼
function fncCancel() {
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
}








</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<!-- <h2 class="r_popupTitle">매장요약정보</h2> -->
	
	<!-- //팝업 타이틀 -->
	
	<!-- 닫기 버튼 -->
	<!-- <p class="close_popup"><a href="#" title="팝업창닫기"><img src="/images/btn_close_popup.png" alt="당기" /></a></p> -->
	<!-- //닫기버튼 -->
	
	<!-- 팝업 본문 -->
	<div class="r_popupCont_pop">
		<div class="dashboard_popup_title">
			<h3 id="strNm" class="shop_name">-</h3>
			<ul>
				<li id="viewStrCd" class="shop_code">-</li>
				<li id="addr" class="shop_address">-</li>
				<li id="telNo" class="shop_tel">-</li>
			</ul>
		</div>
		<div class="dashborad_popup_body">
		
			<!-- 위젯 -->
			<h3 class="blind">위젯으로 전체 현황 보기</h3>
			<ul class="pop_widgets">
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
					<h4>SEMS</h4>
				</li>
			</ul>
			<!-- //위젯 -->
		  	
		  	<!-- 대시보드 본문 -->
			<div class="pop_dashboard_body">
			
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
								<!-- 
								<div class="graph">
									<div id="chrtPie"></div>
								</div>
								-->
								<div id="canvas-holder" style="width:180px;">
        							<div id="myChart2"></div>
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
					<div class="use_condition">
						<h3>시설물현황</h3>
						<div class="table_use_condition">
							<table id="gridEqmtStatus"><tr><td></td></tr></table>
						</div>
					</div>
					<!-- //시설물현황 -->
					
				</div>
				<!-- //2단 -->
				
			</div>
			<!-- //대시보드 본문 -->

		</div>
		
		<!-- 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
			<span class="pageNormal detail">
				<button onclick="javascript:fncConfirm()">상세정보 →</button>
			</span>
		</div>
		<!-- //버튼 그룹 -->
		
	</div>
	<!-- //팝업 본문 -->
	
</div>
