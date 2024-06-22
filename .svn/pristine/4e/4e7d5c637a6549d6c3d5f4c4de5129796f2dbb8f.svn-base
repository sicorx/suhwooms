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

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('input:radio[name="scrAuthSp"]').eq(0).attr('checked', true);
	$('input:radio[name="scrUseYn"]').eq(0).attr('checked', true);
	
	$("#grdAuthMgnt").jqGrid({
	    url:'retrieveAuthMgnt',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['번호','선택', '구분', '권한코드', '권한명', '권한설명', '사용여부','작업자 ID', '작업자 명', '최종 작업 일자', '회사 코드'],
	    colModel:[
              {name:'records',index:'records', width:50, align : 'center',sortable:true, editable:false},
              {name:'choice',index :'choice',width : 50,align : 'center',formatter :chboxFormatter,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},
              {name:'authSp',index:'authSp', width:70, align:'center', sortable:true, editable:false },
              {name:'authCd',index:'authCd', width:70, align:'center', sortable:true, editable:false},
              {name:'authNm',index:'authNm', width:120, align:'left', sortable:true, editable:true},
              {name:'authDesc',index:'authDesc', width:120, align:'left', sortable:true, editable:false},
              {name:'useYn',index:'useYn', width:50, align:'center', sortable:true, editable:false},
              {name:'finalModId',index:'finalModId', width:93, align:'center', sortable:true, editable:false},
              {name:'finalModUserNm',index:'finalModUserNm', width:93, align:'center', sortable:true, editable:false},
              {name:'finalModDttm',index:'finalModDttm', width:93, align:'center', sortable:true, editable:false},
              {name:'companyCd',index:'companyCd', hidden:true}
	         ],
		jsonReader : {
			repeatitems:false
		},
	    rowNum:20,
	    rowList:[],
	    pager: '#grdAuthMgntPager',
	    sortname: 'authCd',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 360,
		postData : {
			scrCompanyCd : $("#scrCompanyCd").val(),
			scrAuthSp: $(':radio[name="scrAuthSp"]:checked').val(),
			scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		},		
		loadComplete : function(data) {

			var list   = $("#grdAuthMgnt").getRowData();
			var rowCnt = list.length;
				
			for(var i=0;i<rowCnt;i++){
					
				if(list[i].authSp == 'H' ){
					$("#grdAuthMgnt").setCell((i+1),'authSp','본부','');	
				}else if(list[i].authSp == 'M' ){
						$("#grdAuthMgnt").setCell((i+1),'authSp','유지보수','');
				}else if(list[i].authSp == 'S' ){
					$("#grdAuthMgnt").setCell((i+1),'authSp','매장','');
				}else if(list[i].authSp == 'T' ){
					$("#grdAuthMgnt").setCell((i+1),'authSp','전기','');
				}
				
			}	
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {
			
			var list = $("#grdAuthMgnt").getRowData(rowid);
					
			onCheckboxDbClick(rowid);

			var companyCd = $("#scrCompanyCd").val();
			var companyNm = $("#scrCompanyNm").val();
			var authCd = list.authCd;
			
			var args = new Array();
			args.push(companyCd);
			args.push(companyNm);
			args.push(authCd);

			fn_divPop("authMgntDtl", "팝업", 650, 500, args);
			
			},
	});
	jqGridResize('grdAuthMgnt');
});

/*******************
1. 기타 필수 스크립트
********************/

function chboxFormatter(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

function onCheckboxClick(rowId){	

	rowIdx = rowId; 
	$('input:checkbox[name="choice"]').each(function(i){
		if(this.id == 'choice_'+rowId && !this.checked){
			this.checked = false;
		}else if(this.id == 'choice_'+rowId && this.checked){
			this.checked = true;
		}else{
			this.checked = false;
		}
	});		
}

function onCheckboxDbClick(rowId){	
	
	rowIdx = rowId; 
	$('input:checkbox[name="choice"]').each(function(i){
		if(this.id == 'choice_'+rowId){
			this.checked = true;		
		}else{
			this.checked = false;
		}
	});
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
	
	$("#grdAuthMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#grdAuthMgnt").setGridParam({
		 postData : {
			scrAuthSp : $(':radio[name="scrAuthSp"]:checked').val(),
			scrCompanyCd : $("#scrCompanyCd").val(),
			scrAuthSp: $(':radio[name="scrAuthSp"]:checked').val(),
			scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
}

function fncAdd() {	 
	
	var companyCd  = $("#scrCompanyCd").val();
	var companyNm  = $("#scrCompanyNm").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	var args = new Array();
	args.push(companyCd);
	args.push(companyNm);
	args.push('');

	fn_divPop("authMgntNew", "팝업", 650, 550, args);
	
}

function fncUpt() {
	
	var companyCd  = $("#scrCompanyCd").val();
	var companyNm  = $("#scrCompanyNm").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	var list   = $("#grdAuthMgnt").getRowData();
	var chkCnt = 0;
	
	$('input:checkbox[name="choice"]').each(function(){
		if(this.checked){
			chkCnt++;
		}
	});
	
	if(chkCnt > 0){
		var authCd = list[rowIdx-1].authCd;
		
		var args = new Array();
		args.push(companyCd);
		args.push(companyNm);
		args.push(authCd);
		
		fn_divPop("authMgntDtl", "팝업", 650, 500, args);
		
	}else{
		alert("${smCommMsgSel}");
	}
}
</script>
<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
	<input type="hidden" id="popArg2" name="companyNm">
	<input type="hidden" id="popArg3" name="authCd">
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
						<select id="scrCompanyCd" name="scrCompanyCd" style="width:112px;" class="searchSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.value}'>${vo.name}</option>
								</c:forEach>
						</select>
					</c:if>
				</td>
				<th>${smUseYn}</th>
				<td>
					<span class="r_radio">
						<input type='radio' id='scrUseYn1' name='scrUseYn' value='Y' /> <label for="scrUseYn1">사용</label>&nbsp;
						<input type='radio' id='scrUseYn2' name='scrUseYn' value='N' /> <label for="scrUseYn2">미사용</label>
					</span>
				</td>
			</tr>
			<tr>
				<th>권한구분</th>
				<td>
					<span class="r_radio">
						<input type='radio' id='scrAuthSp_1' name='scrAuthSp' value='' /> <label for="scrAuthSp_1">전체</label>&nbsp;
						<input type='radio' id='scrAuthSp_2' name='scrAuthSp' value='H' /> <label for="scrAuthSp_2">본부</label>&nbsp;
						<input type='radio' id='scrAuthSp_3' name='scrAuthSp' value='M' /> <label for="scrAuthSp_3">유지보수</label>&nbsp;
						<input type='radio' id='scrAuthSp_4' name='scrAuthSp' value='S' /> <label for="scrAuthSp_4">매장</label>		
					</span>
				</td>
			</tr>
		</table>
		<span class="search">
			<button onclick="javascript:fncSearch()">${smRetrieve}</button>
		</span>
	</div> 
	<div class="r_grid">
		<table id="grdAuthMgnt"><tr><td></td></tr></table>
		<div id="grdAuthMgntPager"></div>
	</div>
	<div class="r_pageBtnWrapper">
	 	<span class="pageNormal">
	       	<button onclick="javascript:fncUpt();">${smUpdate}</button>
	   	</span>	
	 	<span class="pageNormal">
	       	<button onclick="javascript:fncAdd();">${smNew}</button>
	   	</span>
	</div>
</div>