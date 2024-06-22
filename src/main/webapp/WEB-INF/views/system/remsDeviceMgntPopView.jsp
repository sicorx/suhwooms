<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<c:set var="smStrRemsDevIns"><spring:message code="strRemsDevIns"/></c:set>

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

var title = js_er_title ='Error';
var gvPopParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	$('#dialog-confirm').css('overflowY', 'auto');
	
	if('${newYn}' == "Y" ){
		
		
		// 주영 추가 GS 디폴트 장비 개수 셋팅
		$('#mainMeter').val(1);
    	$('#excldMeter').val(0);
    	$('#subMeterLight').val(0);
    	$('#subMeterTemp').val(1);
    	$('#dimmer').val(0);
    	$('#hacon').val(1);
    	$('#tSensor').val(1);
    	$('#temon').val(1);
    	$('#zigbee').val(0);
    	$('#almon').val(0);
    	$('#inv').val(1);
    	$('#sign').val(1);
		
		$('input[type=radio][name=meterCollector]').on('change', function(){
	    	
		    switch($(this).val()){
		        case '1' :
		        	$('#mainMeter').attr("readonly",false).removeClass("r_Input r_disable");
		        	$('#excldMeter').attr("readonly",false).removeClass("r_Input r_disable");
		        	$('#subMeterLight').attr("readonly",false).removeClass("r_Input r_disable");
		        	$('#subMeterTemp').attr("readonly",false).removeClass("r_Input r_disable");
		        	
		        	
		            break;
		        case '0' :
		            $('#mainMeter').attr("readonly",true).addClass("r_Input r_disable");;
		            $('#excldMeter').attr("readonly",true).addClass("r_Input r_disable");;
		        	$('#subMeterLight').attr("readonly",true).addClass("r_Input r_disable");;
		            $('#subMeterTemp').attr("readonly",true).addClass("r_Input r_disable");;

		            break;
		    }
		});
		
		$('#meterCollector_Y').prop('checked', true);
		$('#meterVendor_1').prop('checked', true);
		
	}else if('${newYn}' == "N" ){
		
		$('input[type=radio][name=meterCollector]').on('change', function(){

			switch($(this).val()){
		        case '1' :
		        	$('#mainMeter').attr("readonly",false).removeClass("r_Input r_disable");
		        	$('#excldMeter').attr("readonly",false).removeClass("r_Input r_disable");
		        	$('#subMeterLight').attr("readonly",false).removeClass("r_Input r_disable");
		        	$('#subMeterTemp').attr("readonly",false).removeClass("r_Input r_disable");
		       		$('#meterVendor_1').attr("disabled",false);
		       		$('#meterVendor_2').attr("disabled",false);
		            break;
		        case '0' :
		            $('#mainMeter').attr("readonly",true).addClass("r_Input r_disable");;
		            $('#excldMeter').attr("readonly",true).addClass("r_Input r_disable");;
		        	$('#subMeterLight').attr("readonly",true).addClass("r_Input r_disable");;
		            $('#subMeterTemp').attr("readonly",true).addClass("r_Input r_disable");;
		            $('#meterVendor_1').attr("disabled",true);
		       		$('#meterVendor_2').attr("disabled",true);
		            break;
		    }
		});
		
		if( '${storeRemsMgntDtl.meterCollector}'  == 'Y' ){
			$('#meterCollector_Y').prop('checked', true);
	       	$('#mainMeter').attr("readonly",false).removeClass("r_Input r_disable");
	       	$('#excldMeter').attr("readonly",false).removeClass("r_Input r_disable");
	       	$('#subMeterLight').attr("readonly",false).removeClass("r_Input r_disable");
	       	$('#subMeterTemp').attr("readonly",false).removeClass("r_Input r_disable");
	      		$('#meterVendor_1').attr("disabled",false);
	      		$('#meterVendor_2').attr("disabled",false);
		}else{
			$('#meterCollector_N').prop('checked', true);
	           $('#mainMeter').attr("readonly",true).addClass("r_Input r_disable");;
	           $('#excldMeter').attr("readonly",true).addClass("r_Input r_disable");;
	       	$('#subMeterLight').attr("readonly",true).addClass("r_Input r_disable");;
	           $('#subMeterTemp').attr("readonly",true).addClass("r_Input r_disable");;
	           $('#meterVendor_1').attr("disabled",true);
	      		$('#meterVendor_2').attr("disabled",true);
		}
		
	   	if('${storeRemsMgntDtl.meterVendor}'  == 'DT'){
	   		$('#meterVendor_1').prop('checked', true);
	   	}else if('${storeRemsMgntDtl.meterVendor}'  == 'OM'){
	   		$('#meterVendor_2').prop('checked', true);
	   	}
	   	
	}
	
    
    
	$("#remsStartDt, #remsEndDt").datepicker({
		dateFormat: 'yymmdd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true,
		changeYear: true,
		buttonText: "달력",
		showMonthAfterYear: true
	});
	


	$('#saveForm').validate({
		rules:{
			companyCd:{required:true},
			viewStrCd:{required:true},
			strNm:{required:true},
			mainMeter:{number:true, maxlength:2},							
			excldMeter:{number:true, maxlength:2},							
			subMeterLight:{number:true, maxlength:2},							
			subMeterTemp:{number:true, maxlength:2},							
			dimmer:{number:true, maxlength:2},
			hacon:{number:true, maxlength:2},
			tSensor:{number:true, maxlength:2},
			temon:{number:true, maxlength:2},
			zigbee:{number:true, maxlength:2},
			almon:{number:true, maxlength:1},
			inv:{number:true, maxlength:1},
			sign:{number:true, maxlength:2}
									
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
});

/*******************
1. 기타 필수 스크립트
********************/



/*******************
1. 팝업  
********************/

function fncParticularStrSearch(){

	var companyCd = $("#companyCd").val();
	var url = "storeRemsMgntNew";
	
	var args = new Array();
	
	args.push(companyCd);
	args.push(url);
	
	fn_divPop2ndForm("particularStoreSrch", "팝업", 800, 650, "popupForm2", args );
	
}

function fncSetParticularStore(data){
	$("#viewStrCd").val(data.viewStrCd);
	$("#strNm").val(data.strNm);
	$("#strCd").val(data.strCd);
}

function fncParticularStoreClear(){
	$("#strCd").val("");
	$("#viewStrCd").val("");
	$("#strNm").val("");
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSave() {
	
	if($('#saveForm').valid()){
		if(confirm('${smCommMsgSaveCnf}')){
			$.ajax({
				url:'/saveStoreRemsMgnt',
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

function fncCancel() {
	fncDivPop1Close();
}
</script>
<!-- jQuery validate 다국어 메세지 -->
<%@ include file="/WEB-INF/views/system/validate.jsp" %>
<form id='popupForm2' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="companyCd">
	<input type="hidden" id="popArg2" name="url">
</form>
<div class="r_popup">
   	 <h1 class="r_popupTitle">${smStrRemsDevIns}</h1>	  
 			<div class="r_popupCont">
   			<div class="r_inputTbl r_horizonTbl">    
			<form id="saveForm" name="saveForm" method="post">
				<table>
					<tr>
						<th>${smCompany}<span class="r_required">*</span></th>
						<td>
							<input type='hidden' id='companyCd' name='companyCd' value="${storeRemsMgntDtl.companyCd}" style="width:75px;"/>
							<input type='text' id='companyNm' name='companyNm' value="${storeRemsMgntDtl.companyNm}" style="width:75px;" class="r_Input r_disable" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<th>${smStr}<span class="r_required">*</span></th>
						<c:if test="${newYn eq 'Y' }">
							<td>
								<input type='hidden' id='strCd' name='strCd' value='' />
								<input type='text' id='viewStrCd' name='viewStrCd' value='' readonly="readonly" class="r_Input r_disable"  style="width:112px;" />
								<div class="r_innerSearch">
									<input type='text' id='strNm' name='strNm' value='' readonly="readonly" class="r_Input r_disable"  style="width: 112px;" />
									<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncParticularStrSearch();" style="cursor:pointer"/>
									<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncParticularStoreClear();" style="cursor:pointer;right:4px;"/>
								</div>
							</td>
						</c:if>
						<c:if test="${newYn eq 'N' }">
							<td>
								<input type='hidden' id='strCd' name='strCd' value='${storeRemsMgntDtl.strCd}' />
								<input type='text' id='viewStrCd' name='viewStrCd' value='${storeRemsMgntDtl.viewStrCd}' readonly="readonly" class="r_Input r_disable"  style="width:112px;" />
								<input type='text' id='strNm' name='strNm' value='${storeRemsMgntDtl.strNm}' readonly="readonly" class="r_Input r_disable"  style="width: 112px;" />
							</td>
						</c:if>
					</tr>
					<tr>
						<th>미터수집 여부<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
				    			<input type='radio' name='meterCollector' id='meterCollector_Y' value='1'/><label for="meterCollector_Y">사용</label>&nbsp;
					    		<input type='radio' name='meterCollector' id='meterCollector_N' value='0'/><label for="meterCollector_N">미사용</label>
							</span>
						</td>
					</tr>
					<tr>
						<th>미터 제조사<span class="r_required">*</span></th>
						<td>
							<span class="r_radio">
				    			<input type='radio' name='meterVendor' id='meterVendor_1' value='DT'/><label for="meterVendor_1">DIT</label>&nbsp;
					    		<input type='radio' name='meterVendor' id='meterVendor_2' value='OM' /><label for="meterVendor_2">옴니</label>
							</span>
						</td>
					</tr>
					<tr>
						<th>${smMainMeter}</th>
						<td><input type='number' id='mainMeter' name='mainMeter' value="${storeRemsMgntDtl.mainMeter}"  style="width:70px;" min="1" max="1" maxlength="1" /></td>
					</tr>
					<tr>
						<th>${smExcldMeter}</th>
						<td><input type='number' id='excldMeter' name='excldMeter' value="${storeRemsMgntDtl.excldMeter}"  style="width:70px;" min="0" max="4" maxlength="1" /></td>
					</tr>
					<tr>
						<th>${smSubMeterLight}</th>
						<td><input type='number' id='subMeterLight' name='subMeterLight' value="${storeRemsMgntDtl.subMeterLight}"  style="width:70px;" min="0" max="9" maxlength="1" /></td>
					</tr>
					<tr>
						<th>${smSubMeterTemp}</th>
						<td><input type='number' id='subMeterTemp' name='subMeterTemp' value="${storeRemsMgntDtl.subMeterTemp}"  style="width:70px;"min="0" max="9" maxlength="1"/></td>
					</tr>
					<tr>
						<th>${smDimmer}</th>
						<td><input type='number' id='dimmer' name='dimmer' value="${storeRemsMgntDtl.dimmer}"  style="width:70px;" min="0" max="9" maxlength="1"/></td>
					</tr>
					<tr>
						<th>${smHacon}</th>
						<td><input type='number' id='hacon' name='hacon' value="${storeRemsMgntDtl.hacon}"  style="width:70px;" min="0" max="9" maxlength="1"/></td>
					</tr>
					<tr>
						<th>${smTSensor}</th>
						<td><input type='number' id='tSensor' name='tSensor' value="${storeRemsMgntDtl.tSensor}"  style="width:70px;" min="0" max="9" maxlength="1"/></td>
					</tr>
					<tr>
						<th>${smTemon}</th>
						<td><input type='number' id='temon' name='temon' value="${storeRemsMgntDtl.temon}"  style="width:70px;" min="0" max="9" maxlength="1"/></td>
					</tr>
					<tr>
						<th>${smZigbee}</th>
						<td><input type='number' id='zigbee' name='zigbee' value="${storeRemsMgntDtl.zigbee}"  style="width:70px;" min="0" max="99" maxlength="2"/></td>
					</tr>
					<tr>
						<th>ALmon</th>
						<td><input type='number' id='almon' name='almon' value="${storeRemsMgntDtl.almon}"  style="width:70px;" min="0" max="9" maxlength="1"/></td>
					</tr>
					<tr>
						<th>INV</th>
						<td><input type='number' id='inv' name='inv' value="${storeRemsMgntDtl.inv}"  style="width:70px;" min="0" max="1" maxlength="1"/></td>
					</tr>
					<tr>
						<th>${smSign}</th>
						<td><input type='number' id='sign' name='sign' value="${storeRemsMgntDtl.sign}"  style="width:70px;" min="0" max="1" maxlength="1"/></td>
					</tr>
				</table>
			</form>
   		</div>
   		<div class="r_pageBtnWrapper">
     		<span class="pageNormal">
     			<button onclick="javascript:fncCancel()">${smClos}</button>
     		</span>
     		<span class="pageNormal">
     			<button onclick="javascript:fncSave()">${smSave}</button>
     		</span>
		</div>
		</br>
		</br>
		</br>
	</div>
</div>
