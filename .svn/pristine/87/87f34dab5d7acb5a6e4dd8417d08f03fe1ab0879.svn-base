<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var='sm_alarmHist'><spring:message code='alarmHist'/></c:set>

<script type="text/javascript">
/*
$(function() {
	$(".eqmtDesc").draggable({
		stop: function(event, ui) {
			console.info(event);
			console.info(ui);
		}
	});
});
*/
</script>

<div id="eqmtLocation" data-strcd='${srchStrCd}'>
	<img src="/images/layout/myongil_1440.jpg" class="storeLayoutImg">
		
	<!-- 알몬 1 -->														                                               
	<div class="eqmtDesc" data-temonid='${almonList[0].temonId}' data-portno='${almonList[0].portNo}' data-temonType='${almonList[0].temonType}' style="left:1117px; top: 99px;">
		<div class="eqmtName">${almonList[0].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[1].temonId}' data-portno='${almonList[1].portNo}' data-temonType='${almonList[1].temonType}' style="left:1117px; top: 176px;">
		<div class="eqmtName">${almonList[1].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />	
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[2].temonId}' data-portno='${almonList[2].portNo}' data-temonType='${almonList[2].temonType}' style="left:1117px; top: 252px;">
		<div class="eqmtName">${almonList[2].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[3].temonId}' data-portno='${almonList[3].portNo}' data-temonType='${almonList[3].temonType}' style="left:1194px; top: 176px;">
		<div class="eqmtName">${almonList[3].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[4].temonId}' data-portno='${almonList[4].portNo}' data-temonType='${almonList[4].temonType}' style="left:1194px; top: 252px;">
		<div class="eqmtName">${almonList[4].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
		
	
	<!-- 테몬 1 -->
	<div class="eqmtDesc" data-temonid='${temonList[0].temonId}' data-portno='${temonList[0].portNo}' data-temonType='${temonList[0].temonType}' style="left:220px; top: 187px;">
		<div class="eqmtName">${temonList[0].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[0].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[1].temonId}' data-portno='${temonList[1].portNo}' data-temonType='${temonList[1].temonType}' style="left:289px; top: 187px;">
		<div class="eqmtName">${temonList[1].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[1].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[2].temonId}' data-portno='${temonList[2].portNo}' data-temonType='${temonList[2].temonType}' style="left:359px; top: 187px;">
		<div class="eqmtName">${temonList[2].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[2].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[3].temonId}' data-portno='${temonList[3].portNo}' data-temonType='${temonList[3].temonType}' style="left:427px; top: 187px;">
		<div class="eqmtName">${temonList[3].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[3].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[4].temonId}' data-portno='${temonList[4].portNo}' data-temonType='${temonList[4].temonType}' style="left:496px; top: 187px;">
		<div class="eqmtName">${temonList[4].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[4].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[5].temonId}' data-portno='${temonList[5].portNo}' data-temonType='${temonList[5].temonType}' style="left:566px; top: 187px;">
		<div class="eqmtName">${temonList[5].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[5].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[5].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[6].temonId}' data-portno='${temonList[6].portNo}' data-temonType='${temonList[6].temonType}' style="left:636px; top: 187px;">
		<div class="eqmtName">${temonList[6].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[6].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[6].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[7].temonId}' data-portno='${temonList[7].portNo}' data-temonType='${temonList[7].temonType}' style="left:704px; top: 186px;">
		<div class="eqmtName">${temonList[7].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[7].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[7].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[8].temonId}' data-portno='${temonList[8].portNo}' data-temonType='${temonList[8].temonType}' style="left:773px; top: 186px;">
		<div class="eqmtName">${temonList[8].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[8].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[8].sensTemp}</div>
	</div>


	<!-- 테몬 2 -->											
	<div class="eqmtDesc" data-temonid='${temonList[9].temonId}' data-portno='${temonList[9].portNo}' data-temonType='${temonList[9].temonType}' style="left:130px; top: 381px;">
		<div class="eqmtName">${temonList[9].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[9].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[9].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[10].temonId}' data-portno='${temonList[10].portNo}' data-temonType='${temonList[10].temonType}' style="left:130px; top: 311px;">
		<div class="eqmtName">${temonList[10].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[10].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[10].sensTemp}</div>
	</div>

	
	<!-- 테몬 3 -->														                
	<div class="eqmtDesc" data-temonid='${temonList[11].temonId}' data-portno='${temonList[11].portNo}' data-temonType='${temonList[11].temonType}' style="left:714px; top: 287px;">
		<div class="eqmtName">${temonList[11].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[11].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[11].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[12].temonId}' data-portno='${temonList[12].portNo}' data-temonType='${temonList[12].temonType}' style="left:783px; top: 287px;">
		<div class="eqmtName">${temonList[12].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[12].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[12].sensTemp}</div>
	</div>
	

	<!-- 테몬 4 -->														                
	<div class="eqmtDesc" data-temonid='${temonList[13].temonId}' data-portno='${temonList[13].portNo}' data-temonType='${temonList[13].temonType}' style="left:955px; top: 432px;">
		<div class="eqmtName">${temonList[13].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[13].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[13].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[14].temonId}' data-portno='${temonList[14].portNo}' data-temonType='${temonList[14].temonType}' style="left:955px; top: 356px;">
		<div class="eqmtName">${temonList[14].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[14].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[14].sensTemp}</div>
	</div>
	
	<div class="eqmtDesc" data-temonid='${temonList[15].temonId}' data-portno='${temonList[15].portNo}' data-temonType='${temonList[15].temonType}' style="left:955px; top: 288px;">
		<div class="eqmtName">${temonList[15].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[15].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[15].sensTemp}</div>
	</div>							
</div>