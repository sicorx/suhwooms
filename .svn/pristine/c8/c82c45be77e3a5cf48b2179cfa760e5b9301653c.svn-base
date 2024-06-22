<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smElecUsePerSpace"><spring:message code="elecUsePerSpace"/></c:set>
<c:set var="smAvgElecDiff"><spring:message code="avgElecDiff"/></c:set>
<c:set var="smTotal"><spring:message code="total"/></c:set>
<c:set var="smTempCtrl"><spring:message code="tempCtrl"/></c:set>
<c:set var="smLight"><spring:message code="light"/></c:set>
<c:set var="smElecUsePerSpaceList"><spring:message code="elecUsePerSpaceList"/></c:set>
<c:set var="smCollTime"><spring:message code="collTime"/></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smAvg"><spring:message code="avg"/></c:set>
<c:set var="smMax"><spring:message code="max"/></c:set>
<c:set var="smMin"><spring:message code="min"/></c:set>
<c:set var="smStdDev"><spring:message code="stdDev"/></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	var mode =  '${asResultFlag}';
	
	
	if( mode == 0 )			// 미조치내역
	{
		$("#gridAlarmResultList").jqGrid({
			url:'retrieveAlarmResultList',
			datatype: "json",
			mtype: 'POST',
			postData: {
				asResultFlag : '${asResultFlag}',
				range : '${range}'
			
			},
			colNames:[	  '년월일', '시분', '매장코드', '매장명', 
				          '아이디','타입','포트번호','장비명',
				          '최초 발생일시','마지막 발생일시',
				          '알람','알람발생온도','알람횟수','알람 내용',
				          'AS조치결과','AS기사명','조치방법',
				          '조치방법2','조치내용','조치일자',
				          '담당유지보수업체'
				          ],
			colModel:[
				
				{name:'yyyymmdd',index:'yyyymmdd', 			width:50, align:'center', hidden: true},
				{name:'hhmin',index:'hhmin', 			width:50, align:'center', hidden: true},
				{name:'strCd',index:'strCd', 			width:50, align:'center', hidden: true},
				{name:'strNm',index:'strNm', 			width:50, align:'center', hidden: false},
				{name:'temonId',index:'temonId', 		width:50, align:'center', hidden: true},
				{name:'temonType',index:'temonType', 	width:50, align:'center', hidden: true},
				{name:'portNo',index:'portNo', 			width:50, align:'center', hidden: true},
				{name:'deviceLoc',index:'deviceLoc', 	width:30, align:'center', hidden: false},
				
				{name:'alarmDateS',index:'alarmDateS', 	width:50, align:'center', hidden: false},
				{name:'alarmDateE',index:'alarmDateE', 	width:50, align:'center', hidden: false},
				{name:'alarmType',index:'alarmType', 	width:15, align:'center', hidden: true},
				{name:'alarmTemp',index:'alarmTemp', 	width:20, align:'center', hidden: true},
				
				{name:'alarmCount',index:'alarmCount', 	width:20, align:'center', hidden: false},
				{name:'alarmMessage',index:'alarmMessage', 	width:50, align:'center', hidden: false},
				{name:'asResult',index:'asResult', 		width:50, align:'center', hidden: true},				
				{name:'asEngineer',index:'asEngineer', 	width:50, align:'center', hidden: true},
				{name:'asMethod',index:'asMethod', 		width:50, align:'center', hidden: true},
				{name:'asType',index:'asType', 			width:50, align:'center', hidden: true},
				{name:'asNote',index:'asNote', 			width:50, align:'center', hidden: true},
				{name:'asDate',index:'asDate', 			width:50, align:'center', hidden: true},
				{name:'asVendorNm',index:'asVendorNm', 	width:40, align:'center', hidden: false}
				
				
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
			rowNum:12,
			rowList:[],
			//autowidth: true,
			width: 860,		
			height: '420',
			pager: '#gridAlarmResultListPager',
			sortname: 'alarmDateE',
			sortorder: "desc",
		    viewrecords: true,			    
			hidegrid: false,
			shrinkToFit:true,

		});
	}
	
	
	if( mode == 1 )			// 조치내역
	{
		$("#gridAlarmResultList").jqGrid({
			url:'retrieveAlarmResultList',
			datatype: "json",
			mtype: 'POST',
			postData: {
				asResultFlag : '${asResultFlag}',
				range : '${range}'
			
			},
			colNames:[	  '년월일', '시분', '매장코드', '매장명','장비명', 
			          	  '조치일자','AS기사명','담당유지보수업체','조치방법','조치내용',				          
				          '최초 발생일시','마지막 발생일시',
				          '알람','알람발생온도','알람횟수','알람 내용'				          
				          ],
			colModel:[
				
				{name:'yyyymmdd',index:'yyyymmdd', 			width:50, align:'center', hidden: true},
				{name:'hhmin',index:'hhmin', 				width:50, align:'center', hidden: true},
				{name:'strCd',index:'strCd', 				width:50, align:'center', hidden: true},
				
				{name:'strNm',index:'strNm', 				width:40, align:'center', hidden: false},
				{name:'deviceLoc',index:'deviceLoc', 		width:25, align:'center', hidden: false},
				
				{name:'asDate',index:'asDate', 				width:40, align:'center', hidden: false},
				{name:'asEngineer',index:'asEngineer', 		width:20, align:'center', hidden: false},
				{name:'asVendorNm',index:'asVendorNm', 		width:35, align:'center', hidden: false},				
				{name:'asMethod',index:'asMethod', 			width:20, align:'center', hidden: false},				
				{name:'asNote',index:'asNote', 				width:100, align:'center', hidden: false, formatter:note_formatter},
				
				{name:'alarmDateS',index:'alarmDateS', 		width:50, align:'center', hidden: true},
				{name:'alarmDateE',index:'alarmDateE', 		width:50, align:'center', hidden: true},
				
				{name:'alarmType',index:'alarmType', 		width:15, align:'center', hidden: true},
				{name:'alarmTemp',index:'alarmTemp', 		width:20, align:'center', hidden: true},				
				{name:'alarmCount',index:'alarmCount', 		width:20, align:'center', hidden: true},
				{name:'alarmMessage',index:'alarmMessage', 	width:50, align:'center', hidden: true}
				
				
				
				
				
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
			rowNum:12,
			rowList:[],
			//autowidth: true,
			width: 860,		
			height: '420',
			pager: '#gridAlarmResultListPager',
			sortname: 'asDate',
			sortorder: "desc",
		    viewrecords: true,			    
			hidegrid: false,
			shrinkToFit:true,

		});
		
	}
	
	
	// Excel 다운 추가 하기 - 아직 미구현
	$('#gridAlarmResultList').jqGrid('navGrid', '#gridAlarmResultListPager',{add:false,edit:false,del:false,search:false,refresh:true});	
	$('#gridAlarmResultList').jqGrid('navButtonAdd', '#gridAlarmResultListPager',{
			id:'pager_excel',
			caption:'excel',
			title:'엑셀다운',
			onClickButton : function(e){
				//grid.jqGrid('excelExport',{url:'excelExport'});
				alert('엑셀다운기능 추가');
			}
	});
	
	
	
});


function note_formatter(cellValue, options, rowdata, action)
{	
	var asNoteSummary = rowdata.asNote;	
	
	var asNoteResult = '';
	var di = 0;
	for(var i=0; i <= asNoteSummary.length; i++)
	{
		if( (i % 27) == 0 && i != 0)
		{			
			asNoteResult = asNoteResult + asNoteSummary.substring(di,i) + '<br>';			
			di = i;
		}
		else
		{
			if( i == asNoteSummary.length )
				asNoteResult = asNoteResult + asNoteSummary.substring(di,i) + '<br>';
		}
	}
	
	var html = asNoteResult;	
	return html;	
}


function fncCancel() {
	$("#gridAlarmResultList").clearGridData();
	fncDivPop1Close();
}
</script>
<div id="loadingArea">
	<div class="r_popup">
		<h1 class="r_popupTitle">미조치 알람 내역( 어제 )</h1>	  
		<div class="r_popupCont">
			
			<div class='r_grid'>
				<table id="gridAlarmResultList"><tr><td></td></tr></table>
				<div id="gridAlarmResultListPager"></div>
			</div>
				
			<div class="r_pageBtnWrapper">
				<span class="pageNormal">
					<button onclick="javascript:fncCancel()">${smClos}</button>
				</span>
			</div>
		</div>
		
	</div>
		
</div>