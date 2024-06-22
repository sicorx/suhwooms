<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smMonthlyEqmtTemp"><spring:message code="monthlyEqmtTemp"/></c:set>
<c:set var="smDailyEqmtTemp"><spring:message code="dailyEqmtTemp"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smSrch"><spring:message code="srch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>

<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smDate"><spring:message code="date"/></c:set>

<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>

<script type="text/javascript"> 

/*******************
1. 기타 필수 전역 변수
********************/

var dbColmoArr = new Array();  // 그리드 컬럼명을 저장할 전역변수
var temonIdArr    = new Array();
var hubIdArr      = new Array();
var temonTypeArr  = new Array();
var portNoArr     = new Array();
var deviceTypeArr = new Array();
var deviceLocArr  = new Array();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){ 

	alert('여기여기');
	fncRetrieveStorePlant();
});

function fncRetrieveStorePlant() {

	var srchYyyymm = ( $("#selYearMonth option:selected").val() ).replace( "-", "" );
	
	if( srchYyyymm == '' || srchYyyymm == null ) {
		srchYyyymm = '${orgYyyymm}';	
	}
	
	$("#gridPlantMonthList").jqGrid('GridUnload');
	$("#gridPlantDailyList").jqGrid('GridUnload');
	$('#chrtPlantDaily').html('');
	
	// 쿼리로 넘겨줄 변수 초기화
	dbColmoArr = new Array();
	
	/* jqGrid 컬럼 동적 생성 */
	// 1. 변하지 않는 컬럼 생성
	var tempArr    = new Array();
	var columnArr  = new Array();
	var columnArr1 = new Array();
	var colmoArr   = new Array();
	var colmoArr1  = new Array();
	
	columnArr[0]  = "${smYearMonth}";

	var colmoObj      = new Object();
	colmoObj.name     = "yyyymm";
	colmoObj.index    = "yyyymm";
	colmoObj.width    = 70;
	colmoObj.align    = "center";
	colmoObj.sortable = true;

	colmoArr[0] = colmoObj;
	
	columnArr1[0] = "${smDate}";	
	
	var colmoObj1      = new Object();
	colmoObj1.name     = "yyyymmdd";
	colmoObj1.index    = "yyyymmdd";
	colmoObj1.width    = 70;
	colmoObj1.align    = "center";
	colmoObj1.sortable = true;

	colmoArr1[0] = colmoObj1;
	
	// 2. 변하는 컬럼 생성
	$.ajax({
		async: false,
		type : "POST",		
		url : "/retrieveStorePlant",
		dataType : "json",
		data : {srchStrCd: $('#scrStrCd').val() },
		success : function(rslt) {
			tempArr = rslt;

			$.each(tempArr, function(key, value) {
				columnArr.push( value.deviceLoc + " " + value.deviceType );
				var colmoObj       = new Object();
				colmoObj.name      = value.temonId + value.temonType + value.hubId + value.portNo + value.deviceType;
				colmoObj.index     = value.temonId + value.temonType + value.hubId + value.portNo + value.deviceType;
				colmoObj.width     = 70;
				colmoObj.align     = "right";
				colmoObj.formatter = "number";

				colmoArr.push( colmoObj );

				columnArr1.push( value.deviceLoc + " " + value.deviceType );
				var colmoObj1       = new Object();
				colmoObj1.name      = value.temonId + value.temonType + value.hubId + value.portNo + value.deviceType;
				colmoObj1.index     = value.temonId + value.temonType + value.hubId + value.portNo + value.deviceType;
				colmoObj1.width     = 70;
				colmoObj1.align     = "right";
				colmoObj1.formatter = "number";

				colmoArr1.push( colmoObj1 );
			
				// 쿼리로 넘겨줄 컬럼명
				temonIdArr.push( value.temonId );
				hubIdArr.push( value.hubId );
				temonTypeArr.push( value.temonType );
				portNoArr.push( value.portNo );
				deviceTypeArr.push( value.deviceType );
				deviceLocArr.push( value.deviceLoc );
				//dbColmoArr.push(eqmtObj);
				//dbColmoArr.push( value.portNo + "-" + value.deviceType );
			});
			
			// jquery에서 ajax 사용하여 spring controller에 배열 데이터 전송 위해 변경
			$.ajaxSettings.traditional = true;
			
			// 3. 컬럼 생성 완료 후 월별 시설물 조회
			$("#gridPlantMonthList").jqGrid({
				url:'retrievePlantMonthList',
				datatype: "json",
				mtype: 'POST',
				postData : {
					srchYyyymm : srchYyyymm,
					srchStrCd : $("#scrStrCd").val(),
					temonIdArr : temonIdArr,
					hubIdArr : hubIdArr,
					temonTypeArr : temonTypeArr,
					portNoArr : portNoArr,
					deviceTypeArr : deviceTypeArr,
					deviceLocArr : deviceLocArr
				},
				colNames: columnArr,
				colModel: colmoArr,
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
				height: '180',
				onSelectRow : function(rowid, status, e) {
					var list   = $("#gridPlantMonthList").getRowData(rowid);
					var yyyymm = list.yyyymm.replace("-", "");
					
					fncRetrievePlantDailyList(yyyymm);
				},
				loadComplete : function(data) {
					var list   = $("#gridPlantMonthList").getRowData();
					var rowCnt = list.length;
		
					if( rowCnt > 0 ) {
						$("#gridPlantMonthList").jqGrid('setSelection', 1);
					}
				}
			});
					
			// 4. 컬럼 생성 완료 후 일자별 시설물 그리드 생성
			$("#gridPlantDailyList").jqGrid({
				url:'retrievePlantDailyList',
				datatype: "local",
				mtype: 'POST',
				colNames: columnArr1,
				colModel: colmoArr1,
				postData : {
					srchYyyymm : srchYyyymm,
					srchStrCd : $("#scrStrCd").val(),					
					colmo : dbColmoArr
				},
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
				height: '180',
				onSelectRow : function(rowid, status, e) {
					var list = $("#gridPlantDailyList").getRowData(rowid);
					var dd   = list.yyyymmdd;
					
					fncChartPaging(dd);
				},
				loadComplete : function(data) {
					var list   = $("#gridPlantDailyList").getRowData();
					var rowCnt = list.length;
		
					if( rowCnt > 0 ) {
						$("#gridPlantDailyList").jqGrid('setSelection', 1);
					}
				}				
			});			
		}
	});
}

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

function fncRetrievePlantMonthList() {
	
	var strCd  = $("#scrStrCd").val();
	
	if( strCd == '' || strCd == null ) {
		alert("${smStrCdSrch}");
		return false;
	}

	var yyyymm = ( $("#selYearMonth option:selected").val() ).replace( "-", "" );
	
	if( yyyymm == '' || yyyymm == null ) {
		yyyymm = '${orgYyyymm}';	
	}
	
	$("#gridPlantMonthList").clearGridData();
	$("#gridPlantDailyList").clearGridData();
	$('#chrtPlantDaily').html('');
	
	$("#gridPlantMonthList").setGridParam ({
		datatype : "json",		
		postData : {
			srchYyyymm : yyyymm,
			srchStrCd : strCd,
			temonIdArr : temonIdArr,
			hubIdArr : hubIdArr,
			temonTypeArr : temonTypeArr,
			portNoArr : portNoArr,
			deviceTypeArr : deviceTypeArr,
			deviceLocArr : deviceLocArr		
		}
	}).trigger("reloadGrid");
}

function fncRetrievePlantDailyList(yyyymm) {
	
	$("#selYearMonth").val(yyyymm);
	
	$("#gridPlantDailyList").clearGridData();
	$('#chrtPlantDaily').html('');
	
	$("#gridPlantDailyList").setGridParam({
		datatype : "json",
		postData : {
			srchYyyymm : yyyymm,
			srchStrCd : $("#scrStrCd").val(),
			temonIdArr : temonIdArr,
			hubIdArr : hubIdArr,
			temonTypeArr : temonTypeArr,
			portNoArr : portNoArr,
			deviceTypeArr : deviceTypeArr,
			deviceLocArr : deviceLocArr
		}
	}).trigger("reloadGrid");	
}

function fncChartPaging(dd) {
	
	var param = new Object();
	
	param.srchStrCd  = $("#scrStrCd").val();	
	param.srchYyyymm = $("#selYearMonth").val();
	param.srchDd     = dd;	
	param.temonIdArr    = temonIdArr;
	param.hubIdArr      = hubIdArr;
	param.temonTypeArr  = temonTypeArr;
	param.portNoArr     = portNoArr;
	param.deviceTypeArr = deviceTypeArr;
	param.deviceLocArr  = deviceLocArr;

	
	var rslt      = new Array(); // 차트로 넘겨줄 데이터(y값)
	//2015.05.13. jqplot에서 highstock으로 차르를 변경하면서 사용하지 않음)
	//var tickArr   = new Array(); // 차트로 넘겨줄 x축 값
	var seriesArr = new Array(); // 차트로 넘겨줄 series 속성값 배열

	$('#chrtPlantDaily').html('');

	$.ajax({
		type : "POST",
		async: false,
		url : "retrieveDailyPlantChart",
		data : param,
		dataType : "json",
		success : function(data) {

			// 데이터가 있을 때만 실행
			if( data != null && data.length > 0 ) {
				
				// 결과값의 첫 번째 배열은 'label 키'(DB에서 가져온 컬럼명)를 가지고 있음
				var labelKeyArr = data[0];
				var labelKeyIdx = -1;
				$.each(labelKeyArr, function(idx, info) {
					if( info == "hhmin" ) {
						labelKeyIdx = idx; // xAxis에 사용할 tick을 가지고 있는 결과값 배열 번호
					}
				});
				
				//tickArr = data[ labelKeyIdx + 2 ];

				$.each(data, function(idx, info) {
					
					// 결과값의 첫 번째, 두 번째 배열은 넘어감
					// tick을 가지고 있는 결과값 배열도 넘어감
					if( idx == 0 || idx == 1 || idx == ( labelKeyIdx + 2 ) ) {
					}
					else {
						// string으로 들어온 값을 number로 변환
						var tmp = new Array();
						$.each(info, function(j, val) {
							tmp.push( parseFloat( val ) );
						});
						rslt.push( tmp );
					}
				});

				// 결과값의 두 번째 배열은 'label 명'(화면에서 보여줄 컬럼명)을 가지고 있음
				$.each(data[1], function(j, val) {

					var seriesObj = new Object();
					seriesObj.type = 'line';
					seriesObj.data = rslt[j];
					seriesObj.name = val;
					seriesObj.pointStart = Date.UTC(Number((param.srchYyyymm).substring(0,4)), Number((param.srchYyyymm).substring(4,2))-1, dd, "0000", "000");
					seriesObj.pointInterval = 300 * 1000;	
					seriesObj.tooltip = new Object({
						valueDecimals : 1,
						shared : false,
						valueSuffix : ' ℃',
						positioner : function() {
							return {
								x : 10,
								y : 40
							};
						}
					});

					seriesArr.push( seriesObj );
				});
				
				$('#chrtPlantDaily').highcharts('StockChart', {

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
						inputDateFormat : '%H:%M'
					},
					series : seriesArr,
					xAxis : {
						dateTimeLabelFormats : {
							minute: '%H:%M',
							hour: '%H:%M'
						},
						type : 'datetime',
						gridLineWidth : 1
					},
					yAxis : {
						labels : {
							format: '{value} ℃'
						},
						gridLineDashStyle : 'dash',
						minorTickInterval : 'auto'
					}		
				});					
			}
		}
	});
}	

</script>

<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="companyCd"> 
</form>
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
	        <button onclick="javascript:fncRetrieveStorePlant()">${smRetrieve}</button>
	    </span>
	</div>
	
	<div class="r_halfGridContainer" style="height:250px;">
		<div class="r_grid r_halfGrid_l r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyEqmtTemp}</h3>	
			</div>
			<table id="gridPlantMonthList"><tr><td></td></tr></table>
		</div>
		
		<div class="r_grid r_halfGrid_r r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smDailyEqmtTemp}</h3>	
			</div>
			<table id="gridPlantDailyList"><tr><td></td></tr></table>
		</div>
	</div>
	
	<div class="r_tempChart_b">
		<div id="chrtPlantDaily"></div>
	</div>
</div>