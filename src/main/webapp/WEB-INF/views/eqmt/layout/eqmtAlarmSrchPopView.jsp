<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smStrEqmtAlarmHist"><spring:message code="strEqmtAlarmHist" /></c:set>
<c:set var="smDevice"><spring:message code="device" /></c:set>
<c:set var="smDate"><spring:message code="date" /></c:set>
<c:set var="smYearMonthDate"><spring:message code="yearMonthDate" /></c:set>
<c:set var="smHhmin"><spring:message code="hhmin" /></c:set>
<c:set var="smContents"><spring:message code="contents" /></c:set>
<c:set var="smSensTempC"><spring:message code="sensTempC" /></c:set>
<c:set var="smMaxTempC"><spring:message code="maxTempC" /></c:set>
<c:set var="smMinTempC"><spring:message code="minTempC" /></c:set>
<c:set var="alarm"><spring:message code="alarm" /></c:set>

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
	<script src="/resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
	<script src="/resources/js/jquery.jqGrid.min.js" type="text/javascript"></script>
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
		
		var srchDt = $('#calSrchDt').val();
		var device = $('#selDevice option:selected').val();

		var deviceDtl = device.split(',');

		var strCd     = '${srchStrCd}';
		var temonId   = deviceDtl[0];
		var portNo    = deviceDtl[1];
		var temonType = deviceDtl[2];
		var yyyymmdd  = srchDt.replace('-');
		
		$("#gridEqmtAlarmList").jqGrid({
			url : 'retrieveEqmtAlarmList',
			datatype : "json",
			mtype : 'POST',
			colNames : [ '${smYearMonthDate}', '${smHhmin}', '${smContents}', '${smSensTempC}', '${smMaxTempC}', '${smMinTempC}', '${alarm}' ],
			colModel : [ 
			    {name : 'yyyymmdd',  index : 'yyyymmdd',  width : 100, align : 'center', sortable : true, editable : false}, 
			    {name : 'hhmin',     index : 'hhmin',     width : 50,  align : 'center', sortable : true, editable : false},
			    {name : 'deviceLoc', index : 'deviceLoc', width : 100, align : 'left',   sortable : true, editable : false},
			    {name : 'sensTemp',  index : 'sensTemp',  width : 50,  align : 'right',  sortable : true, editable : false},
			    {name : 'maxTemp',   index : 'maxTemp',   width : 50,  align : 'right',  sortable : true, editable : false},
			    {name : 'minTemp',   index : 'minTemp',   width : 50,  align : 'right',  sortable : true, editable : false},
			    {name : 'alarmYn',   index : 'alarmYn',   width : 50,  align : 'center', sortable : true, editable : false}			    
			],
			jsonReader : {
				repeatitems : false
			},
			rowNum : 10,
			rownumbers : true,
			rowList : [],
			sortname : 'strCd',
			viewrecords : true,
			sortorder : "asc",
			hidegrid : false,				
			shrinkToFit : true,
			autowidth: true,	
			height : 350,
			postData : {
				srchStrCd : strCd,
				yyyymmdd  : yyyymmdd,
				temonId   : temonId,
				portNo    : portNo,
				temonType : temonType
			},
			gridComplete : function(data) {			
				 jqGridEven('gridEqmtAlarmList');	
			}				
		});				
	});
	

	
	/* 
	 * 시설물 알람 목록 조회
	 */
	function fncRetrieveEqmtAlarmList() {

		var srchDt = $('#calSrchDt').val();
		var device = $('#selDevice option:selected').val();

		var deviceDtl = device.split(',');

		var strCd     = '${srchStrCd}';
		var temonId   = deviceDtl[0];
		var portNo    = deviceDtl[1];
		var temonType = deviceDtl[2];
		var yyyymmdd  = srchDt.replace('-');

		$("#gridEqmtAlarmList").setGridParam({
			datatype : "json",
			postData : {
				srchStrCd : strCd,
				yyyymmdd  : yyyymmdd,
				temonId   : temonId,
				portNo    : portNo,
				temonType : temonType
			}
		}).trigger("reloadGrid");	
	}
	</script>
</head>

<body>
	<div class="r_popup">
		<h1 class="r_popupTitle">${smStrEqmtAlarmHist}</h1>	  
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
								<input type='text' id='calSrchDt' name='calSrchDt' style="width:150px;"/>
							</div>
						</td>
					</tr>					
				</table>
			
				<span class="search">
					<button onclick="javascript:fncRetrieveEqmtAlarmList()">${smRetrieve}</button>
				</span>
			</div>
			
			<div class='r_grid'>
				<table id='gridEqmtAlarmList'><tr><td></td></tr></table>
			</div>

			
			<div class="r_pageBtnWrapper">
			     <span class="pageNormal">
			     	<button onclick="javascript:fncCancel()">${smClos}</button>
			     </span>
			</div>
		</div>
	</div>
</body>