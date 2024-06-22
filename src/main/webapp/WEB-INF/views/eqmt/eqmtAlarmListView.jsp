<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>

<c:set var="smAlarmEqmtList"><spring:message code="alarmEqmtList"/></c:set>
<c:set var="smAlarmEqmtDtlList"><spring:message code="alarmEqmtDtlList"/></c:set>

<c:set var="smStrCd"><spring:message code="strCd"/></c:set>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set>
<c:set var="smEqmt"><spring:message code="eqmt"/></c:set>
<c:set var="smRecentAlarm"><spring:message code="recentAlarm"/></c:set>
<c:set var="smMonthlyAlarmCnt"><spring:message code="monthlyAlarmCnt"/></c:set>

<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var gvPopParam = new Object(); // 팝업 파라미터 저장 변수

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	$("#gridAlarmList").jqGrid({
		url:'retrievePlantAlarmList',
		datatype: "local",
		mtype: 'POST',
		postData: {
			srchStrCd : $("#strCd").val(),
			srchYyyymm : $("#selYearMonth").val(),
			srchDeviceType : '${orgDeviceType}'
		},
		colNames:['', '${smStrCd}', '${smStrNm}', '${smMonthlyAlarmCnt}'],
		colModel:[
			{name:'strCd',index:'strCd', width:0, align:'center', hidden:true},
			{name:'viewStrCd',index:'viewStrCd', width:70, align:'center', formatter:'text',  sortable:true, editable:false},
			{name:'strNm',index:'strNm', width:90, align:'left', formatter:'text',  sortable:true, editable:false},
			{name:'alarmCnt',index:'alarmCnt', width:70, align:'center', formatter:'integer',  sortable:true, editable:false}			
		],
		jsonReader : {
		     repeatitems:false
		},
		formatter : {
	  		number : {
				decimalSeparator: ".",
				thousandsSeparator: ",", 
				decimalPlaces: 1,
				defaultValue: '0'
			}
		},
		rowNum:1000,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '300',
		onSelectRow : function(rowid, status, e) {
			var list  = $("#gridAlarmList").getRowData(rowid);
			var strCd = list.strCd;

			fncRetrieveAlarmDtlList(strCd);
		},
		loadComplete : function(data) {
			var list   = $("#gridAlarmList").getRowData();
			var rowCnt = list.length;
			
			if( rowCnt > 0 ) {
				$("#gridAlarmList").jqGrid('setSelection', 1);
			}
		}				
		/*
		ondblClickRow : function(rowid, status, e) {
			var list = $("#gridAlarmList").getRowData(rowid);
			
			var target = '5103';
			var type   = '2';
			var mainId = '1';
			var param  = new Object();
			
			param.orgViewStrCd  = list.viewStrCd;
			param.orgStrCd      = list.strCd;
			param.orgStrNm      = list.strNm;
			param.orgDeviceType = '${orgDeviceType}';
			param.orgYyyymm     = '${orgYyyymm}';
				
			fncMove(target, param);
		}
		*/
	});

	$("#gridAlarmDtlList").jqGrid({
		url:'retrievePlantAlarmDtlList',
		datatype: "local",
		mtype: 'POST',
		postData: {
			srchStrCd : $("#strCd").val(),
			srchYyyymm : $("#selYearMonth").val(),
			srchDeviceType : '${orgDeviceType}'
		},
		colNames:['', '', '', '', '${smEqmt}', '${smRecentAlarm}'],
		colModel:[
			{name:'strCd',index:'strCd', width:0, align:'center', hidden:true},
			{name:'temonId',index:'temonId', width:70, align:'center', hidden:true},
			{name:'temonType',index:'temonType', width:90, align:'left', hidden:true},
			{name:'portNo',index:'portNo', width:120, align:'left', hidden:true},
			{name:'device',index:'device', width:100, align:'center', formatter:'text', sortable:true, editable:false},
			{name:'alarm',index:'alarm', width:180, align:'left', formatter:'text',  sortable:true, editable:false}			
		],
		jsonReader : {
		     repeatitems:false
		},
		formatter : {
	  		number : {
				decimalSeparator: ".",
				thousandsSeparator: ",", 
				decimalPlaces: 1,
				defaultValue: '0'
			}
		},
		rowNum:1000,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '300'
	});
	
	$("#viewStrCd").bind('change', function(e) {
		fncClearInput("C");
	});
	
	$("#strNm").bind('change', function(e) {
		fncClearInput("N");
	});

	$("#viewStrCd").bind('keydown', function(e) {
		if( e.keyCode == 13 ) {
			$("#strNm").val("");
			fncStrSearch( $("#innerSearch") );	
		}
	});

	$("#strNm").bind('keydown', function(e) {
		if( e.keyCode == 13 ) {
			$("#viewStrCd").val("");
			fncStrSearch( $("#innerSearch") );	
		}
	});	
	
	if( '${orgStrCd}' != '' && '${orgStrCd}' != null ) {
		fncSearch();
	}	
});

/*******************
1. 기타 필수 스크립트
********************/

/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}

	gvPopParam.viewStrCd = $("#viewStrCd").val();
	gvPopParam.strNm = $("#strNm").val();
	gvPopParam.companyCd = $("#scrCompanyCd").val();
	
	fncWindowPopup('storeMngSrch');
}

function fncSetStore(data){
	$("#viewStrCd").val(data.viewStrCd);
	$("#strNm").val(data.strNm);
	$("#strCd").val(data.strCd);
}

function fncStoreClear(){
	$("#scrViewStrCd").val("");
	$("#scrStrNm").val("");
	$("#scrStrCd").val("");
}

function fncOrgSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	gvPopParam.companyCd = $("#scrCompanyCd").val();
	fncWindowPopup('showOrgSrch');
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd);
	$("#scrOrgNm").val(data.orgNm);
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}


/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var strCd  = $("#strCd").val();
	var yyyymm = $("#selYearMonth").val();

	if( yyyymm == '' || yyyymm == null ) {
		yyyymm = '${orgYyyymm}';	
	}
	
	$("#gridAlarmList").clearGridData();
	
	$("#gridAlarmList").setGridParam ({
		datatype : "json",		
		postData : {
			srchStrCd : strCd,
			srchYyyymm : yyyymm,
			srchDeviceType : '${orgDeviceType}'
		}
	}).trigger("reloadGrid");
}

function fncRetrieveAlarmDtlList (strCd) {

	var yyyymm = $("#selYearMonth").val();

	if( yyyymm == '' || yyyymm == null ) {
		yyyymm = '${orgYyyymm}';	
	}

	$("#gridAlarmDtlList").clearGridData();
	
	$("#gridAlarmDtlList").setGridParam ({
		datatype : "json",		
		postData : {
			srchStrCd : strCd,
			srchYyyymm : yyyymm,
			srchDeviceType : '${orgDeviceType}'
		}
	}).trigger("reloadGrid");	
}
</script>

<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="strCd"> 
    <input type="hidden" id="popArg2" name="viewStrCd"> 
    <input type="hidden" id="popArg3" name="companyCd"> 
    <input type="hidden" id="popArg4" name="companyNm"> 
</form>
<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>${smCompany}</th>
				<td>
				 	<c:if test="${selectVoListCnt == 1 }">
						<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
						<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
					</c:if>
					<c:if test="${selectVoListCnt > 1 }">			
						<select id="'scrCompanyCd'" name="scrCompanyCd'" style="width:100px;" class="searchSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.name}'>${vo.value}</option>
								</c:forEach>
						</select>
					</c:if>
				</td>
				<th>${smOrg}</th>
				<td colspan="2"><input type='hidden' id='scrOrgCd' name='scrOrgCd' value='' />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value='' class="r_Input r_disable" style="width:140px;" readonly="readonly" />
						<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" style="cursor:pointer"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
				</td>
			</tr>	
			<tr>
				<th>${smStr}</th>
				<td>
					<input type='hidden' id='strCd' name='strCd' value='${orgStrCd}' />
					<input class="r_Input r_disable" type='text' id='viewStrCd' name='viewStrCd' value='${orgViewStrCd}' style="width:100px;" />
					<div class="r_innerSearch">
						<input type='text' id='strNm' name='strNm' value='${strNm}' style="width:150px;" />
						<img src="/images/ico_innerSearch.png" id="innerSearch" onclick="fncStrSearch(this);"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
					</div>
				</td>
				<th>${smYearMonth}</th>
				<td>
					<select class="searchSelect" id="selYearMonth" name="selYearMonth" style="width:120px;" >
						<c:forEach items="${yearMonth}" var="item">
						<option value='${fn:replace(item.yearMonth,"-", "")}'>${item.yearMonth}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">${smRetrieve}</button>
	    </span>
	</div>
	<div class="r_halfGridContainer" style="height:320px;">
		<div class="r_grid r_halfGrid_l r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smAlarmEqmtList}</h3>	
			</div>
			<table id="gridAlarmList"><tr><td></td></tr></table>
		</div>
		
		<div class="r_grid r_halfGrid_r r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smAlarmEqmtDtlList}</h3>	
			</div>
			<table id="gridAlarmDtlList"><tr><td></td></tr></table>
		</div>	
	</div>
	<input id="viewStrCd" name="viewStrCd" type="hidden" value="" />
	<input id="strCd" name="strCd" type="hidden" value="" />
	<input id="strNm" name="strNm" type="hidden" value="" />
	<input id="orgYyyymm" name="orgYyyymm" type="hidden" value="${orgYyyymm }" />
</div>