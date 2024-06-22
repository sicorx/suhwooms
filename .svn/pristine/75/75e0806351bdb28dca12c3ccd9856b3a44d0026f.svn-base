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



<style>
#gridStoreMgnt { cursor : pointer; }
</style>


<script type="text/javascript">

var scrDayChk = "0"

$(document).ready(function(){	
	
	init();			// 초기 셋팅 
	
});

$(window).resize(function(){
    $("#gridStoreMgnt").setGridWidth($("#cont").width());
}).resize();

function init(){
	// Grid 출력
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveElecStore',
	    datatype: "json",
	    mtype: 'POST',
	    postData : {
			scrStrNm:$("#scrStrNm").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			scrDayChk: scrDayChk,	 
			scrContentCd:$("#contentsCd").val(),
		},
		colNames:['No', '매장코드', '매장명', '조직', '설치일', '유지보수업체', '전기업체', '최종수신일자', '수신누락일','구분','매장코드'],
		colModel:[ 	  		
					{name:'records', 		index:'records', 		width:15, align:'center', 	sortable:false, editable:false, editoptions:{readonly:true, size:10}},
					{name:'viewStrCd', 		index:'viewStrCd', 		width:30, align:'center',	sortable:true, editable:false},
					{name:'strNm', 			index:'strNm', 			width:40, align:'left', 	sortable:true, editable:false},
					{name:'orgFullName', 	index:'orgFullName', 	width:40, align:'left', 	sortable:true, editable:false},
					{name:'remsStartDt',	index:'remsStartDt', 	width:60, align:'center', 	sortable:true, editable:false},	                  
					{name:'vendorNm',		index:'vendorNm', 	 	width:50, align:'center',	sortable:true, editable:false},
					{name:'electricentNm', 	index:'electricentNm', 	width:40, align:'center',	sortable:true, editable:false},
					{name:'lastYmdh', 		index:'lastYmdh', 		width:40, align:'center',	sortable:true, editable:false},
					{name:'lapseDay', 		index:'lapseDay', 		width:40, align:'center',	sortable:true, editable:false},
					{name:'contents', 		index:'contents', 		width:50, align:'center',	sortable:true, editable:false},
					{name:'strCd', 			index:'strCd', 			hidden:true}
		],
		jsonReader : {
			repeatitems:false
		},
		rowNum:20,
		rowList:[10,20,50,100],
		pager: '#gridStoreMgntPager',
		recordtext: "건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
		sortname: 'lastYmdh',
		viewrecords: true,
		sortorder: "desc",	     
		hidegrid: false,
		shrinkToFit:true,
		autowidth:true,
		height : 360,
		ondblClickRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridStoreMgnt").getRowData(rowid);			
			var strCd = list.strCd;
			
			$.ajax({
				type : "POST",
				cache : false,
				url : '/retrieveStoreStatus',
				data : {strCd:strCd},
				success : function(data) {			
					$("#r_contents").html(data);			
				},
				error:function(result){
					alert('에러가 발생하였습니다.');
				},
				complete : function()
				{
					
				}
			});
		},
		gridComplete : function() {
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
	
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='10'>검색 결과가 없습니다.</td></tr>");
			}	
		}
	});
	//jqGrid Resize	
	jqGridResize('gridStoreMgnt');	 
}

// 조회 버튼
function fncSearch() {
	
	if(true==$("input:checkbox[id='checkYn']").is(":checked")){
		scrDayChk="1";
	}else{
		scrDayChk="0";
	}

	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		postData : {
	    	scrStrNm:$("#scrStrNm").val(),
	    	scrOrgCd:$("#scrOrgCd").val(),
			scrDayChk: scrDayChk,
			scrContentCd:$("#contentsCd").val(),
		 }
	 }).trigger("reloadGrid");
}

//매장명/코드 입력 Enter 시 수행
$("#scrStrNm").keyup(function(event){	
	
	if(event.which == 13)		// Enter Key Press
	{		
		fncSearch();		// 사용자 조회				
	}
});

//조직명 엔터 및 focusout
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
				fncOrgSearch('sch');
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

function fncSetOrg(data){;
	$("#scrOrgCd").val(data.orgCd);
	$("#scrOrgNm").val(data.orgNm + "(" + data.orgCd + ")");
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrStrCd = $("#scrStrCd").val();
	var scrStrNm = $("#scrStrNm").val();
	var scrContentCd = $("#contentsCd").val();
	
	var scrDayChk = 0;
	if(true==$("input:checkbox[id='checkYn']").is(":checked")){
		scrDayChk="1";
	}else{
		scrDayChk="0";
	}
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrOrgCd);
	$("#excel3").val(scrStrCd);
	$("#excel4").val(scrStrNm);	
	$("#excel5").val(scrDayChk);
	$("#excel6").val(scrContentCd);
	
	$('#excelDownload').attr("action", "/retrieveElecStoreExcel");
	$("#excelDownload").submit();

}
</script>

<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrCompanyCd"> 
	<input type="hidden" id="excel2" name="scrOrgCd"> 
	<input type="hidden" id="excel3" name="scrStrCd"> 
	<input type="hidden" id="excel4" name="scrStrNm">	
	<input type="hidden" id="excel5" name="scrDayChk">	
	<input type="hidden" id="excel6" name="scrContentCd">	
</form>


<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>매장명/코드</th>
				<td>
					<input type='search' id='scrStrNm' name='scrStrNm' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>조직명/코드</th>
				<td>
					<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${companyCd}' />
					<input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value="" placeholder="전체"  style="width:118px;" class="r_Input r_disable"/>						
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>			
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>	 	
				</td>	
				<th></th>
				<td><label><input type="checkbox" id="checkYn" />&nbsp; 3일 이상 수신불량매장</label></td>
				<th>구분</th>
				<td>
					<select id="contentsCd" name="contentsCd" style="width:200px;" class="searchSelect">
						<option value=''>------------- 전체 ------------</option>
						<option value='1'>데이터미송신</option>
						<option value='2'>전력값확인필요(전력값&lt;냉난방)</option>
						<option value='3'>비정상(전력데이터:0)</option>
						<option value='4'>비정상(메인전력전력확인필요)</option>
					</select>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
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
		<table id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
		
</div>