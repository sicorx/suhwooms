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
<c:set var="smUser"><spring:message code="user"/></c:set>
<c:set var="smUserId"><spring:message code="userId" /></c:set>
<c:set var="smUserNm"><spring:message code="userNm" /></c:set>
<c:set var="smAuth"><spring:message code="auth" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smUserInfo"><spring:message code="userInfo" /></c:set>
<c:set var="smMultStrList"><spring:message code="multStrList" /></c:set>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<c:set var="smUserSrch"><spring:message code="userSrch"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smInqry"><spring:message code="inqry"/></c:set>
<style>
.chk1 {
	background: #92D050;
}

.chk2 {
	background: #FFC000;
}
</style>
<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/
var rowIdx = 0;

/*******************
1. 선행, 등록 스크립트
********************/

var selTab;

$(document).ready(function(){
	
	//탭
	$('.tab_tab').click(function(e) {
		  e.preventDefault();
		  if (selTab) $("#" + selTab).attr("style", "display:none;");
		  $(this).tab('show');
	
	  }).on('shown', function(e) {
		  var id = $(this).attr('id');
		  var selId = id.substring(0, id.length - "_tab".length);
		  $("#" + selId).attr("style", "display:block;");
		  selTab = selId;
	  });
	
	  //사용자 정보
	  $("#gridUserList").jqGrid({
	      url:'multOperUserList',
	      datatype: "json",
	      postData : {
			 scrCompanyCd:$.trim($("#scrCompanyCd").val()),
			 scrUserNm:$.trim($("#scrUserNm").val()),
			 scrStrNm:$.trim($("#scrStrNm").val()),
			 scrAreaNm:$.trim($("#scrAreaNm").val())
		  },
	      mtype: 'POST',
	      colNames:['No', '${smUserId}', '${smUserNm}', '소유매장수'],
	      colModel:[
	    	  		{name:'records',index : 'records',width : 50,align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
	                {name:'userId',index:'userId', width:200, align:'center', sortable:true, editable:false},
	                {name:'userNm',index:'userNm', width:200, align:'center', sortable:true, editable:false},
	                {name:'strCnt',index:'strCnt', width:200, align:'center', sortable:true, editable:false}	               
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
		 rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridUserListPager',
	     recordtext: "건/페이지  (전체 {2} 건)",
		 emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'userNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 360,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridUserList").getRowData(rowid);
			var userId = $.trim(list.userId);
			
			// 소유매장 검색
			fncStrMapSearch(userId);
		 },
	     loadComplete : function(data) {
	    	// 소유매장 초기화
	    	fncStrMapInit()
		 }
	  });
	  jqGridResize('gridUserList');
	  
	 // 소유매장 목록 
	 $("#gridStoreMgnt").jqGrid({
	      url:'multOperRemsStoreMgnt',
	      datatype: "local",
	      mtype: 'POST',
	      colNames:['No', '선택', '${smStrCd}', '${smStrNm}', '주소', '매장코드'],
	      colModel:[
	                {name:'records',index : 'records',width : 50,align : 'center',sortable :false, editable : false,editoptions : {readonly : true,size : 10}},
	                {name:'choice',index :'choice',width : 50,align : 'center',sortable :false, formatter :chboxFormatter1,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	                {name:'viewStrCd',index:'viewStrCd', width:85, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	                {name:'strNm',index:'strNm', width:93, align:'center', sortable:true, editable:false},
	                {name:'addr',index:'addr', width:93, align:'center', sortable:true, editable:false},
	                {name:'strCd',index:'strCd', hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'strNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 400
	 });
	  
	  // 전체매장 목록
	  $("#gridStoreMgntList").jqGrid({
	      url:'operRemsStoreMgnt',
	      datatype: "json",
	      postData : {
	    	  scrCompanyCd:$.trim($("#scrCompanyCd").val()),
			 scrStrCd:$.trim($("#scrStrCd").val()),
			 scrStrKd:$.trim($("#scrStrKd").val())
		  },
	      mtype: 'POST',
	      colNames:['No', '선택', '${smStrCd}', '${smStrNm}', '경영자수', '매장코드', '주소'],
	      colModel:[
	    	  		{name:'records',index : 'records',width : 50,align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
	    	  		{name:'choice',index :'choice',width : 50,align : 'center',sortable :false, formatter :chboxFormatter2,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},
	                {name:'viewStrCd',index:'viewStrCd', width:200, align:'center', sortable:true, editable:false},
	                {name:'strNm',index:'strNm', width:200, align:'center', sortable:true, editable:false},
	                {name:'strCnt',index:'strCnt', width:200, align:'center', sortable:true, editable:false},
	                {name:'strCd',index:'strCd', hidden:true},
	                {name:'addr',index:'addr', hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
		 rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridStoreMgntListPager',
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
		 onSelectRow : function(rowid, iRow, iCol, e) {
			
		 },
	     loadComplete : function(data) {
	    	
		 }
	  });
	  
	  jqGridResize('gridUserList');
	  jqGridResize('gridStoreMgntList');
	
	// 엔터 키 이벤트
	$("input[name='scrUserNm']").keydown(function (key) {
		if (key.keyCode == 13) {
			fncSearch();
        }
    });
	$("input[name='scrStrNm']").keydown(function (key) {
		if (key.keyCode == 13) {
			fncSearch();
        }
    });
	$("input[name='scrStrCd']").keydown(function (key) {
		if (key.keyCode == 13) {
			fncStrSearch();
        }
    });

});

/*******************
1. 기타 필수 스크립트
********************/
function chboxFormatter1(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid_1\" id=\"choice_grid_1_" + options.rowId + "\" rowid=\"" + options.rowId + "\" onclick=\"onCheckboxClick('1')\" />";
	
}

function chboxFormatter2(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid_2\" id=\"choice_grid_2_" + options.rowId + "\" rowid=\"" + options.rowId + "\" onclick=\"onCheckboxClick('2')\" />";
}

function onCheckboxClick(chkId) {
	$("input:checkbox[name='choice_grid_" + chkId + "']").each(function() {
		if (this.checked == true) {
			$(this).closest("tr").find("td").addClass("chk" + chkId);
			
		} else {
			$(this).closest("tr").find("td").removeClass("chk" + chkId);
			
		}
	});
}

// 경영자 검색
function fncSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}

	$("#gridUserList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserList").setGridParam({
		postData : {
			scrCompanyCd:companyCd,
			scrUserNm:$.trim($("#scrUserNm").val()),
			scrStrNm:$.trim($("#scrStrNm").val()),
			scrAreaNm:$.trim($("#scrAreaNm").val())
		}
	}).trigger("reloadGrid");	
}

// 소유매장 검색
function fncStrMapSearch(userId) {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({
		 datatype : "json",		
		 postData : {
			 scrCompanyCd:companyCd,
			 scrUserId:userId
		 }
	 }).trigger("reloadGrid");
}

// 소유매장 초기화
function fncStrMapInit() {
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({
		 datatype : "local"
	 }).trigger("reloadGrid");
}

// 전체매장 검색
function fncStrSearch() {	
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}

	$("#gridStoreMgntList").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgntList").setGridParam({
		postData : {
			scrCompanyCd:companyCd,
			scrStrCd:$.trim($("#scrStrCd").val()),
			scrStrKd:$.trim($("#scrStrKd").val())
		}
	}).trigger("reloadGrid");	
}

// 소유매장 목록에서 매장목록으로 >>
function fncUnMappingAll() {
	// 전체 선택
	$("input:checkbox[name='choice_grid_1']").prop("checked", true); 
	onCheckboxClick('1');
	
	fncUnMapping();
}

// 소유매장 목록에서 매장목록으로 >
function fncUnMapping() {
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_1']:checked").size();
	if (chkCnt == 0) {
		alert("소유매장목록에서 체크박스를 선택하세요.");
	}
	
	// 마지막 records 값 리턴
	var lastRecords = fnLastRecords();
	
	var rowid = "";
	var rowData = "";
	var strCd = "";
	var viewStrCd = "";
	var strNm = "";
	var addr = "";
	var addRow = "";
	var totLastRecords = Number(lastRecords) + 1;

	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_1']:checked").each(function() {
		// 해당 로오의 데이터 가져오기
		rowid = $.trim($(this).attr("rowid"));
		rowData = $("#gridStoreMgnt").getRowData(rowid);
		
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		viewStrCd = $.trim(rowData.viewStrCd);		// 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소
		
		// 매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", viewStrCd:viewStrCd, strNm:strNm, addr:addr, strCd:strCd};
		$("#gridStoreMgntList").jqGrid('addRowData', totLastRecords, addRow);
		
		// 소유매장 목록에 삭제
		$("#gridStoreMgnt").delRowData(rowid);
		
		totLastRecords = totLastRecords + 1;
	});
}

// 매장목록에서 소유매장 목록으로 <<
function fncMappingAll() {
	// 경영자 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영자 선택된 로우
	if (selrow == "") {
		alert("경영자를 먼저 선택하세요.");
		return false;
	}
	
	// 전체 선택
	$("input:checkbox[name='choice_grid_2']").prop("checked", true);
	onCheckboxClick('2');

	fncMapping();
}

// 매장목록에서 소유매장 목록으로 <
function fncMapping() {	
	// 경영자 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영자 선택된 로우
	if (selrow == "") {
		alert("경영자를 먼저 선택하세요.");
		return false;
	}
	
	// 선택된 값 없을 시 메세지
	var chkCnt = $("input:checkbox[name='choice_grid_2']:checked").size();
	if (chkCnt == 0) {
		alert("매장목록에서 체크박스를 선택하세요.");
	}
	
	// 매장코드 존재 유무
	// 존재시 retExistStrNm 에 존재하는 매장명 리턴
	// 미존재시 retLastRecord 에 last records 리턴(등록 시 필요)
	var retV = fnExistStrCd();
	var existStrNm = $.trim(retV.retExistStrNm);
	var lastRecords = $.trim(retV.retLastRecord);
	if (existStrNm != "") {
		alert(existStrNm + " 매장이 목록에 이미 존재합니다.");
		return false;
	}
	
	var rowid = "";
	var rowData = "";
	var strCd = "";
	var viewStrCd = "";
	var strNm = "";
	var addr = "";
	var addRow = "";
	var totLastRecords = Number(lastRecords) + 1;
	
	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_2']:checked").each(function() {
		// 해당 로오의 데이터 가져오기
		rowid = $.trim($(this).attr("rowid"));			
		rowData = $("#gridStoreMgntList").getRowData(rowid);
			
		strCd = $.trim(rowData.strCd);				// 실제 매장코드
		viewStrCd = $.trim(rowData.viewStrCd);		// 매장코드
		strNm = $.trim(rowData.strNm);				// 매장 명
		addr = $.trim(rowData.addr);				// 주소

		// 소유매장 목록에 추가
		addRow = {records:totLastRecords, choice:"0", viewStrCd:viewStrCd, strNm:strNm, addr:addr, strCd:strCd};
		$("#gridStoreMgnt").jqGrid('addRowData', totLastRecords, addRow);
		
		// 매장 목록에 삭제
		$("#gridStoreMgntList").delRowData(rowid);
		
		totLastRecords = totLastRecords + 1;
	});
}

// 매장코드 존재 유무
function fnExistStrCd() {
	var retExistStrNm = "";
	var retLastRecord = "";
	var list = $("#gridStoreMgnt").getRowData();
	var cnt = list.length;
	var exiStrCd = "";
	var exiStrNm = "";
	var lastRecord = "";
	var rowid = "";
	var rowData = "";
	var strCd = "";
	
	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid_2']:checked").each(function() {
		rowid = $.trim($(this).attr("rowid"));			
		rowData = $("#gridStoreMgntList").getRowData(rowid);
			
		strCd = $.trim(rowData.strCd);		// 매장코드
		
		for (var i = 0; i < cnt; i++) {
			exiStrCd = $.trim(list[i].strCd);
			exiStrNm = $.trim(list[i].strNm);
			lastRecord = $.trim(list[i].records);
			
			// 존재 시
			if (exiStrCd == strCd) {
				retExistStrNm = exiStrNm;
				break;
			}
		}
		
		retLastRecord = lastRecord;
	});
	
	return {
		retExistStrNm:retExistStrNm,
		retLastRecord:retLastRecord
	};
}

// 마지막 records 값 리턴
function fnLastRecords() {
	var list = $("#gridStoreMgntList").getRowData();
	var cnt = list.length;
	var lastRecord = "";
	
	for (var i = 0; i < cnt; i++) {
		lastRecord = $.trim(list[i].records);
	}
	
	return lastRecord;
}

// 저장
function fncSave() {
	// 경영자 선택 체크
	var selrow = $.trim($("#gridUserList").getGridParam("selrow"));	// 경영자 선택된 로우
	if (selrow == "") {
		alert("경영자를 먼저 선택하세요.");
		return false;
	}
	
	var listData = $("#gridStoreMgnt").getRowData();
	var cnt = listData.length;
	if (cnt < 1) {
		alert("소유매장목록이 없습니다.");
		return false;		
	}
	
	// 회사 코드
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	// 사용자 아이디
	var rowData = $("#gridUserList").getRowData(selrow);
	var userId = $.trim(rowData.userId);
	
	// 소유매장 목록
	var strCd = "";
	var strCds = "";
	for (var i = 0; i < cnt; i++) {
		strCd = $.trim(listData[i].strCd);
		strCds += strCd + ",";
	}
	strCds = strCds.substring(0, strCds.length - 1);

	// 파라미터
	var param = "companyCd=" + companyCd + "&userId=" + userId + "&strCds=" + strCds;
	
	if (confirm("소유매장목록 정보를 " + "${smCommMsgSaveCnf}")) {
		$.ajax({
			url:'/saveStrMapMgnt',
			type:'POST',
			cache:false,
			data:param,
			dataType:'json',
			success:function(data){
				alert('${smCommMsgSave}');
			//	fncSearch();
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
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value="" style="width:118px;" class="r_Input r_disable" required />
						<img src="/images/ico_remove2.png" alt="inner search" onclick="javascript:fncOrgClear();" style="cursor:pointer; right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" class="icon_search" />
					<input type='text' id='' name='scrOrgNm' value="" style="width:51px;" class="r_Input r_disable" readonly="readonly" required />
					<input type='text' id='' name='scrOrgNm' value="" style="width:188px;" class="r_Input r_disable" readonly="readonly" required />
					<input type='text' id='' name='scrOrgNm' value="" style="width:188px;" class="r_Input r_disable" readonly="readonly" required />
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 탭 전체 그룹 -->
	<div class="tab_group">
		<ul class="nav nav-tabs" id="myTab">
		  <li><a href="#a" id="a_tab" class="tab_tab" onfocus="this.blur()">Dashboard</a></li>
		  <li class="active"><a href="#b" id="b_tab" class="tab_tab" onfocus="this.blur()">에너지사용현황</a></li>
		  <li><a href="#c" id="c_tab" class="tab_tab" onfocus="this.blur()">계약전력</a></li>
		  <li><a href="#d" id="d_tab" class="tab_tab" onfocus="this.blur()">시설물현황</a></li>
		  <li><a href="#e" id="e_tab" class="tab_tab" onfocus="this.blur()">알림현황(3)</a></li>
		</ul>
		 
		<div class="tab-content">
		  <div class="tab-pane dashboard" id="a" style="display:none;">
		  
			<!-- 위젯 -->
			<h3 class="blind">위젯으로 전체 현황 보기</h3>
			<ul class="tab_widgets">
				<li class="date_weather_group">
					<!-- 날짜 -->
					<div class="date">
						<h4 class="blind">날짜</h4>
						<p class="year_month">2016년/12월</p>
						<p class="day">16<span class="blind">일</span></p>
						<p class="week_time">금요일/01:52pm</p>
					</div>
					<!-- //날짜 -->
					<!-- 날씨 -->
					<div class="weather">
						<h4 class="blind">날씨</h4>
						<p class="icon_weather"><img src="/images/icon_weather.png" alt="비옴" /></p>
						<h5 class="outside">실외</h5>
						<p class="outside_temperature">6.4℃</p>
						<h5 class="interior">실내</h5>
						<p class="interior_temperature">19.4℃</p>
					</div>
					<!-- //날씨 -->
				</li>
				<li><img src="/images/tab_line_widgets_01.png" alt="" /></li>
				<li class="air_heat">
					<p class="off">OFF</p>
					<h4>냉난방</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="refrigerator">
					<p class="on">정상</p>
					<h4>냉장비</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="sign">
					<p class="on">ON</p>
					<h4>간판</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="sems">
					<p class="on">정상</p>
					<h4>SEMS</h4>
				</li>
			</ul>
			<!-- //위젯 -->
		  	
		  	<!-- 대시보드 본문 -->
			<div class="tab_dashboard_body">
			
				<!-- 1단 -->
				<div class="level_01">
			
					<!-- 에너지사용량 -->
					<div class="energy_area">
						<h3>에너지사용량</h3>
						<p class="btn_month_day">
							<a href="#" title="day"><img src="images/btn_month.png" alt="month" /></a>
							<!-- <a href="#" title="month"><img src="images/btn_day.png" alt="month" /></a> -->
						</p>
						<div class="table_block">
							<ul class="energy_list">
								<li>
									<p class="title"><span class="pr_10">매장계약전력(kw)</span></p>
									<p class="num_gray"><span class="pl_10">23</span></p>
								</li>
								<li>
									<p class="title"><span class="pr_10">지난달(kwh)</span></p>
									<p class="num_gray"><span class="pl_10">3,203</span></p>
								</li>
								<li>
									<p class="title"><span class="pr_10">이번달(kwh)</span></p>
									<p class="num_blue"><span class="pl_10">1,561</span></p>
								</li>
								<li>
									<p class="title"><span class="pr_10">이번달 예측(kwh)</span></p>
									<p class="num_gray"><span class="pl_10">3,621</span></p>
								</li>
								<li>
									<p class="inquiry_time">조회시간 : 2016/12/19 10:20</p>
								</li>
							</ul>
							<div class="graph_area">
								<img src="/images/sample_graph_03.png" alt="샘플 그래프" />
							</div>
						</div>
						
					</div>
					<!-- //에너지사용량 -->
					
				</div>
				<!-- //1단 -->
				
				<!-- 2단 -->
				<div class="level_02">
			
					<!-- 시설물 알림 처리현황 -->
					<div class="message_condition">
						<h3>시설물 알림 처리현황</h3>
						<ul class="graph_area">
							<li>
								<div class="graph"><img src="/images/sample_graph_04.png" alt="샘플 그래프" /></div>
							</li>
							<li>
								<div class="inactions">
									<h4 class="title_inactions">미조치</h4>
									<p class="num_Inactions">7</p>
								</div>
							</li>
							<li>
								<div class="action">
									<h4 class="title_action">조치완료</h4>
									<p class="num_action">3</p>
								</div>
							</li>
							<li>
								<div class="total">
									<h4 class="title_total">총건수</h4>
									<p class="num_total">10</p>
								</div>
							</li>
						</ul>
					</div>
					<!-- //시설물 알림 처리현황 -->

					<!-- 시설물현황 -->
					<div class="use_condition">
						<h3>시설물현황</h3>
						<div class="table_use_condition">
							<table summery="이 표에서는 계약전력 사용현황을 보여줍니다.">
								<caption>계약전력 사용현황 표</caption>
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
								<tr>
									<th>장비명</th>
									<th>온도</th>
									<th>상태</th>
									<th>최근한달알림</th>
									<th>그래프보기</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td class="tleft">WIC</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">OSC1</td>
									<td>8.0℃</td>
									<td><span class="pink">이상</span></td>
									<td><span class="pink">2</span></td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">OSC2</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">INV_WIC</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">INV_OSC(좌)</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">INV_OSC(우)</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //시설물현황 -->
					
				</div>
				<!-- //2단 -->
				
			</div>
			<!-- //대시보드 본문 -->
		  	
		  </div>
		  <div class="tab-pane active" id="b">
		  
			  <!-- 탭  조회조건 -->
			  <div class="r_search multiLine">
				<table>
					<tr>
						<th>기간</th>
						<td>
							<input id="search_dateFrom" type="text" placeholder="2017-01-11" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
							~ <input id="search_dateTo" type="text" placeholder="2017-01-11" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
							<!-- <button onclick="javascript:func_AllBtn();" class="ml_5">전체</button> -->
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
			<!-- //탭  조회조건 -->
			
			<!-- 좌우그리드그룹 -->
			<div class="r_halfGridContainer">
				<div class=r_oneThirdGrid_l2>
					<div class="r_grid r_inputTblTitle mt_10">
						<h3>월별 전력량</h3>
					</div>
					<div class="r_grid">
						<table id="gridUserList"><tr><td></td></tr></table>
						<div id="gridUserListPager"></div>
					</div>
				</div>
				<div class=r_twoThirdGrid_l2>
					<div class="r_grid r_inputTblTitle mt_10">
						<h3>일별 전력량</h3>
					</div>
					<div class="r_grid">
						<table id="gridStoreMgnt"><tr><td></td></tr></table>
					</div>
				</div>
			</div>
			<!-- //좌우그리드그룹 -->
			
			<!-- 그래프 영역 -->
			<div class="common_section">
				<div class="common_section_title">
					<h3 class="float_n">월별 온실가스 배출 현황</h3>
				</div>
				<div class="graph_area">그래프 영역</div>
			</div>
			<!-- //그래프 영역 -->
		  
		  </div>
		  <div class="tab-pane" id="c" style="display:none;">c</div>
		  <div class="tab-pane" id="d" style="display:none;">d</div>
		  <div class="tab-pane" id="e" style="display:none;">e</div>
		</div>
		
	</div>
	<!-- 탭 전체 그룹 -->
	
</div>