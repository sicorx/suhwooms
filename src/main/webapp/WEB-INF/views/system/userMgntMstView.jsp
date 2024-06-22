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
var oldUserId = "";
var rowIdx = 0;

var dupChk = false;

/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){


    $("#gridUserMgnt").setGridWidth($("#cont").width());


}).resize();


$(document).ready(function(){
	
	//makeAuthSpDiv();
	
	//$('input:radio[name="scrAuthSp"]').eq(0).attr('checked', true);
	
	$('input:radio[name="scrUseYn"]').eq(0).attr('checked', true);	
	  $("#gridUserMgnt").jqGrid({
	      url:'retrieveUserMgnt',
	      datatype: "json",
	      mtype: 'POST',
	      colNames:['No', '사용자ID', '사용자명', '권한구분', '사용자 권한', '조직', '매장명', '업체명', '사용자동의','사용여부', 'strCd','vendorCd','companyCd', 'companyNm', 'authId', 'authSp', 'userPw'],
	      colModel:[
	                {name:'records',	index:'records',	width:10,	align:'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},	                  
	                {name:'userId',		index:'userId', 	width:50, 	align:'center', sortable:true, editable:false},
	                {name:'userNm',		index:'userNm', 	width:50,	align:'left', sortable:true, editable:false},
	                {name:'commCdNm',	index:'commCdNm', 	width:50, 	align:'center', sortable:true, editable:false},	                
	                {name:'authNm',		index:'authNm', 	width:50, 	align:'center', sortable:true, editable:false},
	                {name:'orgFullNm',	index:'orgFullNm', 	width:50, 	align:'left', sortable:true, editable:false},
	                {name:'strNm',		index:'strNm', 		width:50, 	align:'left', sortable:true, editable:false},
	                {name:'vendorNm',	index:'vendorNm', 	width:50, 	align:'left', sortable:true, editable:false},
	                {name:'eulaYn',		index:'eulaYn', 	width:30, 	align:'center', sortable:true, editable:false},
	                {name:'useYn',		index:'useYn', 		width:30, 	align:'center', sortable:true, editable:false},
	                {name:'strCd',		index:'strCd', 		hidden:true},
	                {name:'vendorCd',	index:'vendorCd', 	hidden:true},
	                {name:'companyCd',	index:'companyCd', 	hidden:true},
	                {name:'companyNm',	index:'companyNm', 	hidden:true},
	                {name:'authId',		index:'authId', 	hidden:true},
	                {name:'authSp',		index:'authSp', 	hidden:true},
	                {name:'userPw',		index:'userPw', 	hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
		 rowList:[10,20,50,100],
	     pager: '#gridUserMgntPager',
	     sortname: 'userNm',
	     recordtext: "{1} 건/페이지  (전체 {2} 건)",
		 emptyrecords : "검색 결과가 존재하지 않습니다.",
	     loadtext: "Loading...",
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 //width:'100%', 
		 height : 360,
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrUserId:$("#scrUserId").val(),
			 scrUserNm:$("#scrUserNm").val(),
			 scrUseYn: $(':radio[name="scrUseYn"]:checked').val(),
			 //scrAuthSp: $(':radio[name="scrAuthSp"]:checked').val()
			 scrAuthSp: $('#scrAuthSp').val()
		 },
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 var list = $("#gridUserMgnt").getRowData(rowid);
			 
			 fncSel(list);
			 
			 //valueChange(list);
			 
		 },
		gridComplete : function()
		{
			jqGridEven('gridUserMgnt');			 
			var rsltCount = $("#gridUserMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridUserMgnt >tbody").append("<tr><td align='center' colspan='10'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		 
	 });
	  //jqGrid Resize	
	 jqGridResize('gridUserMgnt');
	  
	
	 $('#authDiv').attr('colspan','3');
	 $('#useYnDiv').attr('colspan','3');
	 
	 $('#subAuthSelect1_1').hide();	$('#subAuthSelect1_2').hide();	  
	  
	 $('#subAuthSelect2_1').hide();	$('#subAuthSelect2_2').hide();
	
	 $('#subAuthSelect3_1').hide();	$('#subAuthSelect3_2').hide();
	  
	
	  // authSp radio change 이벤트
	  $("#authSp").change(function() {
		  valueChange();		  
		  //$('#userId').attr("readonly", "true");	// 유저아이디 text 리드온니 ON		  	
		  //$('#userIdBtn').attr("disabled","true");	// 유저아이디 중복 체크 버튼 미사용		  
	  });
	  
	  
	// 기상지역 입력 Enter 시 수행
	$("#scrUserId").keyup(function(event){			
		if(event.which == 13)		// Enter Key Press
		{		
			fncSearch();			// 사용자 조회				
		}
	});
	
	// 조직명(조회용) 엔터 및 focusout
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
	
	// 조직명(저장용) 엔터 및 focusout
	$("input[name='OrgNm']").on({
		keyup: function() {
			$("input[name='OrgCd']").val("");
		},
		keydown: function(key) {
			if (key.keyCode == 13) {
				$(this).blur();
	        }
		},
		blur: function() {
			var OrgNm = $.trim($(this).val());
			var OrgCd = $.trim($("input[name='OrgCd']").val());
			
			// 검색어는 빈값이 아니면서 검색된 orgCd는 빈값일때만 검색
			if (OrgNm != "" && OrgCd == "") {
				fncModifyOrgCd();
			}
		}
	});
});

/*******************
1. 기타 필수 스크립트
********************/
function fnValidate(){
	var rtn = true;
	var userId = $("#userId").val();
	var userNm = $("#userNm").val();
	var userPw = $("#userPw").val();
	var authSp = $("#authSp").val();
	//var OrgNm = $("#OrgNm").val();
	var eulaYn = $("input:radio[name='eulaYn']:checked").val();
	var useYn = $("input:radio[name='useYn']:checked").val();
	var strNm = $("#strNm").val();
	var vendorCd = $("#vendorCd").val();
	
	if( userId == ""){
		$("#userId").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#userId").data("title", "").removeClass("error").tooltip("destroy");
	}
	if( userNm == ""){
		$("#userNm").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#userNm").data("title", "").removeClass("error").tooltip("destroy");
	}
	if( userPw == ""){
		$("#userPw").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#userPw").data("title", "").removeClass("error").tooltip("destroy");
	}
	if( authSp == ""){
		$("#authSp").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#authSp").data("title", "").removeClass("error").tooltip("destroy");
	}
	/*if( $('#subAuthSelect3_1').css("display") != "none" && OrgNm == ""){
		$("#OrgNm").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#OrgNm").data("title", "").removeClass("error").tooltip("destroy");
	}*/
	if( eulaYn == ""){
		$("#eulaYn").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#eulaYn").data("title", "").removeClass("error").tooltip("destroy");
	}
	if( useYn == ""){
		$("#useYn").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#useYn").data("title", "").removeClass("error").tooltip("destroy");
	}
	if( $('#subAuthSelect1_1').css("display") != "none" && strNm == ""){
		$("#strNm").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#strNm").data("title", "").removeClass("error").tooltip("destroy");
	}
	if( $('#subAuthSelect2_1').css("display") != "none" && (vendorCd == "" || vendorCd == null)){
		$("#vendorCd").tooltip("destroy").data("title", "반드시 입력해야 합니다.").addClass("error").tooltip();
		rtn = false;
	}else{
		$("#vendorCd").data("title", "").removeClass("error").tooltip("destroy");
	}
	
	return rtn;
}

function valueChange(list)
{
	var authSp = $('#authSp').val();				// 권한구분				
	var authListJson = JSON.parse('${authList}');				// 사용자 권한 리스트
	var vendorCdListJson = JSON.parse('${vendorCdList}');		// 유지보수 업체 리스트
	var electricEntListJson = JSON.parse('${electricEntList}');	// 전기업체 업체 리스트	

	//console.log( authSp );		
	//console.log( authListJson );
	//console.log( vendorCdListJson );
	
	$('#authDiv').attr('colspan','3');
	$('#useYnDiv').attr('colspan','3');
	 
	$('#subAuthSelect2_1').hide();	$('#subAuthSelect2_2').hide();		// 매장명(코드) 숨기기
	$('#subAuthSelect1_1').hide();	$('#subAuthSelect1_2').hide();		// 유지보수 업체명 숨기기
	$('#subAuthSelect3_1').hide();	$('#subAuthSelect3_2').hide();		// 조직명(코드) 숨기기
	
	
	// 사용자 권한 셋팅
	$('#authId').empty();
	for(var i=0; i<authListJson.length; i++)
	{
		if( authSp == authListJson[i].authSp )
		{									
			$('#authId').append( "<option value='"+authListJson[i].authId+"' >"+ authListJson[i].authNm+"</option>" );
		}
	}		
	
	// 유지보수 업체명 셋팅
	$('#vendorCd').empty();
	if( authSp == "M")	// 유지보수
	{
		$('#authDiv').attr('colspan','1');
		$('#useYnDiv').attr('colspan','3');
		// 매장명(코드) hide		
		$('#subAuthSelect1_1').hide();	$('#subAuthSelect1_2').hide();
		// 업체명 show
		$('#subAuthSelect2_1').show();	$('#subAuthSelect2_2').show();
		
		for(var i=0; i<vendorCdListJson.length; i++)
		{					
			$('#vendorCd').append( "<option value='"+vendorCdListJson[i].value+"' >"+ vendorCdListJson[i].name+"</option>" );	
		}
	}
	
	if( authSp == "T")	// 전기업체
	{
		$('#authDiv').attr('colspan','1');
		$('#useYnDiv').attr('colspan','3');
		// 매장명(코드) hide
		$('#subAuthSelect1_1').hide();	$('#subAuthSelect1_2').hide();
		// 업체명 showc
		$('#subAuthSelect2_1').show();	$('#subAuthSelect2_2').show();
		
		for(var i=0; i<electricEntListJson.length; i++)
		{					
			$('#vendorCd').append( "<option value='"+electricEntListJson[i].value+"' >"+ electricEntListJson[i].name+"</option>" );	
		}
	}
	
	if( authSp =="S")	// 매장사용자
	{
		$('#authDiv').attr('colspan','1');
		$('#useYnDiv').attr('colspan','3');
		// 매장명(코드) hide
		$('#subAuthSelect1_1').show();	$('#subAuthSelect1_2').show();
		// 업체명 show
		$('#subAuthSelect2_1').hide();	$('#subAuthSelect2_2').hide();
	}
	
	if( authSp =="H")	// 본사직원
	{
		$('#authDiv').attr('colspan','31');
		$('#useYnDiv').attr('colspan','1');
		// 조직명(코드) hide
		$('#subAuthSelect3_1').show();	$('#subAuthSelect3_2').show();
		
	}
	
	if( list != null)
	{
		var vendorCd = 	$.trim(list.vendorCd);
 		$('#vendorCd').val( vendorCd );
	}
	
}


/*******************
1. 팝업  
********************/

function fncStoreSearch(){
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#strNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;
	
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );
}


function fncSetStore(data){
	$("#strCd").val(data.strCd);
	$("#strNm").val(data.strNm);
	
}

function fncStoreClear(){
	$("#strCd").val("");
	$("#strNm").val("");
}


/*******************
1. 조직 팝업(검색용)
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
				fncOrgSearch('sch');
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
		fncOrgSearch('sch');
	} else {
		$("input[name='scrOrgNm']").blur();
	}
}

// 조직 팝업
function fncOrgSearch(mode) {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = "";
	if (mode == "sch") {
		orgNm = $.trim($("#scrOrgNm").val());
	} else if (mode == "mod") {
		orgNm = $.trim($("#OrgNm").val());
	}
	$("#popupMode").val(mode);
	
	var args = new Object();
	args.companyCd = companyCd;
	args.orgNm = orgNm;
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
}

function fncSetOrg(data){	
	var mode = $.trim($("#popupMode").val());
	if (mode == "sch") {
		$("#scrOrgCd").val(data.orgCd)
		$("#scrOrgNm").val(data.orgNm + "(" + data.orgCd + ")");
	} else if (mode == "mod") {
		$("#OrgCd").val(data.orgCd)
		$("#OrgNm").val(data.orgNm + "(" + data.orgCd + ")");
	}
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}

/*******************
1. 조직 팝업(저장용)
********************/
//조직명 검색
function fncModifyOrgCd() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#OrgNm").val());
	
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
			$("input[name='OrgCd']").val("");
			var orgCnt = data.orgCnt;
			// 0개 일때
			if (orgCnt == "0") {
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (orgCnt == "1") {
				$("#OrgCd").val(data.orgCd)
				$("#OrgNm").val(data.orgNm + "(" + data.orgCd + ")");
			// 2개 이상일때	
			} else {
				// 조직 팝업
				fncOrgSearch('mod');
			}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}

// 조직 검색 버튼
function fncOrgModifyBtn() {
	var orgNm = $.trim($("#OrgNm").val());
	if (orgNm == "") {
		// 조직 팝업
		fncOrgSearch('mod');
	} else {
		$("input[name='OrgNm']").blur();
	}
}

function fncOrgModifyClear(){
	$("#OrgCd").val("");
	$("#OrgNm").val("");
}

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
		
	if( $("#scrOrgNm").val() == "" || $("#scrOrgNm").val() == null ) {
		$("#scrOrgCd").val('');
	}
	
	//console.log( companyCd );
		
	$("#gridUserMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrUserId:$("#scrUserId").val(),
			 scrUserNm:$("#scrUserNm").val(),			 
			 scrUseYn: $('input:radio[name="scrUseYn"]:checked').val(),
			 //scrAuthSp : $(':radio[name="scrAuthSp"]:checked').val()
			 scrAuthSp : $('#scrAuthSp').val()
		 }
	}).trigger("reloadGrid");
	
	$("#gridUserMgnt").setGridParam({"page":1});		// 1페이지로 이동
}

// 신규 버튼
function fncAdd() {	 
	
	$('#userId').removeAttr("readonly");		// 유저아이디 text 리드온니 해제
	//$('#userIdBtn').attr("disabled","false");						// 유저아이디 중복 체크 버튼 show
	$(".innerBtn").show();
	
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
	
	$('#userId').val( "" );
 	$('#userNm').val( "" );
 	$('#userPw').val( "" );
 	$('#authSp option:eq(0)').prop("selected", true);
 	valueChange();
 	//$("input:radio[name='authId']:input[value='" + "1" + "']").prop("checked", true); 	 	
 	$('#orgNm').val( "" );
 	$('#strNm').val( "" );
 	$("input:radio[name='eulaYn']:input[value='" + "N" + "']").prop("checked", true);
 	$("input:radio[name='useYn']:input[value='" + "Y" + "']").prop("checked", true);
 	
 	
}


// 저장(수정) 버튼
function fncUpt()
{	
	if( dupChk == false )
	{
		alert('사용자ID 중복을 확인하세요.');
		return;
	}
	
	if(fnValidate())
	{
		var authSp = $("#authSp").val();
		var OrgCd = $("#OrgCd").val();
		if(authSp == "H" && (OrgCd == "" || OrgCd == null)){
			if(confirm("조직명(코드)를 입력하시겠습니까?)")){
				// 조직 팝업
				fncOrgSearch('mod');
			}else{
				if(confirm('${smCommMsgSaveCnf}'))
				{
					var target = '/saveUserMgnt';
					
					var companyCd = $('#companyCd').val();
					var userId = $("#userId").val();
					var userNm = $("#userNm").val();
					var userPw = $("#userPw").val();
					var authId = $("#authId").val();
					var OrgNm = $("#OrgNm").val();
					var eulaYn = $("input:radio[name='eulaYn']:checked").val();
					var useYn = $("input:radio[name='useYn']:checked").val();
					var strNm = $("#strNm").val();
					var strCd = $("#strCd").val();
					var vendorCd = $("#vendorCd").val();
					
					$.ajax({
						url: target,
						type:'POST',
						cache:false,
						data:{
							companyCd:companyCd,
							userId:userId,
							userNm:userNm,
							userPw:userPw,
							authSp:authSp,
							authId:authId,
							strCd:strCd,
							strNm:strNm,
							vendorCd:vendorCd,
							eulaYn:eulaYn,
							useYn:useYn,
							OrgCd:OrgCd,
							OrgNm:OrgNm
						},
						dataType:'json',
						success:function(data){
							alert('${smCommMsgSave}');
							
							fncAdd();		// 클리어
							fncSearch();	// 다시 매장 조회	 
							
							// 매장조회 페이지로 이동 넣어야 함
						},
						error:function(result){
							alert('에러가 발생하였습니다.');
						}				
					});
				}
			}
		}else{
			if(confirm('${smCommMsgSaveCnf}'))
			{
				var target = '/saveUserMgnt';
				
				var companyCd = $('#companyCd').val();
				var userId = $("#userId").val();
				var userNm = $("#userNm").val();
				var userPw = $("#userPw").val();
				var authSp = $("#authSp").val();
				var authId = $("#authId").val();
				var OrgNm = $("#OrgNm").val();
				var eulaYn = $("input:radio[name='eulaYn']:checked").val();
				var useYn = $("input:radio[name='useYn']:checked").val();
				var strNm = $("#strNm").val();
				var strCd = $("#strCd").val();
				var vendorCd = $("#vendorCd").val();
				
				$.ajax({
					url: target,
					type:'POST',
					cache:false,
					data:{
						companyCd:companyCd,
						userId:userId,
						userNm:userNm,
						userPw:userPw,
						authSp:authSp,
						authId:authId,
						strCd:strCd,
						strNm:strNm,
						vendorCd:vendorCd,
						eulaYn:eulaYn,
						useYn:useYn,
						OrgCd:OrgCd,
						OrgNm:OrgNm
					},
					dataType:'json',
					success:function(data){
						alert('${smCommMsgSave}');
						
						fncAdd();		// 클리어
						fncSearch();	// 다시 매장 조회	 
						
						// 매장조회 페이지로 이동 넣어야 함
					},
					error:function(result){
						alert('에러가 발생하였습니다.');
					}				
				});
			}
		}
	}
}

// 리스트 선택
function fncSel(list) {
	
	//alert( $('#scrCompanyCd').val() );
	var companyCd = $.trim(list.companyCd);
	var companyNm = $.trim($("#scrCompanyNm").val());
	
	//alert( companyCd );
	//alert( companyNm );
	
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
 	
 	var userId = 	$.trim(list.userId);
 	$('#userId').val( userId ).attr("readonly", true);
 	
 	var userNm =	$.trim(list.userNm);
 	$('#userNm').val( userNm );
 	
 	var userPw = 	$.trim(list.userPw);
 	$('#userPw').val( userPw );
 	
 	var authSp = 	$.trim(list.authSp);
 	$('#authSp').val( authSp ).attr("selected", "selected");
 	$('#authSp').trigger("change");
 	valueChange(list);
 	
 	var commCdNm = 	$.trim(list.commCdNm);
 	var authId = 	$.trim(list.authId);
 	$('#authId').val( authId ).attr('selected', 'selected');
 	
 	var orgCd = 	$.trim(list.orgCd);	
 	var orgNm = 	$.trim(list.orgNm); 	
 	$('#orgNm').val( orgNm );
 	
 	var vendorCd = 	$.trim(list.vendorCd);
 	//$('#vendorCd').val( vendorCd );
 	//$('#vendorNm').val( vendorCd );
 	
 	var vendorNm = 	$.trim(list.vendorNm);
 	
 	
 	var vendorCd = 	$.trim(list.vendorCd);
 	
 	
 	var strNm = 	$.trim(list.strNm);
 	$('#strNm').val( strNm );
 	
 	var strCd = 	$.trim(list.strCd);
 	$('#strCd').val( strCd );
 	
 	var eulaYn = 	$.trim(list.eulaYn);
 	
 	var eulaYn = $.trim(list.eulaYn);
 	$("input:radio[name='eulaYn']:input[value='" + eulaYn + "']").prop("checked", true);
 	
 	var useYn = $.trim(list.useYn);
 	$("input:radio[name='useYn']:input[value='" + useYn + "']").prop("checked", true);
 	
}

// 사용자 삭제 버튼
function fncDel() {
	
	var userId = $('#userId').val();			// 사용자 아이디
	var companyCd = $("#companyCd").val();		// 회사코드
	
	if(confirm('삭제하시겠습니까?'))
	{	
		var target = '/deleteUserMgnt';
		
		$.ajax({
			url: target,
			type:'POST',
			cache:false,
			data: {userId:userId, companyCd:companyCd},
			dataType:'json',
			success:function(data){
				alert('삭제되었습니다.');				
				fncAdd();		// 클리어
				fncSearch();	// 다시 매장 조회				
			},
			error:function(result){
				alert('에러가 발생하였습니다.');
			}				
		});
		
	}
}


//중복확인
function fncUserIdDupChk(){
	var id = $("#userId").val();
	
	if(id != ""){
		oldUserId = vendorCd;
		
		var companyCd = $('#companyCd').val();
		var userId = $('#userId').val();
		
		$.ajax({
			url:'/checkUserId',
			type:'POST',
			cache:false,
			data : {companyCd:companyCd,userId:userId},
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

function fncUserIdChange()
{
	dupChk = false;
	$('#dupMsg').html('');
}

</script>
<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd"> 
	<input type="hidden" id="popArg2" name="companyNm">
	<input type="hidden" id="popArg3" name="userId"> 
</form>
<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>사용자명/ID</th>
				<td>
				 	<c:if test="${selectVoListCnt == 1 }">
						<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
						<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
					</c:if>
					<input type='search' id='scrUserId' name='scrUserId' value='' style="width:118px;" placeholder="전체" />				
				</td>
				<th></th>
				<td></td>
				<th>${smUseYn}</th>
				<td>
					<span class="r_radio">
						<input type='radio' id='scrUseYn1' name='scrUseYn' value='Y' /> <label for="scrUseYn1">사용</label>&nbsp;
						<input type='radio' id='scrUseYn2' name='scrUseYn' value='N' /> <label for="scrUseYn2">미사용</label>
					</span>
				</td>
			</tr>
			<tr>
				<th>${smOrg}</th>
				<td ><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<input type='hidden' id='popupMode' name='popupMode' value="" /><!-- 팝업창모드(조직용:2군데에서 띄우기에 사용) -->
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  placeholder="전체" style="width:118px;" class="r_Input r_disable" />
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>												
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
				<th></th>	
				<td></td>
				<th>권한구분</th>
				<td>					
					<select id="scrAuthSp" name="scrAuthSp" style="width:130px;" class="tblSelect">
						<option value=''>전체</option>
							<c:forEach var="vo" items="${commCdList}" varStatus="status" >
								<option value='${vo.code}' >${vo.commCdNm}</option>
							</c:forEach>
					</select>					
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<div class="r_grid mt_15" id="cont">
		<table class="gridPointer" id="gridUserMgnt"><tr><td></td></tr></table>
		<div id="gridUserMgntPager"></div>
	</div>
	
	<div class="r_inputTbl r_horizonTbl">
		<input type="hidden" id="companyCd" name="companyCd" value='${userVo.companyCd}'  /><!-- 회사 코드 -->
		<div class="r_gridTitle">
			<h3>상세정보</h3>
		</div>
		<table>
			<colgroup>
				<col width="170" />
				<col width="300" />
				<col width="170" />
				<col width="300" />
				<col width="170" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
	         		<th class="textRight"><span class="r_required">*</span>사용자 ID</th>
	         		<td class="tleft">
						<input type='text' id='userId' name='userId' style="width:100px;" value="" onblur="" onchange="javascript:fncUserIdChange()" maxlength="10" />
						<span class="innerBtn">
							<button id="userIdBtn" onclick="javascript:fncUserIdDupChk(); return false;">${smDupChk}</button>
      					</span>
						<span id='dupMsg'></span>
					</td>
					<th class="textRight"><span class="r_required">*</span>사용자명</th>
	         		<td class="tleft">
						<input type='text' id='userNm' name='userNm' style="width:100px;" maxLength="10"  value="" />
					</td>
					<th class="textRight"><span class="r_required">*</span>패스워드</th>
	         		<td class="tleft">
						<input type='password' id='userPw' name='userPw' style="width:100px;" maxLength="8" value="" />
					</td>					
				</tr>
				<tr>
	         		<th class="textRight"><span class="r_required">*</span>권한구분</th>
	         		<td class="tleft">						
						<select id="authSp" name="authSp" style="width:130px;" class="tblSelect" >
								<option value=''>--선택--</option>								
								<c:forEach var="vo" items="${commCdList}" varStatus="status" >
									<option value='${vo.code}' >${vo.commCdNm}</option>
								</c:forEach>
						</select>					
					</td>
					<th class="textRight"><span class="r_required">*</span>사용자 권한</th>
	         		<td id="authDiv" class="tleft">						
						<select id="authId" name="authId" style="width:130px;" class="tblSelect">								
						</select>					
					</td>
					<th id="subAuthSelect1_1" class="textRight"><span class="r_required">*</span>매장명(코드)</th>
					<td id="subAuthSelect1_2" class="tleft"><input type='hidden' id='strCd' name='strCd' value="" />
						<div class="r_innerSearch">
							<input type='text' id='strNm' name='strNm' value="" maxLength="20"  style="width:140px;" class="r_Input r_disable" readonly="readonly" required/>
							<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncStoreSearch();" style="cursor:pointer"/>
							<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
						</div>
					</td>
					<th id="subAuthSelect2_1" class="textRight"><span class="r_required">*</span>업체명</th>
	         		<td id="subAuthSelect2_2" class="tleft">						
						<select id="vendorCd" name="vendorCd" style="width:130px;" maxLength="10"  class="tblSelect">								
						</select>					
					</td>					
				</tr>			
				<tr>
	         		<th class="textRight"><span class="r_required">*</span>사용자 동의</th>
	         		<td class="tleft">	
						<span class="r_radio">							
							<input type='radio' id='eulaYn1' name='eulaYn' value='Y' /> <label for="eulaYn1">동의</label>&nbsp;
							<input type='radio' id='eulaYn2' name='eulaYn' value='N' checked /> <label for="eulaYn2">미동의</label>&nbsp;
						</span>
					</td>
					<th class="textRight"><span class="r_required">*</span>사용 여부</th>
	         		<td id="useYnDiv" class="tleft">
						<span class="r_radio">							
							<input type='radio' id='useYn1' name='useYn' value='Y' checked /> <label for="useYn1">사용</label>&nbsp;
							<input type='radio' id='useYn2' name='useYn' value='N' /> <label for="useYn2">미사용</label>&nbsp;							
						</span>
					</td>
					<th id="subAuthSelect3_1" class="textRight">조직명(코드)</th>
	         		<td id="subAuthSelect3_2" class="tleft">						
						<input type='hidden' id='OrgCd' name='OrgCd' value="" />
						<div class="r_innerSearch">
							<input type='text' id='OrgNm' name='OrgNm' value=""  style="width:140px;" class="r_Input r_disable" />
							<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgModifyBtn();" class="icon_search" style="cursor:pointer"/>
							<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgModifyClear();" style="cursor:pointer;right:4px;"/>
						</div>						
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal save">
	   		<button onclick="javascript:fncUpt();">${smSave}</button>
		</span>
		<span class="pageNormal">
	   		<button onclick="javascript:fncAdd();">${smNew}</button>
		</span>	&nbsp;
	</div>
</div>