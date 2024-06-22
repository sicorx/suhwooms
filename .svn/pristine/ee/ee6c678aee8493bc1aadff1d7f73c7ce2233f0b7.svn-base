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

var dupViewStrCdChk = false;

var OriViewStrCd;

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	console.log( "companyCd : " + '${userVo.companyCd}' );
	
	var mode = '${mode}';
	
	if( "MODIFY" == mode)
		dupViewStrCdChk = true;
	else
		dupViewStrCdChk = false;
	
	init();	
	
	// 조직명 엔터 및 focusout
	$("input[name='orgNm']").on({
		keyup: function() {
			$("input[name='orgCd']").val("");
		},
		keydown: function(key) {
			if (key.keyCode == 13) {
				$(this).blur();
	        }
		},
		blur: function() {
			var orgNm = $.trim($(this).val());
			var orgCd = $.trim($("input[name='orgCd']").val());
			
			// 검색어는 빈값이 아니면서 검색된 orgCd는 빈값일때만 검색
			if (orgNm != "" && orgCd == "") {
				fncSearchOrgCd();
			}
		}
	});
	
	// 기상지역 엔터 및 focusout
	$("input[name='localAreaNm']").on({
		keyup: function() {
			$("input[name='localAreaCd']").val("");
		},
		keydown: function(key) {
			if (key.keyCode == 13) {
				$(this).blur();
	        }
		},
		blur: function() {
			var localAreaNm = $.trim($(this).val());
			var localAreaCd = $.trim($("input[name='localAreaCd']").val());
			
			// 검색어는 빈값이 아니면서 검색된 localAreaCd는 빈값일때만 검색
			if (localAreaNm != "" && localAreaCd == "") {
				fncSearchAreaCd();
			}
		}
	});
});


// 초기 셋팅
function init()
{
	// 램스 시작 일자, 램스 종료 일자 달력 셋팅
	
	$("#remsStartDt, #remsEndDt").datepicker();
	
	var mode = '${mode}';
	$('#mode').val( mode );
	if( mode == "NEW" )	// 신규 매장의 경우
	{
		//init();			
		$('#gwId').val( '${gwId}' );
		$('#gwInfoDiv').show();				// GW정보 나타내기
		$('#remsDeviceInfoDiv').show();		// 램스장비정보 나타내기
		$('#entInfoDiv').show();			// 전기업체, 유지보수업체 나타내기
		
		$('#saveForm').validate({
			ignore: "input[type='text']:hidden",
			rules:{
				strNm:{required:true},
				remsStartDt:{required:true},
				localAreaNm:{required:true},
				contDemandPower:{required:true},
				localAreaCd:{required:true},
				electricEntCd:{required:true},
				gwAddr:{required:true},
				strAreaSpec:{required:true}
			},			
			showErrors: function(errorMap, errorList) {	          
		          $.each(this.validElements(), function (index, element) {
		              var $element = $(element);
		              $element.data("title", "").removeClass("error").tooltip("destroy");
		          });
		          $.each(errorList, function (index, error) {
		              var $element = $(error.element);
		              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
		              
		              // 기상지역 체크
		              var elId = $.trim($element.attr("id"));
		              if (elId == "localAreaCd") {
		            	  $("#localAreaNm").tooltip("destroy").data("title", "검색버튼을 이용하여 검색하여 주세요.").addClass("error").tooltip();
		              }
		          });
		      }
		});
		
		// Default 오늘 날짜 셋팅	
		var remsStartDt = func_toDate();	
		$( "#remsStartDt" ).datepicker( "setDate", remsStartDt );	
		
		console.log( remsStartDt );		
		  
		// 초기 defalut 셋팅( GS25 )
		$('#mainMeterNum').val(		1	);		// 메인미터 개수
		//$('#excldMeterNum').val(	0	);		// 예외미터 개수
		$('#tempMeterNum').val(		2	);		// 냉난방미터 개수
		$('#haconNum').val(			2	);		// 하콘 개수
		$('#tSensorNum').val(		1	);		// 티센서 개수
		$('#temonNum').val(			1	);		// 테몬 개수
		$('#almonNum').val(			0	);		// 알몬 개수
		$('#zigbeeNum').val(		0	);		// 지그비 개수
		$('#invNum').val(			1	);		// 인버터 개수
		$('#signNum').val(			1	);		// 간판 개수
		
		// 미터수집여부 radio change 이벤트	
		$("input[name=meterYn_radio]").change(function() {
			
			var meterYn = $(this).val();
			if( meterYn == "Y" )	
				$('#meterYnDiv').show();   		// Y 일 경우 메인, 냉난방,예외 미터 설정
			else 	
				$('#meterYnDiv').hide();		// N 일 경우 메인, 냉난방, 예외 미터 숨김		
		});
		
	}
	if( mode == "MODIFY" )	// 수정 매장의 경우
	{
		//alert( mode );
		//init();
		$('#gwInfoDiv').hide();				// GW정보 숨기기
		$('#remsDeviceInfoDiv').hide();		// 램스장비정보 숨기기
		$('#entInfoDiv').hide();			// 전기업체, 유지보수업체 나타내기
		
		$('#gwId').val('0');
		
		OriViewStrCd = $('#viewStrCd').val();
		$('#viewStrCdDupChkBtn').hide();
		//$('#electricEntCd').val('1');
		
		$('#saveForm').validate({
			ignore: "input[type='text']:hidden",
			rules:{
				strNm:{required:true},
				localAreaCd:{required:true},
				remsStartDt:{required:true},
				localAreaNm:{required:true},
				contDemandPower:{required:true},
				localAreaCd:{required:true},
				strAreaSpec:{required:true}
			},			
			showErrors: function(errorMap, errorList) {	          
		          $.each(this.validElements(), function (index, element) {
		              var $element = $(element);
		              $element.data("title", "").removeClass("error").tooltip("destroy");
		          });
		          $.each(errorList, function (index, error) {
		              var $element = $(error.element);
		              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
		              
		              // 기상지역 체크
		              var elId = $.trim($element.attr("id"));
		              if (elId == "localAreaCd") {
		            	  $("#localAreaNm").tooltip("destroy").data("title", "검색버튼을 이용하여 검색하여 주세요.").addClass("error").tooltip();
		              }
		          });
		      }
		});
	}
	
	
	
	// validator 	
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#viewStrCd').val()) || re2.test($('#viewStrCd').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#gwAddr').val()) || re2.test($('#gwAddr').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#viewStrCd').val()) || re2.test($('#viewStrCd').val() ) );
	}, "영문과 숫자만 가능 합니다");		    
	
	// 기상지역 텍스트 변경시
	$("input[id='localAreaNm']").on({
		change: function() {
			$("#localAreaCd").val("");
			$("#localAreaNm").tooltip("destroy").data("title", "검색버튼을 이용하여 검색하여 주세요.").addClass("error").tooltip();
		}
	});
	
	// 전화번호 입력시 focus 이동
	$("#telNo1").keyup(function(event){	
		var c = $("#telNo1").val();
		if( c.length == 3 )	
			$("#telNo2").focus();
	});
	$("#telNo2").keyup(function(event){	
		var c = $("#telNo2").val();
		if( c.length == 4 )	
			$("#telNo3").focus();
	});
	$("#telNo3").keyup(function(event){	
		var c = $("#telNo3").val();
		if( c.length == 4 )	
			$("#contDemandPower").focus();
	});
	
	// 기상지역 입력 Enter 시 수행
	$("#localAreaNm").keyup(function(event){	
		
		if(event.which == 13)		// Enter Key Press
		{		
			fncAreaSrchPop();		// 기상지역 조회 팝업				
		}
	});
}

// 현재 날짜 얻어오기
function func_toDate()
{
    var YYYY, MM, DD;	    
    var d = new Date();	
    
    YYYY = d.getFullYear();	    
    
    //한자릿수 월 앞에 0을 붙이기 위한 if문
    if(d.getMonth() < 9)	        
    	MM = '0'+(d.getMonth()+1);
    else
    	MM = d.getMonth()+1;	    
 
    if(d.getDate() < 9)
        DD = '0'+(d.getDate());
    else
        DD = d.getDate();	    
    
    return YYYY+"-"+ MM +"-"+ DD;
}

// gwId 중복 확인
function fncGwIdDupChk()
{
	if($('#gwId').valid())
	{
		var gwId = $('#gwId').val();		
		
		$.ajax({
			url:'/checkGwId',
			type:'POST',
			cache:false,
			data : {gwId:gwId},
			dataType:'json',
			success:function(data){
				if(data == true ){
					$('#dupGwMsg').html('사용 가능');					
					dupGwChk = true;
				}else{
					$('#dupGwMsg').html('중복 정보');					
					dupGwChk = false;	
				}
			},
			error:function(result){
				$('#dupGwMsg').html('${smCommMsgUse}');
				dupGwChk = true;
			}				
		});			
	}
}


// 매장코드 중복 확인
function fncViewStrCdDupChk(){
	
	if($('#viewStrCd').valid()){

		var viewStrCd = $('#viewStrCd').val();
		oldViewStrCd = viewStrCd;
		
		$.ajax({
			url:'/getViewStrCd',
			type:'POST',
			cache:false,
			data : {viewStrCd:viewStrCd},
			dataType:'json',
			success:function(data){
				if(data == true ){
					$('#dupViewStrCdMsg').html('사용 가능');
					dupViewStrCdChk = true;
				}else{
					$('#dupViewStrCdMsg').html('중복 정보');					
					dupViewStrCdChk = false;	
				}
			},
			error:function(result){
				$('#dupViewStrCdMsg').html('${smCommMsgUse}');
				dupViewStrCdChk = true;
			}
		});
	}
}

/*******************
1. 조직 팝업  
********************/
// 조직명 검색
function fncSearchOrgCd() {
	var companyCd = $.trim($("#companyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#orgNm").val());
	
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
			$("input[name='orgCd']").val("");
			var orgCnt = data.orgCnt;
			// 0개 일때
			if (orgCnt == "0") {
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (orgCnt == "1") {
				$("#orgCd").val(data.orgCd)
				$("#orgNm").val(data.orgNm + "(" + data.orgCd + ")");
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
	var orgNm = $.trim($("#orgNm").val());
	if (orgNm == "") {
		// 조직 팝업
		fncOrgSearch();
	} else {
		$("input[name='orgNm']").blur();
	}
}

// 조직 팝업
function fncOrgSearch() {
	var companyCd = $.trim($("#companyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#orgNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.orgNm = orgNm;
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
}

function fncSetOrg(data){
	$("#orgCd").val(data.orgCd)
	$("#orgNm").val(data.orgNm + "(" + data.orgCd + ")");
}

function fncOrgClear(){
	$("#orgCd").val("");
	$("#orgNm").val("");
}

/*******************
2. 기상지역 팝업  
********************/
// 기상지역 검색
function fncSearchAreaCd() {
	var companyCd = $.trim($("#companyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}

	var localAreaNm = $.trim($("#localAreaNm").val());
	
	var param = new Object();
	param.companyCd = companyCd;
	param.localAreaNm = localAreaNm;
	
	$.ajax({
		url:'/retrieveAreaCdCnt',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
			$("input[name='localAreaCd']").val("");
			var areaCnt = data.areaCnt;
			// 0개 일때
			if (areaCnt == "0") {
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (areaCnt == "1") {
				$("#localAreaCd").val(data.areaCd)
				$("#localAreaNm").val(data.fullAreaNm);
			// 2개 이상일때	
			} else {
				// 기상지역 팝업
				fncAreaSearch();
			}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}

// 기상지역 검색 버튼
function fncAreaSearchBtn() {
	var localAreaNm = $.trim($("#localAreaNm").val());
	if (localAreaNm == "") {
		// 기상지역 팝업
		fncAreaSearch();
	} else {
		$("input[name='localAreaNm']").blur();
	}
}

// 기상지역 팝업
function fncAreaSearch() {
	var companyCd = $.trim($("#companyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var localAreaNm = $.trim($("#localAreaNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.localAreaNm = localAreaNm;
	
	fn_divPop("showAreaSrch", "팝업", 800, 650, args );
}

function fncSetArea(data){
	$("#localAreaCd").val(data.areaCd)
	$("#localAreaNm").val(data.areaNm);
}

function fncAreaClear(){
	$("#localAreaCd").val("");
	$("#localAreaNm").val("");
}



// 저장버튼 - 매장정보 저장
function func_saveBtn() {
	if( dupViewStrCdChk == false )
	{
		alert('매장코드 중복을 확인하세요.');
		return;
	}
	
	
	var remsStartDt = $('#remsStartDt').val().replace("-","");
	var remsEndDt = $('#remsEndDt').val().replace("-","");
	
	//console.log( Number(remsStartDt) );
	console.log( Number(remsEndDt) );
	
	if( remsEndDt != 0 )
	{
		console.log( Number( remsStartDt) < Number( remsEndDt ) );
		if( Number( remsStartDt) >= Number( remsEndDt ) )
		{
			alert('종료일자가 올바르지 않습니다.');
			return;
		}
	}
	
	if($('#saveForm').valid())
	{
		if($("#contDemandPower").val() < 1000){
			alert("계약전력이 1000W보다 작습니다.\n1000W보다 큰 값을 입력해주세요.");
			return;
		}
		
		if(confirm('${smCommMsgSaveCnf}'))
		{
			var target = '/saveStoreNewMgnt';
			
			$.ajax({
				url: target,
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					
					if( data == true )
						alert('${smCommMsgSave}');
					else
						alert('에러가 발생하였습니다.');
					
					console.log( "save : " + data );
					
					//fncSearch();
					OriViewStrCd = $('#viewStrCd').val();
					// 매장조회 페이지로 이동 넣어야 함
				},
				error:function(result){
					alert('에러가 발생하였습니다.');
				}				
			});
		}
	}
	else
	{
		alert('필수입력란을 확인하세요.');
	}
		
}

// 취소버튼 - 매장조회 페이지 이동
function func_cancleBtn()
{
	// 매장조회 페이지로 이동 넣어야 함
	if(confirm('취소하시겠습니까?'))
	{	
		var param  = new Object();
		param.mode = "BACK";
		param.scrStrNm = 		'${history.scrStrNm}';
		param.scrDateFrom = 	'${history.scrDateFrom}';
		param.scrDateTo	= 		'${history.scrDateTo}';
		param.scrUseYn 	= 		'${history.scrUseYn}';
		param.scrOrgCd 	= 		'${history.scrOrgCd}';
		param.scrOrgNm 	= 		'${history.scrOrgNm}';
		//var target = '5103';
			
		fncCallPage('4201', param);
	}
}

function viewStrCdChange()
{
	var changeViewStrCd = $('#viewStrCd').val();
	console.log( changeViewStrCd );	
	console.log( OriViewStrCd );
	
	if( OriViewStrCd == changeViewStrCd )
	{
		$('#viewStrCdDupChkBtn').hide();
		$('#dupViewStrCdMsg').html('');
		dupViewStrCdChk = true;
	}
	else
	{	$('#viewStrCdDupChkBtn').show();
		$('#dupViewStrCdMsg').html('');
		dupViewStrCdChk = false;
	}
	
}
</script>

<div id="loadingArea">

	<!-- 매장정보 -->
	<form id="saveForm" name="saveForm" method="post">
	<input type='hidden' id='companyCd' name='companyCd' value='${userVo.companyCd}'/>
	<input type='hidden' id='mode' name='mode' value='${mode}'/>
	
	<!-- 테이블 영역 -->
	<div id="strInfoDiv" class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle top_table">
			<h3>매장정보</h3>
		</div>
		<table>
			<colgroup>
		    	<col width="15%" />
		    	<col width="35%" />
		    	<col width="15%" />
		    	<col width="*" />
	    	</colgroup>
	    	<tbody>
			<tr>
				<th>조직명(코드)</th>
				<td class="tleft">
					<input type='hidden' id='orgCd' name='orgCd' value='${storeMgntDtl.orgCd}'/>
					<div class="r_innerSearch">
						<input type='text' id='orgNm' name='orgNm' value='${storeMgntDtl.orgNm}' style="width:140px;" class="r_Input r_disable" />
						<img src="/images/ico_remove2.png" alt="찾아보기"  onclick="javascript:fncOrgClear();" style="cursor:pointer;top:3px; right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="찾아보기"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
				<th><span class="r_required">*</span>시스템매장코드</th>
				<td class="tleft">
					<input type='text' id='strCd' name='strCd' style="width:100px;" class="r_Input r_disable" value="${storeMgntDtl.strCd}" readonly="readonly"/>					
				</td>
			</tr>
			<tr>
				<th><span class="r_required">*</span>매장코드</th>
				<td class="tleft">
					<input type='text' id='viewStrCd' name='viewStrCd' style="width:100px;" value="${storeMgntDtl.viewStrCd}" onChange="javascript:viewStrCdChange()" maxlength="10" required/>
						  <span class="innerBtn">
					      		<button id="viewStrCdDupChkBtn" onclick="javascript:fncViewStrCdDupChk(); return false;">중복확인</button>
					      </span>					      					
						  <span id='dupViewStrCdMsg'></span>						  
				</td>
				<th><span class="r_required">*</span>매장명</th>
				<td class="tleft">
					<input type='text' id='strNm' name='strNm' value="${storeMgntDtl.strNm}" style="width:145px;" maxlength="30" required/>
				</td>			
			</tr>
			<tr>
				<th>간략주소</th>
				<td class="tleft">
					<input type='text' id='addr' name='addr' value="${storeMgntDtl.addr}" style="width:200px;" maxlength="200"/>
				</td>
				<th>전화번호</th>
				<td class="tleft">
					<input type='text' id='telNo1' name='telNo1' value="${storeMgntDtl.telNo1}" style="width:60px;" maxlength="4"/>					
					<input type='text' id='telNo2' name='telNo2' value="${storeMgntDtl.telNo2}" style="width:60px;" maxlength="4"/>
					<input type='text' id='telNo3' name='telNo3' value="${storeMgntDtl.telNo3}" style="width:60px;" maxlength="4"/>					 
				</td>							
			</tr>
			<tr>
				<th><span class="r_required">*</span>계약전력</th>
				<td class="tleft">
					<input type='hidden' id='oldContDemandPower' name='oldContDemandPower' value="${storeMgntDtl.oldContDemandPower}" />
					<input type='text' id='contDemandPower' name='contDemandPower' value="${storeMgntDtl.contDemandPower}" onkeyUp="" style="width:145px;text-align:right" value="0" maxlength="6"/> W
				</td>
				<th><span class="r_required">*</span>매장크기</th>
				<td class="tleft">
					<input type='text' id='strAreaSpec' name='strAreaSpec' value="${storeMgntDtl.strAreaSpec}" style="width:70px;text-align:right" value="0" maxlength="5"/> ㎡
				</td>							
			</tr>
			<tr>
				<th><span class="r_required">*</span>기상지역</th>
				<td class="tleft">
					<input type='hidden' id='localAreaCd' name='localAreaCd' value="${storeMgntDtl.localAreaCd}" style="width:30px;" required/>
					<div class="r_innerSearch">
						<input type='text' id='localAreaNm' name='localAreaNm' value="${storeMgntDtl.localAreaNm}" class="r_Input r_disable" style="width:200px;"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncAreaClear();" style="cursor:pointer; top:3px; right:4px;"/>						
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncAreaSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
				<th><span class="r_required">*</span>사용여부</th>
				<td class="tleft">
					<span class="r_radio">
				   		<input type='radio' name='useYn_radio' id='useYn_radioY' value='Y' checked /><label for="useYn_radioY">사용</label>&nbsp;
				    	<input type='radio' name='useYn_radio' id='useYn_radioN' value='N'/><label for="useYn_radioN">미사용</label>
					</span>					
				</td>							
			</tr>			
			<tr>
				<th>램스 시작일자</th>
				<td class="tleft">
					<input type='text' id='remsStartDt' name='remsStartDt' value="${storeMgntDtl.remsStartDt}" style="width:100px;" required readonly/>
				</td>
				<th>램스 종료일자</th>
				<td class="tleft">
					<input type='text' id='remsEndDt' name='remsEndDt' value="${storeMgntDtl.remsEndDt}" style="width:100px;"  readonly/>	
				</td>							
			</tr>			
			<tr id="entInfoDiv">
				<th><span class="r_required">*</span>설치 전기업체</th>
				<td colspan="3" class="tleft">
					<select id="electricEntCd" name="electricEntCd" style="width:130px;" class="tblSelect">
						<option value=''>--선택--</option>
						<c:forEach var="vo" items="${electricEntCd}" varStatus="status" >
							<option value='${vo.value}' <c:if test="${userMgntDtl.vendorCd == vo.value}">selected</c:if> >${vo.name}</option>
						</c:forEach>
					</select>					
				</td>							
			</tr>
			</tbody>
		</table>
	</div>	
	<!-- //테이블 영역 -->
	
	<!-- GW정보 -->
	<!-- 테이블 영역 -->
	<div id="gwInfoDiv" class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>GW정보</h3>
		</div>
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
					<input type='number' id='gwId' name='gwId' value="" style="width:145px;" maxlength="10" required/>
					<span class="innerBtn">
						<button onclick="javascript:fncGwIdDupChk(); return false;">중복확인</button>
     				</span>					
     				<span id='dupGwMsg'></span>
				</td>
				<th>MAC Address</th>
				<td class="tleft">
					<input type='text' id='gwAddr' name='gwAddr' value="000000000000"  style="width:145px;" maxlength="12" readonly />
				</td>		
			</tr>
			<tr>
				<th><span class="r_required">*</span>인증여부</th>
				<td class="tleft">
					<input id="authYn_radioY" name="authYn_radio" type="radio" value="Y"/><label for="authYn_radioY">인증</label>
					<input id="authYn_radioN" name="authYn_radio" type="radio" value="N" checked /><label for="authYn_radioN">미인증</label>
				</td>
				<th><span class="r_required">*</span>사용여부</th>
				<td class="tleft">
					<input id="gwUseYn_radioY" name="gwUseYn_radio" type="radio" value="Y" checked /><label for="gwUseYn_radioY">사용</label>
					<input id="gwUseYn_radioN" name="gwUseYn_radio" type="radio" value="N" /><label for="gwUseYn_radioN">미사용</label>
				</td>							
			</tr>	
			</tbody>	
		</table>		
	</div>
	<!-- //테이블 영역 -->
	
	<!-- 램스장비정보 -->
	<!-- 테이블 영역 -->
	<div id="remsDeviceInfoDiv" class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>램스장비정보</h3>
		</div>
		<table>
			<colgroup>
		    	<col width="15%" />
		    	<col width="" />
		    	<col width="15%" />
		    	<col width="" />
		    	<col width="15%" />
		    	<col width="" />
	    	</colgroup>
	    	<tbody>
			<tr>
				<th><span class="r_required">*</span>미터수집여부</th>
				<td colspan="5" class="tleft">
					<input id="meterYn_radioY" name="meterYn_radio" type="radio" value="Y" checked /><label for="meterYn_radioY">사용</label>
					<input id="meterYn_radioN" name="meterYn_radio" type="radio" value="N" /><label for="meterYn_radioN">미사용</label>
				</td>			
			</tr>
			<tr id="meterYnDiv">
				<th>메인미터</th>
				<td class="tleft">
					<select id="mainMeterNum" name="mainMeterNum">
						<option value="0">0</option>
						<option value="1">1</option>						
					</select>
					개					
				</td>
				<!-- 
				<th>예외미터</th>
				<td class="tleft">
					<select id="excldMeterNum" name="excldMeterNum">
						<option value="0">0</option>
						<option value="1">1</option>						
					</select>
				</td>
				 -->
				<th>냉난방미터</th>
				<td class="tleft">	
					<select id="tempMeterNum" name="tempMeterNum">
						<option value="0">0</option>
						<option value="1">1</option>						
						<option value="2">2</option>
					</select>
				</td>	
				<th>간판</th>
				<td colspan="5" class="tleft">
					<select id="signNum" name="signNum">
						<option value="0">0</option>
						<option value="1">1</option>						
					</select>
					개					
				</td>							
			</tr>	
			<tr>
				<th>하콘</th>
				<td class="tleft">
					<select id="haconNum" name="haconNum">
						<option value="0">0</option>
						<option value="1">1</option>						
						<option value="2">2</option>
					</select>
					개					
				</td>
				<th>T-센서</th>
				<td class="tleft">
					<select id="tSensorNum" name="tSensorNum">
						<option value="0">0</option>
						<option value="1">1</option>						
					</select>
				</td>
				<th>테몬</th>
				<td class="tleft">	
					<select id="temonNum" name="temonNum">
						<option value="0">0</option>
						<option value="1">1</option>
						<!-- <option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						 -->				
					</select>
					개
				</td>							
			</tr>		
			<tr>
				<th>지그비</th>
				<td class="tleft">
					<select id="zigbeeNum" name="zigbeeNum">
						<option value="0">0</option>
						<option value="1">1</option>						
						<!-- <option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						 -->
					</select>
					개			
				</td>
				<th>Almon</th>
				<td class="tleft">
					<select id="almonNum" name="almonNum">
						<option value="0">0</option>
						<option value="1">1</option>						
						<!-- <option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						 -->
					</select>
					개
				</td>
				<th>INV</th>
				<td class="tleft">	
					<select id="invNum" name="invNum">
						<option value="0">0</option>
						<option value="1">1</option>						
					</select>
					개
				</td>							
			</tr>	
			</tbody>	
		</table>
	</div>
	<!-- //테이블 영역 -->
	
	</form>
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal">
	   		<button onclick="javascript:func_cancleBtn();">취소</button>
	   	</span>	
	   	<span class="pageNormal">
	   		<button onclick="javascript:func_saveBtn();">저장</button>
	   	</span>	&nbsp;
	</div>
	<!-- //하단 버튼 그룹 -->
	
</div>