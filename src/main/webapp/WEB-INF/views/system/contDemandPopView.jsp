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
	  padding:0; 
	  /*overflow: auto;*/ 
	  overflow-x:hidden; 
	  overflow-y:auto; 
	  text-align:left;
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
	var strCd = '${param.strCd}';	
	var strNm = '${param.strNm}';
	
	//$('#title').text( strNm + " 계약전력 사용 현황" );
	
	fncMonthChartData( strCd );
	
});


//차트 데이터
function fncMonthChartData( strCd ) {
	
	$('#chrtMain').html('');	
	
	
	
	
	
	var d = new Date();	
	var dayoftheweek = d.getDay();
	var YYYY = d.getFullYear();
	var MM = (d.getMonth()+1)>9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1);
	var DD = d.getDate()>9 ? ''+d.getDate() : '0'+d.getDate();
	var HH = d.getHours()>9 ? ''+d.getHours() : '0'+d.getHours();
	var MIN = d.getMinutes()>9 ? ''+d.getMinutes() : '0'+d.getMinutes();
	
	var param = new Object();	
	param.strCd = strCd;	
	param.yyyymm = YYYY+""+MM;	
			
	
	$.ajax({
		async: false,
		url : "retrieveMonthDemandChart",
		dataType : "json",
		data : param,
		success : function(data) {
			
			fncMonthChart( data );			
			
		}
	});
	
}

// 차트 그리기
function fncMonthChart( data )
{	
	var yyyymmdd 	= new Array();
	var hh	   		= new Array();
	var qrt			= new Array();
	var contPower  	= new Array();
	var total		= new Array();
	
	var chartDataContPower		= new Array();	// 차트 계약전력
	var chartDataMaxContPower	= new Array();	// 차트 최대수요전력
	
	
	$.each(data, function(key, value) {	
		
		if(key == 0) {											
			$.each(value, function(idx, val) {
				yyyymmdd.push(val);				
			});
		}
		else if(key == 1) {
			$.each(value, function(idx, val) {
				hh.push( Number(val) );				
			});
		}
		else if(key == 2) {
			$.each(value, function(idx, val) {
				qrt.push( Number(val) );				
			});
		}
		else if(key == 3) {
			$.each(value, function(idx, val) {
				contPower.push( Number(val) );				
			});
		}
		else if(key == 4) {
			$.each(value, function(idx, val) {
				total.push( Number(val) );				
			});
		}		
	});

	
	for(var i=0; i<yyyymmdd.length; i++) 
	{			
		//var getDateTime = Date.UTC( Number( yyyymmdd[i] ), Number( (String)(yyyymmdd[i]).substr(4,2) )-1, Number( (String)(yyyymmdd[i]).substr(6,2) ), hh[i], qrt[i] );
		var getDateTime = Date.UTC( Number( (String)(yyyymmdd[i]).substr(0,4) ) , Number( (String)(yyyymmdd[i]).substr(4,2) )-1 ,  Number( (String)(yyyymmdd[i]).substr(6,2) ) ,  Number( (String)(hh[i]) ) ,  Number( (String)(qrt[i]) ) );
		
		//var getDateTime = Date.UTC(Number( (String)(list[i].yyyymmdd).substr(0,4) ), Number( (String)(list[i].yyyymmdd).substr(4,2))-1, (String)(list[i].dd), "00", "000");
		chartDataContPower.push( [ getDateTime, Number( contPower[i] ) ]  );
		chartDataMaxContPower.push( [ getDateTime, Number( total[i] ) ]  );
		//console.log( Number( (String)(yyyymmdd[i]).substr(0,4) ) + "," + Number( (String)(yyyymmdd[i]).substr(4,2) )-1 + "," +  Number( (String)(yyyymmdd[i]).substr(6,2) ) + "," +  Number( (String)(hh[i]) ) + "," +  Number( (String)(qrt[i]) ) );
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
			height : 400,
			panning : true,
		},
		credits : {
			enabled : false
		},
		//colors : ['#D80546', '#F5516C'],
		exporting : {
			enabled : false
		},
		scrollbar: {
			enabled: false
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
				second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%Y-%m-%d<br/>%H:%M',
				hour: '%Y-%m-%d<br/>%H:%M',
				day: '%d일',
				week: '%Y<br/>%m-%d',
				month: '%Y-%m',
				year: '%Y'
			},
			tickInterval: 1 * 3600 * 1000
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
		navigator: {
			enabled : false,
		}
	});
}


// 닫기 버튼
function fncCancel() {
	fncDivPop1Close();	
}








</script>
<div class="r_popup">
	
	<!-- 팝업 본문 -->
	<div class="r_popupCont_pop">		
		<div class="">		
			<!-- 위젯 -->
			<h3 class="blind">월별 계약전력사용현황</h3>
		  	<!-- 대시보드 본문 -->
			<div class="pop_dashboard_body">			
				<div class="graph">
					<div id="chrtMain"></div>
				</div>
			</div>
			<!-- //대시보드 본문 -->
		</div>
		
		<!-- <span id="title"></span> -->
		
		<!-- 버튼 그룹 -->
		<div class="r_pageBtnWrapper border_none">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>			
		</div>
		<!-- //버튼 그룹 -->
		
	</div>
	<!-- //팝업 본문 -->
	
</div>
