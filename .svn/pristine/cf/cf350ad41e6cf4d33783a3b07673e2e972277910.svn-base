<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smMonthlyTotalElecUse"><spring:message code="monthlyTotalElecUse"/></c:set>
<c:set var="smDailyTotalElecUse"><spring:message code="dailyTotalElecUse"/></c:set>

<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>

<c:set var="smDate"><spring:message code="date"/></c:set>
<c:set var="smTotalElecUse"><spring:message code="totalElecUse"/></c:set>
<c:set var="smHacElecUse"><spring:message code="hacElecUse"/></c:set>
<c:set var="smLightElecUse"><spring:message code="lightElecUse"/></c:set>
<c:set var="smOutdoorTempC"><spring:message code="outdoorTempC"/></c:set>
<c:set var="smIndoorTempC"><spring:message code="indoorTempC"/></c:set>

<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smLight"><spring:message code="light"/></c:set>
<c:set var="smEtc"><spring:message code="etc"/></c:set>

<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<style type="text/css">
	.ui-jqgrid .ui-jqgrid-bdiv{ overflow-x:hidden; 
	overflow-y: true;
	}
</style>
<script type="text/javascript">


$(function() {
		
	// 달력 - 년월
	$('#scrDateFrom, #scrDateTo').monthpicker({pattern: 'yyyy-mm', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    selectedYear: 2017,
	    startYear: 2010,
	    finalYear: 2050,
	    openOnFocus: false});			
	
	$('#scrDateFromBtn').bind('click', function () {
		$('#scrDateFrom').monthpicker('show');
	});
	$('#scrDateToBtn').bind('click', function () {
		$('#scrDateTo').monthpicker('show');
	});

	
});


$(document).ready(function(){
	
	init();
	func_monthBtn(12);	
	fncSearch();
	
});

$(window).resize(function(){



    $("#gridUsedArea").setGridWidth($("#con1").width());
    $("#gridUsedDailyArea").setGridWidth($("#con2").width());
    

}).resize();


/*******************
1. 기타 필수 스크립트
********************/

function init()
{	
	//console.log( '${totalVal.storeCount}') ;
	$('#totalStoreCnt').text( 			'${totalVal.storeCount}' );	// 전체 매장수 
	$('#totalDailyUseWatage').text( 	'${totalVal.totalUse}' );	// 일평균 총 사용량
	$('#totalDailyAvgWatage').text( 	'${totalVal.avgUse}' );		// 일평균 매장별 사용량
		
	
	//월별 전력량
	$("#gridUsedArea").jqGrid({
		url:'retrieveEnergyUseMonthStatus',
		datatype: "local",
		mtype: 'POST',		
		postData: {
			srchStrCd: '${orgStrCd}',
			srchYyyymm: '${orgYyyymm}'
		},
		colNames:['년월', '전체전력량(kWh)', '냉난방전력량(kWh)', '기타전력량(kWh)'],
		colModel:[
			{name:'yyyymm',	index:'yyyymm', width:'auto', 	align:'center', sortable:true, 		editable:false, 	editoptions:{readonly:true,size:10}},
			{name:'total',	index:'total', 	width:'auto', 	align:'right', 	formatter:'number', formatoptions:{decimalPlaces:0}, sortable:true, editable:false},
			{name:'temp',	index:'temp', 	width:'auto', 	align:'right', 	formatter:'number', formatoptions:{decimalPlaces:0}, sortable:true, editable:false},
			{name:'etc',	index:'etc', 	width:'auto', 	align:'right', 	formatter:'number', formatoptions:{decimalPlaces:0}, sortable:true, editable:false}			
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
		
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		sortname: 'yyyymm',
		sortorder: "desc",
	    viewrecords: true,		
		height: '200',
		onSelectRow : function(rowid, status, e) {
			
			var list   = $("#gridUsedArea").getRowData(rowid);
			var yyyymm = list.yyyymm.replace("-", "");
			
			fncRetrieveUsedDailyArea(yyyymm);		// 일별 사용량 Gird 출력
		},
		gridComplete : function()
		{
			jqGridEven('gridUsedArea');			 
			var rsltCount = $("#gridUsedArea").getGridParam("reccount");			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridUsedArea >tbody").append("<tr><td align='center' colspan='4'>검색 결과가 없습니다.</td></tr>");
			}	
		},		
		loadComplete : function(data) {
			var list   = $("#gridUsedArea").getRowData();
			var rowCnt = list.length;
					
			// 첫번째 row를 선택
			if( rowCnt > 0 ) {
				$("#gridUsedArea").jqGrid('setSelection', 1);
				
			}
			
			
		}		
	});	
	
	
	//일자별 전력량 
	$("#gridUsedDailyArea").jqGrid({
		url:'retrieveEnergyUseDayStatus',
		datatype: "local", 	// 월이 선택되면 수행
		mtype: 'POST',
		colNames:['일자', '전체전력량(kWh)', '냉난방전력량(kWh)', '기타전력량(kWh)','yyyymmdd'],
		colModel:[
			{name:'dd',index:'dd', width:100, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', width:170, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp', width:170, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'etc',index:'etc', width:172, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'yyyymmdd',index:'yyyymmdd', hidden:'true'}
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
				fncDailyChart(list);
			} 
		}
	});
		//2017.06.30 데이터 짤림 현상으로 인한 수정
		/* viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: false,
		sortname: 'dd',
		sortorder: "desc",
		viewrecords: true,
		height: '200',		
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list   = $("#gridUsedDailyArea").getRowData(rowid);
			//var yyyymmdd = list.yyyymmdd.replace("-", "");
			
		},
		loadBeforeSend : function()
		{
			
		},
		gridComplete : function()
		{
			jqGridEven('gridUsedDailyArea');			 
			var rsltCount = $("#gridUsedDailyArea").getGridParam("reccount");			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridUsedDailyArea >tbody").append("<tr><td align='center' colspan='4'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		loadComplete : function(data) {
			
			jqGridEven('gridMonthDemandList');			 
			var rsltCount = $("#gridMonthDemandList").getGridParam("reccount");			
			//alert("111==="+rsltCount);
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{
				alert('검색된 데이터가 없습니다.');
			}
			else
			{
				var list   = $("#gridUsedDailyArea").getRowData();
				var rowCnt = list.length;
				// 첫번째 row를 선택
				if( rowCnt > 0 ) {
					$("#gridUsedDailyArea").jqGrid('setSelection', 1);
					fncDailyChart(list);
				} 
			}
		}		
	}); */
}

// 조회 버튼
function fncSearch() {	
	
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}		
	
	var scrDateFrom = $.trim($("#scrDateFrom").val());
	var scrDateTo = $.trim($("#scrDateTo").val());
	
	console.log( scrDateFrom );
	console.log( scrDateTo );
	
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
			scrCompanyCd:companyCd,			
			scrDateFrom:scrDateFrom,
			scrDateTo:scrDateTo
		}
	}).trigger("reloadGrid");	
	
	$("#gridUsedArea").setGridParam({"page":1});		// 1페이지로 이동
}


// 일별 전력량 그래프
function fncRetrieveUsedDailyArea(yyyymm) {
	
	//$('#selectedMonth').val( yyyymm );	
	
	console.log("yyyymm : " + yyyymm );
	
	$('#chrtMain').html('');						// 차트 지우기
	$("#gridUsedDailyArea").clearGridData();		// 일별 grid 지우기
	
	$("#gridUsedDailyArea").setGridParam({
		datatype : "json",
		
		postData : {
			scrYyyymm : yyyymm,
			//srchStrCd : $("#scrStrCd").val()
		}
	}).trigger("reloadGrid");
	

}

// 시간별 전력량 그래프 - 미사용
function fncDailyChart(list) {

	$('#chrtMain').html('');
	
	//var list   = $("#gridUsedDailyArea").getRowData();
	var rowCnt = list.length;
	console.log( "rowCnt : " + rowCnt );
	//for(var i=0; i<rowCnt; i++)		
		
	
		console.log( " list : " + list[rowCnt-1].yyyymmdd );
	
	var dd 			= new Array();
	var temp   		= new Array();
	var tempArray	= new Array();
	var etc   		= new Array();
	var yyyymmdd	= new Array();
	var tick		= new Array();
	
	var chartDataTemp	= new Array();		// 차트 냉난방 데이터
	var chartDataEtc	= new Array();		// 차트 기타 데이터
	
	
	var param = new Object();
	
	
	/*
	for(var i=rowCnt-1; i>=0; i--) 
	{	
		dd.push( list[i].dd );	
		temp.push( Number( list[i].temp ) );				
		etc.push( Number( list[i].etc ) );
		yyyymmdd.push( list[i].yyyymmdd );		
		// YYYY, MM, DD, HH, MIN
		var getDateTime = Date.UTC(Number( (String)(list[i].yyyymmdd).substr(0,4) ), Number( (String)(list[i].yyyymmdd).substr(4,2))-1, (String)(list[i].dd), "00", "000");
		tick.push( getDateTime );
		
		chartDataTemp.push( [ getDateTime, Number( list[i].temp ) ]  );
		chartDataEtc.push( 	[ getDateTime, Number( list[i].etc ) ]  );
		//temp.push( "[" + Date.UTC(Number( (String)(list[i].yyyymmdd).substr(0,4) ), Number( (String)(list[i].yyyymmdd).substr(4,2))-1, (String)(list[i].dd), "00", "000")  + "," + Number( list[i].temp ) + "]");		
		
	}
	*/
	//for (var i = 0; i < rowCnt; i++) 
		for (var i = rowCnt-1; i >= 0; i--)    //하이차트는 데이트 정렬 ASC로 해야하기때문에 리스트 반대로 정렬
	{	
		dd.push( list[i].dd );	
		temp.push( Number( list[i].temp ) );				
		etc.push( Number( list[i].etc ) );
		yyyymmdd.push( list[i].yyyymmdd );		
		// YYYY, MM, DD, HH, MIN
		var getDateTime = Date.UTC(Number( (String)(list[i].yyyymmdd).substr(0,4) ), Number( (String)(list[i].yyyymmdd).substr(4,2))-1, (String)(list[i].dd), "00", "000");
		tick.push( getDateTime );
		
		if( Number( list[i].temp) < 0 )
			chartDataTemp.push( [ getDateTime, Number( 0 ) ]  );
		else
			chartDataTemp.push( [ getDateTime, Number( list[i].temp ) ]  );
		
		if( Number( list[i].etc ) < 0 )
			chartDataEtc.push( 	[ getDateTime, Number( 0 ) ]  );
		else
			chartDataEtc.push( 	[ getDateTime, Number( list[i].etc ) ]  );
		//temp.push( "[" + Date.UTC(Number( (String)(list[i].yyyymmdd).substr(0,4) ), Number( (String)(list[i].yyyymmdd).substr(4,2))-1, (String)(list[i].dd), "00", "000")  + "," + Number( list[i].temp ) + "]");		
	//	alert([ getDateTime, Number( list[i].temp ) ]  );
	//	alert([ getDateTime, Number( list[i].etc ) ] );
	}
	//console.log( chartDataTemp );
	//console.log( chartDataEtc );
	
	
	Highcharts.setOptions({
	lang: {
			weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			rangeSelectorZoom : '',
			loading : "Loading...",
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
			selected: 1,
			inputEnabled : false,

	    },
	    navigator : {
	    	height : 30,
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
				},
		],		
		xAxis : {
			type: 'datetime',
			dateTimeLabelFormats: {
				second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%d일',
				hour: '%d일',
				day: '%d일',
				week: '%Y<br/>%m-%d',
				month: '%Y-%m',
				year: '%Y'
			},
			tickInterval: 24 * 3600 * 1000
		},
		yAxis : {
			labels: {
				allowDecimals : 'false',
				align: 'left',			
	    		formatter: function() {
	    			return (this.value > 0 ? '' : '') + numberWithCommas (this.value ) + 'Kwh';
	    		}
	    	},
	    	min: 0,
	    	
		},
		
	});	
	

			
}




//날짜 버튼
function func_monthBtn(add) {
	var date = $.trim($("#scrDateTo").val());	
	var retDate = gfnDateAdd(date, 'M', -add+1 , '-');
	
	retDate = retDate.substring(0,7);
	
	$("#scrDateFrom").val(retDate);
	
	
}

// 날짜 버튼(전체)
function func_AllBtn() {
	$("#scrDateFrom").val("2010-01");
	$("#scrDateTo").val("${toDayMonth}");
}


</script>

<div id="loadingArea">


	<!-- 조회조건 -->
	<div class="r_search multiLine">	
	
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;display:none;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>	
			
		<table>
			<tr>
				<th>기간</th>
				<td>
					<input id="scrDateFrom" name="scrDateFrom" type="text" placeholder="" value='' style="width:80px;" readonly />
					<button class="monthBtn" style="background-color:rgba(0,0,0,0) !important" id="scrDateFromBtn"><img src="/images/btn_calendar_new.png"></button>
					~ <input id="scrDateTo" name="scrDateTo" type="text" placeholder="${toDayMonth}" value='${toDayMonth}' style="width:80px;" readonly />
					<button class="monthBtn" style="background-color:rgba(0,0,0,0) !important" id="scrDateToBtn"><img src="/images/btn_calendar_new.png"></button>
					<button onclick="javascript:func_AllBtn();" class="ml_5">전체</button>
			   		<button onclick="javascript:func_monthBtn(1);">1m</button>
			   		<button onclick="javascript:func_monthBtn(6);">6m</button>
			   		<button onclick="javascript:func_monthBtn(12);">1y</button>
				</td>
			</tr>	
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->	
	
	<!-- 테이블 영역 -->
	<!-- 전체매장 전력사용현황 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>전체매장 전력사용현황</h3>
		</div>					
		<table>
			<colgroup>
		    	<col width="15%" />
		    	<col width="222" />
		    	<col width="15%" />
		    	<col width="222" />
		    	<col width="15%" />
		    	<col width="*" />
	    	</colgroup>
	    	<tbody>
	    	<tr>
				<th>전체 매장수</th>
				<td><span id="totalStoreCnt"></span></td>
				<th>일평균 총 사용량(kWh)</th>
				<td><span id="totalDailyUseWatage"></span></td>
				<th>일평균 매장별 사용량(kWh)</th>
				<td><span id="totalDailyAvgWatage"></span></td>						
			</tr>
			</tbody>
		</table>
	</div>
	<!-- //전체매장 전력사용현황 -->
	<!-- //테이블 영역 -->
	
	<div class="r_halfGridContainer" style="height:280px;">
		<div class="r_grid r_halfGrid_l r_secondTbl" id="con1">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyTotalElecUse}</h3>	
			</div>
			<table class="gridPointer" id="gridUsedArea"><tr><td></td></tr></table>
		</div>
		
		<div class="r_grid r_halfGrid_r r_secondTbl" id="con2">
			<div class="r_inputTblTitle">
				<h3>${smDailyTotalElecUse}</h3>	
			</div>
			<table class="gridPointer" id="gridUsedDailyArea"><tr><td></td></tr></table>
		</div>
	</div>
	
	<div class="r_mainChart_b">
		<div id="chrtMain"></div>
	</div>	
	
</div>