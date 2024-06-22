<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>

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

var dupChk = false;
var oldUserId = "";
var title = js_er_title ='Error';
var gvPopParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	/*	
	alert( "${strCd}" );
	alert( "${strNm}" );
	alert( "${calculateYn}" );	
	alert( "${storeArea}");
	*/
	
	var strCd = "${strCd}";
	var storeArea = "${storeArea}";
	var strNm = "${strNm}";
	//alert( "${calculateYn}" );
	$('#strName').text( strNm);
	
	$('#storeArea').val( storeArea );
	$('#storeArea2').val( Math.round( storeArea * 0.3025 * 10 ) / 10 );
	
	$('#strCd').val( strCd );
	$('#strNm').val( strNm);
	
	$('#excelForm').ajaxForm({
		type : "POST",
		cache : false,
		async: false,
		url: "/demandPowerExcelRead",
		dataType : "json",
		beforeSend: function()
		{	
			$('#detailContent').html('');
			$('#calculateDetail').hide();
			
		},
		success: function(result) {
			//alert( result );
			//alert( JSON.stringify(result));			
			excelData = result;
			console.log( result );
			//alert( result.length );
			var lastRow = result.length -1 ;
			
			for(var i=0; i<result.length-2; i++)
			{
				$('#detailContent').append("<tr>"+
						"<td>"+ result[i].deviceGroup +"</td>"+
						"<td>"+ result[i].deviceNm +"</td>"+
						"<td>"+ Math.ceil( result[i].deviceCnt ) +"</td>"+
						"<td>"+ result[i].deviceUnit +"</td>"+
						"<td>"+ result[i].deviceStandard +"</td>"+						
						"<td>"+ Math.ceil( result[i].consumWatage ) +"</td>"+
						"<td>"+ Math.ceil( result[i].useWatage )  +"</td>"+
						"<td>"+ result[i].note+"</td>"+						
						"</tr>");
			}
			
			$('#consumWatageVal').text( 	result[lastRow].consumWatageSum );
			$('#demandPowerVal').text(		result[lastRow].demandPower );
			$('#recommendDemandPowerVal').text( result[lastRow].recommendDemandPower );
			
			$('#calculateDetail').show();
			
			// TnM 추천계약전력 계산
		},
        error: function(result) {
        	alert('잘못된 파일 or 형식이 잘못되었습니다.');
        }
	});
});

/*******************
1. 기타 필수 스크립트
********************/


var detailAccordion = 0;
function fncDetailAccordion(){
	
	if( detailAccordion == 0 ){
		$('#detailAccordion').show();
		detailAccordion = 1;
	}else{
		$('#detailAccordion').hide();
		detailAccordion = 0;
	}	
}

function fncDupInit(){
	if(oldUserId != $('#userId').val()){
		 dupChk = false;
		 $('#dupMsg').html('');
	 }  
}

function fncUserIdDupChk(){
	
	if($('#userId').valid()){
		var userId = $('#userId').val();
		oldUserId = userId;
		
		$.ajax({
			url:'/checkUserId',
			type:'POST',
			cache:false,
			data : {userId:userId},
			dataType:'json',
			success:function(data){
				if(data == true ){
					$('#dupMsg').html('사용 가능');
					dupChk = true;
				}else{
					$('#dupMsg').html('중복 정보');
					dupChk = false;	
				}
			},
			error:function(result){
				$('#dupMsg').html('${smCommMsgUse}');
				dupChk = true;
			}				
		});			
	}
}

/*******************
1. 팝업  
********************/

function fncOrgSearch2depth(){
	var companyCd  = $("#companyCd").val();
	
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop2ndForm("orgSrch2depth", "팝업", 800, 650, "popupForm2", args );
}

function fncSetOrg2depth(data)
{
	$("#orgCd").val(data.orgCd);
	$("#orgNm").val(data.orgNm);
}

function fncStrSearch2depth(obj)
{
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop2ndForm("storeMngSrch2depth", "팝업", 800, 650, "popupForm2", args );
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/
function fncSave()
{
	var authCd = "";
	
	if( $(":radio[name='authSp']:checked").val() == 'H' ){
		authCd = $('#authCd1').val();
	}else if( $(":radio[name='authSp']:checked").val() == 'M' ){
		authCd = $('#authCd2').val();
	}else if( $(":radio[name='authSp']:checked").val() == 'S' ){
		authCd = $('#authCd3').val();
	}else if( $(":radio[name='authSp']:checked").val() == 'T' ){
		authCd = $('#authCd4').val();
	}
	
	$('#authCd').val(authCd);
	
	if($('#saveForm').valid()){
		if(!dupChk){
			$('#dupMsg').html('${smCommMsgDupChk}');
			return;
		}

		if(confirm('${smCommMsgSaveCnf}')){
			
			$.ajax({
				url:'/saveUserMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					fncSearch();
					fncDivPop1Close();
				},
				error:function(result){
				}				
			});
		}
	}
}
	
function fncCancel()
{
	fncDivPop1Close();
	gridExcelDataListReload();
}

function numberCheck()
{
	var numberVal = ($('#storeArea').val()).trim();
	var token = numberVal.split(".");
	var len = numberVal.length;
	var ch = numberVal.charAt(0);
	
	if( token[1] != null && token[1].length > 1 )
	{
		alert("소수점 첫째자리까지 입력 가능");
		$('#storeArea').val( numberVal.substr(0, len-1) );
		$('#storeArea2').val( Math.round( numberVal.substr(0, len-1) * 0.3025 * 10 ) / 10 );
		return;
	}
	
	for(i = 0; i < len; i++)
	{ 	
		ch = numberVal.charAt(i); 
		if( (ch >= '0' && ch <= '9') || ch == '.' ) 
		{
			$('#storeArea2').val( Math.round( numberVal * 0.3025 * 10 ) / 10 );
			continue;
		} 
 		else 
 		{ 
			alert("숫자만 입력가능합니다.");
			$('#storeArea').val("");
			return;
 		}	
	}
}

function checkFile()
{	
	
	//alert( rowId );
	var fileValue = $("#file").val().split("\\");
	var fileName = fileValue[fileValue.length-1]; // 파일명

	if( fileName.substr(0,6) == "tnm" )
	{
		//$('#upLoadBtn').val(strCd);		
		//alert( $('#upLoadBtn').val() );
		
		var ids = $('#gridInputExcelList').jqGrid('getDataIDs');
		for (var i = 0; i < ids.length; i++) 
		{
			if( i != rowIndex )
			{
			    var rowId = ids[i];
			    var rowData = $('#gridInputExcelList').jqGrid ('getRowData', rowId);		    
			    
		    	var excelInputHtml = '';			    	
			    $('#gridInputExcelList').jqGrid('setRowData', rowId, { excelInput: excelInputHtml });
			}		
		}
	}
	else
	{
		alert('잘못된 파일형식 입니다.');	
		$('#upLoadBtn').hide();
		$('#dbInsertBtn').hide();
	}
}

function saveExcelFile()
{
	
	var strCd = $('#strCd').val();
	var strNm = $('#strNm').val();
	
	var fileName = strCd + "_" + strNm;
	
	if(fileName == "")
	{
		  alert(" 첨부파일을 다운로드할 수 없습니다.");
		  return;
	}
	
	if(!confirm("첨부파일을 다운로드 하시겠습니까?"))
		return;
	
	window.open("/saveExcel?strCd=" + strCd + "&strNm=" + strNm, "_blank"); 
	
}

</script>
<form id='popupForm2' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="strCd">
	<input type="hidden" id="popArg2" name="strNm">
	<input type="hidden" id="popArg3" name="calculateYn">
</form>
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<div class="r_popup">
	<!-- <h1 class="r_popupTitle">계약전력 산출</h1> -->
	
	<div class="r_popupCont">
    	<div class="r_inputTbl r_horizonTbl">  
			<form id="excelForm" name="excelForm" enctype="multipart/form-data" method="post" >
			
				<input type="hidden" id="strNm" name="strNm" />
				<input type="hidden" id="strCd" name="strCd" />
				<table>
					<tr>
						<th>매장명</th>
						<td><span id="strName" >-</span></td>
					</tr>
					<tr>
						<th>매장면적<span class="r_required">*</span></th>
						<td>
							<input type='text' id='storeArea' name='storeArea' style="width:100px;" data-clear-btn="true" maxlength="7" onKeyUp="javascript:numberCheck()" required/>
							㎡ (<input type='text' id='storeArea2' name='storeArea2' style="text-align:right;width:60px;border:0px;"  readonly/> 평 )
							<span style="font-size:0.8em;">( 소수점 입력 가능 )</span>							
						</td>
					</tr>
					<tr style="display:none;">
						<th>냉난방기 개수<span class="r_required">*</span></th>
						<td>
							<input type='text' id='tempNum' name='tempNum' style="width:100px;" value="2" maxlength="1" required/>							
						</td>
					</tr>
					<tr>
						<th>부하산정표<span class="r_required">*</span></th>						
						<td>
							<input type="file" id="excelFile" name="excelFile" onchange="javascript:checkFile();" style="width:300px;  min-width:100px; font-weight:bold; text-align:center; vertical-align:middle; padding:0 15px;" />	
						</td>						
					</tr>
					<tr>
						<th colspan="2" style="font-size:0.9em;color:red;">※ 시트명은 반드시 " tnm... "으로 변경후 진행하시길 바랍니다.<br>( 예시 : tnm_지에스본점(부하산정표) ) </th>						
												
					</tr>
														
				</table>
				
				
				
				<div class="r_pageBtnWrapper">
			    	<span class="pageNormal">
			    		<input type="submit" id="upLoadBtn" name="upLoad" value="계약전력 산출" />
		    		</span>
	    		</div>	
			</form>
    	</div>
	</div>
	<br>
	<div id="calculateDetail" style="display:none;">
		<div class="r_popupCont">
		    <div class="r_inputTbl r_horizonTbl">
				<table>					
					<tr>
						<th>소비전력</th>
						<td>
							<span id="consumWatageVal">-</span> kW							
						</td>
					</tr>
					<tr>
						<th>전기업체 계약전력( 0.85 )</th>
						<td>
							<span id="demandPowerVal">-</span> kW							
						</td>
					</tr>
					<tr style="background-color:rgba(255,167,167,1);">
						<th>TnM 추천계약전력</th>						
						<td>
							<span style="font-weight:bold;" id="recommendDemandPowerVal">-</span> kW	
						</td>						
					</tr>					
				</table>	
	    	</div>		    
		</div>
		
		<div class="r_pageBtnWrapper">
		    <span class="pageNormal">
		    	<button onclick="javascript:saveExcelFile()">엑셀 다운로드</button>
		    </span>
		</div>
		
		<div class="r_accordion r_open r_secondTbl">
			<div class="r_accordionTitle" onclick="fncDetailAccordion();" id="detailAccordionTitle">
				<span class="r_accordionIcon"></span>
				<h3>상세보기( 엑셀 내용 )</h3> <span style="float:right; font-size:0.8em;"> * 마우스 클릭</span>
			</div>
			<div class="r_accordionCont"  id="detailAccordion"  style="display:none; font-size:0.8em;">
			    <div class="r_inputTbl">
					<table>
				        <col width="10%"/>
				        <col width="20%"/>
				        <col width="5%"/>
				        <col width="5%"/>
				        <col width="10%"/>
				        <col width="15%" />					        
				        <col width="15%" />
				        <col width="20%" />
				        <thead>
				        	<tr>
					            <th scope="col">분류</th>
					            <th scope="col">장비명</th>
					            <th scope="col">수량</th>
					            <th scope="col">단위</th>
					            <th scope="col">규격(가로*세로*높이)</th>						            
					            <th scope="col">소비전력(W)</th>
					            <th scope="col">사용소비전력(W)</th>
					            <th scope="col">비고</th>
				        	</tr>
				        </thead>
				        <tbody id="detailContent">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="r_pageBtnWrapper">
		<span class="pageNormal">
			<button onclick="javascript:fncCancel()">닫기</button>
		</span>
	</div>
</div>