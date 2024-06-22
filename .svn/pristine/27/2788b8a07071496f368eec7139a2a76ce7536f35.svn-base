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
var oldVendorCd = "";
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;
/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	
	$('input:radio[name="scrUseYn"]').eq(0).attr('checked', true);
	
	
	  $("#gridVendorMgnt").jqGrid({
	      url:'retrieveVendorMgnt',
	      datatype: "json",
	      postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrVendorNm:$("#scrVendorNm").val(),
			 scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		  },
	      mtype: 'POST',
	      colNames:['No', '업체코드', '업체명', '사용여부', '최종 수정자', '최종수정일시', '회사코드', '사용여부코드'],
	      colModel:[
	                {name:'records',index : 'records',width : 50,align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
	                {name:'vendorCd',index:'vendorCd', width:85, align:'center', sortable:true, editable:false},
	                {name:'vendorNm',index:'vendorNm', width:85, align:'center', sortable:true, editable:false},
	                {name:'useYnNm',index:'useYnNm', width:30, align:'center', sortable:true, editable:false},
	                {name:'finalUserNm',index:'finalUserNm', width:50, align:'center', sortable:false, editable:false},
	                {name:'finalModDttm',index:'finalModDttm', width:93, align:'center', sortable:false, editable:false},
	                {name:'companyCd',index:'companyCd', hidden:true},
	                {name:'useYn',index:'useYn', hidden:true}
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
	     sortname: 'vendorNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 260,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 var list = $("#gridVendorMgnt").getRowData(rowid);
			 
			 // 수정
			 fncUpt(list);
		}
	 });
	  //jqGrid Resize	
	  jqGridResize('gridVendorMgnt');
	  
	  // 최초 신규버튼 클릭
	  fncAdd();
	  
	// validate
	$('#saveForm').validate({
		rules:{
			vendorCd:{required:true, minlength:3, maxlength:10, checkCd:true},
			vendorNm:{required:true},
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
	    return this.optional(element) || ( re1.test($('#vendorCd').val()) || re2.test($('#vendorCd').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	// 엔터 키 이벤트
	$("input[name='scrVendorNm']").keydown(function (key) {
		if (key.keyCode == 13) {
			fncSearch();
        }
    });
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	$("#gridVendorMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridVendorMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrVendorNm:$("#scrVendorNm").val(),
			 scrUseYn: $('input:radio[name="scrUseYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
	
}

// 신규
function fncAdd() {	
	var companyCd = $.trim($("#scrCompanyCd").val());
	var companyNm = $.trim($("#scrCompanyNm").val());

	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = false;
	oldVendorCd = "";
	$('#dupMsg').html('');
	
	$("#vendorCd").val("").attr("readonly", false);
	$(".innerBtn").show();
	$("#vendorNm").val("");
	$("input:radio[name='useYn']:input[value='Y']").prop("checked", true);	
}

// 수정
function fncUpt(list) {
	var companyCd = $.trim(list.companyCd);
	var companyNm = $.trim($("#scrCompanyNm").val());
	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = true;
	oldVendorCd = "";
	$('#dupMsg').html('');
	 
 	var vendorCd = $.trim(list.vendorCd);
	$("#vendorCd").val(vendorCd).attr("readonly", true);
	$(".innerBtn").hide();
	var vendorNm = $.trim(list.vendorNm);
	$("#vendorNm").val(vendorNm);
 	var useYn = $.trim(list.useYn);
 	$("input:radio[name='useYn']:input[value='" + useYn + "']").prop("checked", true);	
}

// 중복확인 초기화
function fncDupInit() {
	if (oldVendorCd != $('#vendorCd').val()) {
		dupChk = false;
		$('#dupMsg').html('');
	}
}

// 중복확인
function fncVendorCdDupChk(){
	
	if($('#vendorCd').valid()){
		
		oldVendorCd = vendorCd;
		
		var companyCd = $('#companyCd').val();
		var vendorCd = $('#vendorCd').val();
		
		$.ajax({
			url:'/checkVendorCd',
			type:'POST',
			cache:false,
			data : {companyCd:companyCd,vendorCd:vendorCd},
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
				url:'/saveVendorMgnt',
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

// 삭제
function fncDel() {
	var selrow = $.trim($("#gridVendorMgnt").getGridParam("selrow"));	// 선택된 로우
	var vendorCd = $.trim($("#vendorCd").val());						// 선택된 업체코드
	if (selrow == "" || vendorCd == "") {
		alert("삭제할 행을 선택하세요.");
		return false;
	}
	
	if(confirm("선택한 행을 삭제하시겠습니까?")){
		$.ajax({
			url:'/deleteVendorMgnt',
			type:'POST',
			cache:false,
			data:$('#saveForm').serialize(),
			dataType:'text',
			success:function(data){
				if (data == "DENY") {
					alert("등록된 엔지니어가 있어서 삭제가 불가합니다.");
				} else {
					alert('${smCommMsgDel}');
					fncSearch();	
				}
			},
			error:function(result){
				alert("에러가 발생했습니다.");
			}				
		});
	}
}
</script>

<div id="loadingArea">

	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<form id="saveForm" name="saveForm" method="post">
			<div class="r_gridTitle top_table">
				<h3>온실가스 배출 총량</h3>
			</div>
			<table>
				<colgroup>
			    	<col width="129" />
			    	<col width="*" />
			    </colgroup>
		    	<tbody>
		       		<tr>
		         		<th>온실가스 배출량</th>
		         		<td class="tleft">20.752 tCO eq(12개월)</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->
	
	<!-- 그래프 영역 -->
	<div class="common_section">
		<div class="common_section_title">
			<h3 class="float_n">월별 온실가스 배출 현황</h3>
		</div>
		<div class="graph_area">
			<p>그래프 영역</p>
		</div>
	</div>
	<!-- //그래프 영역 -->
	
	<!-- 지시문 -->
	<div class="r_infoGroup">
	    <span class="r_infoTxt"><img src="/images/ico_info_new.png">온실가스 배출량 = Σ[전력사용량(MWh) * 배출계수(tGHG(CO2/CH4/N2O)/MWh) * 지구온난화지수]</span>
	    <span class="r_infoTxt"><img src="/images/ico_info_new.png">배출계수 : 해당연도의 국가 고유 전력배출계수, 전력거래소에서 발표(현재는 2011년 발표한 0.4585(tCO2/MWh기준))</span>
	    <span class="r_infoTxt r_last"><img src="/images/ico_info_new.png">지구온난화 지수 : CO2=1, CH4=21, N2O=310</span>
    </div>
	<!-- //지시문 -->
	
</div>