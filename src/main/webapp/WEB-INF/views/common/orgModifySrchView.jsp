<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var='sm_orgTree'><spring:message code='orgTree'/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var gvOrgData  = new Array();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	$('#pStrNm').bind('keydown', function(e) {
		if( e.keyCode == 13 ) {
			$('#pStrCd').val("");
			fncRetrieveOrgByStore();	
		}
	});	

	fncRetrieveOrg();
});


/*******************
1. 기타 필수 스크립트
********************/

function fncGetChildren(parent) {
	
	var data = gvOrgData;
	var rslt = new Array();
	
	$.each(data, function(key, value) {
		if( value.uperOrgCd == parent ) {
			rslt.push( value );		
		}
	});
	
	return rslt;
}

function fncGetAllChildren(parent) {

	var data = new Array();
	var rslt = new Array();
	
	data = fncGetChildren( parent );

	for(var i = 0; i < data.length; i++) {
		var temp  = data[i];
		
		temp.children = fncGetAllChildren(temp.orgCd);
		
		if( ( temp.children ).length <= 0 ) {
			delete temp.children;
		}
		
		rslt[i] = temp;
	}
	
	return rslt;
}

function fncRetrieveOrgByStore() {
	
	var strNm = $('#pStrNm').val();
	$('#orgTree').jstree(true).search( strNm );
	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncRetrieveOrg() {

	var companyCd = '${companyCd}';
	
	gvOrgData = null;
	
	$.ajax({
		type : "POST",
		cache : false,
		url : "/retrieveOrg",
		data : {companyCd:companyCd},
		success : function(data) {

			gvOrgData = data;
			
			$('#orgTree').jstree({
				'core' : {'data' : fncGetAllChildren( 0 ), 'multiple' : false},
				'types' : {
					'default' : {'icon' : false}
				},				
				'plugins':["wholerow", "search"], 
				'search' : {'show_only_matches' : true, 'search_leaves_only' : true}
			});

			$('#orgTree').on("select_node.jstree", function(evt, data) {					
				$('#orgTree').jstree("toggle_node", data.node);
				
				var dataObj = data.node.original;
				
				/*var rslt = $('#orgTree').jstree('get_selected', true); 
				
				var param = new Object();
				
				$.each(rslt, function(key,value) {
					param.orgCd = value.original.orgCd;
					param.orgNm = value.original.text;
				});

				fncSetOrg(param);	
				fncDivPop1Close();*/
				
			});
		}
	});
}

function fncOrgConfirm() {
		
	var rslt = $('#orgTree').jstree('get_selected', true); 
	
	var param = new Object();

	$.each(rslt, function(key,value) {
		param.orgCd = value.original.orgCd;
		param.orgNm = value.original.text;
	});

	fncSetOrg(param);	
	fncDivPop1Close();
}

function fncOrgCancel() {
	fncDivPop1Close();
}
</script>
<div class="r_popup">
     <h1 class="r_popupTitle">${smArea}${smInq}</h1>	  
	  <div class="r_popupCont">
	    <div class="r_search multiLine">     
		<table>
			<tr>
				<th>조직명</th>	
				<td><input type='search' id='pStrNm' name='pStrNm'	style='width: 115px;' /></td>
			</tr>
		</table>
		<span class="search">
			<button onclick="javascript:fncRetrieveOrgByStore()">${smRetrieve}</button>
		</span>
		</div>
		<div class="r_grid">
			<div id="orgTree" style="border: 1px solid gray;overflow:scroll;text-align: left; height: 350px;"></div>
		</div>
		<input type='hidden' id='pStrCd' name='pStrCd' />
		<div class="r_pageBtnWrapper">
		     <span class="pageNormal">
		     	<button onclick="javascript:fncOrgCancel()">${smClos}</button>
		     </span>
		     <span class="pageNormal">
		     	<button onclick="javascript:fncOrgConfirm()">${smCnfm}</button>
		     </span>
		</div>
	</div>
</div>