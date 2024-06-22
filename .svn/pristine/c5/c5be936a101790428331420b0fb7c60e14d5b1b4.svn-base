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

<script src="<c:url value="/resources/js/bootstrap.min.js" />" type="text/javascript"></script>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var title = js_er_title ='Error';

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){

	fncSearch();
	
	jQuery.validator.addMethod("checkValue", function(value, element) {
	    return ( (value % 5) == 0 );
	}, "5단위로 입력하세요");
	
	$('#saveForm1').validate({
		rules:{
			sdtime0:{required:true, number:true, max:100, min:60, checkValue:true},
			sdtime1:{required:true, number:true, max:100, min:60, checkValue:true},
			sdtime2:{required:true, number:true, max:100, min:60, checkValue:true},
			sdtime3:{required:true, number:true, max:100, min:60, checkValue:true},
			sdtime4:{required:true, number:true, max:100, min:60, checkValue:true},
			usdtime0:{required:true, number:true, max:100, min:60, checkValue:true},
			usdtime1:{required:true, number:true, max:100, min:60, checkValue:true},
			usdtime2:{required:true, number:true, max:100, min:60, checkValue:true},
			usdtime3:{required:true, number:true, max:100, min:60, checkValue:true},
			usdtime4:{required:true, number:true, max:100, min:60, checkValue:true}
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
	
	$('#saveForm2').validate({
		rules:{
			sdd0:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd1:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd2:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd3:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd4:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd5:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd6:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd7:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd8:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd9:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd10:{required:true, number:true, max:20, min:-20, checkValue:true},
			sdd11:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd0:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd1:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd2:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd3:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd4:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd5:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd6:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd7:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd8:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd9:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd10:{required:true, number:true, max:20, min:-20, checkValue:true},
			usdd11:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd0:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd1:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd2:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd3:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd4:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd5:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd6:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd7:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd8:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd9:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd10:{required:true, number:true, max:20, min:-20, checkValue:true},
			snd11:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd0:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd1:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd2:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd3:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd4:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd5:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd6:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd7:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd8:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd9:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd10:{required:true, number:true, max:20, min:-20, checkValue:true},
			usnd11:{required:true, number:true, max:20, min:-20, checkValue:true}
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
1. 조회 
2. 갱신
********************/

function fncSearch() {
	
	var scrCompanyCd = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	$.ajax({
		url:'/retrieveDimmTimePolicyList',
		type:'POST',
		cache:false,
		data : {scrCompanyCd:scrCompanyCd},
		dataType:'json',
		success:function(data){			
			$('#sdtime0').val( data[0].sundimmtime );
			$('#sdtime1').val( data[1].sundimmtime );
			$('#sdtime2').val( data[2].sundimmtime );
			$('#sdtime3').val( data[3].sundimmtime );
			$('#sdtime4').val( data[4].sundimmtime );
			
			$('#usdtime0').val( data[0].unsundimmtime );
			$('#usdtime1').val( data[1].unsundimmtime );
			$('#usdtime2').val( data[2].unsundimmtime );
			$('#usdtime3').val( data[3].unsundimmtime );
			$('#usdtime4').val( data[4].unsundimmtime );	
			$('#companyCd').val(data.companyCd );
		},
		error:function(result){
			
			$('#sdtime0').val( '' );
			$('#sdtime1').val( '' );
			$('#sdtime2').val( '' );
			$('#sdtime3').val( '' );
			$('#sdtime4').val( '' );
			
			$('#usdtime0').val( '' );
			$('#usdtime1').val( '' );
			$('#usdtime2').val( '' );
			$('#usdtime3').val( '' );
			$('#usdtime4').val( '' );
		}
	});

	$.ajax({
		url:'/retrieveDimmWeatherPolicyList',
		type:'POST',
		cache:false,
		data : {scrCompanyCd:scrCompanyCd},
		dataType:'json',
		success:function(data){
	
			for(var i=0; i<12; i++)
			{
				$("#sdd"+i).val( data[i].sundaydimm );
				$('#usdd'+i).val( data[i].unsundaydimm );
				$('#snd'+i).val( data[i].sunnightdimm );
				$('#usnd'+i).val( data[i].unsunnightdimm );
				$('#weather'+i).val( data[i].weatherdesc );
				
				$('#weather_text'+i).text( data[i].weatherdesc );
			}
		},
		error:function(result){
			for(var i=0; i<12; i++)
			{
				$("#sdd"+i).val( '' );
				$('#usdd'+i).val( '' );
				$('#snd'+i).val( '' );
				$('#usnd'+i).val( '' );
			}
		}
	});
}

function fncSaveTime() {
	
	if(!$('#saveForm1').valid()){
		return false;
	}
	
	var timeSunDimmList = "";
	var timeUnSunDimmList = "";
		
	for(var j = 0; j < 5; j++){
		
		timeSunDimmList = timeSunDimmList + $("#sdtime"+j+"").val()+":";
		timeUnSunDimmList = timeUnSunDimmList + $("#usdtime"+j+"").val()+":";
	
	}

	$('#timeSunDimmList').val(timeSunDimmList);
	$('#timeUnSunDimmList').val(timeUnSunDimmList);
	
	if(confirm("${smCommMsgSaveCnf}")){
		
		$.ajax({
			url:'/saveDimmTimePolicyMgnt',
			type:'POST',
			cache:false,
			data:$('#saveForm1').serialize(),
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

function fncSaveWeather() {
	
	if(!$('#saveForm2').valid()){
		return false;
	}
	
	var sunDayDimmList="";
	var unSunDayDimmList="";
	var sunNightDimmList="";
	var unSunNightDimmList="";
	var weatherList="";
	
	for(var i=0; i<12; i++){
		
		sunDayDimmList = sunDayDimmList + $("#sdd"+i+"").val()+":";
		unSunDayDimmList = unSunDayDimmList + $("#usdd"+i+"").val()+":";
		sunNightDimmList = sunNightDimmList + $("#snd"+i+"").val()+":";
		unSunNightDimmList = unSunNightDimmList + $("#usnd"+i+"").val()+":";
		weatherList = weatherList + $("#weather"+i+"").val()+":";
	}
	
	$('#sunDayDimmList').val(sunDayDimmList);
	$('#unSunDayDimmList').val(unSunDayDimmList);
	$('#sunNightDimmList').val(sunNightDimmList);
	$('#unSunNightDimmList').val(unSunNightDimmList);
	$('#weatherList').val(weatherList);
	
	if(confirm("${smCommMsgSaveCnf}")){
		
		$.ajax({
			url:'/saveDimmWeatherPolicyMgnt',
			type:'POST',
			cache:false,
			data:$('#saveForm2').serialize(),
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
</script>
<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>${smCompany}</th>
				<td>
					<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
					<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable'  readonly='readonly' >
				</td>
				<td>
					
	    		</td>
			</tr>
		</table>
		<span class="search">
	    	<button onclick="javascript:fncSearch()">${smRetrieve}</button>
		</span>
	</div>
	<!-- 시간별 디밍 설정 값입력  -->
	<div class="r_grid">	
		<div class="r_gridTitle">
			<h3>시간별 디밍 설정 값</h3>
	    </div>
		<form id="saveForm1" name="saveForm1" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="">
			<input type="hidden" id="timeUnSunDimmList" name="timeUnSunDimmList" value="">
			<input type="hidden" id="timeSunDimmList" name="timeSunDimmList" value="">
			<table>
			
				<col width="40%" />
	        	<col width="30%" />
	        	<col width="30%" />
	        	<thead>
		        	<tr>
		        		<th scope="col">구분</th>
		        		<th scope="col">일광 매장 </th>
		        		<th scope="col">비일광 매장</th>
		        	</tr>
	        		<tr>
						<td scope="col">일몰 1시간 후 ~ 일출  디밍 설정(%)</td>	
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  80 : </span><input type='number' id="sdtime0" name="sdtime0" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  80 : </span><input type='number' id="usdtime0" name="usdtime0" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
					</tr>
					<tr>
						<td scope="col">일출 ~ 일출 후 1시간 디밍 설정(%)</td>		
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="sdtime1" name="sdtime1" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="usdtime1" name="usdtime1" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
					</tr>		
					<tr>
						<td scope="col">일출 후 1시간 ~ 12시 디밍 설정(%)</td>					
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="sdtime2" name="sdtime2" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="usdtime2" name="usdtime2" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
					</tr>
					<tr>
						<td scope="col">12시 ~ 일몰 2시간 전 디밍 설정(%)</td>				
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="sdtime3" name="sdtime3" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="usdtime3" name="usdtime3" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
					</tr>
					<tr>
						<td scope="col">일몰 2시간 전 ~ 일몰 1시간 후 디밍 설정(%)</td>
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  75 : </span><input type='number' id="sdtime4" name="sdtime4" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>
						<td scope="col" align="Center"><span style="padding-right: 5px">권장  80 : </span><input type='number' id="usdtime4" name="usdtime4" value='' style="width:20%;text-align: center" class='numberVal' /><span style="padding-left: 5px">%</span></td>		
					</tr>
				</thead>
			</table>
		</form>
	</div>
	<div class="r_pageBtnWrapper" style="margin-top: 4px; border-top: 0px solid; padding: 5px 0 30px 0 ">
		<span class="pageNormal">
	  		<button onclick="javascript:fncSaveTime();">${smSave}</button>
		</span>	&nbsp;
	</div>
	<div class="r_grid">
		<div class="r_gridTitle">
			<h3>날씨별  디밍 보정 값</h3>
		</div>
		<form id="saveForm2" name="saveForm2" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="">
			<input type="hidden" id="weatherList" name="weatherList" value="">
			<input type="hidden" id="sunDayDimmList" name="sunDayDimmList" value="">
			<input type="hidden" id="unSunDayDimmList" name="unSunDayDimmList" value="">
			<input type="hidden" id="sunNightDimmList" name="sunNightDimmList" value="">
			<input type="hidden" id="unSunNightDimmList" name="unSunNightDimmList" value="">
			<table>
				<caption>Grid Table</caption>
				<col width="5%" />
				<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	        	<col width="5%" />
	       	 	<thead>
	        		<tr>
	        		<th colspan="2" scope="col">구분</th>
	        		<c:forEach begin="0" end="11" step="1" var="i">
	        			<th scope="col"><label id="weather_text${i}"></label></th>
	        		</c:forEach>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan=2 >일광</td>
						<td>낮 디밍</td>
						<c:forEach begin="0" end="11" step="1" var="i">
							<td>
								<input type='number' id="sdd${i}" name="sdd${i}" value='' style="width:100%;text-align: center" class='numberVal' />
							</td>
						</c:forEach>
					</tr>
					<tr>
						<td>밤 디밍</td>
						<c:forEach begin="0" end="11" step="1" var="i">
							<td>
								<input type='number' id="snd${i}" name="snd${i}" value='' style="width:100%;text-align: center" class='numberVal' />
							</td>
						</c:forEach>
					</tr>
					<tr>
						<td rowspan=2 >비일광</td>
						<td>낮 디밍</td>
						<c:forEach begin="0" end="11" step="1" var="i">
						<td>
							<input type='number' id="usdd${i}" name="usdd${i}" value='' style="width:100%;text-align: center" class='numberVal' />
						</td>
							</c:forEach>
					</tr>
					<tr>
						<td>밤 디밍</td>
						<c:forEach begin="0" end="11" step="1" var="i">
							<td>
								<input type='number' id="usnd${i}" name="usnd${i}" value='' style="width:100%;text-align: center" class='numberVal' />
							</td>
						</c:forEach>					
					</tr>
					<tr>
					<c:forEach begin="0" end="11" step="1" var="i">
							<input type="hidden" id="weather${i}" name="weather${i}" value="">
					</c:forEach>					
					</tr>			
				</tbody>
			</table>
		</form>
	</div>
	<div class="r_pageBtnWrapper" style="margin-top: 4px; border-top: 0px solid; padding: 5px 0 30px 0 ">
		<span class="pageNormal">
	   		<button onclick="javascript:fncSaveWeather();">${smSave}</button>
		</span>	&nbsp;
	</div>
</div>