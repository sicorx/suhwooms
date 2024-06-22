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

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();


$(document).ready(function(){
	
	// 셀렉트 선택	
	var ssVenderCd = $.trim("${userVo.vendorCd}");
	$("#scrVendorCd").val(ssVenderCd);	
	if (ssVenderCd != "") $("#scrVendorCd").attr("disabled", "disabled");
	
	
	// 매장할당현황조회
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveEngineerStrList',
	    datatype: "json",
	    postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			scrStrCd:$("#scrStrCd").val(),				 
			scrVendorCd:$("#scrVendorCd").val(),
			scrUserNm:$("#scrUserNm").val()
		},
	    mtype: 'POST',
	    colNames:['No', '조직', '매장코드', '매장명', '유지보수업체', 'ID', '엔지니어', '주소', '전화번호', '할당일시'],
	    colModel:[
			{name:'records', index:'records', width:60, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
	        {name:'orgNm', index:'orgNm', width:100, align:'center', sortable:true, editable:false},
	        {name:'viewStrCd', index:'viewStrCd', width:100, align:'center', sortable:true, editable:false},
	        {name:'strNm', index:'strNm', width:100, align:'left', sortable:true, editable:false},
	        {name:'vendorNm' ,index:'vendorNm', width:100, align:'center', sortable:true, editable:false},
	        {name:'userId', index:'userId', width:100, align:'center', sortable:true, editable:false},		                
	        {name:'userNm', index:'userNm', width:100, align:'left', sortable:true, editable:false},
	        {name:'addr', index:'addr', width:240, align:'left', sortable:false, editable:false},
	        {name:'telNo', index:'telNo', width:100, align:'center', sortable:false, editable:false},
	        {name:'finalModDttm', index:'finalModDttm', width:100, align:'center', sortable:false, editable:false},
		],
	    jsonReader : {
	    	repeatitems:false
	    },
		rowNum:20,
		rowList:[10,20,50,100],
	    pager: '#gridStoreMgntPager',
	    recordtext: "{1} 건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
	    sortname: 'orgNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 460,
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='10'>검색 결과가 없습니다.</td></tr>");
			}	
		}
		
	});
	jqGridResize('gridStoreMgnt');
	  
	// 엔터 키 이벤트
	$("input[name='scrStrCd'], input[name='scrUserNm']").on({
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

// 검색
function fncSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var scrOrgNm = $.trim($("#scrOrgNm").val());
	if (scrOrgNm == "") {
		$("#scrOrgCd").val("");
	}
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		postData : {
			scrCompanyCd:companyCd,
			scrOrgCd:$("#scrOrgCd").val(),
			scrStrCd:$("#scrStrCd").val(),				 
			scrVendorCd:$("#scrVendorCd").val(),
			scrUserNm:$("#scrUserNm").val()
		}
	}).trigger("reloadGrid");
}

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

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrStrCd = $("#scrStrCd").val();
	var scrVendorCd = $("#scrVendorCd").val();
	var scrUserNm = $("#scrUserNm").val();
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrOrgCd);
	$("#excel3").val(scrStrCd);
	$("#excel4").val(scrVendorCd);
	$("#excel5").val(scrUserNm);
	
	$('#excelDownload').attr("action", "/downloadEngineerExcel");
	$("#excelDownload").submit();

}
</script>
<div id="loadingArea">

<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrCompanyCd"> 
	<input type="hidden" id="excel2" name="scrOrgCd"> 
	<input type="hidden" id="excel3" name="scrStrCd"> 
	<input type="hidden" id="excel4" name="scrVendorCd">
	<input type="hidden" id="excel5" name="scrUserNm">
	<input type="hidden" id="excel6" name="page" value ="1">
</form>
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
				<th>조직명(코드)</th>
				<td><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable" />
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
				<th>매장명/코드</th>
				<td>
					<input type='search' id='scrStrCd' name='scrStrCd' value="" style="width:140px;" />
				</td>
				<th>업체</th>	
				<td>
					<select id="scrVendorCd" name="scrVendorCd" class="searchSelect" style="width:140px;">							
						<option value="">--전체--</option>
					<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
					</select>
				</td>
				<th>엔지니어명/ID</th>	
				<td>
					<input type='search' id='scrUserNm' name='scrUserNm' value='' style="width:140px;" />
				</td>
			</tr>
		</table>
		<span class="search">
			<button onclick="javascript:fncSearch();">Search</button>
		</span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">
			<h3>매장할당현황조회</h3>
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
</div>