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

	//$("#companyCd").val('${companyCd}');
	//console.log( "companyCd : " + companyCd );	

	
	// 대시보드 상단 정보
	DashStoreMstData();	
	
	// 대시보드 계약전력사용현황
	DashStoreContPowerData();	
	
	// 대시보드 공지사항
	DashNoticeListData();	
	
	
	
	// 시설물 알람처리 현황
	DashStoreAlarmData();
	
	// 피크발생 현황
	DashStorePeakData();
	//storeEqmtData( strCd );
	
});


// 대시보드 - 매장정보
function DashStoreMstData()
{
	$.ajax({
		url:'/retrieveDashStoreMstData',
		type:'POST',
		cache:false,
		//data : {strCd:strCd},
		dataType:'json',
		success:function(data){
			console.log( "retrieveDashStoreMstData : " + data.strNm );
			
			if( data.storeCount == null )				
				$('#storeCount').text( "-" );
			else
				$('#storeCount').text( 		data.storeCount );
			
			if( data.totalAvgUse == null )				
				$('#totalAvgUse').text( "-" );
			else
				$('#totalAvgUse').text( 	data.totalAvgUse );
			
			if( data.avgUse == null )				
				$('#avgUse').text( "-" );
			else
				$('#avgUse').text( 		data.avgUse );
			
			if( data.semsAbnormalStrCnt == null )
				$('#semsAbnormalStrCnt').text( "-" );
			else
				$('#semsAbnormalStrCnt').text( 		data.semsAbnormalStrCnt );
			
			var totalUse = data.totalUse;		// 사용량
			var curPredictUsage = data.curPredictUsage;
			
			
			if( data.totalUse == null )
				$('#totalUse').text( "-" );
			else
				$('#totalUse').text( 		data.totalUse );
			
			if( data.curPredictUsage == null )
				$('#curPredictUsage').text( "-" );
			else
				$('#curPredictUsage').text( 		data.curPredictUsage );
			
			
			// 사용량-예측 전력 그래프
			
		},
		error:function(result){
			//alert("에러가 발생했습니다.");
		}
	});
	
	
}

// 대시보드 - 계약전력 grid
function DashStoreContPowerData()
{	
	$("#gridContPowerStatus").jqGrid({
		url:'retrieveStoreContPowerData',
		datatype: "json",		
		mtype: 'POST',
     	//postData : { strCd:strCd },
	    colNames:['No', '매장명', '계약전력(kW)', '최대수요전력', '최대냉난방전력(kW)', 'strCd' ],
     	colModel:[
               {name:'records',		index:'records',	hidden:true},
               {name:'strNm',		index:'strNm', 		width:30, 	align:'left', 	sortable:true, 	editable:false},	                  
               {name:'contPower',	index:'contPower', 	width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:0}},
               {name:'totalMain',	index:'totalMain', 	width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:0}},
               {name:'temp',		index:'temp',		width:40, 	align:'center', sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:0}},
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
	 	height : 150,	
	 	onSelectRow : function(rowid, iRow, iCol, e) {
			 
			var list = $("#gridContPowerStatus").getRowData(rowid);	
			
			var param = new Object();
			param.strCd = list.strCd;
			param.strNm	= list.strNm;
			
			fn_divPop("contDemandPop", "매장정보", 600, 500, "계약전력 사용현황" );		// 매장별 계약전력 팝업
			 
		},	 		
	 	gridComplete : function()
		{
	 		$("#gridContPowerStatus tr.jqgrow:even").css("background", "#E0E0E0");
			$("#gridContPowerStatus tr.jqgrow td").css("height", "10px");			
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
	jqGridResize('gridContPowerStatus');
}



// 대시보드 - 공지사항
function DashNoticeListData( strCd )
{
	$("#gridNoticeList").jqGrid({
		url:'retrieveNotice',
		datatype: "json",		
		mtype: 'POST',
     	//postData : { strCd:strCd },
	    colNames:['No', '공지사항ID', '공지종류', '제목', '게시여부', '게시자', '게시일', '게시시작일', '게시종료일',  '공지대상', '조회건수'],
	    colModel:[ 	  		
	    	  		{name:'records',		index:'records',		width:10,		align:'center',	sortable:true,	editable:false,	editoptions:{readonly:true,size:10} },
	    	  		{name:'noticeId',		index:'noticeId', 		hidden:true},
	    	  		{name:'noticeTypeNm',	index:'noticeTypeNm', 	width:15,		align:'center', sortable:true, 	editable:false},	  
	                {name:'title',			index:'title',			width:50,		align:'left',	sortable:true,	editable:false,	editoptions:{readonly:true,size:10} },
	                {name:'pubYn',			index:'pubYn', 			hidden:true },
	                {name:'userNm',			index:'userNm', 		width:20, 		align:'center', sortable:true, 	editable:false},	                  
	                {name:'pubDttm',		index:'pubDttm', 		width:30, 		align:'center', sortable:true, 	editable:false},
	                {name:'pubStartDt',		index:'pubStartDt', 	hidden:true},
	                {name:'pubEndDt',		index:'pubEndDt', 		hidden:true},
	                {name:'targetNames',	index:'targetNames', 	hidden:true},
	                {name:'viewCnt',		index:'viewCnt', 		hidden:true },
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
	   	recordtext: "건/페이지  (전체 {2} 건)",
	   	emptyrecords : "검색 결과가 존재하지 않습니다.",
	   	loadtext: "Loading...",
	   	sortname: 'pubEndDt',
	    viewrecords: true,
	    sortorder: "desc",	     
	    scroll: false,
	 	autowidth:true,
	 	height : 150,	
	 	gridComplete : function()
		{
	 		$("#gridNoticeList tr.jqgrow:even").css("background", "#E0E0E0");
			$("#gridNoticeList tr.jqgrow td").css("height", "10px");
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
	jqGridResize('gridNoticeList');
}

//1단 시설물 알람 처리 현황
function DashStoreAlarmData()
{
	$.ajax({		
		url:'/retrieveDashStoreAlarmData',
		type:'POST',
		cache:false,
		dataType:'json',
		success:function(data){
			
			console.log( "yResult : " + 	data.yResult );
			/*
			var yResult = numberWithCommas( 	data.yResult );
			var nResult = numberWithCommas( 	data.nResult );
			var resultCnt = numberWithCommas( 	data.resultCnt );
			*/
			var yResult =  	data.yResult ;
			var nResult =  	data.nResult ;
			var resultCnt =  	data.resultCnt ;
			
			
						
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
			        width : 100,
					height : 200,					
			        type: 'pie'
				},
				credits : {
					enabled : false
				},
				colors : ['#FF0000', '#00D8FF'],
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



// 대시보드 - 피크 발생 현황
function DashStorePeakData() 
{
	
	var yyyymm 		= new Array();						
	var peakCnt 	= new Array();	
	
	var peakCntData	= new Array();
	
	var tick 		= new Array();	
	var chartDataPeakCnt	= new Array();		// 차트 냉난방 데이터
	
	var d = new Date();	
	
	var YYYY = d.getFullYear();
	var MM = (d.getMonth()+1) > 9 ? ''+(d.getMonth()+1) : '0'+(d.getMonth()+1);
	
	var YYYYtemp;
	var MMtemp;
	
	var YM = YYYY + "" + MM;	
	var madeData = 0;
	
	
	var Xyyyymm = new Array();
	var aa = 1;
	var bb = 2;
	var cc = 3;
	var dd = 4;
	var ee = 5;
	var ff = 6;
	var gg = 1;
	var hh = 2;
	var ii = 3;
	var jj = 2;
	var kk = 2;
	var ll = 3;
	
			
	
	// 에너지사용현황 데이터
	$.ajax({
		url:'/retrieveStorePeakChartData',
		type:'POST',
		cache:false,
		sync:false,
		data : {yyyymm:YM},
		dataType:'json',
		success:function(data){			
			
			$.each(data, function(key, value) {
				if(key == 0) {			// yyyymm
					$.each(value, function(idx, val) {						
						yyyymm.push(val);
						console.log( val );
					});
				}
				else if(key == 1) {		// peakCnt
					$.each(value, function(idx, val) {						
						peakCnt.push( val );
					});
				}
			});
			
			// 12개월 만들기
			for(var k=0; k<12; k++ )			
			{
				YYYYtemp = YYYY;
				MMtemp = MM;
				
				MMtemp = (MMtemp - k);
				if( MMtemp <= 0 )
				{
					MMtemp = MMtemp + 12;
					YYYYtemp = YYYYtemp - 1;
				}
				MMtemp = (MMtemp) > 9 ? ''+(MMtemp) : '0'+(MMtemp);
				
				YM = YYYYtemp + "" + MMtemp;
				
				
				
				for(var i=0; i<yyyymm.length;i++) 
				{	
					if( YM == yyyymm[i] )
					{
						Xyyyymm.push( yyyymm[i] );
						console.log( "같음" );
						//var getDateTime = Date.UTC(Number( (String)(YYYYtemp) ), Number( (String)(MMtemp-1) ), "01", "00", "000");
						var getDateTime = Date.UTC(Number( (String)(YYYYtemp) ), Number( (String)(MMtemp-1) ), "01", "00", "000");
						//var getDateTime = Date.UTC( "201703", "01", "01", "00", "000");
						tick.push( getDateTime );
						chartDataPeakCnt.push( [ getDateTime, Number( peakCnt[i] ) ]  );
						madeData = 1;
						continue;
					}						
				}
				
				if( madeData == 0 )
				{
					Xyyyymm.push( YYYYtemp + "" + MMtemp );
					var getDateTime = Date.UTC(Number( (String)(YYYYtemp) ), Number( (String)(MMtemp-1) ), "01", "00", "000");
					//var getDateTime = Date.UTC( "201703", "01", "01", "00", "000");
					tick.push( getDateTime );								
					chartDataPeakCnt.push( [ getDateTime, Number( 0 ) ]  );
					
					//console.log( "12개월 : " + k + " / " + 0 );
				}
				else
				{
					madeData = 0;
				}				
			}
			
			Xyyyymm.sort( function(a,b){return a-b});
			
			for(var i=0; i<chartDataPeakCnt.length;i++) 
			{					
				$('#mPeakCnt'+i).text( chartDataPeakCnt[i][1] );
				
				peakCntData.push( Number( chartDataPeakCnt[i][1]) );
				console.log( "dd : " + chartDataPeakCnt[i] );
				
				switch( i )
				{			
					case 0 : aa = Number( chartDataPeakCnt[i][1]); break;
					case 1 : bb = Number( chartDataPeakCnt[i][1]); break;
					case 2 : cc = Number( chartDataPeakCnt[i][1]); break;
					case 3 : dd = Number( chartDataPeakCnt[i][1]); break;
					case 4 : ee = Number( chartDataPeakCnt[i][1]); break;
					case 5 : ff = Number( chartDataPeakCnt[i][1]); break;
					case 6 : gg = Number( chartDataPeakCnt[i][1]); break;
					case 7 : hh = Number( chartDataPeakCnt[i][1]); break;
					case 8 : ii = Number( chartDataPeakCnt[i][1]); break;
					case 9 : jj = Number( chartDataPeakCnt[i][1]); break;
					case 10 : kk = Number( chartDataPeakCnt[i][1]); break;
					case 11 : ll = Number( chartDataPeakCnt[i][1]); break;
				}				
			}
				
			$('#chrtPeak').highcharts( {

				chart: {
			        type: 'column',
			        width: 600,
			        height : 200,
			    },
			    title: {
			        text: ''
			    },			    
			    xAxis: {
			        categories: Xyyyymm,
			        crosshair: true
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: ''
			        }
			    },
			    tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: true
			    },
			    plotOptions: {
			        column: {
			            pointPadding: 0.2,
			            borderWidth: 0
			        }
			    },
			    series: [{			    	
			        name: '피크매장',
			        data: [ ll, kk, jj, ii, hh, gg, ff, ee, dd, cc, bb, aa ] 

			    }]		
				
			});			
			
			
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
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

// 닫기 버튼
function fncCancel() {
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
}

// 통제관제현황 - 계약전력 페이지 이동
function fncMoveContDemandList()
{
	
	$.ajax({
		type : "POST",
		cache : false,
		url : '/retrieveEnergyCont',
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


// 시스템관리 - 공지사항 관리 - 공지사항
function fncMoveNoticeList()
{	
	$.ajax({
		type : "POST",
		cache : false,
		url : '/retrieveNoticeList',
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

// 통합관제현황 - 시설물 - 시설물알림
function fncMoveEqmtMessageList()
{	
	$.ajax({
		type : "POST",
		cache : false,
		url : '/retrieveEqmtMessageList',
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

// 통합관제현황 - 피크제어매장
function fncMovePeakList()
{	
	$.ajax({
		type : "POST",
		cache : false,
		url : '/retrievePeakControlStore',
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


</script>

<div id="loadingArea">

	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		
			<!-- 위젯 -->
			<h3 class="blind">위젯으로 전체 현황 보기</h3>
			<ul class="pop_widgets">
				<!-- 날짜 -->
				<div class="date">
					<h4 class="blind">날짜</h4>
					<p id="year_month" class="year_month">2016년/12월</p>
					<p id="day" class="day">16<span class="blind">일</span></p>
					<p id="week_time" class="week_time">금요일/01:52pm</p>
				</div>
				<!-- //날짜 -->
				
				<!-- 상단 정보 -->
				<li><img src="/images/tab_line_widgets_01.png" alt="" /></li>
				<li class="">
					<p id="storeCount" class="">-</p>
					<h4>전체매장수</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="">
					<p id="totalAvgUse" class="">-</p>
					<h4>일평균 총 사용량</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="">
					<p id="avgUse" class="">-</p>
					<h4>일평균 매장별 사용량</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="">
					<p id="semsAbnormalStrCnt" class="">-</p>
					<h4>SEMS 이상매장</h4>
				</li>			
				<li class="">
					<!-- 예측사용량 -->					
					<p id="curPredictUsage" class="">-</p>
					<h4>예측사용량</h4>
				</li>
				<li>					
					<p id="totalUse" class="">-</p>
					<h4>실사용량</h4>
					
				</li>
			</ul>
			<!-- //위젯 -->
		  	
		  	<!-- 대시보드 본문 -->
			<div class="pop_dashboard_body">
			
				<!-- 1단 -->
				<div class="level_02">
					
					
					<!-- 계약전력 사용현황 -->
					<div class="message_condition">
						<h3>계약전력 사용현황</h3>
						
						<button onclick="javascript:fncMoveContDemandList();">+ more</button>						
						
						<div class="table_use_condition">
							<table class="gridPointer" id="gridContPowerStatus"><tr><td></td></tr></table>
						</div>						
					</div>
					<!-- //계약전력 사용현황 -->
					
					<!-- 계약전력 사용현황 -->
					<div class="use_condition">
						<h3>공지사항</h3>
						
						<button onclick="javascript:fncMoveNoticeList();">+ more</button>		
						
						<div class="table_use_condition">
							<table id="gridNoticeList"><tr><td></td></tr></table>
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
							
						<button onclick="javascript:fncMoveEqmtMessageList();">+ more</button>	
						
						<ul class="graph_area">
							<li>
								<div class="graph">
									<div id="chrtPie"></div>
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
					<!-- //피크 발생 현황 -->

					<!-- 피크발생현황 -->
					<div class="use_condition">
						<h3>피크발생현황</h3>
						
						<button onclick="javascript:fncMovePeakList();">+ more</button>	
												
						<div class="graph_area">								
								<div id="chrtPeak"></div>
						</div>								
						<table>
							<colgroup>
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    	<col width="" />
						    </colgroup>						    
					    	<tbody>
				       		<tr>
				         		<th>발생<br />건수</th>
				         		<td>
				         			<div class="" id="mPeakCtnBtn11">	<label id="mPeakCnt11">-</label></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn10">	<span id="mPeakCnt10">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn9">		<span id="mPeakCnt9">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn8">	<span id="mPeakCnt8">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn7">	<span id="mPeakCnt7">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn6">		<span id="mPeakCnt6">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn5">		<span id="mPeakCnt5">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn4">	<span id="mPeakCnt4">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn3">		<span id="mPeakCnt3">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn2">	<span id="mPeakCnt2">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn1">	<span id="mPeakCnt1">-</span></div>
				         		</td>
				         		<td>
				         			<div class="" id="mPeakCtnBtn0">		<span id="mPeakCnt0">-</span></div>
				         		</td>
							</tr>
							</tbody>
						</table>
						
						
						
					</div>
					<!-- //피크발생현황 -->
					
				</div>
				<!-- //2단 -->
				
		
		</div>	
		
	</div>
	
	
</div>
