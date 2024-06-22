<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smMonthlyLightElecUse"><spring:message code="monthlyLightElecUse"/></c:set>
<c:set var="smDailyLightElecUse"><spring:message code="dailyLightElecUse"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smTotalElecUse"><spring:message code="totalElecUse"/></c:set>
<c:set var="smLightElecUse"><spring:message code="lightElecUse"/></c:set>
<c:set var="smLightElecUseRatio"><spring:message code="lightElecUseRatio"/></c:set>
<c:set var="smDimmingValue"><spring:message code="dimmingValue"/></c:set>
<c:set var="smDate"><spring:message code="date"/></c:set>
<c:set var="smWeather"><spring:message code="weather"/></c:set>
<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>
<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	// 월별 전력량
	$("#gridUsedAreaLight").jqGrid({
		url:'retrieveUseMonthListLight',
		datatype: "local",
		mtype: 'POST',
		postData : {
			srchStrCd : $("#strCd").val(),
		},		
		colNames:['${smYearMonth}', '${smTotalElecUse}', '${smLightElecUse}', '${smLightElecUseRatio}', '${smDimmingValue}'],
		colModel:[
			{name:'yyyymm',index:'yyyymm', width:70, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'light',index:'light', width:90, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'ratio',index:'ratio', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'dimm',index:'dimm', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false}
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
		rowNum:13,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '445',
		onSelectRow : function(rowid, iRow, iCol, e) {
			var list = $("#gridUsedAreaLight").getRowData(rowid);
			var yyyymm = list.yyyymm.replace("-", "");
	
			fncRetireveUseDailyListLight(yyyymm);
		},
		loadComplete : function(data) {
			var list   = $("#gridUsedAreaLight").getRowData();
			var rowCnt = list.length;
			
			if( rowCnt > 0 ) {
				$("#gridUsedAreaLight").jqGrid('setSelection', 1);
			}
		}
	});

	//일자별 조명전력량
	$("#gridUsedDailyAreaLight").jqGrid({
		url:'retrieveUseDailyListLight',
		datatype: "local",
		mtype: 'POST',
		colNames:['${smDate}', '${smTotalElecUse}', '${smLightElecUse}', '${smDimmingValue}', '${smWeather}'],
		colModel:[
			{name:'yyyymmdd',index:'yyyymmdd', width:70, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
			{name:'total',index:'total', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'light',index:'light', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'dimm',index:'dimm', width:70, align:'right', formatter:'number', formatoptions:{decimalPlaces:1}, sortable:true, editable:false},
			{name:'weather',index:'weather', width:70, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}}
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
		rowNum:31,
		rowList:[],
		viewrecords: true,
		hidegrid: false,
		autowidth: true,
		shrinkToFit: true,
		height: '445'
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
});

/*******************
1. 기타 필수 스크립트
********************/

function fncClearInput(param){
	
	$("#strCd").val("");
	
	if( param == "C" ) {
		$("#strNm").val("");	
	}
	else if( param == "N") {
		$("#viewStrCd").val("");	
	}
}

/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#scrStrNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;
	
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );
	
}

function fncSetStore(data){
	$("#scrViewStrCd").val(data.viewStrCd);
	$("#scrStrNm").val(data.strNm);
	$("#scrStrCd").val(data.strCd);
}

function fncStoreClear(){
	$("#scrViewStrCd").val("");
	$("#scrStrNm").val("");
	$("#scrStrCd").val("");
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var strCd  = $("#scrStrCd").val();
	var yyyymm = ( $("#selYearMonth").val() ).replace( "-", "" );
	
	if( strCd == '' || strCd == null ) {
		alert("${smStrCdSrch}");
		return false;
	}

	if( yyyymm == '' || yyyymm == null ) {
		yyyymm = '${orgYyyymm}';
	}
	
	$("#gridUsedAreaLight").clearGridData();
	$("#gridUsedDailyAreaLight").clearGridData();
	
	$("#gridUsedAreaLight").setGridParam ({
		datatype : "json",
		postData : {
			srchYyyymm : yyyymm,
			srchStrCd : strCd
		}
	}).trigger("reloadGrid");
}

function fncRetireveUseDailyListLight(yyyymm) {
	$("#gridUsedDailyAreaLight").clearGridData();

	$("#gridUsedDailyAreaLight").setGridParam({
		datatype : "json",
		postData : {
			srchStrCd : $("#scrStrCd").val(),
		    srchYyyymm: yyyymm
		}
	}).trigger("reloadGrid");
}

</script>

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
			</tr>	
			<tr>
				<th>${smStr}</th>
				<td>
					<input type='hidden' id='scrStrCd' name='scrStrCd' value='' />
					<input type='text' id='scrViewStrCd' name='scrViewStrCd' value='${storeStatusVo.viewStrCd}' style="width:100px;" class="r_Input r_disable" readonly />
					<div class="r_innerSearch">
						<input type='text' id='scrStrNm' name='scrStrNm' value='${storeStatusVo.strNm}' style="width:100px;" class="r_Input r_disable" readonly />
						<img src="/images/ico_innerSearch.png" alt="inner search" id="innerSearch"  onclick="javascript:fncStrSearch();" style="cursor:pointer"/>
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
	<div class="r_halfGridContainer" style="height:400px;">
		<div class="r_grid r_halfGrid_l r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smMonthlyLightElecUse}</h3>	
			</div>
			<table id="gridUsedAreaLight"><tr><td></td></tr></table>
		</div>
		
		<div class="r_grid r_halfGrid_r r_secondTbl">
			<div class="r_inputTblTitle">
				<h3>${smDailyLightElecUse}</h3>	
			</div>
			<table id="gridUsedDailyAreaLight"><tr><td></td></tr></table>
		</div>
	</div>
</div>