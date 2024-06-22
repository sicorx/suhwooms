<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>

<c:set var="smContElecPerSpace"><spring:message code="contElecPerSpace" /></c:set>
<c:set var="smStrCount"><spring:message code="strCount" /></c:set>
<c:set var="smPeakStr"><spring:message code="peakStr" /></c:set>
<c:set var="smContElecPerSpaceDist"><spring:message code="contElecPerSpaceDist" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	//면적당 계약전력 분포
  	var data1 = document.getElementById("data1").value;
	var data2 = document.getElementById("data2").value;
	var data3 = document.getElementById("data3").value;
	var data4 = document.getElementById("data4").value;
	var data5 = document.getElementById("data5").value;
	var data6 = document.getElementById("data6").value;
	var data7 = document.getElementById("data7").value;
	var data8 = document.getElementById("data8").value;
	var data9 = document.getElementById("data9").value;
	var data10 = document.getElementById("data10").value;
	var data11 = document.getElementById("data11").value;
	var data12 = document.getElementById("data12").value;
	var data13 = document.getElementById("data13").value;
	var data14 = document.getElementById("data14").value;
	var data15 = document.getElementById("data15").value;
	var data16 = document.getElementById("data16").value;
	var data17 = document.getElementById("data17").value;
	var data18 = document.getElementById("data18").value;
	var data19 = document.getElementById("data19").value;
	var data20 = document.getElementById("data20").value;
	var data21 = document.getElementById("data21").value;
	var data22 = document.getElementById("data22").value;
	var data23 = document.getElementById("data23").value;
	var data24 = document.getElementById("data24").value;
	var data25 = document.getElementById("data25").value;
	var data26 = document.getElementById("data26").value;
	var data27 = document.getElementById("data27").value;
	var data28 = document.getElementById("data28").value;
	var data29 = document.getElementById("data29").value;
	var data30 = document.getElementById("data30").value;
	
	line1 = [[0, data1], [20, data2], [40, data3], [60, data4], [80, data5], [100, data6], [120, data7], [140, data8], [160, data9], [180, data10], [200, data11],
	         [220, data12], [240, data13], [260, data14], [280, data15], [300, data16], [320, data17], [340, data18], [360, data19], [380, data20], [400, data21],
	         [420, data22], [440, data23], [460, data24], [480, data25], [500, data26], [520, data27], [540, data28], [560, data29], [580, data30] ]; 
 
	$.jqplot('chrtUsedAreaCont', [line1], {
		series:[{renderer:$.jqplot.BarRenderer}],
	    axesDefaults: {
	        tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
	        tickOptions: {
	          angle: -30,
	          fontSize: '10pt'
	        }
	    },
	    grid: {
	    	drawGridLines: true,
	    	shadow: false,
	    	background: 'rgba(0, 0, 0, 0)',
	    	borderWidth: 0
	    },
	    axes: {
	      xaxis: {
	    	label: '${smContElecPerSpace}',
	        renderer: $.jqplot.CategoryAxisRenderer,
	        tickOptions: {
	        	showGridline: false
	        }
	      },
	      yaxis: {
	    	  label: '${smStrCount}'
	      }
	    }
	});
	
	$('#chrtUsedAreaCont').bind('jqplotDataClick',
		function(ev, seriesIndex, pointIndex, data){
			var startVal = $('startVal').val();
			var endVal = $('endVal').val();
			var index = pointIndex;
			
			switch(index){
			case 0:
				startVal = 0;
				endVal = 20;
				break;
				
			case 1:
				startVal = 20;
				endVal = 40;
				break;
			
			case 2:
				startVal = 40;
				endVal = 60;
				break;
			
			case 3:
				startVal = 60;
				endVal = 80;
				break;
			
			case 4:
				startVal = 80;
				endVal = 100;
				break;
			
			case 5:
				startVal = 100;
				endVal = 120;
				break;
			
			case 6:
				startVal = 120;
				endVal = 140;
				break;
			
			case 7:
				startVal = 140;
				endVal = 160;
				break;
			
			case 8:
				startVal = 160;
				endVal = 180;
				break;
				
			case 9:
				startVal = 180;
				endVal = 200;
				break;
				
			case 10:
				startVal = 200;
				endVal = 220;
				break;
				
			case 11:
				startVal = 220;
				endVal = 240;
				break;
				
			case 12:
				startVal = 240;
				endVal = 260;
				break;
				
			case 13:
				startVal = 260;
				endVal = 280;
				break;
				
			case 14:
				startVal = 280;
				endVal = 300;
				break;
				
			case 15:
				startVal = 300;
				endVal = 320;
				break;
				
			case 16:
				startVal = 320;
				endVal = 340;
				break;
				
			case 17:
				startVal = 340;
				endVal = 360;
				break;
				
			case 18:
				startVal = 360;
				endVal = 380;
				break;
				
			case 19:
				startVal = 380;
				endVal = 400;
				break;
				
			case 20:
				startVal = 400;
				endVal = 420;
				break;
				
			case 21:
				startVal = 420;
				endVal = 440;
				break;
				
			case 22:
				startVal = 440;
				endVal = 460;
				break;
				
			case 23:
				startVal = 460;
				endVal = 480;
				break;
				
			case 24:
				startVal = 480;
				endVal = 500;
				break;
				
			case 25:
				startVal = 500;
				endVal = 520;
				break;
				
			case 26:
				startVal = 520;
				endVal = 540;
				break;
				
			case 27:
				startVal = 540;
				endVal = 560;
				break;
				
			case 28:
				startVal = 560;
				endVal = 580;
				break;
				
			case 29:
				startVal = 580;
				endVal = 1000;
				break;
			}

			var args = new Array();
			args.push(startVal);
			args.push(endVal);
			args.push('${sessionUserVo.sessionYyyyMm}');
			
			fn_divPop("energyContExcessList", "팝업", 1000, 750, args );
			
		}
	);
});

/*******************
1. 팝업  
********************/

function fncExcessStoreSearch(yyyymm) {
	
	var args = new Array();
	args.push('');
	args.push('');
	args.push(yyyymm);
	
	fn_divPop("energyContExcessList", "팝업", 1000, 750, args );
	
}
</script>
<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="startVal"> 
    <input type="hidden" id="popArg2" name="endVal"> 
    <input type="hidden" id="popArg3" name="orgYyyymm"> 
</form>
<div id="loadingArea">
	<div style="height:200px;">
		<div class="r_inputTbl">
			<div class="r_inputTblTitle">
				<h3>${smPeakStr}</h3>				
			</div>
		</div>
		<div class="r_grid">
			<table>
				<tr>
					<c:forEach items="${epContOverStore}" var="epContOverStore">
					<th>`${epContOverStore.yymm}</th>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach items="${epContOverStore}" var="epContOverStore">
						<c:choose>
							<c:when test="${epContOverStore.peakCount < 10}">
							<td class="r_gridInput r_last">
								<div class="excessStoreCntGood" onclick="fncExcessStoreSearch('${epContOverStore.yyyymm}')" >
									<span class="r_number">${epContOverStore.peakCount}</span>
								</div>
							</td>
							</c:when>	
							
							<c:when test="${epContOverStore.peakCount > 10 && epContOverStore.peakCount < 20}">
							<td class="r_gridInput r_last">
								<div class="excessStoreCntNormal" onclick="fncExcessStoreSearch('${epContOverStore.yyyymm}')" >
									<span class="r_number">${epContOverStore.peakCount}</span>
								</div>
							</td>
							</c:when>
							
							<c:otherwise>
							<td class="r_gridInput r_last">
								<div class="excessStoreCntBad" onclick="fncExcessStoreSearch('${epContOverStore.yyyymm}')" >
									<span class="r_number">${epContOverStore.peakCount}</span>
								</div>
							</td>
							</c:otherwise>
						</c:choose>
					</c:forEach>	
				</tr>
			</table>
		</div>
	</div>
	
	<div class="r_inputTbl">
		<div class="r_inputTblTitle">
			<h3>${smContElecPerSpaceDist}</h3>
		</div>
	</div>
	
	<div class="r_perSpaceChart">
		<div id="chrtUsedAreaCont" style="height:400px;"></div>
		<input id="data1" type="hidden" class="content" value="${epContExcessChrtVo.data1}" readonly />
		<input id="data2" type="hidden" class="content" value="${epContExcessChrtVo.data2}" readonly />
		<input id="data3" type="hidden" class="content" value="${epContExcessChrtVo.data3}" readonly />
		<input id="data4" type="hidden" class="content" value="${epContExcessChrtVo.data4}" readonly />
		<input id="data5" type="hidden" class="content" value="${epContExcessChrtVo.data5}" readonly />
		<input id="data6" type="hidden" class="content" value="${epContExcessChrtVo.data6}" readonly />
		<input id="data7" type="hidden" class="content" value="${epContExcessChrtVo.data7}" readonly />
		<input id="data8" type="hidden" class="content" value="${epContExcessChrtVo.data8}" readonly />
		<input id="data9" type="hidden" class="content" value="${epContExcessChrtVo.data9}" readonly />
		<input id="data10" type="hidden" class="content" value="${epContExcessChrtVo.data10}" readonly />
		<input id="data11" type="hidden" class="content" value="${epContExcessChrtVo.data11}" readonly />
		<input id="data12" type="hidden" class="content" value="${epContExcessChrtVo.data12}" readonly />
		<input id="data13" type="hidden" class="content" value="${epContExcessChrtVo.data13}" readonly />
		<input id="data14" type="hidden" class="content" value="${epContExcessChrtVo.data14}" readonly />
		<input id="data15" type="hidden" class="content" value="${epContExcessChrtVo.data15}" readonly />
		<input id="data16" type="hidden" class="content" value="${epContExcessChrtVo.data16}" readonly />
		<input id="data17" type="hidden" class="content" value="${epContExcessChrtVo.data17}" readonly />
		<input id="data18" type="hidden" class="content" value="${epContExcessChrtVo.data18}" readonly />
		<input id="data19" type="hidden" class="content" value="${epContExcessChrtVo.data19}" readonly />
		<input id="data20" type="hidden" class="content" value="${epContExcessChrtVo.data20}" readonly />
		<input id="data21" type="hidden" class="content" value="${epContExcessChrtVo.data21}" readonly />
		<input id="data22" type="hidden" class="content" value="${epContExcessChrtVo.data22}" readonly />
		<input id="data23" type="hidden" class="content" value="${epContExcessChrtVo.data23}" readonly />
		<input id="data24" type="hidden" class="content" value="${epContExcessChrtVo.data24}" readonly />
		<input id="data25" type="hidden" class="content" value="${epContExcessChrtVo.data25}" readonly />
		<input id="data26" type="hidden" class="content" value="${epContExcessChrtVo.data26}" readonly />
		<input id="data27" type="hidden" class="content" value="${epContExcessChrtVo.data27}" readonly />
		<input id="data28" type="hidden" class="content" value="${epContExcessChrtVo.data28}" readonly />
		<input id="data29" type="hidden" class="content" value="${epContExcessChrtVo.data29}" readonly />
		<input id="data30" type="hidden" class="content" value="${epContExcessChrtVo.data30}" readonly />
	</div>
</div>
