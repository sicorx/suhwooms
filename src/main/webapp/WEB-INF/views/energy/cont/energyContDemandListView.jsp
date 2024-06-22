<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smContElecK"><spring:message code="contElecK"/></c:set>
<c:set var="smMaxDemandElecK"><spring:message code="maxDemandElecK"/></c:set>
<c:set var="smMaxDemandElec"><spring:message code="maxDemandElec"/></c:set>
<c:set var="smMaxDemandHacElec"><spring:message code="maxDemandHacElec"/></c:set>
<c:set var="smMaxDemandLightElec"><spring:message code="maxDemandLightElec"/></c:set>
<c:set var="smDate"><spring:message code="date"/></c:set>
<c:set var="smContElec"><spring:message code="contElec"/></c:set>
<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>
<c:set var="smTime"><spring:message code="time"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smSrch"><spring:message code="srch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>
<c:set var="smMonthlyMaxDemandElec"><spring:message code="monthlyMaxDemandElec"/></c:set>
<c:set var="smDailyMaxDemandElec"><spring:message code="dailyMaxDemandElec"/></c:set>
<style type="text/css">
	.ui-jqgrid .ui-jqgrid-bdiv{ overflow-x:hidden; 
	overflow-y: true;
	}
</style>
<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
 	$("input[name='scrDate']").monthpicker({pattern: 'yyyy-mm', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    selectedYear: 2017,
	    startYear: 2010,
	    finalYear: 2050,
	    openOnFocus: false});			
	
	$('#scrDateBtn').bind('click', function () {
		$('#scrDateFrom').monthpicker('show')
	});	
	$('#scrDateBtn2').bind('click', function () {
		$('#scrDateTo').monthpicker('show');
	});	
	 
});

$(window).resize(function(){


    $("#gridMonthDemandList").setGridWidth($("#cont").width());


}).resize();

$(document).ready(function(){
	// Default Date Setting	
	
	$("#gridMonthDemandList").jqGrid({
		url:'retrieveMonthDmndList',
		datatype: "local",
		mtype: 'POST',
		postData: {
			scrStrNm : $('#scrStrNm').val(),
			scrDateFrom : $('#scrDateFrom').val(),
			scrDateTo : $('#scrDateTo').val(),
			scrOrgCd : $('#scrOrgCd').val()
		},
		colNames:['No',	'매장명','매장코드','조직명','오버이력','계약전력(kW)','최대수요전력(kW)','여유전력(kW)','최대냉난방전력(kW)','주소','전화번호','strCd','orgCd','yyyymm'],
		colModel:[
			 {name:'records',		index:'records',	width:10,	align:'center' },
			 {name:'strNm',			index:'strNm', 		width:60,	align:'left' },
             {name:'viewStrCd',		index:'viewStrCd', 	width:45,	align:'center' },             	                  
             {name:'orgFullName',	index:'orgFullName',width:45, 	align:'left' },
             {name:'peakCnt',		index:'peakCnt', 	width:30, 	align:'center' },             
             {name:'contPower',		index:'contPower', 	width:40, 	align:'center',	formatter:'number', formatoptions:{decimalPlaces:1}},	                
             {name:'mainTotal',		index:'mainTotal', 	width:40, 	align:'center',  formatter:'number', formatoptions:{decimalPlaces:1}},
             {name:'freePower',		index:'freePower', 	width:40, 	align:'center',  formatter:'number', formatoptions:{decimalPlaces:1}},
             {name:'temp',			index:'temp', 		width:40, 	align:'center' },
             {name:'addr',			index:'addr', 		width:80, 	align:'left' },
             {name:'telNo',			index:'telNo', 		width:60, 	align:'center' },
             {name:'strCd',			index:'strCd', 		hidden:true},
             {name:'orgCd',			index:'orgCd', 		width:50, 	hidden:true},
             {name:'yyyymm',		index:'yyyymm', 	width:50,	hidden:true}
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
		rowNum:20,
	    rowList:[10,20,50,100],
		pager: '#gridMonthDemandListPager',
		recordtext: "{1} 건/페이지  (전체 {2} 건)",
	    emptyrecords : "검색 결과가 존재하지 않습니다.",
	    loadtext: "Loading...",
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height: '300',
		onSelectRow : function(rowid, iRow, iCol, e) {
	  		var list   = $("#gridMonthDemandList").getRowData(rowid);
	  		//var strCd = list.strCd;
	  		//var yyyymm = list.yyyymm;
	  		console.log( list.strCd );	  		
	  		fncMonthChartData(list);			// 월별 계약전력 그래프
	  		
		},
		gridComplete : function()
		{
			jqGridEven('gridMonthDemandList');			 
			var rsltCount = $("#gridMonthDemandList").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridMonthDemandList >tbody").append("<tr><td align='center' colspan='10'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		loadComplete : function(data) {
			
			var list   = $("#gridMonthDemandList").getRowData();
			var rowCnt = list.length;
	
			if( rowCnt > 0 ) {
				$("#gridMonthDemandList").jqGrid('setSelection', 1);
			}
		}
	});
	
	// 매장명/코드 입력 Enter 시 수행
	$("#scrStrNm").keyup(function(event){	
		
		if(event.which == 13)		// Enter Key Press
		{		
			fncSearch()		// 사용자 조회				
		}
	});
	

	// 조직명 엔터 및 focusout
	$("input[name='scrOrgNm']").on({
		keyup: function() {
			$("input[name='scrOrgCd']").val("");
		},
		keydown: function(key) {
			if (key.keyCode == 13) {
				$(this).blur();
	        }
		},
		blur: function() {
			var scrOrgNm = $.trim($(this).val());
			var scrOrgCd = $.trim($("input[name='scrOrgCd']").val());
			
			// 검색어는 빈값이 아니면서 검색된 orgCd는 빈값일때만 검색
			if (scrOrgNm != "" && scrOrgCd == "") {
				fncSearchOrgCd();
			}
		}
	});
	
	fncSearch();
	
});


/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/


//조직명 검색
function fncSearchOrgCd() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#scrOrgNm").val());
	
	var param = new Object();
	param.companyCd = companyCd;
	param.orgNm = orgNm;
	
	$.ajax({
		url:'/retrieveOrgCdCnt',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
			$("input[name='scrOrgCd']").val("");
			var orgCnt = data.orgCnt;
			// 0개 일때
			if (orgCnt == "0") {
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (orgCnt == "1") {
				$("#scrOrgCd").val(data.orgCd)
				$("#scrOrgNm").val(data.orgNm + "(" + data.orgCd + ")");
			// 2개 이상일때	
			} else {
				// 조직 팝업
				fncOrgSearch();
			}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}



//조직 검색 버튼
function fncOrgSearchBtn() {
	var orgNm = $.trim($("#scrOrgNm").val());
	if (orgNm == "") {
		// 조직 팝업
		fncOrgSearch();
	} else {
		$("input[name='scrOrgNm']").blur();
	}
}

// 조직 팝업
function fncOrgSearch() {
	
	var companyCd = $.trim($("#scrCompanyCd").val());
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#scrOrgNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.orgNm = orgNm;
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd)
	$("#scrOrgNm").val(data.orgNm + "(" + data.orgCd + ")");
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}



function fncSearch() {
	
	if($('#scrDateFrom').val() > $('#scrDateTo').val()){
		alert("기간을 확인해주세요.");
		return false;
	}
	
	$("#gridMonthDemandList").clearGridData();	

	$("#gridMonthDemandList").setGridParam ({
		datatype : "json",		
		postData : {	
			scrStrNm : $('#scrStrNm').val(),
			scrDateFrom : $('#scrDateFrom').val(),
			scrDateTo : $('#scrDateTo').val(),
			scrOrgCd : $('#scrOrgCd').val(),
			scrMode : $(':radio[name="scrMode"]:checked').val()
		}
	}).trigger("reloadGrid");
	
	$('#chrtMain').html('');
	
		
}


// 차트 데이터
function fncMonthChartData(list) {
	
	$('#chrtMain').html('');
	
	
	var param = new Object();	
	param.strCd = list.strCd;
	param.yyyymm = list.yyyymm;			
	
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
		var getDateTime = Date.UTC( Number( (String)(yyyymmdd[i]).substr(0,4) ) , Number( (String)(yyyymmdd[i]).substr(4,2) )-1 ,  Number( (String)(yyyymmdd[i]).substr(6,2) ) ,  Number( (String)(hh[i]) ) ,  Number( (String)(qrt[i]) ) );		
		chartDataContPower.push( [ getDateTime, Number( contPower[i] ) ]  );
		chartDataMaxContPower.push( [ getDateTime, Number( total[i] ) ]  );
	
	}	
		
		
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
		//colors : ['#D80546', '#F5516C'],
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'center'

		},
		rangeSelector: {
	    	enabled: true,	    	
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
			selected: 4,
			inputEnabled : false

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
	    	height : 30,
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
			name : '최대수요전력',
			type : 'line',
			data : chartDataMaxContPower,			
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
				second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%Y-%m-%d<br/>%H:%M',
				hour: '%d일 %H시',
				day: '%d일',
				week: '%Y<br/>%m-%d',
				month: '%Y-%m',
				year: '%Y'
			},
			tickInterval: 24 * 3600 * 1000
		},
		yAxis : {
			labels: {
				allowDecimals : 'true',
				align: 'left',			
	    		formatter: function() {
	    			return (this.value > 0 ? '' : '') + numberWithCommas (this.value ) + 'Kw';
	    		}
	    	},
	    	min: 0,
	    	
		},		
	});
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrStrNm = $("#scrStrNm").val();
	var scrDateFrom = $("#scrDateFrom").val();
	var scrDateTo = $("#scrDateTo").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrMode = $(':radio[name="scrMode"]:checked').val();
	
	$("#excel1").val(scrStrNm);
	$("#excel2").val(scrOrgCd);
	$("#excel3").val(scrDateFrom);
	$("#excel4").val(scrDateTo);
	$("#excel5").val(scrMode);
	
	$('#excelDownload').attr("action", "/downloadMonthDmndExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">

<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrStrNm"> 
	<input type="hidden" id="excel2" name="scrOrgCd"> 
	<input type="hidden" id="excel3" name="scrDateFrom"> 
	<input type="hidden" id="excel4" name="scrDateTo">
	<input type="hidden" id="excel5" name="scrMode">
</form>

	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />						
		<table>
			<tr>
				<th>매장명/코드</th>
				<td>				
					<input type='hidden' id='scrStrCd' name='scrStrCd' value="" style="width:100px;" />
					<input type='text' id='scrStrNm' name='scrStrNm' value="" style="width:100px;"  placeholder="전체"/>
				</td>
				<th>조직명(코드)</th>
				<td><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체" readOnly=true; />
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer" />
				</td>			
				<th>기간</th>
				<td>
				
					 <input id="scrDateFrom" name="scrDate" type="text" placeholder="${toDayMonth}" value='${toDayMonth}' style="width:80px;" readonly />
					<button class="monthBtn" style="background-color:rgba(0,0,0,0) !important" id="scrDateBtn"><img src="/images/btn_calendar_new.png"></button> 
					~ <input id="scrDateTo" name="scrDate" type="text" placeholder="${toDayMonth}" value='${toDayMonth}' style="width:80px;" readonly />
					<button class="monthBtn" style="background-color:rgba(0,0,0,0) !important" id="scrDateBtn2"><img src="/images/btn_calendar_new.png"></button>
				</td>				
				<td>
					<span class="r_radio">
				   		<input type='radio' name='scrMode' id='scrModeAll' value='ALL' checked /><label for="scrModeAll">전체</label>&nbsp;
				    	<input type='radio' name='scrMode' id='scrModeOver' value='OVER'/><label for="scrModeOver">오버매장</label>
				    	<input type='radio' name='scrMode' id='scrModeEnough' value='ENOUGH'/><label for="scrModeEnough">여유매장</label>
					</span>					
				</td>
			</tr>			
		</table>
		<span class="search">
			<button onclick="javascript:fncSearch()">Search</button>
		</span>
	</div>	
	<!-- //조회조건 -->
	
	<div class="r_halfGridContainer" style="height:250px;">
		<div class="r_grid r_secondTbl" id="cont">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyMaxDemandElec}</h3>
				
				<!-- 엑셀 download -->
				<div style="text-align:right">
					<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
				</div>
				<!-- //엑셀 download -->
			</div>
			<table class="gridPointer" id="gridMonthDemandList"><tr><td></td></tr></table>			
			<div id="gridMonthDemandListPager"></div>
			
		</div>
	</div>
		
	<div class="r_mainChart_b">
		<div id="chrtMain"></div>
	</div>
	
</div>