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
<c:set var="smMainMeter"><spring:message code="mainMeter"/></c:set>
<c:set var="smExcldMeter"><spring:message code="excldMeter"/></c:set>
<c:set var="smSubMeterLight"><spring:message code="subMeterLight"/></c:set>
<c:set var="smSubMeterTemp"><spring:message code="subMeterTemp"/></c:set>
<c:set var="smDimmer"><spring:message code="dimmer"/></c:set>
<c:set var="smHacon"><spring:message code="hacon"/></c:set>
<c:set var="smTSensor"><spring:message code="tSensor"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smSign"><spring:message code="sign"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>
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

// 페이지 사용 - jooyoung

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();



$(document).ready(function(){
	
	// 조회 변수 셋팅
	$('#scrStrNm').val( 		'${scrValue.scrStrNm}' );
	$('#scrOrgNm').val( 		'${scrValue.scrOrgNm}' );
	$('#scrOrgCd').val( 		'${scrValue.scrOrgCd}' );
	
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveRemsConfigDataList',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['No', '조직명', '매장명', '피크', '냉난방','간판', '회사 코드', '매장코드','뷰 코드', '조직코드'],
	    colModel:[
	                {name:'records',	index:'records',	width:10,	align:'center',	sortable : true },	                  
	                {name:'orgFullNm',	index:'orgFullNm', 	width:45, 	align:'left' },
	                {name:'strNm',		index:'strNm', 		width:50, 	align:'left' },
	                {name:'peakType',	index:'peakType', 	width:80,	align:'center' },
	                {name:'tempType',	index:'tempType', 	width:80, 	align:'center' },
	                {name:'signType',	index:'signType', 	width:80, 	align:'center' },
	                {name:'companyCd',	index:'companyCd', 	hidden:true},
	                {name:'strCd',		index:'strCd', 		hidden:true},
	                {name:'viewStrCd',	index:'viewStrCd', 	hidden:true},
	                {name:'orgCd',		index:'orgCd', 		hidden:true}
	           ],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[],
	    pager: '#gridStoreMgntPager',
	    sortname: 'strNm',
	    recordtext: "{1} 건/페이지  (전체 {2} 건)",
	    emptyrecords : "검색 결과가 존재하지 않습니다.",
	    loadtext: "Loading...",
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 360,
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrStrCd:$("#scrStrCd").val(),
			scrStrNm:$("#scrStrNm").val(),
			scrOrgCd:$("#scrOrgCd").val()
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {
			fncUpt();			
		}, 
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='6'>검색 결과가 없습니다.</td></tr>");
			}	
		}
	});
	  //jqGrid Resize 
	  jqGridResize('gridStoreMgnt');
	  
	  
	// 엔터 키 이벤트
	$("input[name='scrStrNm']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncSearch();
	        }
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
		
		
		
		
		
		
});


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
1. 조직 팝업  
********************/
// 조직명 검색
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

// 조직 검색 버튼
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


// 조회 버튼
function fncSearch() {
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	if( $("#scrOrgNm").val() == "" || $("#scrOrgNm").val() == null ) {
		$("#scrOrgCd").val('');
	}
	
	console.log( "scrCompanyCd : " + $("#scrCompanyCd").val() );
	console.log( "scrStrNm : " + $("#scrStrNm").val() );
	console.log( "scrOrgCd : " + $("#scrOrgCd").val() );
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrStrCd:$("#scrStrCd").val(),			 
			 scrStrNm:$("#scrStrNm").val(),
			 scrOrgCd:$("#scrOrgCd").val(),			
			 scrOrgNm:$("#scrOrgNm").val()
		 }
	 }).trigger("reloadGrid");
}

//수정 버튼
function fncUpt()
{	
	var rowKey = getSelectedRow();							// 선택된 리스트 rowKey
	var list = $("#gridStoreMgnt").getRowData(rowKey);		// 선택된 리스트 정보
	
	if( rowKey != '' )							
	{
		var param  = new Object();		
		param.strCd   		= list.strCd;					// 시스템매장코드		
		param.strNm			= list.strNm;					// 회사명
		param.orgCd			= list.orgCd;					// 조직코드
		param.orgNm			= list.orgNm;					// 조직명
		
		param.companyCd 	= $("#scrCompanyCd").val();		// 회사코드
		param.scrStrNm		= $('#scrStrNm').val();			// 회사명
		param.scrOrgCd	 	= $('#scrOrgCd').val();
		param.scrOrgNm 		= $('#scrOrgNm').val();
						
		menuLoadImgShow("loadingArea");		// 로딩바
				
		console.log( "fncUpt() 수정버튼" );
		console.log( param );
		
		$.ajax({
			type : "POST",
			cache : false,
			url : '/remsConfigMgntPop',
			data : param,
			success : function(data) {
				
				$("#r_contents").html(data);
				
			},
			error:function(result){
				alert('에러가 발생하였습니다.');
			},
			complete : function()
			{
				menuLoadImgHide("loadingArea");		// 로딩바
			}
		});
	}
	
}

//선택된 리스트
function getSelectedRow() 
{
	var grid = $("#gridStoreMgnt");
	var rowKey = grid.jqGrid('getGridParam',"selrow");
	
	if (rowKey)
	{
		//alert("Selected row primary key is: " + rowKey);
		return rowKey;
	}
	else
	{
		alert("선택된 매장이 없습니다.");
		return '';
	}
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	/* $('#scrStrNm').val( 		'${scrValue.scrStrNm}' );
	$('#scrOrgNm').val( 		'${scrValue.scrOrgNm}' );
	$('#scrOrgCd').val( 		'${scrValue.scrOrgCd}' ); */
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrStrCd = $("#scrStrCd").val();
	var scrStrNm = $("#scrStrNm").val();
	var scrOrgNm = $("#scrOrgNm").val();
	var scrOrgCd = $("#scrOrgCd").val();
	
	$("#excel1").val(scrStrNm);
	$("#excel2").val(scrOrgNm);
	$("#excel3").val(scrOrgCd);
	$("#excel4").val(scrCompanyCd);
	$("#excel5").val(scrStrCd);
	
	$('#excelDownload').attr("action", "/downloadRemsConfigDataListExcel");
	$("#excelDownload").submit();

}
</script>
<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="strCd">
    <input type="hidden" id="popArg2" name="viewStrCd">
    <input type="hidden" id="popArg3" name="strNm">
    <input type="hidden" id="popArg4" name="companyCd">
    <input type="hidden" id="popArg5" name="companyNm">
</form>
<form id="excelDownload" name='excelDownload' method='post'>
		<input type="hidden" id="excel1" name="scrStrNm"> 
		<input type="hidden" id="excel2" name="scrOrgNm"> 
		<input type="hidden" id="excel3" name="scrOrgCd"> 
		<input type="hidden" id="excel4" name="scrCompanyCd"> 
		<input type="hidden" id="excel5" name="scrStrCd"> 
	</form>
<div id="loadingArea">
	
	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<c:if test="${selectVoListCnt == 1 }">
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />
		</c:if>
		<c:if test="${selectVoListCnt > 1 }">			
			<select id="scrCompanyCd" name="scrCompanyCd" style="display:none;">
				<option value=''>--선택--</option>
					<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
			</select>
		</c:if>		
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
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>				
			</tr>			
		</table>
		<span class="search">
			<button onclick="javascript:fncSearch()">Search</button>
		</span>
	</div>
	<!-- //조회조건 -->
	
	
	
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">
			<h3>램스환경 목록</h3>
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();"/>
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal">
	   		<button onclick="javascript:fncUpt();">수정</button>
	   	</span>	
	</div>
	<!-- //하단 버튼 그룹 -->
	
</div>