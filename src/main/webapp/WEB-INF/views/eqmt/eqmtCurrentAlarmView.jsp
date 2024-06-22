<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smAlarmEqmtList"><spring:message code="alarmEqmtList"/></c:set>
<c:set var="smAutoRefresh5"><spring:message code="autoRefresh5"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smEqmt"><spring:message code="eqmt"/></c:set>
<c:set var="smRecentAlarm"><spring:message code="recentAlarm"/></c:set>
<c:set var="smAutoRefresh5"><spring:message code="autoRefresh5"/></c:set>
<c:set var="smRecentTempC"><spring:message code="recentTempC"/></c:set>

<c:set var="smEqmtTemp"><spring:message code="eqmtTemp"/></c:set>
<c:set var="smTime"><spring:message code="time"/></c:set>
<c:set var="smTempC"><spring:message code="tempC"/></c:set>

<script>
window.setInterval('fncDrawGrid()', 300000); // 5분(300초)마다 새로그림

/*
var dayRedArr = new Array();
var dayYelArr = new Array();
var dayBluArr = new Array();
var weekRedArr = new Array();
var weekYelArr = new Array();
var weekBluArr = new Array();
var monthRedArr = new Array();
var monthYelArr = new Array();
var monthBluArr = new Array();
*/
$(document).ready(function(){
	/* 시설물 목록 */
	$("#gridEquipmentList").jqGrid({
		url: 'retrieveEquipmentFailureList',
		datatype: 'json',
		mtype: 'POST',
		colNames:['', '', '', '', '${smStrCd}', '${smStrNm}', '${smEqmt}', '${smRecentAlarm}'],
		colModel:[
			{name:'portNo',index:'portNo', width:0, align:'center', hidden:true},
			{name:'temonId',index:'temonId', width:0, align:'center', hidden:true},
			{name:'temonType',index:'temonType', width:0, align:'center', hidden:true},
			{name:'strCd',index:'strCd', width:0, align:'center', hidden:true},
			{name:'viewStrCd',index:'viewStrCd', width:70, align:'center', formatter:'text',  sortable:true, editable:false},
			{name:'strNm',index:'strNm', width:90, align:'left', formatter:'text',  sortable:true, editable:false},
			{name:'device',index:'device', width:90, align:'left', formatter:'text',  sortable:true, editable:false},
			{name:'alarm',index:'alarm', width:120, align:'left', formatter:'text',  sortable:true, editable:false}
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
		rowNum: 1000,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '150',
		onSelectRow : function(rowid, status, e) {
			var list = $("#gridEquipmentList").getRowData(rowid);

			var alarm  = list.alarm.replace("-", "");
			alarm  = alarm.replace("-", "");    
			alarm  = alarm.replace(":", "");
			
			var strCd     = list.strCd;
			var portNo    = list.portNo;
			var temonId   = list.temonId;
			var temonType = list.temonType;
			var ymd       = alarm.substring( 0, 8 );
			var hhmin     = alarm.replace(ymd, "").substring( 1, 5 );

			if( temonType != "A" ) {
				fncReloadChrt(strCd,portNo,temonId,temonType,ymd,hhmin);	
			}
		},
		loadComplete : function(data) {
			var list   = $("#gridEquipmentList").getRowData();
			var rowCnt = list.length;
			
			if( rowCnt > 0 ) {
				$("#gridEquipmentList").jqGrid('setSelection', 1);
			}
		}
	});	
	
	/* 시설물 상태 
	var dayCrit = 3;
	var weekCrit = 21;
	var monthCrit = 90;
	
	$.ajax({
		type : 'POST',
		cache : false,
		url : 'retrieveEquipmentFailure',
		data : '',
		success : function(data) {

			$.each(data, function(idx, info) {
				
				if( idx == 'day' ) {
					$.each(info, function(key, value) {
						if( value.cnt > dayCrit ) {
							dayRedArr.push( value.strCd + value.portNo );		
						}
						else if( value.cnt <= dayCrit && value.cnt > dayCrit - 1 ) {
							dayYelArr.push( value.strCd + value.portNo );
						}
						else if( value.cnt <= dayCrit - 1 ) {
							dayBluArr.push( value.strCd + value.portNo );
						}
					});										
				}
				
				if( idx == 'week' ) {
					$.each(info, function(key, value) {
						if( value.cnt > weekCrit ) {
							weekRedArr.push( value.strCd + value.portNo );
						}
						else if( value.cnt <= weekCrit && value.cnt > weekCrit - 1 ) {
							weekYelArr.push( value.strCd + value.portNo );
						}
						else if( value.cnt <= weekCrit - 1 ) {
							weekBluArr.push( value.strCd + value.portNo );
						}						
					});															
				}

				if( idx == 'month' ) {
					$.each(info, function(key, value) {
						if( value.cnt > monthCrit ) {
							monthRedArr.push( value.strCd + value.portNo );
						}
						else if( value.cnt <= monthCrit && value.cnt > monthCrit - 1 ) {
							monthYelArr.push( value.strCd + value.portNo );
						}
						else if( value.cnt <= monthCrit - 1 ) {
							monthBluArr.push( value.strCd + value.portNo );
						}						
					});					
				}
			});

			var htmlData  = '';
		    htmlData += '<ul>';
		    htmlData += '<li class="list_center">1 일</li>';
		    htmlData += '<li class="list_center">1 주</li>';
		    htmlData += '<li class="list_center">1 달</li>';					
		    htmlData += '</ul>';			    
    		htmlData += '<ul>';   
    		htmlData += '<li class="list_right"><div class="red" onclick="fncReloadGrid(1)" >' + dayRedArr.length + '</div></li>';
    		htmlData += '<li class="list_right"><div class="red" onclick="fncReloadGrid(2)" >' + weekRedArr.length + '</div></li>';
    		htmlData += '<li class="list_right"><div class="red" onclick="fncReloadGrid(3)" >' + monthRedArr.length + '</div></li>';						
    		htmlData += '</ul>';
    		htmlData += '<ul>';
    		htmlData += '<li class="list_right"><div class="yel" onclick="fncReloadGrid(4)" >' + dayYelArr.length + '</div></li>';
    		htmlData += '<li class="list_right"><div class="yel" onclick="fncReloadGrid(5)" >' + weekYelArr.length + '</div></li>';
    		htmlData += '<li class="list_right"><div class="yel" onclick="fncReloadGrid(6)" >' + monthYelArr.length + '</div></li>';
    		htmlData += '</ul>';
    		htmlData += '<ul>';
    		htmlData += '<li class="list_right"><div class="blu" onclick="fncReloadGrid(7)" >' + dayBluArr.length + '</div></li>';
    		htmlData += '<li class="list_right"><div class="blu" onclick="fncReloadGrid(8)" >' + weekBluArr.length + '</div></li>';
    		htmlData += '<li class="list_right"><div class="blu" onclick="fncReloadGrid(9)" >' + monthBluArr.length + '</div></li>';
    		htmlData += '</ul>';

			$("#plantStatus").html( htmlData );	
			
			fncReloadGrid(1);
		}
	});	
	*/
});
/*
function fncReloadGrid(param) {
	$("#gridEquipmentList").jqGrid( 'clearGridData', true );
	
	var arr = null;

	switch(param){
	case 1:
		arr = dayRedArr;
		break;
	case 2:
		arr = weekRedArr;
		break;
	case 3:
		arr = monthRedArr;
		break;
	case 4:
		arr = dayYelArr;
		break;
	case 5:
		arr = weekYelArr;
		break;
	case 6:
		arr = monthYelArr;
		break;
	case 7:
		arr = dayBluArr;
		break;
	case 8:
		arr = weekBluArr;
		break;
	case 9:
		arr = monthBluArr;
		break;
	}
	
	$("#gridEquipmentList").clearGridData();
	$("#chrtLatestTemp").html('');
	
	if( arr.length > 0 ) {
		$("#gridEquipmentList").setGridParam({
			datatype : 'json',
			postData : {
				param : arr
			}
		}).trigger("reloadGrid");
	}
}
*/

function fncDrawGrid() {

	if( $("#chkRefresh").prop("checked") ) {
		
		$("#gridEquipmentList").jqGrid( 'clearGridData', true );
		$("#gridEquipmentList").setGridParam({
			datatype : 'json'
		}).trigger("reloadGrid");
	}
}

function fncReloadChrt(strCd,portNo,temonId,temonType,ymd,hhmin) {

	var ret    = new Array();
	var period = new Array();
	
	$("#chrtLatestTemp").html('');
	
	var param = new Object();
	param.strCd     = strCd;
	param.portNo    = portNo;
	param.temonId   = temonId;
	param.temonType = temonType;
	param.yyyymmdd  = ymd;
	param.hhmin     = hhmin;
	
	$.ajax({
		type: 'POST',
		url: 'retrieveLatestTemp',
		data: param,
		dataType: 'json',
		success: function(data) {

			$.each(data, function(key,value) {
				period.push( value.period );
				ret.push( value.sensTemp );
			});

			fncDrawChrt(ret, period);
		}
	});
}	

function fncDrawChrt(ret, period) {

	if(ret != null && ret.length != 0) {

		$.jqplot('chrtLatestTemp', [ret], {
			seriesDefaults : {
				showMarker : false,
				fill : false
			},
			grid : {
		    	drawGridLines: true,
		    	shadow: false,
		    	background: 'rgba(0, 0, 0, 0)',
		    	borderWidth: 0
			},
		    series: [
				{label: '${smEqmtTemp}',	fillAlpha: 0.2},
		    ],
			axes: {
				xaxis: {
					label: '${smTime}',
					renderer: $.jqplot.CategoryAxisRenderer,
					ticks: period,
			        drawMajorGridlines: false,
			    	tickRenderer: $.jqplot.CanvasAxisTickRenderer,
			    	tickOptions: {
			    		angle: -45,
			    		fontSize: '9pt',
			    		showGridline: false
			    	}
				},
				yaxis: {
					label: '${smTempC}',
					tickOptions: {
			        	formatString: "%'.1f"
					}
				}	    
			}
		});
	}
}

</script>
<div id="loadingArea">
	<div class="r_alarmEqmt">
		<div class="r_inputTbl">
			<div class="r_inputTblTitle">
				<div style="float:left;">
					<h3>
						<c:set var="ymd" value="${yyyymmdd }" />
						${smAlarmEqmtList} : ${fn:substring(ymd, 0, 4)}-${fn:substring(ymd, 4, 6)}-${fn:substring(ymd, 6, 8)} (${dayOfWeek }) H-4
					</h3>				
				</div>
				<div style="float:right;">
					<h3>
						${smAutoRefresh5} <input id="chkRefresh" type="checkbox" checked/>&nbsp;&nbsp;
					</h3>
				</div>
			</div>
		</div>
		<div class="r_alarmEqmtList">
			<table id="gridEquipmentList"><tr><td></td></tr></table>
		</div>
	
		<div class="r_inputTbl">
			<div class="r_inputTblTitle">
				<h3>${smRecentTempC}</h3>
			</div>
		</div>
		<div class="r_alarmEqmtChart">
			<div id="chrtLatestTemp"></div>
		</div>
	</div>
</div>