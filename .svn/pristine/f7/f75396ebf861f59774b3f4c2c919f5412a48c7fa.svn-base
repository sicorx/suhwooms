<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smArea"><spring:message code="area"/></c:set>
<c:set var="smStartDt"><spring:message code="startDt"/></c:set>
<c:set var="smEndDt"><spring:message code="endDt"/></c:set>
<c:set var="smUseYn"><spring:message code="useYn"/></c:set>
<c:set var="smRegiId"><spring:message code="regiId"/></c:set>
<c:set var="smRegiNm"><spring:message code="regiNm"/></c:set>
<c:set var="smFinalModDt"><spring:message code="finalModDt"/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smDupChk"><spring:message code="dupChk"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smNew"><spring:message code="new"/></c:set>
<c:set var="smUpdate"><spring:message code="update"/></c:set>
<c:set var="smDelete"><spring:message code="delete"/></c:set>
<c:set var="smSave"><spring:message code="save"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var rowIdx = 0;

/*******************
1. 선행, 등록 스크립트
********************/

var excelData;

$(document).ready(function(){
	
	
	gridExcelDataList();			// 계약전력 산출 매장 리스트 가지고 오기
	
	
	/////////////////////////////////////////////////////////////////////
	
	
});

$(window).resize(function(){


    $("#gridInputExcelList").setGridWidth($("#cont").width());

}).resize();



function searchBtn()
{
	
	var getStrNm = $('#searchStrNm').val();
	
	if( getStrNm == '' )
		getStrNm = '%';
	
	var getCalculateYn = $("#calculateYn").val();
	
	$("#gridInputExcelList").setGridParam({"page":1});		// 1페이지로 이동	
	$("#gridInputExcelList").setGridParam({ datatype: "json", postData : { strNm:getStrNm, calculateYn:getCalculateYn } }).trigger("reloadGrid");	
}

//매장명 입력 Enter 시 수행
$("#searchStrNm").keyup(function(event){
	if(event.which == 13)		// Enter Key Press
	{
		searchBtn();		// 매장 조회
	}
});

function gridExcelDataListReload()
{
	$("#searchStrNm").val("");
	var getCalculateYn = $("#calculateYn").val();
	
	$("#gridInputExcelList").setGridParam({"page":1});		// 1페이지로 이동	
	$("#gridInputExcelList").setGridParam({ datatype: "json", postData : { strNm:'%', calculateYn:getCalculateYn } }).trigger("reloadGrid");
	
}

// DB에서 전기업체별 계약전력 산출 리스트 가지고 오기
function gridExcelDataList(  )
{
	
	
	$("#gridInputExcelList").jqGrid({
		url:'/demandPowerStoreList',
	    datatype: "json",
      	mtype: 'POST',
		cache:false,						
		//data: excelData,
		colNames:[	'매장코드','매장명', '산출유무', '매장면적', '계약전력(kW)', 'TnM추천 계약전력(kW)', '부하산정표 업로드', '엑셀 다운로드'],
		colModel:[
			{name:'strCd',					index:'strCd', 					width:100,		align:'center'},
			{name:'strNm',					index:'strNm', 					width:100,		align:'center'},
			{name:'calculateYn',			index:'calculateYn',	 		width:50,		align:'center'},
			{name:'storeArea',				index:'storeArea',	 			width:100,		align:'center'},
			{name:'demandPower',			index:'demandPower',	 		width:100,		align:'center'},
			{name:'recommendDemandPower',	index:'recommendDemandPower',	width:100,		align:'center'},			
			{name:'excelInput',				index:'excelInput', 			width:100, 		align:'center', sortable:false},
			{name:'excelOutput',			index:'excelOutput', 			width:100, 		align:'center', sortable:false}

		],
		
		formatter : {
	  		number : {
				decimalSeparator: ".",
				thousandsSeparator: ",", 
				decimalPlaces: 1,
				defaultValue: '0'
			}
		},
		rowNum:20,
		rowList:[20,50,100],
		rownumbers: true,
		autowidth: true,
		//width: 1000,		
		height: '500',
		pager: '#gridInputExcelListPager',	
		
		sortable:true,
		sortname: 'calculateYn',
		sortorder: "asc",
		
	    viewrecords: true,		
		shrinkToFit:true,
		
		loadtext: "Loading...",
		recordtext: "{1} 건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		
		ondblClickRow : function(rowid, iRow, iCol, e) {
				
				//var list = $("#gridInputExcelList").getRowData(rowid);
				
				
				excelInputPopup( rowid );				
				
		}, 
		beforeRequest : function()
		{
			//alert('11');
			$("#gridInputExcelList").clearGridData();
		},
		gridComplete: function(idx){
			
			
			var ids = $('#gridInputExcelList').jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) 
			{
			    var rowId = ids[i];
			    
			    var list = $("#gridInputExcelList").getRowData(rowId);
			    
			    var rowData = $('#gridInputExcelList').jqGrid ('getRowData', rowId);
			    
			    
			    if( rowData.calculateYn == 'Y' )		// 계약전력 산출 Y
			    {
			    	var excelInputHtml = '<input type="button" name="excelInput" id="excelInput" value="수정" onClick="excelInputPopup( '+"" + rowId + ""+' );" />';
				    $('#gridInputExcelList').jqGrid('setRowData', rowId, { excelInput: excelInputHtml });
				    				    
				    var excelOutputHtml = '<input type="button" name="excelOutput" id="excelOutput" value="다운로드" onClick="saveExcel( '+"" + rowId + ""+' );" />';
			    	$('#gridInputExcelList').jqGrid('setRowData', rowId, { excelOutput: excelOutputHtml });
			    }
			    else									// 계약전력 산출 N
			    {		
			    	var excelInputHtml = '<input type="button" name="excelInput" id="excelInput" value="업로드" onClick="excelInputPopup( '+"" + rowId + ""+' );" />';
				    $('#gridInputExcelList').jqGrid('setRowData', rowId, { excelInput: excelInputHtml });
				    
				    var excelOutputHtml = '-';
			    	$('#gridInputExcelList').jqGrid('setRowData', rowId, { excelOutput: excelOutputHtml });
			    	
			    }
			    
			}
		          
	   },

		
	}).trigger("reloadGrid");
	
	
	/*
	$("#gridInputExcelList").jqGrid('navGrid','#gridInputExcelListPager'
			,{
				add:false,edit:false,view:true,del:false,search:true,refresh:true				
			 } 													
			,{
				closeAfterAdd: true, 
				reloadAfterSubmit: false,
				closeOnEscape:true
			 } 		
			,{
				closeAfterAdd: true, 
				reloadAfterSubmit: false,
				closeOnEscape:true
			}
			,{
				reloadAfterSubmit: false,
				closeOnEscape:true
			} 							
			,{
				closeOnEscape:true,
				onSearch:function(){									
				}//onSearch:function(){
			}//Search Option
			,{
				closeOnEscape:true
			} 
	   	);

	*/
	
	
	
	
	/*
	$("#gridInputExcelList").jqGrid('setGroupHeaders', {
		  useColSpanStyle: true, 
		  groupHeaders:[
			{startColumnName: 'storeArea', numberOfColumns: 2, titleText: '정보 입력'}
		  ]
		});
	*/
	
	
	
}

function saveExcel( rowId )
{
	var list = $("#gridInputExcelList").getRowData(rowId)
	
	var fileName = list.strCd + "_" + list.strNm;
	//alert( list.strCd );
	//alert( list.strNm );
	
	if(fileName == "")
	{
		  alert(" 첨부파일을 다운로드할 수 없습니다.");
		  return;
	}
	
	if(!confirm("첨부파일을 다운로드 하시겠습니까?"))
		return;
	
	window.open("/saveExcel?strCd=" + list.strCd + "&strNm=" + encodeURI(list.strNm), "_blank"); 
	
}

function excelInputPopup( rowId )
{
	var list = $("#gridInputExcelList").getRowData(rowId)
	
	var args = new Array();	

	args.push( list.strCd );	
	args.push( list.strNm );
	args.push( list.calculateYn );
	args.push( list.storeArea );
	
	var param = new Object();
	param.strCd = list.strCd;
	param.strNm	= list.strNm;
	param.calculateYn	= list.calculateYn;
	param.storeArea	= list.storeArea;
	
	//alert( args );
	
	//fn_divPop("demandPowerExcelPop", "팝업", 750, 750, args);
	fn_divPop("demandPowerExcelPop", "계약전력산출", 750, 350, param);
}

function fn_excelDownload(){
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrStrNm = $("#searchStrNm").val();
	var srcCalculateYn = $("#calculateYn").val();
	
	$("#excel1").val(scrStrNm);
	$("#excel2").val(srcCalculateYn);
	
	$('#excelDownload').attr("action", "/downloadDemandPowerExcel");
	$("#excelDownload").submit();
}
</script>

<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="strCd">
	<input type="hidden" id="popArg2" name="strNm">
	<input type="hidden" id="popArg3" name="calculateYn">
	<input type="hidden" id="popArg4" name="storeArea">		
	
</form>

<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrStrNm"> 
	<input type="hidden" id="excel2" name="srcCalculateYn"> 
</form>

<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>매장명</th>
				<td>
					<input type="text"   id="searchStrNm" name="searchStrNm" placeholder="전체"/>
					<input type="button" id="searchBtnInit" name="serarchBtnInit" value="초기화" onClick="javascript:gridExcelDataListReload();" style="width:100px;" />
				</td>
				<th>산출유무</th>
				<td>
					<select id="calculateYn" name="calculateYn" style="width:70px;" class="tblSelect" >
						<option value=''>--전체--</option>								
						<option value='Y'>Y</option>								
						<option value='N'>N</option>								
					</select>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:searchBtn()">Search</button>
	    </span>
	</div>
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">			
			<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table id="gridInputExcelList"><tr><td></td></tr></table>
		<div id="gridInputExcelListPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
	<div class="r_pageBtnWrapper mr_0 ml0 border_none tleft ml_0">※ 부하산정표 or 매장면적을 잘못 업로드하신경우 TnM으로 연락주시기 바랍니다.( 010-7325-9193 정주영 대리)</div>		

</div>


		