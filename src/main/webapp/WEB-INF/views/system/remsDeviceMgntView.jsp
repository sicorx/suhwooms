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
<c:set var="smMainMeter"><spring:message code="mainMeter"/></c:set>
<c:set var="smExcldMeter"><spring:message code="excldMeter"/></c:set>
<c:set var="smSubMeterLight"><spring:message code="subMeterLight"/></c:set>
<c:set var="smSubMeterTemp"><spring:message code="subMeterTemp"/></c:set>
<c:set var="smDimmer"><spring:message code="dimmer"/></c:set>
<c:set var="smHacon"><spring:message code="hacon"/></c:set>
<c:set var="smTSensor"><spring:message code="tSensor"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smSign"><spring:message code="sign"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>
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
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();

$(document).ready(function(){
	
	//$("input:radio[name='scrMeterCollector']:input[value='1']").prop("checked", true);
	
	$("#gridStoreMgnt").jqGrid({
		url:'storeRemsMgnt',
	    datatype: "json",
	    postData : {
			scrCompanyCd:$("#scrCompanyCd").val(),
			scrStrCd:$("#scrStrCd").val(),
			scrOrgCd:$("#scrOrgCd").val(),
			//scrMeterCollector: $(':radio[name="scrMeterCollector"]:checked').val()
		},
	    mtype: 'POST',
	    colNames:['No', '조직명', '${smStrNm}', '${smMainMeter}', '${smExcldMeter}', '${smSubMeterTemp}', '${smHacon}', '${smTSensor}', '${smTemon}', '${smZigbee}', 'Almon', 'INV', '${smSign}', '회사코드', 'strCd'],
	    colModel:[
	                {name:'records',			index:'records',			width:10,	align:'center',	sortable:false },
	                {name:'orgFullNm',			index:'orgFullNm',	 		width:45, 	align:'left'},
	                {name:'strNm',				index:'strNm', 				width:50, 	align:'left'},	                
	                {name:'mainMeter',			index:'mainMeter', 			width:50, 	align:'center'},
	                {name:'excldMeter',			index:'excldMeter', 		hidden:true,width:50, 	align:'center'},
	                {name:'subMeterTemp',		index:'subMeterTemp', 		width:50, 	align:'center'},
	                {name:'hacon',				index:'hacon', 				width:50, 	align:'center'},
	                {name:'tSensor',			index:'tSensor', 			width:50, 	align:'center'},
	                {name:'temon',				index:'temon', 				width:50, 	align:'center'},
	                {name:'zigbee',				index:'zigbee', 			width:50, 	align:'center'},
	                {name:'almon',				index:'almon',			 	width:50, 	align:'center'},
	                {name:'inv',				index:'inv', 				width:50, 	align:'center'},
	                {name:'sign',				index:'sign', 				width:50, 	align:'center'},
	                {name:'companyCd',			index:'companyCd', 			hidden:true},
	                {name:'strCd',				index:'strCd', 				hidden:true}	                
	           ],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:20,
		rowList:[10,20,50,100],
	    pager: '#gridStoreMgntPager',
	    recordtext: "{1} 건/페이지  (전체 {2} 건)",
		emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 260,
		onSelectRow : function(rowid, iRow, iCol, e) {
			 var list = $("#gridStoreMgnt").getRowData(rowid);
			 
			 // 수정
			 fncUpt(list);
		},
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='14'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		loadComplete : function(data) {
			var list   = $("#gridStoreMgnt").getRowData();
			var rowCnt = list.length;
			
			if( rowCnt > 0 ) {
				$("#gridStoreMgnt").jqGrid('setSelection', 1);
			}
		}
	});
	  //jqGrid Resize 
	  jqGridResize('gridStoreMgnt');
	  
	// validate
	$('#saveForm').validate({
		rules:{
			strCd:{required:true},			
			mainMeter:{required:true},
			//excldMeter:{required:true},
			subMeterTemp:{required:true},
			hacon:{required:true},
			tSensor:{required:true},
			temon:{required:true},
			zigbee:{required:true},
			almon:{required:true},
			inv:{required:true},
			sign:{required:true},
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
	
	// 엔터 키 이벤트
	$("input[name='scrStrCd']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncSearch();
	        }
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
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/
// 검색
function fncSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var scrOrgNm = $.trim($("#scrOrgNm").val());
	if (scrOrgNm == "") {
		$("#scrOrgCd").val("");
	}
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:companyCd,
			 scrStrCd:$("#scrStrCd").val(),				 
			 scrOrgCd:$("#scrOrgCd").val(),			 
		 }
	 }).trigger("reloadGrid");
}

// 수정
function fncUpt(list) {
	var companyCd = $.trim(list.companyCd);
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	var strCd = $.trim(list.strCd);	
	$("#strCd").val(strCd);		
 	var mainMeter = $.trim(list.mainMeter);	
	$("#mainMeter").val(mainMeter);
	//var excldMeter = $.trim(list.excldMeter);	
	//$("#excldMeter").val(excldMeter);
	var subMeterTemp = $.trim(list.subMeterTemp);	
	$("#subMeterTemp").val(subMeterTemp);
	var hacon = $.trim(list.hacon);	
	$("#hacon").val(hacon);
	var tSensor = $.trim(list.tSensor);	
	$("#tSensor").val(tSensor);
	var temon = $.trim(list.temon);	
	$("#temon").val(temon);
	var zigbee = $.trim(list.zigbee);	
	$("#zigbee").val(zigbee);
	var almon = $.trim(list.almon);	
	$("#almon").val(almon);
	var inv = $.trim(list.inv);	
	$("#inv").val(inv);
	var sign = $.trim(list.sign);	
	$("#sign").val(sign);
	var strNm = document.getElementById("strNm"); 
		strNm.innerHTML = $.trim(list.strNm);	
}

// 저장
function fncSave() {
	if ($('#saveForm').valid()) {
		if (confirm("${smCommMsgSaveCnf}")) {
			$.ajax({
				url:'/saveStoreRemsMgnt',
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
	var scrStrCd = $("#scrStrCd").val();
	var scrOrgCd = $("#scrOrgCd").val();
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrStrCd);
	$("#excel3").val(scrOrgCd);
	
	$('#excelDownload').attr("action", "/downloadstoreRemsMgntExcel");
	$("#excelDownload").submit();

}
</script>
<div id="loadingArea">
	<form id="excelDownload" name='excelDownload' method='post'>
		<input type="hidden" id="excel1" name="scrCompanyCd"> 
		<input type="hidden" id="excel2" name="scrStrCd"> 
		<input type="hidden" id="excel3" name="scrOrgCd"> 
	</form>
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
				<th>매장명/코드</th>
				<td>
					<input type='search' id='scrStrCd' name='scrStrCd' value="" style="width:100px;" placeholder="전체"/>
				</td>
				<th>조직명(코드)</th>
				<td><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
			</tr>
			<!-- DB 변경으로 미사용	
			<tr>
				<th>미터수집사용여부</th>
				<td colspan="3">
					<span class="r_radio">
						<input type='radio' id='scrMeterCollector1' name='scrMeterCollector' value='1' /> <label for="scrMeterCollector1">사용</label>&nbsp;
						<input type='radio' id='scrMeterCollector0' name='scrMeterCollector' value='0' /> <label for="scrMeterCollector0">미사용</label>
					</span>
				</td>
			</tr>
			 -->
		</table>
		<span class="search">
			<button onclick="javascript:fncSearch()">Search</button>
		</span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">
			<h3>렘스장비 목록</h3>
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();"/>
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle">
			<h3>상세정보  - &nbsp;<div id ="strNm" style ="float:right"></div> </h3><div></div>
		</div>
		<form id="saveForm" name="saveForm" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="" /><!-- 회사 코드 -->
			<input type='hidden' id='strCd' name='strCd' value="" /><!-- 매장 코드 -->			
			<table>
		    	<colgroup>
			    	<col width="15%" />
			    	<col width="" />
			    	<col width="15%" />
			    	<col width="" />
			    	<col width="15%" />
			    	<col width="" />
		    	</colgroup>
		    	<tbody>
		       		<tr>
		       			<!-- DB변경으로 미사용
		         		<th><span class="r_required">*</span>미터수집사용여부</th>
		         		<td colspan="5" class="tleft">
							<span class="r_radio">
					    		<input type='radio' name='meterCollector' id='meterCollector_1' value='1'/><label for="meterCollector_1">사용</label>&nbsp;
						    	<input type='radio' name='meterCollector' id='meterCollector_0' value='0'/><label for="meterCollector_0">미사용</label>
							</span>
						</td>
						-->
					</tr>
					<tr>
						<th>메인미터</th>
		         		<td class="tleft">
							<select id="mainMeter" name="mainMeter">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>
						<!-- DB변경으로 미사용
						<th>예외미터</th>
						<td class="tleft">
							<select id="excldMeter" name="excldMeter">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="4" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>
						-->
						<th>냉난방미터</th>
						<td class="tleft">
							<select id="subMeterTemp" name="subMeterTemp">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="2" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>						
						<th>간판</th>
						<td class="tleft">
							<select id="sign" name="sign">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>					
					</tr>
					<tr>
						<th>하콘</th>
						<td class="tleft">
							<select id="hacon" name="hacon">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="2" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>
						<th>T-센서</th>
						<td class="tleft">
							<select id="tSensor" name="tSensor">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>
						<th>테몬</th>
						<td class="tleft">
							<select id="temon" name="temon">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>
					</tr>
					<tr>						
						<th>INV</th>
						<td class="tleft">
							<select id="inv" name="inv">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>						
						<th>지그비</th>
						<td class="tleft">
							<select id="zigbee" name="zigbee">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
						</td>
						<th>Almon</th>
						<td class="tleft">
							<select id="almon" name="almon">
								<option value="">--선택--</option>
								<c:forEach var="i" begin="0" end="1" step="1">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
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
	
</div>