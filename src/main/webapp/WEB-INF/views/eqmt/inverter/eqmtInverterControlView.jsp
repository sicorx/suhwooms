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
<c:set var="smDeviceType"><spring:message code="deviceType"/></c:set>
<c:set var="smMaxTempAlarmYn"><spring:message code="maxTempAlarmYn"/></c:set>
<c:set var="smMaxTemp"><spring:message code="maxTemp"/></c:set>
<c:set var="smMinTempAlarmYn"><spring:message code="minTempAlarmYn"/></c:set>
<c:set var="smAlarmMask"><spring:message code="alarmMask"/></c:set>
<c:set var="smDefrostSensTemp"><spring:message code="defrostSensTemp"/></c:set>
<c:set var="smAlarm"><spring:message code="alarm"/></c:set>
<c:set var="smMinTemp"><spring:message code="minTemp"/></c:set>
<c:set var="smErrCd"><spring:message code="errCd"/></c:set>
<c:set var="smDefwOwner"><spring:message code="defwOwner"/></c:set>
<c:set var="smOperMode"><spring:message code="operMode"/></c:set>
<c:set var="smDefrostTempConf"><spring:message code="defrostTempConf"/></c:set>
<c:set var="smInnerTemp"><spring:message code="innerTemp"/></c:set>
<c:set var="smDefrostTerm"><spring:message code="defrostTerm"/></c:set>
<c:set var="smInnerTempConf"><spring:message code="innerTempConf"/></c:set>
<c:set var="smDefrostDelay"><spring:message code="defrostDelay"/></c:set>
<c:set var="smSensTempOut"><spring:message code="sensTempOut"/></c:set>
<c:set var="smDewaterDelay"><spring:message code="dewaterDelay"/></c:set>
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
<c:set var="smInvDtlInfo"><spring:message code="invDtlInfo"/></c:set>
<c:set var="smAlarmMaskTip"><spring:message code="alarmMaskTip"/></c:set>
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

$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	$('#saveForm').validate({
		rules:{
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

function checkChangeValue(){
	
	var alarmMaskFlag = 0;
	var operModeFlag = 0;
	var sensTempConfFlag = 0;
	var maxTempAlarmYnFlag = 0;
	var maxTempFlag = 0;
	var minTempAlarmYnFlag = 0;
	var minTempFlag = 0;
	var defrostTempConfFlag = 0;
	var defrostTermFlag = 0;
	var defrostDelayFlag = 0;
	var dewaterDelayFlag = 0;
	
	//make Flag
	if( "${gisVo.maxTempAlarmMask}" != $("select[name=maxTempAlarmMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.minTempAlarmMask}" != $("select[name=minTempAlarmMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.sensTempMask}" != $("select[name=sensTempMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.defrostSensTempMask}" != $("select[name=defrostSensTempMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.highPressureMask}" != $("select[name=highPressureMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.lowPressureMask}" != $("select[name=lowPressureMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.compMask}" != $("select[name=compMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.linkMask}" !=$("select[name=linkMask]").val() ){
		alarmMaskFlag = 1;
	}
	if( "${gisVo.operMode}" != $(':radio[name="operMode"]:checked').val() ){
		operModeFlag = 1;
	}

	var tempSensTempConf1 = "${gisVo.sensTempConf}" * 10;
    var tempSensTempConf2 = $("#sensTempConf").val() * 10;
	
	if(tempSensTempConf1 != tempSensTempConf2 ){
		sensTempConfFlag = 1;
	}
	if( "${gisVo.maxTempAlarmYn}" != $(':radio[name="maxTempAlarmYn"]:checked').val() ){
		maxTempAlarmYnFlag = 1;
	}
	if( "${gisVo.maxTemp}" != $('#maxTemp').val() ){
		maxTempFlag = 1;
	}
	if( "${gisVo.minTempAlarmYn}" != $(':radio[name="minTempAlarmYn"]:checked').val() ){
		minTempAlarmYnFlag = 1;
	}
	if( "${gisVo.minTemp}" != $('#minTemp').val() ){
		minTempFlag = 1;
	}
	if( "${gisVo.defrostTempConf}" != $('#defrostTempConf').val() ){
		defrostTempConfFlag = 1;
	}
	if( "${gisVo.defrostTerm}" != $('#defrostTerm').val() ){
		defrostTermFlag = 1;
	}
	if( "${gisVo.defrostDelay}" != $('#defrostDelay').val() ){
		defrostDelayFlag = 1;
	}
	if( "${gisVo.dewaterDelay}" != $('#dewaterDelay').val() ){
		dewaterDelayFlag = 1;
	}
	
	//make mask
	var maxTempAlarmMask = $("select[name=maxTempAlarmMask]").val();
	var minTempAlarmMask = $("select[name=minTempAlarmMask]").val();
	var sensTempMask = $("select[name=sensTempMask]").val();
	var defrostSensTempMask = $("select[name=defrostSensTempMask]").val();
	var highPressureMask = $("select[name=highPressureMask]").val();
	var lowPressureMask = $("select[name=lowPressureMask]").val();
	var compMask = $("select[name=compMask]").val();
	var linkMask = $("select[name=linkMask]").val();
	
	//flag, mask 정리
	var controlFlag1 =  alarmMaskFlag * 1 + operModeFlag * 2 + sensTempConfFlag * 4 + maxTempAlarmYnFlag * 8 + maxTempFlag * 16 + minTempAlarmYnFlag * 32 + minTempFlag * 64;
	var controlFlag2 = defrostTempConfFlag * 1 + defrostTermFlag * 2 + defrostDelayFlag * 4 + dewaterDelayFlag * 8;
	
	//Alarm Mask1, Alarm Mask2
	var alarmMask1 = maxTempAlarmMask * 1 + minTempAlarmMask * 2 + sensTempMask * 4 + defrostSensTempMask * 8 + highPressureMask * 16 + lowPressureMask * 32 + compMask * 64	+ linkMask * 128;
	var alarmMask2 = 0;	
	
	$('#controlFlag1').val(controlFlag1);
	$('#controlFlag2').val(controlFlag2);
	$('#alarmMask1').val(alarmMask1);
	$('#alarmMask2').val(alarmMask2);
	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSave(){
	
	checkChangeValue();
	
	if($('#saveForm').valid()){			
		
		if(confirm("${smCommMsgSaveCnf}")){

			$.ajax({
				url:'/controlInverterSignleMachine',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert("제어 요청이 완료 되었습니다.");
				},
				error:function(result){
					alert("제어 요청이 실패 했습니다.");
				}
			});
		}
	}

}


function fncCancel() {

	fncDivPop1Close();

}

</script>
<div class="r_popup">
	<h1 class="r_popupTitle">인버터 장비 제어</h1>
		<div class="r_popupCont">
			<form id="saveForm" name="saveForm" method="post">
				<table style="width:50%">
					<tr>
						<td style="width:50%">매장 : ${gisVo.strNm}</td>
						<td style="width:50%">장치 : [${gisVo.deviceLoc}]</td>
					</tr>
				</table>
				<div class="r_inputTbl r_horizonTbl"> 
					<div class="r_compWrapper">
						<div class="r_grid">
							<input type="hidden" id="strCd" name="strCd" value="${gisVo.strCd}"/>
							<input type="hidden" id="hubId" name="hubId" value="${gisVo.hubId}"/>
							<input type="hidden" id="portNo" name="portNo" value="${gisVo.portNo}"/>
						    <input type="hidden" id="controlFlag1" name="controlFlag1" value=""/>
						    <input type="hidden" id="controlFlag2" name="controlFlag2" value=""/>
						    <input type="hidden" id="alarmMask1" name="alarmMask1" value=""/>
						    <input type="hidden" id="alarmMask2" name="alarmMask2" value=""/>
							<table>
								<caption>Grid Table</caption>
								<col width="12.5%" />
					        	<col width="12.5%" />
					        	<col width="12.5%" />
					        	<col width="12.5%" />
					        	<col width="12.5%" />
					        	<col width="12.5%" />
					        	<col width="12.5%" />
					        	<col width="12.5%" />
					       	 	<thead>
					        		<tr>
										<th scope="col">고온알람</th>
										<th scope="col">저온알람</th>
										<th scope="col">온도센서</th>
										<th scope="col">제상센서</th>
										<th scope="col">고압알람</th>
										<th scope="col">저압알람</th>
										<th scope="col">압축기알람</th>
										<th class="r_last" scope="col">링크알람</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<select id="maxTempAlarmMask" name="maxTempAlarmMask" style="width:70px;" class="tblSelect" >
												<option value='1'<c:if test="${gisVo.maxTempAlarmMask == 1}">selected</c:if> >비활성</option>
												<option value='0'<c:if test="${gisVo.maxTempAlarmMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="minTempAlarmMask" name="minTempAlarmMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.minTempAlarmMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.minTempAlarmMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="sensTempMask" name="sensTempMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.sensTempMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.sensTempMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="defrostSensTempMask" name="defrostSensTempMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.defrostSensTempMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.defrostSensTempMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="highPressureMask" name="highPressureMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.highPressureMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.highPressureMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="lowPressureMask" name="lowPressureMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.lowPressureMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.lowPressureMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="compMask" name="compMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.compMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.compMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
										<td>
											<select id="linkMask" name="linkMask" style="width:70px;" class="tblSelect" >
												<option value='1' <c:if test="${gisVo.linkMask == 1}">selected</c:if> >비활성</option>
												<option value='0' <c:if test="${gisVo.linkMask == 0}">selected</c:if> >활성</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<br></br>
	    		<div class="r_inputTbl r_horizonTbl">		
					<table>
					<tr>
						<th width="25%">${smOperMode}</th>
						<td width="25%">
							<span class="r_radio">
					    		<input type='radio' name='operMode' id='operMode_1' <c:if test="${gisVo.operMode == 17}">checked</c:if> value='17'/><label for="operMode_1">냉장/냉동</label>&nbsp;
						    	<input type='radio' name='operMode' id='operMode_2' <c:if test="${gisVo.operMode == 18}">checked</c:if> value='18'/><label for="operMode_2">제상</label>
							</span>
						</td>
						<th width="25%">${smInnerTempConf}<span class="r_required">(소수 1자리 가능)</span></th>
						<td width="25%"><input type='number' id='sensTempConf' name='sensTempConf' style="width:70px; text-align: center" value="${gisVo.sensTempConf}" required/>
					</tr>
					<tr>
						<th>${smMaxTempAlarmYn}</th>
						<td>
							<span class="r_radio">
					    		<input type='radio' name='maxTempAlarmYn' id='maxTempAlarm_Y' <c:if test="${gisVo.maxTempAlarmYn == 1}">checked</c:if> value='1'/><label for="maxTempAlarm_Y">사용</label>&nbsp;
						    	<input type='radio' name='maxTempAlarmYn' id='maxTempAlarm_N' <c:if test="${gisVo.maxTempAlarmYn == 0}">checked</c:if> value='0'/><label for="maxTempAlarm_N">미사용</label>
							</span>
						</td>
						<th>${smDefrostTempConf}</th>
						<td><input type='number' id='defrostTempConf' name='defrostTempConf' style="width:70px; text-align: center" value="${gisVo.defrostTempConf}" required/></td>
					</tr>
					<tr>
						<th>${smMaxTemp}</th>
						<td><input type='number' id='maxTemp' name='maxTemp' style="width:70px; text-align: center" value="${gisVo.maxTemp}" required/></td>
						<th>${smDefrostTerm}(시간)</th>
						<td><input type='number' id='defrostTerm' name='defrostTerm' style="width:70px; text-align: center" value="${gisVo.defrostTerm}"  min='1' max='24' required/></td>
					</tr>
					<tr>
						<th>${smMinTempAlarmYn}</th>
						<td>
							<span class="r_radio">
					    		<input type='radio' name='minTempAlarmYn' id='minTempAlarm_Y' <c:if test="${gisVo.minTempAlarmYn == 1}">checked</c:if> value='1'/><label for="minTempAlarm_Y">사용</label>&nbsp;
						    	<input type='radio' name='minTempAlarmYn' id='minTempAlarm_N' <c:if test="${gisVo.minTempAlarmYn == 0}">checked</c:if> value='0'/><label for="minTempAlarm_N">미사용</label>
							</span>
						</td>
						<th>${smDefrostDelay}(0-30분)</th>
						<td><input type='number' id='defrostDelay' name='defrostDelay' style="width:70px; text-align: center" value="${gisVo.defrostDelay}"  min='0' max='30' required/></td>
					</tr>
					<tr>
						<th>저온 경보 설정 온도</th>
						<td><input type='number' id='minTemp' name='minTemp' style="width:70px; text-align: center" value="${gisVo.minTemp}" required/></td>
						<th>${smDewaterDelay}(0-30분)</th>
						<td><input type='number' id='dewaterDelay' name='dewaterDelay' style="width:70px; text-align: center" value="${gisVo.dewaterDelay}" min='0' max='30' required/></td>
					</tr>
				</table>
    		</div>
			<div class="r_pageBtnWrapper">
    			<span class="pageNormal">
    				<button type="button"  onclick="javascript:fncCancel()">${smClos}</button>
				</span>
				<span class="pageNormal">
		    		<button type="button" onclick="javascript:fncSave()">제어</button>
		    	</span>
			</div>
		</form>
	</div>
</div>