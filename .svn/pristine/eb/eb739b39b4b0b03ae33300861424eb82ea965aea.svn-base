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
<c:set var="smCompany"		><spring:message code="company"/></c:set>
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

// 페이지 사용 - jooyoug

/*******************
1. 선행, 등록 스크립트
********************/
$(function() {
	// 달력
	$("#scrDateFrom, #scrDateTo").datepicker();
});

$(document).ready(function(){	
	
	init();			// 초기 셋팅 
	 	
});

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());

    

}).resize();

function init()
{
	var toDayDate = gfnTodayDate("-");
	// 조회 변수 셋팅
	$('#scrStrNm').val( 		'${scrValue.scrStrNm}' );
	$('#scrOrgNm').val( 		'${scrValue.scrOrgNm}' );
	$('#scrOrgCd').val( 		'${scrValue.scrOrgCd}' );	
	
	if('${scrValue.scrDateFrom}' == "" )
	{	
		// Default Date Setting
		//var DateFrom = gfnDateAdd(toDayDate, 'M', -36, '-');
		//$( "#scrDateFrom" ).datepicker( "setDate",  DateFrom );
		$( "#scrDateFrom" ).datepicker( "setDate",  "2010-01-01" );
		
	}
	else
	{		
		$('#scrDateFrom').val( 		'${scrValue.scrDateFrom}' );
	}
	
	if('${scrValue.scrDateTo}' == "" )
	{	
		$( "#scrDateTo" ).datepicker( 	"setDate",  toDayDate );
	}
	else
	{
		$('#scrDateTo').val( 		'${scrValue.scrDateTo}' );	
	}    

	
	  
	// Grid 출력
	$("#gridStoreMgnt").jqGrid({
		url:'retrieveStoreMgnt',
		datatype: "json",
		mtype: 'POST',
      	postData : {
      		scrCompanyCd:$("#scrCompanyCd").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			scrStrCd:$("#scrStrCd").val(),
			scrStrNm:$("#scrStrNm").val(),
			scrUseYn: 'Y',
			scrDateFrom: $("#scrDateFrom").val(),
			scrDateTo: $("#scrDateTo").val()			 
		},
      	colNames:['No', '매장명', '매장코드', '조직명', '계약전력(kW)', '설치일자', '유지보수업체', '전기업체', '주소', '전화번호', '면적', 'orgCd','localAreaCd','strcd','useYn','vendorCd', 'electricCd' ],
      	colModel:[
                {name:'records',		index:'records',		width:15,	align:'center',	sortable:true,	editable:false,	editoptions : {readonly : true,size : 10} },	                
                {name:'strNm',			index:'strNm', 			width:50, 	align:'left', 	sortable:true, 	editable:false},	                  
                {name:'viewStrCd',		index:'viewStrCd', 		width:40, 	align:'center', sortable:true, 	editable:false},
                {name:'orgFullNm',		index:'orgFullNm', 			width:50, 	align:'left', 	sortable:true, 	editable:false},
                {name:'contDemandPower',index:'contDemandPower',width:40, 	align:'center', 	sortable:true, 	editable:false, formatter:'number', formatoptions:{decimalPlaces:0} },
                {name:'remsStartDt',	index:'remsStartDt', 	width:40, 	align:'center', sortable:true, 	editable:false},	      
                {name:'vendorNm',		index:'vendorNm',		width:50, 	align:'center', sortable:true, 	editable:false},	                
                {name:'electricNm',		index:'electricNm', 	width:50, 	align:'center', sortable:true, 	editable:false},	                
                {name:'addr',			index:'addr', 			width:150, 	align:'left', 	sortable:true, 	editable:false},
                {name:'telNo',			index:'telNo', 			width:80, 	align:'center', sortable:true, 	editable:false},
                {name:'strAreaSpec',	index:'strAreaSpec', 	width:80, 	align:'center', sortable:true, 	editable:false},	                
                {name:'orgCd',			index:'orgCd', 			hidden:true},
                {name:'localAreaCd',	index:'localAreaCd', 	hidden:true},
                {name:'strCd',			index:'strCd', 			hidden:true},
                {name:'useYn',			index:'useYn', 			hidden:true},
                {name:'vendorCd',		index:'vendorCd', 		hidden:true},
                {name:'electricCd',		index:'electricCd', 	hidden:true}
                
		],
     	jsonReader : {
			repeatitems:false
     	},
     	formatter : {
	  		number : {
				decimalSeparator: ".",
				thousandsSeparator: ",", 
				decimalPlaces: 0,
				defaultValue: '0'
			}
		},
    	rowNum:20,
    	rowList:[10,20,50,100],
    	pager: '#gridStoreMgntPager',
    	recordtext: "건/페이지  (전체 {2} 건)",
    	emptyrecords : "검색 결과가 존재하지 않습니다.",
    	loadtext: "Loading...",
    	sortname: 'strNm',
     	viewrecords: true,
     	sortorder: "asc",	     
     	hidegrid: false,
     	shrinkToFit:true,
	 	autowidth:true,
	 	height : 360,		 
	 	onClickRow : function(rowid, iRow, iCol, e ) {		 
	 	},		
	 	ondblClickRow : function(rowid, iRow, iCol, e) {
			
			var list = $("#gridStoreMgnt").getRowData(rowid);	
			var param  = new Object();
			param.strCd	= list.strCd;	
			
			fn_divPop("dashBoardPop", "매장정보", 1000, 700, param);		// 대시보드 팝업
			
		},
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='11'>검색 결과가 없습니다.</td></tr>");
			}	
		}		
	 });
	  //jqGrid Resize	
	  jqGridResize('gridStoreMgnt');	 
	  
	  
	  
	  
	// 매장명/코드 입력 Enter 시 수행
	$("#scrStrNm").keyup(function(event){	
		
		if(event.which == 13)		// Enter Key Press
		{		
			fncSearch();		// 사용자 조회				
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
}


//달력 기간 버튼
function fncMonthBtn(val)
{
	var DateTo = $( "#scrDateTo" ).val();
	var DateFrom = gfnDateAdd(DateTo, 'M', (val*-1), '-');
	$( "#scrDateFrom" ).datepicker( "setDate",  DateFrom );
}

//전체 
function funAllBtn(){
	var toDayDate = gfnTodayDate("-");

	$( "#scrDateFrom" ).datepicker( "setDate",  "2010-01-01" );
	$( "#scrDateTo" ).datepicker( "setDate", toDayDate );
}

// 조회 버튼
function fncSearch() {
	
	var companyCd = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	if( $("#scrOrgNm").val() == "" || $("#scrOrgNm").val() == null ) {
		$("#scrOrgCd").val('');
	}
	
	if($("#scrDateFrom").val() > $("#scrDateTo").val()){
		alert("설치일자를 확인해주세요.");
		return false;
	}
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrStrCd:$("#scrStrCd").val(),
			 scrStrNm:$("#scrStrNm").val(),
			 scrUseYn: $(':radio[name="search_radio"]:checked').val(),
			 scrDateFrom: $("#scrDateFrom").val(),
			 scrDateTo: $("#scrDateTo").val()
		 }
	 }).trigger("reloadGrid");
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

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrStrCd = $("#scrStrCd").val();
	var scrStrNm = $("#scrStrNm").val();
	var scrUseYn = 'Y';
	var scrDateFrom = $("#scrDateFrom").val();
	var scrDateTo = $("#scrDateTo").val();
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrOrgCd);
	$("#excel3").val(scrStrCd);
	$("#excel4").val(scrStrNm);
	$("#excel5").val(scrUseYn);
	$("#excel6").val(scrDateFrom);
	$("#excel7").val(scrDateTo);
	
	$('#excelDownload').attr("action", "/downloadstoreListExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">
	<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrCompanyCd"> 
	<input type="hidden" id="excel2" name="scrOrgCd"> 
	<input type="hidden" id="excel3" name="scrStrCd"> 
	<input type="hidden" id="excel4" name="scrStrNm"> 
	<input type="hidden" id="excel5" name="scrUseYn"> 
	<input type="hidden" id="excel6" name="scrDateFrom"> 
	<input type="hidden" id="excel7" name="scrDateTo"> 
</form>
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
				 	<input type='search' id='scrStrNm' name='scrStrNm' value='' placeholder="전체" style="width:112px;" />
				</td>
				<th>조직명/코드</th>
				<td>
					<input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value="" placeholder="전체" style="width:118px;" class="r_Input r_disable" />						
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>			
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>	 	
				</td>
				<th>설치일자</th>
				<td>
				
					<input id="scrDateFrom" type="text" placeholder="2017-01-11" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
					~ <input id="scrDateTo" type="text" placeholder="2017-01-11" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
					<button onclick="javascript:funAllBtn();">전체</button>
			   		<button onclick="javascript:fncMonthBtn(1);">1m</button>
			   		<button onclick="javascript:fncMonthBtn(6);">6m</button>
			   		<button onclick="javascript:fncMonthBtn(12);">1y</button>
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
			<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
			
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