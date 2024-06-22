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

/*******************
1. 기타 필수 전역 변수
********************/

var rowIdx = 0;

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$("#gridUserMgnt").jqGrid({
		url:'searchVendorEngineerStrList',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['번호', '점포코드', '점포명', '주소', '사용자 ID', '사용자 명', '작업자 ID', '작업자 명', '최종 작업 일자'],
	    colModel:[
	              {name:'records',index : 'records',width : 50,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	              {name:'strCd',index :'strCd',width : 50,align : 'center',sortable:true, editable:false},  
	              {name:'strNm',index:'strNm', width:85, align:'left', sortable:true, editable:false},
	              {name:'addr',index:'addr', width:85, align:'left', sortable:true, editable:false},
	              {name:'userId',index:'userId', width:93, align:'center', sortable:true, editable:false},
	              {name:'userNm',index:'userNm', width:93, align:'left', sortable:true, editable:false},
	              {name:'finalModId',index:'finalModId', width:93, align:'center', sortable:true, editable:false},
	              {name:'finalModUserNm',index:'finalModUserNm', width:93, align:'center', sortable:true, editable:false},
	              {name:'finalModDttm',index:'finalModDttm', width:93, align:'center', sortable:true, editable:false},
        ],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[],
	    pager: '#gridUserMgntPager',
	    sortname: 'userId',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		//width:'100%', 
		height : 360,
		postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			scrStrCd:$("#scrStrCd").val(),
			scrStrNm:$("#scrStrrNm").val(),
			scrUserId:$("#scrUserId").val(),
			scrUserNm:$("#scrUserNm").val()
		},
		gridComplete : function()
		{
			jqGridEven('gridUserMgnt');			 
			var rsltCount = $("#gridUserMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridUserMgnt >tbody").append("<tr><td align='center' colspan='9'>검색 결과가 없습니다.</td></tr>");
			}	
		},	
		
	});
	//jqGrid Resize	
	jqGridResize('gridUserMgnt');	
	

	// 셀렉트 선택	
	var ssVenderCd = $.trim("${userVo.vendorCd}");
	$("#scrVendorCd").val(ssVenderCd);	
	if (ssVenderCd != "") $("#scrVendorCd").attr("disabled", "disabled");
	
	// 세션값 있을 경우 자동 검색
	if (ssVenderCd != "") fncSearch();
});

/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	var vendorCd  = $("#scrVendorCd").val();
	
	if( vendorCd == '' || vendorCd == null ) {
		alert("업체를 선택하세요.");
		return false;
	}

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

function fncOrgSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
	
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd);
	$("#scrOrgNm").val(data.orgNm);
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}

function fncExcelDown(){
	$('#excelForm').attr("action", "/downloadEngineerExcel");
	$("#excelForm").submit();
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
	
	$("#gridUserMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridUserMgnt").setGridParam({
		 postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrVendorCd:$("#scrVendorCd").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			scrStrCd:$("#scrStrCd").val(),
			scrStrNm:$("#scrStrrNm").val(),
			scrUserId:$("#scrUserId").val(),
			scrUserNm:$("#scrUserNm").val()
		 }
	 }).trigger("reloadGrid");
}

</script>
<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
</form>
<div id="loadingArea">
	<div class="r_search multiLine">
		<form id='excelForm' name='excelForm' method='post'> 
			<table>
				<tr>
					<th>${smCompany}</th>
					<td>
					 	<c:if test="${selectVoListCnt == 1 }">
							<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
							<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
						</c:if>
						<c:if test="${selectVoListCnt > 1 }">			
							<select id="scrCompanyCd" name="scrCompanyCd" style="width:112px;" class="searchSelect">
								<option value=''>--선택--</option>
									<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
										<option value='${vo.value}'>${vo.name}</option>
								</c:forEach>
							</select>
							</c:if>
					</td>
					<th>유지보수</th>
					<td>
					 	<c:if test="${selectVoListCnt2 == 1 }">
							<input type='hidden' id='scrVendorCd' name='scrVendorCd' value='${userVo.vendorCd}' />
							<input type='text' id='scrVendorNm' name='scrVendorNm' style='width:100px;' value='${userVo.vendorNm}' class='r_Input r_disable' readonly='readonly'/>
						</c:if>
						<c:if test="${selectVoListCnt2 > 1 }">			
							<select id="scrVendorCd" name="scrVendorCd" style="width:112px;" class="searchSelect">
								<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList2}" varStatus="status" >
									<option value='${vo.value}' <c:if test="${userVo.vendorCd == vo.value}">selected</c:if> >${vo.name}</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>${smOrg}</th>
					<td><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
						<div class="r_innerSearch">
							<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable" readonly="readonly" required/>
							<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" style="cursor:pointer"/>
							<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
						</div>
					</td>
					<th>${smStr}</th>
					<td>
						<input type='hidden' id='scrStrCd' name='scrStrCd' value='' />
						<input type='text' id='scrViewStrCd' name='scrViewStrCd' value='' style="width:100px;" class="r_Input r_disable" readonly />
						<div class="r_innerSearch">
							<input type='text' id='scrStrNm' name='scrStrNm' value='' style="width:100px;" class="r_Input r_disable" readonly />
							<img src="/images/ico_innerSearch.png" alt="inner search" id="innerSearch"  onclick="javascript:fncStrSearch();" style="cursor:pointer"/>
							<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>사용자 ID</th>
					<td>
						<input type='search' id='scrUserId' name='scrUserId' value='' style="width:112px;" />
					</td>
					<th>사용자 명</th>	
					<td>
						<input type='search' id='scrUserNm' name='scrUserNm' value='' style="width:112px;" />
					</td>
				</tr>
			</table>
		</form>
		<span class="search">
	       	<button onclick="javascript:fncSearch()">${smRetrieve}</button>
	   	</span>
	</div>
	<div class="r_grid">
		<table class="gridPointer" id="gridUserMgnt"><tr><td></td></tr></table>
		<div id="gridUserMgntPager"></div>
	</div>
</div>