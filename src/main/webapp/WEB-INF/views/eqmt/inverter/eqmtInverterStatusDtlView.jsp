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

<div class="r_popup">
	<h1 class="r_popupTitle">${smInvDtlInfo}</h1>
	<div class="r_popupCont">
		<table style="width:15%">
			<tr>
				<td>${gisVo.yyyyMmDdView}</td><td>${gisVo.hhMinView}</td>
			</tr>
		</table>
   		<div class="r_inputTbl r_horizonTbl">		
			<table>
				<tr>
					<th width="25%">${smDeviceType}</th>
					<td width="25%">${gisVo.deviceType}</td>
					<th width="25%">${smMaxTempAlarmYn}</th>
					<td width="25%">${gisVo.maxTempAlarmYn}</td>
				</tr>
				<tr>
					<th>FW_VER</th>
					<td>${gisVo.fwVer}</td>
					<th>${smMaxTemp}</th>
					<td>${gisVo.maxTemp}</td>
				</tr>
				<tr>
					<th>MODEL</th>
					<td>${gisVo.model}</td>
					<th>${smMinTempAlarmYn}</th>
					<td>${gisVo.minTempAlarmYn}</td>
				</tr>
				<tr>
					<th>${smErrCd}</th>
					<td>${gisVo.errCd}</td>			
					<th>저온 경보 설정 온도</th>
					<td>${gisVo.minTemp}</td>
				</tr>			
				<tr>
					<th>${smOperMode}</th>
					<td>${gisVo.operMode}</td>			
					<th>${smDefrostTempConf}</th>
					<td>${gisVo.defrostTempConf}</td>
				</tr>			
				<tr>
					<th>${smInnerTemp}</th>
					<td>${gisVo.sensTemp}</td>			
					<th>${smDefrostTerm}</th>
					<td>${gisVo.defrostTerm}</td>
				</tr>
				<tr>
					<th>${smInnerTempConf}</th>
					<td>${gisVo.sensTempConf}</td>
					<th>${smDefrostDelay}</th>
					<td>${gisVo.defrostDelay}</td>
				</tr>
				<tr>
					<th>${smSensTempOut}</th>
					<td>${gisVo.sensTempOut}</td>
					<th>${smDewaterDelay}</th>
					<td>${gisVo.dewaterDelay}</td>
				</tr>
			</table>
   		</div>
		<div class="r_pageBtnWrapper">
   			<span class="pageNormal">
   				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
		</div>
	</div>
</div>
