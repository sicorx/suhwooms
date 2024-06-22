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
<style>
	.ui-jqgrid .ui-jqgrid-bdiv {
		  position: relative; 
		  margin: 0em; 
		  padding:0; 
		  /*overflow: auto;*/ 
		  overflow-x:hidden; 
		  overflow-y:true; 
		  text-align:left;
	}
</style>
<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){
    $("#gridMonthDemandList").setGridWidth($("#cont").width());
}).resize();

$(function() {
	$('#scrDate').monthpicker({pattern: 'yyyy-mm', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    selectedYear: 2017,
	    startYear: 2010,
	    finalYear: 2050,
	    openOnFocus: false});			
	
	$('#scrDateBtn').bind('click', function () {
		$('#scrDate').monthpicker('show');
	});	
});

$(document).ready(function(){
	//매장명/코드 입력 Enter 시 수행
	$("#scrStrNm").keyup(function(event){			
		if(event.which == 13)		// Enter Key Press
		{		
			fncSearch();			// 사용자 조회				
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
	
	init();
	
});

function init(){
	
	// Grid 출력
	$("#gridMonthDemandList").jqGrid({
		url:'retrieveEnergy',
	    datatype: "json",
	    mtype: 'POST',
	    postData : {
	    	scrStrNm:$("#scrStrNm").val(),
	    	scrOrgCd:$("#scrOrgCd").val(),
	    	scrDate: $("#scrDate").val(),		 
	    	scrJudge: $("#scrJudge").val(),		 
		},
	   	colNames:['No', '매장코드', '매장명', '조직', '매장면적', '최초계약전력', '수정계약전력', 'MAX년월','MAX사용전력', '적정여부', '해당월최대전력', '차이전력', '총사용량', '평균사용량', '영업일수'],
	  	colModel:[ 	  		
	  		{name:'records', 			index:'records', 			width:15, align:'center', 	sortable:true, editable:false, editoptions:{readonly:true, size:10}},
			{name:'viewStrCd', 			index:'viewStrCd', 			width:30, align:'center',	sortable:true, editable:false},
	        {name:'strNm', 				index:'strNm', 				width:40, align:'left', 	sortable:true, editable:false},
	        {name:'orgNm', 				index:'orgNm', 				width:40, align:'left', 	sortable:true, editable:false},
	        {name:'strAreaSpec',		index:'strAreaSpec',		width:40, align:'center', 	sortable:true, editable:false},	                  
	        {name:'demandPower',		index:'demandPower', 	 	width:40, align:'right',	sortable:true, editable:false},
	        {name:'recommDemandPower',	index:'recommDemandPower',	width:40, align:'right',	sortable:true, editable:false},
	        {name:'yearMon', 			index:'yearMon', 			width:40, align:'center',	sortable:true, editable:false},
	        {name:'maxWatage', 			index:'maxWatage', 			width:40, align:'right',	sortable:true, editable:false},
	        {name:'judge', 				index:'judge', 				width:30, align:'center',	sortable:true, editable:false},
	        {name:'maxUseWatage', 		index:'maxUseWatage', 		width:50, align:'right',	sortable:true, editable:false},
	        {name:'useWatageDiff', 		index:'useWatageDiff', 		width:40, align:'right',	sortable:true, editable:false},
	        {name:'totalWatage', 		index:'totalWatage', 		width:40, align:'right',	sortable:true, editable:false},
	        {name:'avgWatage', 			index:'avgWatage', 			width:30, align:'right',	sortable:true, editable:false},
	        {name:'operDayCnt', 		index:'operDayCnt', 		width:30, align:'right',	sortable:true, editable:false},
		],
	  	jsonReader : {
			repeatitems:false
	  	},
	    rowNum:20,
	    rowList:[10,20,50,100],
	    pager: '#gridMonthDemandListPager',
	    recordtext: "건/페이지  (전체 {2} 건)",
	    emptyrecords : "검색 결과가 존재하지 않습니다.",
	    loadtext: "Loading...",
	    sortname: 'yearMon',
	    viewrecords: true,
	    sortorder: "desc",	     
	    hidegrid: false,
	    shrinkToFit:true,
	 	autowidth:true,
	 	height : 360,	
		loadComplete : function(data){
			var list = $("#gridMonthDemandList").getRowData();
			var rowCnt = list.length;
	
			if( rowCnt > 0 ) {
				$("#gridMonthDemandList").jqGrid('setSelection', 1);
			}else{
				$("#gridMonthDemandList >tbody").append("<tr><td align='center' colspan='15'>검색 결과가 없습니다.</td></tr>");
			}
		}
	 }); 
}



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
	
	$("#gridMonthDemandList").clearGridData();	
	
	$("#gridMonthDemandList").setGridParam ({
		datatype : "json",		
		postData : {	
			scrStrNm : $('#scrStrNm').val(),
			scrDate : $('#scrDate').val(),
			scrOrgCd : $('#scrOrgCd').val(),
			scrJudge : $('#scrJudge').val()
		}
	}).trigger("reloadGrid");
	
		
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrStrNm = $("#scrStrNm").val();
	var scrDate = $("#scrDate").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrJudge = $("#scrJudge").val();
	
	$("#excel1").val(scrStrNm);
	$("#excel2").val(scrDate);
	$("#excel3").val(scrOrgCd);
	$("#excel4").val(scrJudge);
	
	$('#excelDownload').attr("action", "/downloadEqmtExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">
<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrStrNm"> 
	<input type="hidden" id="excel2" name="scrDate"> 
	<input type="hidden" id="excel3" name="scrOrgCd"> 
	<input type="hidden" id="excel4" name="scrJudge"> 
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
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체" />
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>			
				<th>기간</th>
				<td>
					<input id="scrDate" name="scrDate" type="text" placeholder="${toDayMonth}" value='${toDayMonth}' style="width:80px;" readonly />
					<button class="monthBtn" style="background-color:rgba(0,0,0,0) !important" id="scrDateBtn"><img src="/images/btn_calendar_new.png"></button>
				</td>				
				<th>적정여부</th>
				<td>
					<select id="scrJudge" name="scrJudge" style="width:130px;" class="tblSelect">
						<option value=''>전체</option>
						<option value='1'>과다</option>
						<option value='2'>여유</option>
						<option value='3'>적정</option>
						<option value='4'>부족</option>
					</select>
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
			<div class="r_gridTitle">
				<h3></h3>	
				<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
			</div>
			</div>
			<table class="gridPointer" id="gridMonthDemandList"><tr><td></td></tr></table>			
			<div id="gridMonthDemandListPager"></div>
		</div>
	</div>
		

</div>