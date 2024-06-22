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

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<title>REMS</title>

	<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/ui.jqgrid.css" />
 	<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jquery.jqplot.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/rems_global.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/rems_page.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/smoothness/jquery-ui.css" />
			
	<script src="resources/js/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script src="resources/js/jquery-ui.min.js" type="text/javascript"></script>
	<script src="resources/js/highstock.js" type="text/javascript" ></script>
	<script src="resources/js/exporting.js" type="text/javascript" ></script>
	<script src="resources/js/popup.js" type="text/javascript" ></script>

	<script type="text/javascript">
	/*
	 * jQuery UI 달력 
	 */
	$(function() {
		$("#calSrchDt").datepicker({
			dateFormat: 'yymmdd',
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			changeMonth: true,
			changeYear: true,
			buttonText: "달력",
			showMonthAfterYear: true
		});
	});


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

	
	
	/*
 	 * 팝업창에서 매장 장비 온도 추이 조회
	 */
	$(document).ready(function() {

		var gvInput = opener.gvPopParam.dataset;
		$("#selDevice").val(gvInput.temonid + "," + gvInput.portno + "," + gvInput.temontype);
		
		var currentDate = new Date();
		$("#calSrchDt").datepicker( "setDate", currentDate );
		
		fncRetrieveEqmtTemp();
	});
	

	
	/* 
	 * 차트 조회
	 */
	function fncRetrieveEqmtTemp() {

		var srchDt = $('#calSrchDt').val();
		var device = $('#selDevice option:selected').val();

		var deviceDtl = device.split(',');

		var strCd     = '${srchStrCd}';
		var temonId   = deviceDtl[0];
		var portNo    = deviceDtl[1];
		var temonType = deviceDtl[2];
		var yyyymmdd  = srchDt.replace('-');

		$.ajax({
			type : "POST",
			cache : false,
			url : "/retrieveEqmtTempChrt",
			data : {
				srchStrCd : strCd,
				yyyymmdd  : yyyymmdd,
				temonId   : temonId,
				portNo    : portNo,
				temonType : temonType
			},
			dataType : "json",
			success : function(result) {
				$('#chrtContainer').empty().append("${sm_rsltNotExist}");

				//성공시 실행부분
				var Day_data = [];
				var temp = [];
				var alarm_data = [];

				// 그래프 데이터
				var min_temp = Number(result[0].min_temp);
				var max_temp = Number(result[0].max_temp);

				for ( var i = 0; i < result.length - 1; i++) {

					if (Number(result[i].sens_temp) != -50) {

						UTC_str = Date.UTC(result[i].yyyy, result[i].mm - 1,
								result[i].dd, result[i].hh, result[i].min,
								"00", "000");
						Day_data.push([ Number(UTC_str),
								Number(result[i].sens_temp) ]);

						if (result[i].alarm_yn == 'Y' || result[i].alarm_yn == 'H' || result[i].alarm_yn == 'L') {
							alarm_data.push([ Number(UTC_str),
									Number(result[i].sens_temp) ]);
						} else if (result[i].alarm_yn == 'N'){
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
	</script>
</head>

<body>
	<div class="r_popup">
		<h1 class="r_popupTitle">${smStrEqmtTempTrend}</h1>	  
		<div class="r_popupCont">	
			<div class="r_search multiLine">  
				<table>
					<tr>
						<th>${smDevice}</th>
						<td>
							<select id="selDevice" class="searchSelect">
							<c:forEach var='index' begin="0" end="${eqmtList.size() - 1}">
								<c:choose>
								<c:when	test="${eqmtList[index].temonType != 'A'}">
									<option	value="${eqmtList[index].temonId},${eqmtList[index].portNo},${eqmtList[index].temonType}">
									${eqmtList[index].deviceLoc}
									</option>
								</c:when>
								</c:choose>
							</c:forEach>
							</select>					
						</td>
					
						<th>${smDate}</th>
						<td>
							<div class="r_innerSearch">
								<input type='text' id='calSrchDt' name='calSrchDt' />							
							</div>
						</td>
					</tr>					
				</table>
			
				<span class="search">
					<button onclick="javascript:fncRetrieveEqmtTemp()">${smRetrieve}</button>
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
</body>