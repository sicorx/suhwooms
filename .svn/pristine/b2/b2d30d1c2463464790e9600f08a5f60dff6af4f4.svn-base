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
var dupChk = false;
var oldElectricentCd = "";
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;
/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){

    $("#gridVendorMgnt").setGridWidth($("#cont").width());

}).resize();

$(document).ready(function(){
	
	$("input:radio[name='scrUseYn']:input[value='Y']").prop("checked", true);
	
	  $("#gridVendorMgnt").jqGrid({
	      url:'retrieveElecMgnt2',
	      datatype: "json",
	      postData : {
			 scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		  },
	      mtype: 'POST',
	      colNames:['No', '전기업체코드', '전기업체명', '사용여부', '등록자ID', '등록자명', '최종작업일자'],
	      colModel:[
	                {name:'records',		index:'records',		width:50, align:'center', sortable:false, editable:false, editoptions:{readonly:true, size:10}},
	                {name:'electricentCd',	index:'electricentCd', 	width:85, align:'left',   sortable:true,  editable:false},
	                {name:'electricentNm',	index:'electricentNm', 	width:85, align:'left',   sortable:true,  editable:false},
	                {name:'useYnNm',		index:'useYnNm', 		width:30, align:'center', sortable:false, editable:false},
	                {name:'finalModId',		index:'finalModId', 	width:50, align:'center', sortable:false, editable:false},
	                {name:'finalModNm',		index:'finalModNm', 	width:93, align:'center', sortable:false, editable:false},
	                {name:'finalModDttm',	index:'finalModDttm', 	width:93, align:'center', sortable:false, editable:false},
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridVendorMgntPager',
	     recordtext: "건/페이지  (전체 {2} 건)",
		 emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'finalModDttm',
	     viewrecords: true,
	     sortorder: "desc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 260,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 var list = $("#gridVendorMgnt").getRowData(rowid);
			 // 수정
			 fncUpt(list);
		},
		loadComplete : function(data) {
			// 최초 신규버튼 클릭
			fncAdd();
		}
	 });
	  //jqGrid Resize	
	  jqGridResize('gridVendorMgnt');
	  
	// validate
	$('#saveForm').validate({
		rules:{
			electricentCd:{required:true, minlength:3, maxlength:20, checkCd:true},
			electricentNm:{required:true},
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
	    return this.optional(element) || ( re1.test($('#electricentCd').val()) || re2.test($('#electricentCd').val() ) );
	}, "영문과 숫자만 가능 합니다");
	

	// 중복확인 key up
	$("input[id='electricentCd']").on({
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

	$("#gridVendorMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridVendorMgnt").setGridParam({
		 postData : {
			 scrUseYn: $('input:radio[name="scrUseYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
}

// 신규
function fncAdd() {	

	dupChk = false;
	oldVendorCd = "";
	$('#dupMsg').html('');
	
	$("#electricentCd").val("").attr("readonly", false);
	$(".innerBtn").show();
	$("#electricentNm").val("");
	$("input:radio[name='useYn']:input[value='Y']").prop("checked", true);	
}

// 수정
function fncUpt(list) {

	dupChk = true;
	oldElectricentCd = "";
	$('#dupMsg').html('');
	 
 	var electricentCd = $.trim(list.electricentCd);
	$("#electricentCd").val(electricentCd).attr("readonly", true);
	$(".innerBtn").hide();
	var electricentNm = $.trim(list.electricentNm);
	$("#electricentNm").val(electricentNm);
 	var useYn = $.trim(list.useYn);
 	$("input:radio[name='useYn']:input[value='" + useYn + "']").prop("checked", true);	
}

// 중복확인 초기화
function fncDupInit() {
	if (oldVendorCd != $('#electricentCd').val()) {
		dupChk = false;
		$('#dupMsg').html('');
	}
}

// 중복확인
function fncVendorCdDupChk(){

	if($('#electricentCd').valid()){
		
		oldElectricentCd = electricentCd;
		
		var electricentCd = $('#electricentCd').val();
		
		$.ajax({
			url:'/checkElecCd',
			type:'POST',
			cache:false,
			data : {electricentCd:electricentCd},
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
				url:'/saveElectricMgnt',
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
		alert('필수입력란을 확인하세요.');
	}
}
</script>

<div id="loadingArea">

	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>${smUseYn}</th>
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
			<h3>전기업체 목록</h3>
			
			<!-- 엑셀 download -->
			<!-- div style="text-align:right">
				<img src="/images/download_excel.png"/>
			</div -->
			<!-- //엑셀 download -->
			
		</div>
		<table id="gridVendorMgnt"><tr><td></td></tr></table>
		<div id="gridVendorMgntPager"></div>
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
		         		<th><span class="r_required">*</span>업체코드</th>
		         		<td class="tleft">
							<input type='text' id='electricentCd' name='electricentCd' style="width:100px;" value="" maxlength="10" required/>
							<span class="innerBtn">
								<button onclick="javascript:fncVendorCdDupChk(); return false;">${smDupChk}</button>
	      					</span>
							<span id='dupMsg'></span>
						</td>
						<th><span class="r_required">*</span>업체명</th>
		         		<td class="tleft">
							<input type='text' id='electricentNm' name='electricentNm' style="width:100px;" value="" required />
						</td>
					</tr>
					<tr>
		         		<th><span class="r_required">*</span>사용여부</th>
		         		<td colspan="3" class="tleft">
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