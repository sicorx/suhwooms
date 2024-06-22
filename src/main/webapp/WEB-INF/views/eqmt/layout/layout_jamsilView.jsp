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
	<img src="/images/layout/jamsil_1440.jpg" class="storeLayoutImg">
		
	<!-- 알몬 1 -->														                                               
	<div class="eqmtDesc" data-temonid='${almonList[0].temonId}' data-portno='${almonList[0].portNo}' data-temontype='${almonList[0].temonType}' style="left:175px; top: 264px;">
		<div class="eqmtName">${almonList[0].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[1].temonId}' data-portno='${almonList[1].portNo}' data-temontype='${almonList[1].temonType}' style="left:250px; top: 264px;">
		<div class="eqmtName">${almonList[1].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />	
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[2].temonId}' data-portno='${almonList[2].portNo}' data-temontype='${almonList[2].temonType}' style="left:175px; top: 330px;">
		<div class="eqmtName">${almonList[2].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[3].temonId}' data-portno='${almonList[3].portNo}' data-temontype='${almonList[3].temonType}' style="left:250px; top: 330px;">
		<div class="eqmtName">${almonList[3].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[4].temonId}' data-portno='${almonList[4].portNo}' data-temontype='${almonList[4].temonType}' style="left:175px; top: 405px;">
		<div class="eqmtName">${almonList[4].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[5].temonId}' data-portno='${almonList[5].portNo}' data-temontype='${almonList[5].temonType}' style="left:250px; top: 405px;">
		<div class="eqmtName">${almonList[5].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[5].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[6].temonId}' data-portno='${almonList[6].portNo}' data-temontype='${almonList[6].temonType}' style="left:250px; top: 480px;">
		<div class="eqmtName">${almonList[6].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[6].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
	</div>
	
	<div class="eqmtDesc" data-temonid='${almonList[7].temonId}' data-portno='${almonList[7].portNo}' data-temontype='${almonList[7].temonType}' style="left:250px; top: 554px;">
		<div class="eqmtName">${almonList[7].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${almonList[7].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
	</div>
	
	<!-- 테몬 1 -->
	<div class="eqmtDesc" data-temonid='${temonList[0].temonId}' data-portno='${temonList[0].portNo}' data-temontype='${temonList[0].temonType}' style="left:673px; top: 133px;">
		<div class="eqmtName">${temonList[0].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[0].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[1].temonId}' data-portno='${temonList[1].portNo}' data-temontype='${temonList[1].temonType}' style="left:740px; top: 133px;">
		<div class="eqmtName">${temonList[1].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[1].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[2].temonId}' data-portno='${temonList[2].portNo}' data-temontype='${temonList[2].temonType}' style="left:811px; top: 133px;">
		<div class="eqmtName">${temonList[2].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[2].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[3].temonId}' data-portno='${temonList[3].portNo}' data-temontype='${temonList[3].temonType}' style="left:880px; top: 133px;">
		<div class="eqmtName">${temonList[3].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[3].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[4].temonId}' data-portno='${temonList[4].portNo}' data-temontype='${temonList[4].temonType}' style="left:948px; top: 133px;">
		<div class="eqmtName">${temonList[4].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[4].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[5].temonId}' data-portno='${temonList[5].portNo}' data-temontype='${temonList[5].temonType}' style="left:1018px; top: 133px;">
		<div class="eqmtName">${temonList[5].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[5].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[5].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[6].temonId}' data-portno='${temonList[6].portNo}' data-temontype='${temonList[6].temonType}' style="left:741px; top: 306px;">
		<div class="eqmtName">${temonList[6].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[6].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[6].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[7].temonId}' data-portno='${temonList[7].portNo}' data-temontype='${temonList[7].temonType}' style="left:810px; top: 306px;">
		<div class="eqmtName">${temonList[7].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[7].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[7].sensTemp}</div>
	</div>


	<!-- 테몬 2 -->											
	<div class="eqmtDesc" data-temonid='${temonList[8].temonId}' data-portno='${temonList[8].portNo}' data-temontype='${temonList[8].temonType}' style="left:450px; top: 385px;">
		<div class="eqmtName">${temonList[8].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[8].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[8].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[9].temonId}' data-portno='${temonList[9].portNo}' data-temontype='${temonList[9].temonType}' style="left:450px; top: 552px;">
		<div class="eqmtName">${temonList[9].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[9].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[9].sensTemp}</div>
	</div>

	
	<!-- 테몬 3 -->														                
	<div class="eqmtDesc" data-temonid='${temonList[10].temonId}' data-portno='${temonList[10].portNo}' data-temontype='${temonList[10].temonType}' style="left:1077px; top: 481px;">
		<div class="eqmtName">${temonList[10].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[10].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[10].sensTemp}</div>
	</div>

	<div class="eqmtDesc" data-temonid='${temonList[11].temonId}' data-portno='${temonList[11].portNo}' data-temontype='${temonList[11].temonType}' style="left:1077px; top: 349px;">
		<div class="eqmtName">${temonList[11].deviceLoc}</div>
		<img src="/images/layout/icon/alarm_${temonList[11].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 
		<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[11].sensTemp}</div>
	</div>	
</div>