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

// 페이지 사용 - jooyoung

var dupChk = false;
var oldGwId = "";
var title = js_er_title ='Error';
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;
/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();

$(document).ready(function(){
	
	$("input:radio[name='scrUseYn']:input[value='Y'], input:radio[name='scrAuthYn']:input[value='%']").prop("checked", true);
	
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveGwListMgnt',
		datatype: "json",
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrStrCd:$("#scrStrCd").val(),				 
			scrOrgCd:$("#scrOrgCd").val(),
			scrUseYn: $(':radio[name="scrUseYn"]:checked').val(),
			scrGwId:$("#scrGwId").val(),
			scrAuthYn: $(':radio[name="scrAuthYn"]:checked').val()
		},
		mtype: 'POST',
		colNames:['No', 'GW ID', '조직명', '매장명', '인증여부', 'SW 버전', '업데이트 일시', '업데이트 성공여부', '사용여부', '회사코드', 'gwAddr', 'strCd', 'authYn', 'useYn'],
		colModel:[
				{name:'records',		index:'records',		width:10,	align:'center', sortable:false},
				{name:'gwId',			index:'gwId',			width:35, 	align:'center', sortable:true, editable:false},
				{name:'orgFullNm',		index:'orgFullNm', 		width:45, 	align:'left',	sortable:true, editable:false},
				{name:'strNm',			index:'strNm', 			width:50, 	align:'left', 	sortable:true, editable:false},
				{name:'authYnNm',		index:'authYnNm', 		width:35, 	align:'center', sortable:true, editable:false},
				{name:'gwSwVer',		index:'gwSwVer', 		width:35, 	align:'center', sortable:true, editable:false},		                
				{name:'updateTime',		index:'updateTime', 	width:70, 	align:'center', sortable:true, editable:false},
				{name:'updateSuccessYn',index:'updateSuccessYn',width:35, 	align:'center', sortable:true, editable:false},
				{name:'useYnNm',		index:'useYnNm', 		width:35, 	align:'center', sortable:true, editable:false},
				{name:'companyCd',		index:'companyCd', 		hidden:true},
				{name:'gwAddr',			index:'gwAddr', 		hidden:true},
				{name:'strCd',			index:'strCd', 			hidden:true},
				{name:'authYn',			index:'authYn', 		hidden:true},
				{name:'useYn',			index:'useYn', 			hidden:true}
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
		sortname: 'strNm',
		viewrecords: true,
		sortorder: "asc",	     
		hidegrid: false,
		shrinkToFit:true,
		autowidth:true,
		height : 260,
		onSelectRow : function(rowid, iRow, iCol, e) {
			
			var list = $("#gridStoreMgnt").getRowData(rowid);
	 		fncUpt(list);	// 수정
		},
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='9'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		loadComplete : function(data) {
			
			var list   = $("#gridStoreMgnt").getRowData();
			var rowCnt = list.length;
	
			if( rowCnt > 0 ) {
				$("#gridStoreMgnt").jqGrid('setSelection', 1);
			}
		}
	});
	//jqGrid Resize	
	jqGridResize('gridStoreMgnt');
	  
	// validate
	$('#saveForm').validate({
		rules:{
			strCd:{required:true},
			gwId:{required:true, number:true},
			gwAddr:{maxlength: 12, minlength : 12, checkCd:true},
		},			
		showErrors: function(errorMap, errorList) {	          
	          $.each(this.validElements(), function (index, element) {
	              var $element = $(element);
	              $element.data("title", "").removeClass("error").tooltip("destroy");
	          });
	          $.each(errorList, function (index, error) {
	              var $element = $(error.element);
	              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
	          });
	      }
		
	});
	
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#gwAddr').val()) || re2.test($('#gwAddr').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	// 엔터 키 이벤트
	$("input[name='scrStrCd'], input[name='scrGwId']").on({
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
	
	// 중복확인 key up
	$("input[id='gwId']").on({
		keyup: function() {
			fncDupInit();
		}
	});
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/
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
			 scrStrCd:$("#scrStrCd").val(),				 
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrUseYn: $(':radio[name="scrUseYn"]:checked').val(),
			 scrGwId:$("#scrGwId").val(),
			 scrAuthYn: $(':radio[name="scrAuthYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
}

// 수정
function fncUpt(list) {
	var companyCd = $.trim(list.companyCd);
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = true;
	$('#dupMsg').html('');
	 
 	var gwId = $.trim(list.gwId);
	$("#gwId").val(gwId).attr("readonly", false);
	oldGwId = gwId;
	$(".innerBtn").show();
	var gwAddr = $.trim(list.gwAddr);
	$("#gwAddr").val(gwAddr);
	var strCd = $.trim(list.strCd);	
	$("#strCd").val(strCd);
	var authYn = $.trim(list.authYn);
 	$("input:radio[name='authYn']:input[value='" + authYn + "']").prop("checked", true);
 	var useYn = $.trim(list.useYn);
 	$("input:radio[name='useYn']:input[value='" + useYn + "']").prop("checked", true);	
 	var strNm = document.getElementById("strNm"); 
	strNm.innerHTML = $.trim(list.strNm);
}

// 중복확인 초기화
function fncDupInit() {
	if (oldGwId != $('#gwId').val()) {
		dupChk = false;
		$('#dupMsg').html('');
	}
}

// 중복확인
function fncGwIdDupChk() {
	if ($('#gwId').valid()) {
		var gwId = $.trim($('#gwId').val());
		var preGwId = $.trim(oldGwId);
		
		$.ajax({
			url:'/checkGwId',
			type:'POST',
			cache:false,
			data : {gwId:gwId,preGwId:preGwId},
			dataType:'json',
			success:function(data){		
				if(data == true ){
					$('#dupMsg').html('사용 가능');
					dupChk = true;
				}else{
					$('#dupMsg').html('중복 정보');
					dupChk = false;
				}
			},
			error:function(result){
				$('#dupMsg').html('에러 발생');
				dupChk = false;
			}
		});
	}
}

// 저장
function fncSave() {
	if ($('#saveForm').valid()) {
		
		if (!dupChk) {
			$('#dupMsg').html('${smCommMsgDupChk}');
			return false;
		}
		
		if (confirm("${smCommMsgSaveCnf}")) {
			$.ajax({
				url:'/saveGWMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					fncSearch();
				},
				error:function(result){
					alert("에러가 발생했습니다.");
				}
			});
		}
	}
}

/*******************
1. 조직 팝업  
********************/
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
	var scrStrCd = $("#scrStrCd").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrUseYn = $(':radio[name="scrUseYn"]:checked').val();
	var scrGwId = $("#scrGwId").val();
	var scrAuthYn = $(':radio[name="scrAuthYn"]:checked').val();

	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrStrCd);
	$("#excel3").val(scrOrgCd);
	$("#excel4").val(scrUseYn);
	$("#excel5").val(scrGwId);
	$("#excel6").val(scrAuthYn);
	
	$('#excelDownload').attr("action", "/retrieveGwListExcelMgnt");
	$("#excelDownload").submit();

}
</script>
<div id="loadingArea">
	<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrCompanyCd"> 
	<input type="hidden" id="excel2" name="scrStrCd"> 
	<input type="hidden" id="excel3" name="scrOrgCd"> 
	<input type="hidden" id="excel4" name="scrUseYn"> 
	<input type="hidden" id="excel5" name="scrGwId"> 
	<input type="hidden" id="excel6" name="scrAuthYn"> 
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
				<th>매장명/코드</th>
				<td>
					<input type='search' id='scrStrCd' name='scrStrCd' value="" style="width:100px;" placeholder="전체" />
				</td>
				<th>조직명(코드)</th>
				<td><input type='hidden' id='scrOrgCd' name='scrOrgCd' value=""/>
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
				<th>${smUseYn}</th>
				<td>
					<span class="r_radio">						
						<input type='radio' id='scrUseYn1' name='scrUseYn' value='Y' /> <label for="scrUseYn1">사용</label>&nbsp;
						<input type='radio' id='scrUseYn2' name='scrUseYn' value='N' /> <label for="scrUseYn2">미사용</label>
					</span>
				</td>
			</tr>
			<tr>
				<th>GW ID</th>
				<td>
					<input type='search' id='scrGwId' name='scrGwId' value="" style="width:100px;" placeholder="전체"/>
				</td>
				<th>인증여부</th>
				<td>
					<span class="r_radio">
						<input type='radio' id='scrAuthYn1' name='scrAuthYn' value='%' /> <label for="scrAuthYn1">전체</label>&nbsp;
						<input type='radio' id='scrAuthYn2' name='scrAuthYn' value='Y' /> <label for="scrAuthYn2">인증</label>&nbsp;
						<input type='radio' id='scrAuthYn3' name='scrAuthYn' value='N' /> <label for="scrAuthYn3">미인증</label>
					</span>
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
			<h3>게이트웨이 목록</h3>
			
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
	
	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>상세정보  - &nbsp;<div id ="strNm" style ="float:right"></div> </h3><div></div>
		</div>
		<form id="saveForm" name="saveForm" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="" /><!-- 회사 코드 -->
			<input type='hidden' id='strCd' name='strCd' value="" /><!-- 매장 코드 -->			
			<table>
				<colgroup>
			    	<col width="15%" />
			    	<col width="35%" />
			    	<col width="15%" />
			    	<col width="*" />
			    </colgroup>
		    	<tbody>
		       		<tr>
		         		<th><span class="r_required">*</span>GW ID</th>
		         		<td class="tleft">
							<input type='number' id='gwId' name='gwId' style="width:100px;" value="" maxlength="10" />
							<span class="innerBtn">
								<button onclick="javascript:fncGwIdDupChk(); return false;">${smDupChk}</button>
	      					</span>
							<span id='dupMsg'></span>
						</td>
						<th>Mac Address</th>
		         		<td class="tleft">
							<input type='text' id='gwAddr' name='gwAddr' style="width:100px;" value="" maxLength="12" readonly />
						</td>
					</tr>
					<tr>
		         		<th><span class="r_required">*</span>인증여부</th>
		         		<td class="tleft">
							<span class="r_radio">
					    		<input type='radio' name='authYn' id='authYn_Y' value='Y'/><label for="authYn_Y">사용</label>&nbsp;
						    	<input type='radio' name='authYn' id='authYn_N' value='N'/><label for="authYn_N">미사용</label>
							</span>
						</td>
						<th><span class="r_required">*</span>사용여부</th>
		         		<td class="tleft">
							<span class="r_radio">
					    		<input type='radio' name='useYn' id='useYn_Y' value='Y'/><label for="useYn_Y">사용</label>&nbsp;
						    	<input type='radio' name='useYn' id='useYn_N' value='N'/><label for="useYn_N">미사용</label>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal">
	   		<button onclick="javascript:fncSave();">${smSave}</button>
	   	</span>	
	</div>
	<!-- //하단 버튼 그룹 -->
	
</div>