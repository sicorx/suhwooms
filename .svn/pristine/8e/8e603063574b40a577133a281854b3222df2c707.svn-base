<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
var dupChk = false;
var oldUserId = "";
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;

/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridUserMgnt").setGridWidth($("#cont").width());


}).resize();

$(document).ready(function(){
	
	
	
	// 셀렉트 선택	
	var ssVenderCd = $.trim("${userVo.vendorCd}");
	$("#scrVendorCd").val(ssVenderCd);	
	if (ssVenderCd != "") $("#scrVendorCd").attr("disabled", "disabled");
	
	
	$("#vendorCd").val(ssVenderCd);	
	
	//if (ssVenderCd != "") $("#vendorCd").attr("disabled", "disabled");
	
	
	
	
	$("input:radio[name='scrUseYn']:input[value='Y']").prop("checked", true);
	
	$("#gridUserMgnt").jqGrid({
		url:'searchMaintainEngineerList',
	    datatype: "json",
	    postData : {
	    	scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrUserId:$("#scrUserId").val(),
			scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		},
	    mtype: 'POST',
	    colNames:['No', '업체명', 'ID', '사용자', '사용여부', '사용자동의', 'vendorCd', 'userPw', 'useYn', 'eulaYn'],
	    colModel:[
	    	{name:'records', index:'records', width:50, align:'center', sortable:false, editable:false, editoptions :{readonly:true, size:10}},
	        {name:'vendorNm', index:'vendorNm', width:85, align:'center', sortable:true, editable:false},
	        {name:'userId' ,index:'userId', width:85, align:'center', sortable:true, editable:false},
	        {name:'userNm', index:'userNm', width:85, align:'left', sortable:true, editable:false},
	        {name:'useYnNm', index:'useYnNm', width:93, align:'center', sortable:true, editable:false},
	        {name:'eulaYnNm', index:'eulaYnNm', width:93, align:'center', sortable:true, editable:false},
	        {name:'vendorCd', index:'vendorCd', hidden:true},
	        {name:'userPw', index:'userPw', hidden:true},
	        {name:'useYn', index:'useYn', hidden:true},
	        {name:'eulaYn', index:'eulaYn', hidden:true}
		],
	    jsonReader : {
	    	repeatitems:false
		},
	    rowNum:20,
		rowList:[10,20,50,100],
	    pager: '#gridUserMgntPager',
	    recordtext: "건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
	    sortname: 'vendorNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 260,
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridUserMgnt").getRowData(rowid);
			 
			// 수정
			fncUpt(list);
		},
		gridComplete : function()
		{
			jqGridEven('gridUserMgnt');			 
			var rsltCount = $("#gridUserMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridUserMgnt >tbody").append("<tr><td align='center' colspan='6'>검색 결과가 없습니다.</td></tr>");
			}	
		},	
		loadComplete : function(data) {
			var list = $("#gridUserMgnt").getRowData();
			var rowCnt = list.length;
			
			if (rowCnt > 0) {
				$("#gridUserMgnt").jqGrid('setSelection', 1);
			}
		}
	});
	//jqGrid Resize	
	jqGridResize('gridUserMgnt');
	
	
	// validate
	$('#saveForm').validate({
		rules:{
			vendorCd:{required:true},
			userId:{required:true, minlength:3, maxlength:10, checkCd:true},
			userNm:{required:true},
			userPw:{required:true},
			userPwRe:{equalTo: '#userPw' },
			eulaYn:{required:true},
			useYn:{required:true},
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
	    return this.optional(element) || ( re1.test($('#userId').val()) || re2.test($('#userId').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	// 엔터 키 이벤트
	$("input[name='scrUserId']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncSearch();
	        }
		}
	});
	
	// 중복확인 key up
	$("input[id='userId']").on({
		keyup: function() {
			fncDupInit();
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
	
	$("#gridUserMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserMgnt").setGridParam({
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrUserId:$("#scrUserId").val(),
			scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		}
	}).trigger("reloadGrid");
}

// 신규
function fncAdd() {	
	var companyCd = $.trim($("#scrCompanyCd").val());
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = false;
	oldUserId = "";
	$('#dupMsg').html('');
	
	//$("#vendorCd").val("");
	$("#userId").val("").attr("readonly", false);
	$(".innerBtn").show();
	$("#userNm").val("");
	$("#userPw").val("");
	$("#userPwRe").val("");
	$("input:radio[name='eulaYn']:input[value='Y']").prop("checked", true);
	$("input:radio[name='useYn']:input[value='Y']").prop("checked", true);	
	
	

	
	
}

// 수정
function fncUpt(list) {
	var companyCd = $.trim($("#scrCompanyCd").val());
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = true;
	oldUserId = "";
	$('#dupMsg').html('');
	 
 	var vendorCd = $.trim(list.vendorCd);
 	$("#vendorCd").val(vendorCd);
 	var userId = $.trim(list.userId); 	
	$("#userId").val(userId).attr("readonly", true);
	$(".innerBtn").hide();
	var userNm = $.trim(list.userNm);
	$("#userNm").val(userNm);
	var userPw = $.trim(list.userPw);	
	$("#userPw").val(userPw);
	$("#userPwRe").val("");
	var eulaYn = $.trim(list.eulaYn);
 	$("input:radio[name='eulaYn']:input[value='" + eulaYn + "']").prop("checked", true);
 	var useYn = $.trim(list.useYn);
 	$("input:radio[name='useYn']:input[value='" + useYn + "']").prop("checked", true);	
}

// 중복확인 초기화
function fncDupInit() {
	if (oldUserId != $('#userId').val()) {
		dupChk = false;
		$('#dupMsg').html('');
	}
}

// 중복확인
function fncUserIdDupChk(){
	
	if($('#userId').valid()){
		
		var userId = $('#userId').val();
		oldUserId = userId;
		
		$.ajax({
			url:'/checkUserId',
			type:'POST',
			cache:false,
			data : {userId:userId},
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
			return;
		}
		
		if (confirm("${smCommMsgSaveCnf}")) {
			$.ajax({
				url:'/saveEngineerMgnt',
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
	else
	{
		alert("필수항목을 입력하세요.");
	}
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrVendorCd = $("#scrVendorCd").val();
	var scrUserId = $("#scrUserId").val();
	var scrUseYn = $(':radio[name="search_radio"]:checked').val();
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrVendorCd);
	$("#excel3").val(scrUserId);
	$("#excel4").val(scrUseYn);
	
	$('#excelDownload').attr("action", "/downloadMaintainEngineerListrExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">
	<form id="excelDownload" name='excelDownload' method='post'>
		<input type="hidden" id="excel1" name="scrCompanyCd"> 
		<input type="hidden" id="excel2" name="scrVendorCd"> 
		<input type="hidden" id="excel3" name="scrUserId"> 
		<input type="hidden" id="excel4" name="scrUseYn">
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
				<th>업체</th>	
				<td>
					<select id="scrVendorCd" name="scrVendorCd" class="searchSelect" style="width:140px;">							
						<option value="">--전체--</option>
					<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
					</select>
				</td>
				<th>사용자명/ID</th>
				<td>
					<input type='search' id='scrUserId' name='scrUserId' value='' placeholder="전체" style="width:112px;" />
				</td>
				<th>사용여부</th>
				<td>
					<span class="r_radio">
						<input type='radio' id='scrUseYn1' name='scrUseYn' value='Y' /> <label for="scrUseYn1">사용</label>&nbsp;
						<input type='radio' id='scrUseYn2' name='scrUseYn' value='N' /> <label for="scrUseYn2">미사용</label>
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
			<h3>엔지니어 목록</h3>
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();"/>
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table class="gridPointer" id="gridUserMgnt"><tr><td></td></tr></table>
		<div id="gridUserMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->

	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>상세정보</h3>
		</div>
		<form id="saveForm" name="saveForm" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="" /><!-- 회사 코드 -->						
			<table>
				<colgroup>
			    	<col width="15%" />
			    	<col width="35%" />
			    	<col width="15%" />
			    	<col width="*" />
		    	</colgroup>
		    	<tbody>
		    		<tr>
		         		<th><span class="r_required">*</span>업체명</th>
		         		<td colspan="3" class="tleft">
							<select id="vendorCd" name="vendorCd" class="searchSelect" style="width:140px; height:24px;">							
								<option value="">--선택--</option>
							<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
								<option value='${vo.value}'>${vo.name}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
		       		<tr>
		         		<th><span class="r_required">*</span>ID</th>
		         		<td class="tleft">
							<input type='text' id='userId' name='userId' style="width:100px;" value="" maxlength="10" />
							<span class="innerBtn">
								<button onclick="javascript:fncUserIdDupChk(); return false;">${smDupChk}</button>
	      					</span>
							<span id='dupMsg'></span>
						</td>
						<th><span class="r_required">*</span>사용자명</th>
		         		<td class="tleft">
							<input type='text' id='userNm' name='userNm' style="width:100px;" value="" maxLength="30" />
						</td>
					</tr>
					<tr>
		         		<th><span class="r_required">*</span>PW 입력</th>
		         		<td class="tleft">
							<input type='password' id='userPw' name='userPw' style="width:100px; height:24px;" value="" maxlength="20" />
						</td>
						<th><span class="r_required">*</span>PW 재입력</th>
		         		<td class="tleft">
							<input type='password' id='userPwRe' name='userPwRe' style="width:100px; height:24px;" value="" maxLength="20" />
						</td>
					</tr>
					<tr>
		         		<th><span class="r_required">*</span>동의여부</th>
		         		<td class="tleft">
							<span class="r_radio">
					    		<input type='radio' name='eulaYn' id='eulaYn_Y' value='Y'/><label for="eulaYn_Y">동의</label>&nbsp;
						    	<input type='radio' name='eulaYn' id='eulaYn_N' value='N'/><label for="eulaYn_N">미동의</label>
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
	   	<span class="pageNormal">
	    	<button onclick="javascript:fncAdd();">${smNew}</button>
	   	</span>
	</div>
	<!-- //하단 버튼 그룹 -->
	
</div>