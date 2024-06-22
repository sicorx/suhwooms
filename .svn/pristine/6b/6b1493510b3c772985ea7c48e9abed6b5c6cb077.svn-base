<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var='sm_orgTree'><spring:message code='orgTree'/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smStrEqmtTempTrend"><spring:message code="strEqmtTempTrend" /></c:set>
<c:set var="smDevice"><spring:message code="device" /></c:set>
<c:set var="smDate"><spring:message code="date" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	$("#calSrchDt").datepicker({
		dateFormat: 'yymmdd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true
	});

	$('#calSrchDt').val("${eqmtVo.yyyyMmDd}");
	
	fncRetrieveInverterTemp();
});

/*******************
1. 기타 필수 스크립트
********************/

Date.prototype.format = function(f) {
	if (!this.valueOf())
		return " ";

	var weekName = [ "${sm_sunday}", "${sm_monday}", "${sm_tuesday}", "${sm_wednesday}", "${sm_thursday}", "${sm_friday}", "${sm_saturday}" ];
	var d = this;

	return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
		case "yyyy":
			return d.getFullYear();
		case "yy":
			return (d.getFullYear() % 1000).zf(2);
		case "MM":
			return (d.getMonth() + 1).zf(2);
		case "dd":
			return d.getDate().zf(2);
		case "E":
			return weekName[d.getDay()];
		case "HH":
			return d.getHours().zf(2);
		case "hh":
			return ((h = d.getHours() % 12) ? h : 12).zf(2);
		case "mm":
			return d.getMinutes().zf(2);
		case "ss":
			return d.getSeconds().zf(2);
		case "a/p":
			return d.getHours() < 12 ? "${sm_morning}" : "${sm_afternoon}";
		default:
			return $1;
		}
	});
};

String.prototype.string = function(len) {
	var s = '', i = 0;
	while (i++ < len) {
		s += this;
	}
	return s;
};

String.prototype.zf = function(len) {
	return "0".string(len - this.length) + this;
};

Number.prototype.zf = function(len) {
	return this.toString().zf(len);
};

function fncRetrieveInverterTemp() {

	var scrDt = $('#calSrchDt').val();
	var device = $('#selDevice').val();

	var strCd      = "${eqmtVo.strCd}";
	var hubId     = 1;
	var portNo    = device;
	var yyyyMmDd  = scrDt.replace('-');

	if( portNo == null || portNo == "" ){
		alert("장치를 선택해주세요");
		return false;
	}
	if( yyyyMmDd == null || yyyyMmDd == "" ){
		alert("일자를 선택해주세요");
		return false;
	}
	
	$.ajax({
		type : "POST",
		cache : false,
		url : "/retrieveInverterTempChartData",
		data : {
			strCd : strCd,
			yyyyMmDd  : yyyyMmDd,
			hubId   : hubId,
			portNo    : portNo
		},
		dataType : "json",
		success : function(result) {
			$('#chrtContainer').empty().append("${sm_rsltNotExist}");

			//성공시 실행부분
			var Day_data = [];
			var temp = [];
			var alarm_data = [];

			// 그래프 데이터
			//var min_temp = Number(result[0].min_temp);
			//var max_temp = Number(result[0].max_temp);
			
			var min_temp = Number("-10");
			var max_temp = Number("10");
			
			for ( var i = 0; i < result.length - 1; i++) {

				if (Number(result[i].sens_temp) != -50) {

					UTC_str = Date.UTC(result[i].yyyy, result[i].mm - 1,
							result[i].dd, result[i].hh, result[i].min,
							"00", "000");
					Day_data.push([ Number(UTC_str),
							Number(result[i].sens_temp) ]);
					
					if (result[i].alarm_sp != '0000000000000000') {
						alarm_data.push([ Number(UTC_str),
								Number(result[i].sens_temp) ]);
					} else if (result[i].alarm_sp == '0000000000000000'){
						alarm_data.push([ Number(UTC_str), null ]);
					}
				}
			}

			Highcharts.setOptions({
				lang : {
					weekdays : [ '${sm_sunday}', '${sm_monday}', '${sm_tuesday}', '${sm_wednesday}', '${sm_thursday}', '${sm_friday}',
							'${sm_saturday}' ],
					shortMonths : [ '${sm_jan}', '${sm_feb}', '${sm_mar}', '${sm_apr}', '${sm_may}', '${sm_jun}',
							'${sm_jul}', '${sm_aug}', '${sm_sep}', '${sm_oct}', '1${sm_jan}', '${sm_dec}' ],
				}
			});

			// Create the chart
			$('#chrtContainer').highcharts('StockChart', {

				loading : {
					style : {
						backgroundColor : 'silver'
					},
					labelStyle : {
						color : 'white'
					}
				},
				chart : {
					borderWidth : 1,
					plotBorderWidth : 1,
					spacingRight : 15,
					spacingLeft : 15,
					height : 360,
					panning : true,

				},
				credits : {
					enabled : false
				},
				exporting : {
					enabled : false
				},
				title : {},
				xAxis : {
					type : 'datetime',
					dateTimeLabelFormats : {
						second : '%H:%M',
						minute : '%H:%M',
						hour : '%H',
						day : '%H',
						week : '%m-%d<br>%H:%M',
						month : '%Y-%m-%d<br>%H:%M',
						year : '%Y-%m-%d<br>%H:%M'
					},
					tickPixelInterval : 55,
					gridLineWidth : 1,
					labels : {
						style : {
							fontSize : '1em'
						},
					},
				},
				plotOptions : {
					series : {
						color : '#8C8C8C',
						dataLabels : {
							enabled : false,
						},
					},
				},
				yAxis : {
					min : -30,
					max : 30,
					gridLineDashStyle : 'dash',
					minorTickInterval : 'auto',
					plotBands : [ {
						from : min_temp,
						to : max_temp,
						color : '#F6F6F6',
						label : {
							text : '',
							align : 'left',
							verticalAlign : 'top',
						}
					} ],
					plotLines : [ {
						value : min_temp,
						width : 1,
						color : 'red',
						dashStyle : 'shortdash',
						label : {
							text : min_temp + '℃ ${sm_lowTemp}',
							align : 'left',
							y : 12
						}
					}, {
						value : max_temp,
						width : 1,
						color : 'red',
						dashStyle : 'shortdash',
						label : {
							text : max_temp + '℃ ${sm_highTemp}',
							align : 'left',
						}
					} ],
				},
				navigator : {
					series : {
						type : 'line',
						color : '#4572A7',
						fillOpacity : 0.05,
						dataGrouping : {
							smoothed : true
						},
						lineWidth : 1,
						marker : {
							enabled : false
						}
					},
					enabled : false,
				},
				scrollbar : {
					enabled : false,
					barBorderRadius : 20,
					barBorderWidth : 0,
					buttonBorderWidth : 0,
					trackBackgroundColor : 'none',
					trackBorderWidth : 5,
					trackBorderRadius : 1,
					trackBorderColor : '#CCC',
					height : 50
				},
				rangeSelector : {
					allButtonsEnabled : true,
					selected : 0,
					buttons : [ {
						type : 'day',
						count : 1,
						text : 'day'
					}, {
						type : 'minute',
						count : 60,
						text : '1h'
					}, {
						type : 'minute',
						count : 360,
						text : '6h'
					}, {
						type : 'minute',
						count : 720,
						text : '12h'
					} ],
					inputEnabled : false
				},
				tooltip : {
					valueDecimals : 0,
					shared : false,
					valueSuffix : ' ℃',
					positioner : function() {
						return {
							x : 10,
							y : 40
						};
					},
				},
				series : [ {
					name : '${sm_temp}',
					data : Day_data,
					type : 'line',
					color : '#8C8C8C'
				}, {
					name : '${sm_alarm}',
					type : 'line',
					data : alarm_data,
					lineWidth : 5,
					lineColor : 'red',
					states : {
						hover : {
							lineWidth : 5,
						}
					},
				}
				]
			});
		},
		error : function(result) {
			alert("${sm_errorHappens}"); //실패시 실행부분
		}
	});
}

/*******************
1. 팝업  
********************/


/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

</script>
<div class="r_popup">
	<h1 class="r_popupTitle">${smStrEqmtTempTrend}</h1>	  
	<div class="r_popupCont">	
		<div class="r_search multiLine">  
			<table>
				<tr>
					<th>${smDevice}</th>
					<td>
						<select id="selDevice" name="selDevice" style="width:112px;" class="searchSelect">
							<option value=''>--선택--</option>
							<c:forEach var="vo" items="${eqmtList}" varStatus="status" >
								<option value='${vo.value}' <c:if test="${eqmtVo.portNo == vo.value}">selected</c:if> >${vo.name}</option>
							</c:forEach>
						</select>
					</td>
					<th>${smDate}</th>
					<td>
						<input type='text' id='calSrchDt' name='calSrchDt' />
					</td>
				</tr>					
			</table>
			<span class="search">
				<button onclick="javascript:fncRetrieveInverterTemp()">${smRetrieve}</button>
			</span>
		</div>
		<div id="chrtContainer"></div>
		<div class="r_pageBtnWrapper">
		     <span class="pageNormal">
		     	<button onclick="javascript:fncCancel()">${smClos}</button>
		     </span>
		</div>
	</div>
</div>
