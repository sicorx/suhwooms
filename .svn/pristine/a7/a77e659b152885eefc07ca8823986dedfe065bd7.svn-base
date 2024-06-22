<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	//월별 전력량
	$("#gridUsedArea").jqGrid({
		url:'retrieveUseMonthList',
		datatype: "local",
		mtype: 'POST',
		postData: {
			srchStrCd: '${orgStrCd}',
			srchYyyymm: '${orgYyyymm}'
		},
		colNames:['${smYearMonth}', '${smTotalElecUse}', '${smHacElecUse}', '${smLightElecUse}', '${smOutdoorTempC}'],
		colModel:[
			{name:'yyyymm',index:'yyyymm', width:70, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'temp',index:'temp', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'light',index:'light', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'forecastTemp',index:'forecastTemp', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false}
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
		rowNum:13,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '200',
		onSelectRow : function(rowid, status, e) {
			var list   = $("#gridUsedArea").getRowData(rowid);
			var yyyymm = list.yyyymm.replace("-", "");

			fncRetrieveUsedDailyArea(yyyymm);
		},
		loadComplete : function(data) {
			var list   = $("#gridUsedArea").getRowData();
			var rowCnt = list.length;
			
			if( rowCnt > 0 ) {
				$("#gridUsedArea").jqGrid('setSelection', 1);
			}
		}		
	});
	
	//일자별 전력량 
	$("#gridUsedDailyArea").jqGrid({
		url:'retrieveUseDailyList',
		datatype: "local", //최초조회하지 않음
		mtype: 'POST',
		colNames:['${smDate}', '${smTotalElecUse}', '${smHacElecUse}', '${smLightElecUse}', '${smIndoorTempC}', '${smOutdoorTempC}'],
		colModel:[
			{name:'yyyymmdd',index:'yyyymmdd', width:50, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', width:90, align:'right', sortable:true, editable:false},
			{name:'temp',index:'temp', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'light',index:'light', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'senseTemp',index:'senseTemp', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'forecastTemp',index:'forecastTemp', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false}
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
		rowNum:31,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '200',
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list   = $("#gridUsedDailyArea").getRowData(rowid);
			var yyyymmdd = list.yyyymmdd.replace("-", "");

			// 시간차트 조회
			fncHourlyChart(yyyymmdd);
		},
		loadComplete : function(data) {

			if(  data.length > 0 ) {
				$("#gridUsedDailyArea").jqGrid('setSelection', 1);				
			}
		}		
	});
	
	$("#viewStrCd").bind('change', function(e) {
		fncClearInput("C");
	});
	
	$("#strNm").bind('change', function(e) {
		fncClearInput("N");
	});

	$("#viewStrCd").bind('keydown', function(e) {
		if( e.keyCode == 13 ) {
			$("#strNm").val("");
			fncStrSearch( $("#innerSearch") );	
		}
	});

	$("#strNm").bind('keydown', function(e) {
		if( e.keyCode == 13 ) {
			$("#viewStrCd").val("");
			fncStrSearch( $("#innerSearch") );	
		}
	});	
	
	if( '${orgStrCd}' != '' && '${orgStrCd}' != null ) {
		fncSearch();
	}	
});

/*******************
1. 기타 필수 스크립트
********************/

function fncClearInput(param){

	$("#scrStrCd").val("");
	
	if( param == "C" ) {
		$("#strNm").val("");	
	}
	else if( param == "N") {
		$("#viewStrCd").val("");	
	}
}

/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#scrStrNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;
		
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );
}

function fncSetStore(data){
	$("#scrViewStrCd").val(data.viewStrCd);
	$("#scrStrNm").val(data.strNm);
	$("#scrStrCd").val(data.strCd);
}

function fncStoreClear(){
	$("#scrViewStrCd").val("");
	$("#scrStrNm").val("");
	$("#scrStrCd").val("");
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var scrStrCd  = $("#scrStrCd").val();
	var yyyymm = ( $("#selYearMonth").val() ).replace( "-", "" );
	
	if( scrStrCd == '' || scrStrCd == null ) {
		alert("${smStrCdSrch}");
		return false;
	}

	if( yyyymm == '' || yyyymm == null ) {
		yyyymm = '${orgYyyymm}';	
	}
	
	$("#gridUsedArea").clearGridData();
	$("#gridUsedDailyArea").clearGridData();
	$('#chrtMain').html('');
	
	$("#gridUsedArea").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUsedArea").setGridParam ({
		datatype : "json",		
		postData : {
			srchYyyymm : yyyymm,
			srchStrCd : scrStrCd
		}
	}).trigger("reloadGrid");
}

function fncRetrieveUsedDailyArea(yyyymm) {
	
	$('#selectedMonth').val( yyyymm );
	
	$("#gridUsedDailyArea").clearGridData();

	
	$("#gridUsedDailyArea").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUsedDailyArea").setGridParam({
		datatype : "json",
		postData : {
			srchYyyymm: yyyymm,
			srchStrCd : $("#scrStrCd").val()
		}
	}).trigger("reloadGrid");
}

function fncHourlyChart(yyyymmdd) {

	$('#chrtMain').html('');
	
	var ticks = new Array();
	var hac   = new Array();
	var light = new Array();
	var etc   = new Array();
	
	var param = new Object();
	
	param.srchStrCd    = $('#scrStrCd').val();
	param.srchYyyymm   = $('#selectedMonth').val();
	param.srchYyyymmdd = yyyymmdd;
			
	$.ajax({
		type : "POST",
		async: false,
		url : "retrieveMainUseHourlyChrt",
		data : param,
		dataType : "json",
		success : function(data) {

			for(var i = data.length; i > 0; i--) {
				var val = data[i-1];

				ticks.push( val.hh );	
				hac.push( Number( val.hac ) );
				light.push( Number( val.light ) );
				etc.push( Number( val.etc ) );
			}
			
			if( light == null || light.length <= 0 ) {
				light = [null];
			}

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
					inputDateFormat : "%Y-%m-%d"
				},
				series : [ {
					type : 'column',
					data : hac,
					name : '${smTempCtrl}',
		            pointStart: Date.UTC(Number(param.srchYyyymm.substr(0,4)), Number(param.srchYyyymm.substr(4,2))-1, yyyymmdd, ticks[0], "000"),
					pointInterval : 3600 * 1000,	
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
		            pointStart: Date.UTC(Number(param.srchYyyymm.substr(0,4)), Number(param.srchYyyymm.substr(4,2))-1, yyyymmdd, ticks[0], "000"),
		            pointInterval : 3600 * 1000,		
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
		            pointStart: Date.UTC(Number(param.srchYyyymm.substr(0,4)), Number(param.srchYyyymm.substr(4,2))-1, yyyymmdd, ticks[0], "000"),
		            pointInterval : 3600 * 1000,
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
					dateTimeLabelFormats : {
						hour: '%H',
						day: '%e. %b'
					},
					type : 'datetime',
					gridLineWidth : 1
				},
				yAxis : {
					gridLineDashStyle : 'dash',
					minorTickInterval : 'auto',
				},
			});	
		}
	});		
}

</script>

<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>${smCompany}</th>
				<td>
				 	<c:if test="${selectVoListCnt == 1 }">
						<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
						<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
					</c:if>
					<c:if test="${selectVoListCnt > 1 }">			
						<select id="'scrCompanyCd'" name="scrCompanyCd'" style="width:100px;" class="searchSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.name}'>${vo.value}</option>
								</c:forEach>
						</select>
					</c:if>
				</td>
			</tr>	
			<tr>
				<th>${smStr}</th>
				<td>
					<input type='hidden' id='scrStrCd' name='scrStrCd' value='' />
					<input type='text' id='scrViewStrCd' name='scrViewStrCd' value='${storeStatusVo.viewStrCd}' style="width:100px;" class="r_Input r_disable" readonly />
					<div class="r_innerSearch">
						<input type='text' id='scrStrNm' name='scrStrNm' value='${storeStatusVo.strNm}' style="width:100px;" class="r_Input r_disable" readonly />
						<img src="/images/ico_innerSearch.png" alt="inner search" id="innerSearch"  onclick="javascript:fncStrSearch();" style="cursor:pointer"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
					</div>
				</td>
				<th>${smYearMonth}</th>
				<td>
					<select class="searchSelect" id="selYearMonth" name="selYearMonth" style="width:120px;" >
						<c:forEach items="${yearMonth}" var="item">
						<option value='${fn:replace(item.yearMonth,"-", "")}'>${item.yearMonth}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
	
		<span class="search">
	        <button onclick="javascript:fncSearch()">${smRetrieve}</button>
	    </span>
	</div>
	
	<div class="r_halfGridContainer" style="height:280px;">
		<div class="r_grid r_halfGrid_l r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyTotalElecUse}</h3>	
			</div>
			<table id="gridUsedArea"><tr><td></td></tr></table>
		</div>
		
		<div class="r_grid r_halfGrid_r r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smDailyTotalElecUse}</h3>	
			</div>
			<table id="gridUsedDailyArea"><tr><td></td></tr></table>
		</div>
	</div>
	
	<div class="r_mainChart_b">
		<div id="chrtMain"></div>
		<input type="hidden" id='selectedMonth' name='selectedMonth' value='' />
		<input type="hidden" id='yyyymmdd' name='yyyymmdd' value='' />
	</div>
	
	<div id="dialog-confirm" title="" style="display:none;">
		<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>로딩중...</p>
	</div>
</div>