<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var='sm_alarmHist'><spring:message code='alarmHist'/></c:set>
<c:set var='sm_office'><spring:message code='office'/></c:set>
<c:set var='sm_casher'><spring:message code='casher'/></c:set>

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
	<img src="/images/layout/sangam_1440.jpg" class="storeLayoutImg">

	<!-- 네모  - 중앙 위  -->
	<div class="storeLayoutBox"	style="left: 420px; top: 69px; width: 150px; height: 110px"></div>

	<!-- 네모  - 중앙 위  -->
    <div class="storeLayoutBox"	style="left: 269px; top: 69px; width: 150px; height: 110px; line-height: 110px; text-align: center;">
	${sm_office}
	</div>

	<!-- 네모  - 중앙 ( ZIGBEE)-->
	<div class="storeLayoutBox"	style="left: 70px; top: 180px; width: 750px; height: 350px"></div>

	<!-- 네모  - 오른쪽 (TEMON1)-->
	<div class="storeLayoutBox"	style="left: 822px; top: 230px; width: 85px; height: 300px"></div>

	<!-- 콤프레셔 박스 -->
	<div class="storeLayoutBox"	style="left: 690px; top: 40px; width: 200px; height: 130px"></div>

	<!-- TEMON 1 자리 -->
	<div class="storeLayoutBox"	style="left: 249px; top: 180px; width: 80px; height: 20px;"></div>
	<div class="storeLayoutBox"	style="left: 519px; top: 180px; width: 80px; height: 20px"></div>
	<div class="storeLayoutBox"	style="left: 682px; top: 180px; width: 80px; height: 20px"></div>

	<!-- TEMON 2 자리 -->
	<div class="storeLayoutBox"	style="left: 800px; top: 280px; width: 20px; height: 50px"></div>

	<!-- TEMON 3 자리 -->
	<div class="storeLayoutBox"	style="left: 344px; top: 450px; width: 100px; height: 20px"></div>
	<div class="storeLayoutBox"	style="left: 445px; top: 450px; width: 100px; height: 20px"></div>
	<div class="storeLayoutBox"	style="left: 546px; top: 450px; width: 100px; height: 20px"></div>


	<!-- 매장 입구 -->
	<div class="storeLayoutBox"	style="left: 150px; top: 250px; width: 50px; height: 150px; line-height: 150px;">
	${sm_casher}
	</div>

	<!-- 매장 입구    -->
	<div class="storeLayoutBox"	style="left: 70px; top: 300px; width: 30px; height: 30px; background-image: url('/images/layout/door.png'); background-size: 30px 30px; background-repeat: no-repeat; -webkit-transform: rotate(0deg);"></div>

	<!-- 매장 진열대 -->
	<div class="storeLayoutBox"	style="left: 280px; top: 260px; width: 40px; height: 40px;">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
		</table>
	</div>

	<div class="storeLayoutBox"	style="left: 455px; top: 260px; width: 40px; height: 40px;">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
		</table>
	</div>

	<div class="storeLayoutBox"	style="left: 620px; top: 260px; width: 40px; height: 40px;">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
		</table>
	</div>

	<div class="storeLayoutBox"	style="left: 280px; top: 340px; width: 40px; height: 40px;">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
		</table>
	</div>

	<div class="storeLayoutBox"	style="left: 455px; top: 340px; width: 40px; height: 40px;">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
		</table>
	</div>

	<div class="storeLayoutBox"	style="left: 620px; top: 340px; width: 40px; height: 40px;">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
			<tr>
				<td style="border: 1px solid;"></td>
				<td style="border: 1px solid;"></td>
			</tr>
		</table>
	</div>
		
	<!-- 알몬 1 -->														                                               
	<div class="eqmtDesc" style="left:694px; top:46px;">
		<div class="comp" data-temonid='${almonList[0].temonId}' data-portno='${almonList[0].portNo}' data-temonType='${almonList[0].temonType}'>
			<div class="eqmtName">${almonList[0].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${almonList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />
		</div> 
	</div>
	
	<div class="eqmtDesc" style="left:755px; top:46px;">
		<div class="comp" data-temonid='${almonList[1].temonId}' data-portno='${almonList[1].portNo}' data-temonType='${almonList[1].temonType}'>
			<div class="eqmtName">${almonList[1].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${almonList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />	
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:816px; top:46px;">
		<div class="comp" data-temonid='${almonList[2].temonId}' data-portno='${almonList[2].portNo}' data-temonType='${almonList[2].temonType}'>
			<div class="eqmtName">${almonList[2].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${almonList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:694px; top:107px;">
		<div class="comp" data-temonid='${almonList[3].temonId}' data-portno='${almonList[3].portNo}' data-temonType='${almonList[3].temonType}'>
			<div class="eqmtName">${almonList[3].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${almonList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:755px; top:107px;">
		<div class="comp" data-temonid='${almonList[4].temonId}' data-portno='${almonList[4].portNo}' data-temonType='${almonList[4].temonType}'>
			<div class="eqmtName">${almonList[4].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${almonList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
		</div>
	</div>
		
	<div class="eqmtDesc" style="left:816px; top:107px;">
		<div class="comp" data-temonid='${almonList[5].temonId}' data-portno='${almonList[5].portNo}' data-temonType='${almonList[5].temonType}'>
			<div class="eqmtName">${almonList[5].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${almonList[5].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" />		
		</div>
	</div>
		
	<!-- 테몬 1 -->
	<div class="eqmtDesc" style="left:503px; top:112px;">
		<div class="wic" data-temonid='${temonList[0].temonId}' data-portno='${temonList[0].portNo}' data-temonType='${temonList[0].temonType}'>
			<div class="eqmtName">${temonList[0].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${temonList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[0].sensTemp}</div>
		</div>
	</div>

	<div class="eqmtDesc" style="left:426px; top:75px;">
		<div class="wic" data-temonid='${temonList[1].temonId}' data-portno='${temonList[1].portNo}' data-temonType='${temonList[1].temonType}'>
			<div class="eqmtName">${temonList[1].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${temonList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[1].sensTemp}</div>
		</div>
	</div>

	<!-- 테몬 2 -->
	<div class="eqmtDesc" style="left:835px; top:243px;">
		<div class="wic" data-temonid='${temonList[2].temonId}' data-portno='${temonList[2].portNo}' data-temonType='${temonList[2].temonType}'>
			<div class="eqmtName">${temonList[2].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${temonList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[2].sensTemp}</div>
		</div>
	</div>

	<div class="eqmtDesc" style="left:835px; top:313px;">
		<div class="wic" data-temonid='${temonList[3].temonId}' data-portno='${temonList[3].portNo}' data-temonType='${temonList[3].temonType}'>
			<div class="eqmtName">${temonList[3].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${temonList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[3].sensTemp}</div>
		</div>
	</div>

	<div class="eqmtDesc" style="left:835px; top:384px;">
		<div class="wic" data-temonid='${temonList[4].temonId}' data-portno='${temonList[4].portNo}' data-temonType='${temonList[4].temonType}'>
			<div class="eqmtName">${temonList[4].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${temonList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[4].sensTemp}</div>
		</div>
	</div>

	<div class="eqmtDesc" style="left:835px; top:456px;">
		<div class="wic" data-temonid='${temonList[5].temonId}' data-portno='${temonList[5].portNo}' data-temonType='${temonList[5].temonType}'>
			<div class="eqmtName">${temonList[5].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${temonList[5].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${temonList[5].sensTemp}</div>
		</div>
	</div>

	<!-- 지그비 -->														                
	<div class="eqmtDesc" style="left:339px; top:180px;">
		<div class="osc" data-temonid='${zigbeeList[0].temonId}' data-portno='${zigbeeList[0].portNo}' data-temonType='${zigbeeList[0].temonType}'>
			<div class="eqmtName">${zigbeeList[0].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[0].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[0].sensTemp}</div>
		</div>
	</div>

	<div class="eqmtDesc" style="left:610px; top:180px;">
		<div class="osc" data-temonid='${zigbeeList[1].temonId}' data-portno='${zigbeeList[1].portNo}' data-temonType='${zigbeeList[1].temonType}'>
			<div class="eqmtName">${zigbeeList[1].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[1].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[1].sensTemp}</div>
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:760px; top:210px;">
		<div class="osc" data-temonid='${zigbeeList[2].temonId}' data-portno='${zigbeeList[2].portNo}' data-temonType='${zigbeeList[2].temonType}'>
			<div class="eqmtName">${zigbeeList[2].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[2].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[2].sensTemp}</div>
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:760px; top:423px;">
		<div class="osc" data-temonid='${zigbeeList[3].temonId}' data-portno='${zigbeeList[3].portNo}' data-temonType='${zigbeeList[3].temonType}'>
			<div class="eqmtName">${zigbeeList[3].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[3].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[3].sensTemp}</div>
		</div>
	</div>

	<div class="eqmtDesc" style="left:662px; top:470px;">
		<div class="osc" data-temonid='${zigbeeList[4].temonId}' data-portno='${zigbeeList[4].portNo}' data-temonType='${zigbeeList[4].temonType}'>
			<div class="eqmtName">${zigbeeList[4].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[4].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[4].sensTemp}</div>
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:268px; top:470px;">
		<div class="osc" data-temonid='${zigbeeList[5].temonId}' data-portno='${zigbeeList[5].portNo}' data-temonType='${zigbeeList[5].temonType}'>
			<div class="eqmtName">${zigbeeList[5].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[5].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[5].sensTemp}</div>
		</div>
	</div>
	
	<div class="eqmtDesc" style="left:207px; top:470px;">
		<div class="osc" data-temonid='${zigbeeList[6].temonId}' data-portno='${zigbeeList[6].portNo}' data-temonType='${zigbeeList[6].temonType}'>
			<div class="eqmtName">${zigbeeList[6].deviceLoc}</div>
			<img src="/images/layout/icon/alarm_${zigbeeList[6].alarmYn}.png" class="signal" title="${sm_alarmHist}" onclick="fncAlarmPopup(this.parentElement)" /> 		
			<div class="eqmtTemp" onclick="javascript:fncTempTrendPopup(this.parentElement)">${zigbeeList[6].sensTemp}</div>
		</div>
	</div>	
</div>