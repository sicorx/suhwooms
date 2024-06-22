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
	
	// 달력
	$( "#search_dateFrom, #search_dateTo" ).datepicker({  
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true,		
		// 달력 아이콘  
	    showOn: "button",  
	    buttonImage: "/images/btn_calendar_new.png",  
	    buttonImageOnly: true,  
	    // 달력 하단의 종료와 오늘 버튼 Show  
	    showButtonPanel: true,  
	    // date 포멧  
	    showAnim : "",  
	    // 다른 달의 일 보이기, 클릭 가능  
	    numberOfMonths: 1,  
	    showButtonPanel: true,		    
	});
	
	if('${scrValue.scrDateFrom}' == "" )
	{		
		// Default Date Setting
		var DateFrom = func_makeDate(31);
		$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );		
	}
	else
	{		
		$('#scrDateFrom').val( 		'${scrValue.scrDateFrom}' );
	}
	
	if('${scrValue.scrDateTo}' == "" )
	{
		var DateTo = func_toDate();
		$( "#search_dateTo" ).datepicker( "setDate", DateTo );
	}
	else
	{
		$('#scrDateTo').val( 		'${scrValue.scrDateTo}' );	
	}
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

	<!-- 조회조건 -->
	<div class="r_search multiLine">
	
		<c:if test="${selectVoListCnt == 1 }">
			<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
			<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;display:none;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
		</c:if>
		<c:if test="${selectVoListCnt > 1 }">			
			<select id="scrCompanyCd" name="scrCompanyCd" style="width:112px;display:none;" class="searchSelect">
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
				 	<input type='search' id='scrVendorNm' name='scrVendorNm' value='' style="width:112px;" />
				</td>
				<th>설치일자</th>
				<td>
					<input id="search_dateFrom" type="text" placeholder="2017-01-11" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
					~ <input id="search_dateTo" type="text" placeholder="2017-01-11" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
					<button onclick="javascript:func_AllBtn();" class="ml_5">전체</button>
			   		<button onclick="javascript:func_monthBtn(1);">1m</button>
			   		<button onclick="javascript:func_monthBtn(6);">6m</button>
			   		<button onclick="javascript:func_monthBtn(12);">1y</button>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid">
		<div class="r_gridTitle">
			<h3>매장리스트</h3>
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png"/>
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table id="gridVendorMgnt"><tr><td></td></tr></table>
		<div id="gridVendorMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->

</div>