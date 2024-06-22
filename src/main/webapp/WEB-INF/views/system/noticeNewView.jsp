<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
var menuAuthList = {};

$(document).ready(function(){
	
	init();	
	
	$("#authId_4").change(function(){
        if($("#authId_4").is(":checked")){
        	fncLoadMenuAuth();
        }else{
        	$("#rightTree").remove();
        }
    });
	
});
	
// 초기 셋팅
function init() {

	var mode = '${mode}';
	
	if("NEW"== mode){
		$("input:radio[name='pubYn']:radio[value='N']").attr("checked",true);
	}
	
	$("#pubStartDt, #pubEndDt" ).datepicker({  
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true,		
		// 달력 아이콘  
	    showOn: "button",  
	    buttonImage: "/images/btn_calendar_new.png",  
	    buttonImageOnly: true,  
	    // 달력 하단의 종료와 오늘 버튼 Show  
	    showButtonPanel: true,  
	    // date 포멧  
	    showAnim : "",  
	    // 다른 달의 일 보이기, 클릭 가능  
	    numberOfMonths: 1,  
	    showButtonPanel: true,		    
	});

	var list = new Array(); 
	<c:forEach var="item" items="${noticeTargetList}" >
		list.push("${item.authId}");
	</c:forEach>


	for(var i=0; i<list.length; i++){
		$("input:checkbox[id='authId_"+list[i]+"']").attr("checked", true);
		if(list[i] == 4){
			fncLoadMenuAuth();
		}
	}
}
	
	
// 하루전, 한달전, 계산 
function funcMakeDate(day){		 
    var YYYY, MM, DD;
    var date = new Date();
    var d = new Date(Date.parse(date)-86400000*day);	
    
    YYYY = d.getFullYear();	    
    
    //한자릿수 월 앞에 0을 붙이기 위한 if문
    if(d.getMonth() < 9)	        
    	MM = '0'+(d.getMonth()+1);
    else
    	MM = d.getMonth()+1;	    
 
    if(d.getDate() < 9)
        DD = '0'+(d.getDate());
    else
        DD = d.getDate();	    
    
    return YYYY+"-"+ MM +"-"+ DD;
}

//권한에 해당하는 메뉴권한 가져오기
function fncLoadMenuAuth() {
    $.ajax({
        url: '/retrieveOrgCdList',
        type: 'POST',
        cache: false,
        data: {noticeId:$("#noticeId").val()},
        dataType: 'json',
        success: function (data) {
            console.log("data:", data);
            if (data && data.success) {
                fncRightTreeReload(eval(data.json));
            } else {
                alert('fail');
            }
        },
        error: function (result) {
            alert('에러가 발생 했습니다');
        }
    });
}

function fncRightTreeReload(source) {
    $("#rightTreeDiv").html('<div id="rightTree"></div>');

    console.log("source:", source);
    
    menuAuthList = {};
    loadMenuAuthList(source);
	  
    $("#rightTree").fancytree({
        checkbox: true,
        selectMode: 3,
        source: source,
        loadChildren: function (event, ctx) {

        },
        select: function (event, data) {

        },
        dblclick: function (event, data) {
            data.node.toggleSelected();
        },
        keydown: function (event, data) {
            if (event.which === 32) {
                data.node.toggleSelected();
                return false;
            }
        },
        // The following options are only required, if we have more than one tree on one page:
        cookieId: "fancytree-orgsel",
        idPrefix: "fancytree-orgsel-"
    });
    

    fncExpandAll('rightTree');
}

function loadMenuAuthList(json) {
    var obj;
    for (var i = 0, size = json.length; i < size; i++) {
        obj = json[i];
        menuAuthList[obj.key] = !!obj.selected;
        if (obj.folder && obj.children) {
            loadMenuAuthList(obj.children);
        }
    }
}
	
//버튼 : 전체 펼치기
function fncExpandAll(treeId) {
    $("#" + treeId).fancytree("getRootNode").visit(function(node){
        node.setExpanded(true);
    });
}
	
function funcSave() {
	var mode = '${mode}';
	
	if("NEW"== mode){
		if(true == isValue()){
		    if (!confirm("저장하시겠습니까?")) {
		        return false;
		    }
		    if($("#authId_4").is(":checked")){
		    	if (!addFormNodeData()) return;
		    }
		    $.ajax({
		        url: '/saveNotice',
		        type: 'POST',
		        cache: false,
		        data: $('#saveForm').serialize(),
		        dataType: 'json',
		        success: function (data) {
		            if (data && data.success) {
		                alert('${smCommMsgSave}');
		                reload();
		            } else {
		                var msg = '저장에 실패 했습니다.';
		                if (data && data.errMsg) {
		                    msg += '\n' + data.errMsg;
		                }
		                alert(msg);
		            }
		        },
		        error: function (result) {
		            alert('에러가 발생 했습니다');
		        }
		    });
		}			
	}else{
		if(true == isValue()){
		    if (!confirm("저장하시겠습니까?")) {
		        return false;
		    }
		    if($("#authId_4").is(":checked")){
		    	if (!addFormNodeData()) return;
		    }
		    
		    $.ajax({
		        url: '/saveNotice2',
		        type: 'POST',
		        cache: false,
		        data: $('#saveForm').serialize(),
		        dataType: 'json',
		        success: function (data) {
		            if (data && data.success) {
		                alert('${smCommMsgSave}');
		                reload();
		            } else {
		                var msg = '저장에 실패 했습니다.';
		                if (data && data.errMsg) {
		                    msg += '\n' + data.errMsg;
		                }
		                alert(msg);
		            }
		        },
		        error: function (result) {
		            alert('에러가 발생 했습니다');
		        }
		    });
		}			
	}
}
	
function reload() {
    $.ajax({
        type: "POST",
        cache: false,
        url: window.dhtmlHistory.currentLocation,
        data: '',
        success: function (data) {
            $("#r_contents").html(data);
        }
    });
}	

function isValue() {
	var isValue = true;
	
	if(""==$("#title").val()){
		alert("제목을 입력해 주세요.");
		$("#title").focus();
		isValue = false;
		return false;
	} 
	if(""== $("input:radio[name='pubYn']:checked").val()){
		alert("개시여부를 선택해 주세요.");
		$("#pubYn_Y").focus();
		isValue = false;
		return false;
	}
	if(""==$("#noticeTypeCd option:selected").val()){
		alert("공지 종류를 선택해 주세요.");
		$("#noticeTypeCd").focus();
		isValue = false;
		return false;
	}		
	if(""==$("#pubStartDt").val()){
		alert("개시 시작일자를 선택해 주세요.");
		$("#pubStartDt").focus();
		isValue = false;
		return false;
	} 
	if(""==$("#pubEndDt").val()){
		alert("개시 종료일자를 선택해 주세요.");
		$("#pubEndDt").focus();
		isValue = false;
		return false;
	}
	if(""!=$("#pubStartDt").val() && ""!=$("#pubEndDt").val()){
		var startDt = $("#pubStartDt").val().replace(/\-/g,"");
		var endDt = $("#pubEndDt").val().replace(/\-/g,"");
		if(startDt > endDt){
			alert("게시기간을 바르게 입력해 주세요.");
			$("#pubStartDt").focus();
			isValue = false;
			return false;
		}
	}
	if(""==$("#contents").val()){
		alert("공지내용을 입력해 주세요.");
		$("#contents").focus();
		isValue = false;
		return false;
	} 		
	return isValue;
}


//메뉴내용 폼데이터에 적용하기
function addFormNodeData() {
	var orgCdArray = [];
	
	$("#rightTree").fancytree("getRootNode").visit(function(node){
		if (!!node.selected || !!node.partsel) {
			console.log("node.key:", node.key);
			orgCdArray.push(node.key);
		}
	});
	
	if (orgCdArray.length == 0) {
		alert("선택한 조직이 없습니다.");
		return false;
	} else {
		$('#orgCdArray').val(orgCdArray.join(","));
	}
	return true;
}

// 취소 버튼
function funcCancle() {
	if(confirm('취소하시겠습니까?')) {
		var param  = new Object();
		param.mode = "BACK";
		param.title = '${history.title}';
		param.noticeTypeCd = '${history.noticeTypeCd}';
		param.authId = '${history.authId}';
		param.scrDateFrom = '${history.pubStartDt}';
		param.scrDateTo = '${history.pubEndDt}';

   		fncCallPage('retrieveNoticeList', param);
   	}
}    
</script>

<style>
th,td{border:1px solid;}
</style>

<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="strCd"> 
	<input type="hidden" id="popArg2" name="viewStrCd"> 
	<input type="hidden" id="popArg3" name="companyCd"> 
	<input type="hidden" id="popArg4" name="companyNm">
	<input type="hidden" id="popArg5" name="localAreaNm"> 
</form>

<div id="loadingArea">

	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle top_table">
			<h3>공지사항 등록/수정</h3>
		</div>
	
		<!-- 공지사항등록 -->
		<form id="saveForm" name="saveForm" method="post">
		<input type='hidden' id='noticeId' name='noticeId' value='${noticeDtl.noticeId}'/>
		<input type='hidden' id='companyCd' name='companyCd' value='${companyCd}'/>
		<input type='hidden' id='orgCdArray' name='orgCdArray' />
		<input type='hidden' id='mode' name='mode' value='${mode}'/>
		<div id="strInfoDiv">
			<table>
				<colgroup>
					<col width="" />
					<col width="500" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tbody>
				<tr>
					<th>*제목</th>
					<td colspan="3" class="tleft">
						<input type='text' id='title' name='title' value='${noticeDtl.title}'/>
					</td>
				</tr>			
				<tr>
					<th>*게시여부</th>
					<td class="tleft">
						<span class="r_radio">
					   		<input type='radio' name='pubYn' id='pubYn_Y' value='Y' <c:if test="${noticeDtl.pubYn == 'Y'}">checked</c:if>/><label for="pubYn_Y">게시</label>&nbsp;
					    	<input type='radio' name='pubYn' id='pubYn_N' value='N' <c:if test="${noticeDtl.pubYn == 'N'}">checked</c:if>/><label for="pubYn_N">미게시</label>
						</span>					  
					</td>
					<th>공지종류</th>
					<td class="tleft">
						<select id="noticeTypeCd" name="noticeTypeCd" style="width:130px;" class="tblSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.code}' <c:if test="${noticeDtl.noticeTypeCd == vo.code}">selected</c:if>>${vo.commCdNm}</option>
								</c:forEach>
						</select>	
					</td>			
				</tr>
				<tr>
					<th>게시기간</th>
					<td colspan="3" class="tleft">
						<input id="pubStartDt" name="pubStartDt" type="text" placeholder="" value='${noticeDtl.pubStartDt}' style="width:90px;" readonly />
						~ <input id="pubEndDt" name="pubEndDt" type="text" placeholder="" value='${noticeDtl.pubEndDt}'	style="width:90px;" readonly />
					</td>							
				</tr>
				<tr>
				<th>게시대상</th>
					<td class="tleft"> 
						<c:forEach var="vo" items="${authNmList}" varStatus="status">
							<input type="checkbox" id="authId_${vo.authId}" name="authId" value="${vo.authId}"/><label for="authId_${vo.authId}">${vo.authNm}</label>
						</c:forEach>
					</td>
					<td colspan="2" class="tleft">
			            <div id="rightTreeDiv" style="overflow:auto; height:200px;">
			                <div id="rightTree"></div>
			            </div>
					</td>		
				</tr>
				
				<tr>
					<th>내용</th>
					<td colspan="3" class="tleft pt_5 pb_5">
						<textarea id="contents" name="contents" rows="10" cols="40" style="width:100%;">${noticeDtl.contents}</textarea>
					</td>				
				</tr>	
				</tbody>									
			</table>
		</div>	
		</form>
	
		<div class="r_pageBtnWrapper mr_0 ml0 border_none">	
		   	<span class="pageNormal">
		   		<button onclick="javascript:funcSave();">저장</button>
		   	</span>	&nbsp;			
			<span class="pageNormal">
		   		<button onclick="javascript:funcCancle();">취소</button>
		   	</span>	
		</div>
	</div>
</div>