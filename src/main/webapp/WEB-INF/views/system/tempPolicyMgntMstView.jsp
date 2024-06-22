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

<script type="text/javascript">

/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridTempPolicyMgnt").setGridWidth($("#cont").width());


}).resize();

$(document).ready(function(){
	
	$("#gridTempPolicyMgnt").jqGrid({
		url:'retrieveTempPolicyMgnt',
		datatype: "json",
		 postData : {
			 scrCompanyCd:$('#scrCompanyCd').val()
		 },
	    mtype: 'POST',
	    colNames:['No', '연도', '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월', '회사코드' ],
	    colModel:[
						{name:'records',index : 'records',width : 107, align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
						{name:'yyyy',index:'yyyy', align:'center', sortable:true, editable:false},
						{name:'m1',index:'m1', width:113, align:'center', sortable:false, editable:false},
						{name:'m2',index:'m2', width:113, align:'center', sortable:false, editable:false},
						{name:'m3',index:'m3', width:113, align:'center', sortable:false, editable:false},
						{name:'m4',index:'m4', width:113, align:'center', sortable:false, editable:false},
						{name:'m5',index:'m5', width:113, align:'center', sortable:false, editable:false},
						{name:'m6',index:'m6', width:113, align:'center', sortable:false, editable:false},
						{name:'m7',index:'m7', width:113, align:'center', sortable:false, editable:false},
						{name:'m8',index:'m8', width:113, align:'center', sortable:false, editable:false},
						{name:'m9',index:'m9', width:113, align:'center', sortable:false, editable:false},
						{name:'m10',index:'m10', width:113, align:'center', sortable:false, editable:false},
						{name:'m11',index:'m11', width:113, align:'center', sortable:false, editable:false},
						{name:'m12',index:'m12', width:113, align:'center', sortable:false, editable:false},
						{name:'companyCd',index:'companyCd', hidden:true}	               
	    	],
	    jsonReader : {
	        repeatitems:false
	    },
	    rowNum:20,
	    rowList:[10,20,50,100],
	    pager: '#gridTempPolicyMgntPager',
	    recordtext: "건/페이지  (전체 {2} 건)",
	    emptyrecords : "검색 결과가 존재하지 않습니다.",
	    loadtext: "Loading...",
	    sortname: 'yyyy',
	    viewrecords: true,
	    sortorder: "desc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 240,
		loadComplete : function(data) {
			
			 jqGridResize('gridUserInfo');	
		}
	 });
	
	$('#saveForm').validate({
		rules:{
			mm1:{required:true, number:true, max:30, min:18},
			mm2:{required:true, number:true, max:30, min:18},
			mm3:{required:true, number:true, max:30, min:18},
			mm4:{required:true, number:true, max:30, min:18},
			mm5:{required:true, number:true, max:30, min:18},
			mm6:{required:true, number:true, max:30, min:18},
			mm7:{required:true, number:true, max:30, min:18},
			mm8:{required:true, number:true, max:30, min:18},
			mm9:{required:true, number:true, max:30, min:18},
			mm10:{required:true, number:true, max:30, min:18},
			mm11:{required:true, number:true, max:30, min:18},
			mm12:{required:true, number:true, max:30, min:18}
		},			
		showErrors: function(errorMap, errorList) {	          
	          $.each(this.validElements(), function (index, element) {
	              var $element = $(element);
	              $element.data("title", "").removeClass("error").tooltip("destroy");
	          });
	          $.each(errorList, function (index, error) {
	              var $element = $(error.element);
	              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
	          });
	      }
	});
	
	// 연도 셀렉트 변경시
	$("select[id='scrYyyy']").on({
		change: function() {
			fncSearch();
		}
	});
	  
	fncSearch();
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	 var scrYyyy = $("#scrYyyy").val();
	 var scrCompanyCd = $("#scrCompanyCd").val();

	 if( scrYyyy == null || scrYyyy == "" ){
		 alert("연도를 조회하세요");
		 return;
	 }

		$.ajax({
			url:'/retrieveTempPolicy',
			type:'POST',
			cache:false,
			data : {scrYyyy:scrYyyy,scrCompanyCd:scrCompanyCd},
			dataType:'json',
			success:function(data){
				
				$('#yyyy').val(data.yyyy );
				$('#mm1').val(data.m1 );
				$('#mm2').val(data.m2 );
				$('#mm3').val(data.m3 );
				$('#mm4').val(data.m4 );
				$('#mm5').val(data.m5 );
				$('#mm6').val(data.m6 );
				$('#mm7').val(data.m7 );
				$('#mm8').val(data.m8 );
				$('#mm9').val(data.m9 );
				$('#mm10').val(data.m10 );
				$('#mm11').val(data.m11 );
				$('#mm12').val(data.m12 );
				$('#companyCd').val(data.companyCd );
			},
			error:function(result){
				
				$('#yyyy').val($('#scrYyyy').val() );
				$('#mm1').val("");
				$('#mm2').val("");
				$('#mm3').val("");
				$('#mm4').val("");
				$('#mm5').val("");
				$('#mm6').val("");
				$('#mm7').val("");
				$('#mm8').val("");
				$('#mm9').val("");
				$('#mm10').val("");
				$('#mm11').val("");
				$('#mm12').val("");
				$('#companyCd').val($('#scrCompanyCd').val() );
			}
		});
	 
	$("#gridTempPolicyMgnt").setGridParam({"page":1});		// 1페이지로 이동		
	$("#gridTempPolicyMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:scrCompanyCd
		 }
	 }).trigger("reloadGrid");
}

function fncSave() {			
	
	var monthTempList = "";
	for(var i=1 ; i < 13 ; i++){
		
		monthTempList = monthTempList + $("#mm"+i+"").val()+":"; 
		
	}
	$('#monthTempList').val(monthTempList);

	if($('#saveForm').valid()){
		if(confirm($.trim($("#scrYyyy").val()) + "년도 권고온도 설정을" + "${smCommMsgSaveCnf}")){
			
			$.ajax({
				url:'/saveTempPolicyMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					fncSearch();
				},
				error:function(result){
					alert("에러가 발생했습니다.");
				}				
			});
		}
	}
}
</script>
<div id="loadingArea">

	<!-- 조회조건 -->
	<div class="r_search multiLine">	
		<c:if test="${selectVoListCnt == 1 }">
			<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
			<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />
		</c:if>
		<c:if test="${selectVoListCnt > 1 }">			
			<select id="scrCompanyCd" name="scrCompanyCd" style="display:none;">
				<option value=''>--선택--</option>
					<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
			</select>
		</c:if>
		<table>
			<tr>
				<th>연도</th>
				<td>
					<select id="scrYyyy" name="scrYyyy" class="searchSelect" style="width:100px;">
						<c:forEach var="vo" items="${selectVoList2}" varStatus="status">
							<option value='${vo.value}'>${vo.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>		
		</table>
	</div>
	<!-- //조회조건 -->
	
	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>권고온도 설정</h3>
		</div>
		<form id="saveForm" name="saveForm" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="" />
			<input type="hidden" id="monthTempList" name="monthTempList" value="" />
			<table>
				<caption>Grid Table</caption>
				<col />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	        	<col width="7.5%" />
	       	 	<thead>
	        		<tr>
						<th scope="col" class="tcenter">연도</th>
						<c:forEach begin="1" end="12" step="1" var="i">
							<th class="tcenter" scope="col"<c:out value="${i eq 12 ? ' class=tcenter' : ''}" />>${i}월</th>
						</c:forEach>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="tcenter">
							<input type="text" id="yyyy" name="yyyy" value="" maxLength="4" style="width:90%;border: none" readonly="readonly" />
						</td>
						<td class="tcenter">
							<input type='number' id="mm1" name="mm1" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm2" name="mm2" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm3" name="mm3" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm4" name="mm4" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm5" name="mm5" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm6" name="mm6" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm7" name="mm7" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm8" name="mm8" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm9" name="mm9" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm10" name="mm10" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm11" name="mm11" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
						<td class="tcenter">
							<input type='number' id="mm12" name="mm12" value='' maxLength="2" style="width:100%;" class='numberVal' />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper mr_0 ml0 border_none">
		<span class="pageNormal">
	   		<button onclick="javascript:fncSave();">${smSave}</button>
		</span>
	</div>
	<!-- //하단 버튼 그룹 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">		
		<div class="r_gridTitle">
	       	<h3>권고온도 내역</h3>
	     	</div>
		<table id="gridTempPolicyMgnt"><tr><td></td></tr></table>
		<div id="gridTempPolicyMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
</div>