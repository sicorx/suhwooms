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
var newWin = null;
var dtlWin = null;

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('input:radio[name="scrUseYn"]').eq(0).attr('checked', true);
	
	$("#gridCompanyMgnt").jqGrid({
		url:'retrieveCompanyMgnt',
	    datatype: "json",
	    mtype: 'POST',
	    colNames:['번호', '선택', '회사 코드', '회사 명', '코드 규칙', '국가', '사용 여부', '작업자 ID', '작업자 명', '최종 작업 일자' ],
	    colModel:[
	            {name:'records',index : 'records',width : 50,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	            {name:'choice',index :'choice',width : 50,align : 'center',formatter :chboxFormatter,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	            {name:'companyCd',index:'companyCd', width:85, align:'left', sortable:true, editable:false},
	            {name:'companyNm',index:'companyNm', width:85, align:'left', sortable:true, editable:false},
	            {name:'companyStrCd',index:'companyStrCd', width:85, align:'left', sortable:true, editable:false},
	            {name:'countryNm',index:'countryNm', width:85, align:'left', sortable:true, editable:false},
	            {name:'useYn',index:'useYn', width:93, align:'center', sortable:true, editable:false},
	            {name:'finalModId',index:'finalModId', width:93, align:'center', sortable:true, editable:false},
	            {name:'finalModUserNm',index:'finalModUserNm', width:93, align:'center', sortable:true, editable:false},
	            {name:'finalModDttm',index:'finalModDttm', width:93, align:'center', sortable:true, editable:false}
	    	],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
	    rowList:[],
	    pager: '#gridCompanyMgntPager',
	    sortname: 'companyNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 360,
		postData : {
			scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		},
		ondblClickRow : function(rowid, iRow, iCol, e) {
				
			var list = $("#gridCompanyMgnt").getRowData(rowid);
				
			onCheckboxDbClick(rowid);
			
			var companyCd = list.companyCd;

			var args = new Array();
			args.push(companyCd);
			dtlWin = showPopupPost('retrieveCompanyMgntDtl', 'retrieveCompanyMgntDtl', 650, 450, args);
		}	 
	 });
	  //jqGrid Resize	
	  jqGridResize('gridCompanyMgnt');	
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
	
	$("#gridCompanyMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridCompanyMgnt").setGridParam({
		 postData : {
			 scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
	
	$("#gridCompanyMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridCompanyMgnt").setGridParam({
		 postData : {
			 scrUseYn: $('input:radio[name="scrUseYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
}

function fncAdd() {
	
	var args = new Array();
	args.push('');	
	
	newWin = showPopupPost('companyMgntNew', 'companyMgntNew', 650, 450, args);
	
}

function fncUpt() {
	var list   = $("#gridCompanyMgnt").getRowData();
	var chkCnt = 0;
	$('input:checkbox[name="choice"]').each(function(){
		if(this.checked){
			chkCnt++;
		}
	});
	
	if(chkCnt > 0){
		var companyCd = list[rowIdx-1].companyCd;
		
		var args = new Array();
		args.push(companyCd);
		
		dtlWin = showPopupPost('retrieveCompanyMgntDtl', 'retrieveCompanyMgntDtl', 650, 450, args);
	}else{
		alert("${smCommMsgSel}");
	}
}

function fncDel() {
	
	var list   = $("#gridCompanyMgnt").getRowData();
	var chkCnt = 0;
	$('input:checkbox[name="choice"]').each(function(){
		if(this.checked){
			chkCnt++;
		}
	});
	
	if(chkCnt > 0 && (!newWin||newWin.closed) && (!dtlWin||dtlWin.closed)){
		
		var companyCd = list[rowIdx-1].companyCd;		
		if(confirm("${smCommMsgDelCnf}")){
			$.ajax({
				url:'/deleteCompanyMgnt',
				type:'POST',
				cache:false,
				data : {companyCd:companyCd},
				dataType:'json',
				success:function(data){
					alert('${smCommMsgDel}');
					fncSearch();				
				},
				error:function(result){
					alert('error');
				}				
			});
		}
	}else if(newWin && !newWin.closed){
		alert("${smCommMsgOpen}");	
		newWin.focus();
	}else if(dtlWin && !dtlWin.closed){
		alert("${smCommMsgOpen}");
		dtlWin.focus();
	}else{
		alert("${smCommMsgSel}");		
	}

}
</script>
<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd"> 
</form>
<div class="r_search oneLine">
	<table>
		<tr>
			<th>${smUseYn}</th>
			<td>
				<span class="r_radio">
					<input type='radio' id='scrUseYn1' name='scrUseYn' value='Y' /> <label for="scrUseYn1">사용</label>&nbsp;
					<input type='radio' id='scrUseYn2' name='scrUseYn' value='N' /> <label for="scrUseYn2">미사용</label>
				</span>
			</td>
			<td>
				<span class="search">
        			<button onclick="javascript:fncSearch()">${smRetrieve}</button>
    			</span>
    		</td>
		</tr>
	</table>
</div>
<div class="r_grid">
	<table id="gridCompanyMgnt"><tr><td></td></tr></table>
	<div id="gridCompanyMgntPager"></div>
</div>
<div class="r_pageBtnWrapper">
	<span class="pageNormal">
    	<button onclick="javascript:fncDel();">${smDelete}</button>
   	</span>	
 	<span class="pageNormal">
    	<button onclick="javascript:fncUpt();">${smUpdate}</button>
   	</span>	
   	<span class="pageNormal">
    	<button onclick="javascript:fncAdd();">${smNew}</button>
   	</span>	&nbsp;
</div>