<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="smCompany"><spring:message code="company"/></c:set>
<c:set var="smYearMonth"><spring:message code="yearMonth"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>

<c:set var="smHacElecUsePerSpaceDist"><spring:message code="hacElecUsePerSpaceDist" /></c:set>
<c:set var="smTempElecUsePerSpace"><spring:message code="tempElecUsePerSpace" /></c:set>
<c:set var="smStrCount"><spring:message code="strCount" /></c:set>
<c:set var="smYear"><spring:message code="year"/></c:set>
<c:set var="smMonth"><spring:message code="month"/></c:set>
<c:set var="smAvg"><spring:message code="avg"/></c:set>
<c:set var="smMax"><spring:message code="max"/></c:set>
<c:set var="smMin"><spring:message code="min"/></c:set>
<c:set var="smStdDev"><spring:message code="stdDev"/></c:set>

<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){

	//menuLoadImgShow("loadingArea");
	//menuLoadImgHide("loadingArea");
	
	
	$("#selYearMonth").val('${userVo.yyyymm}');
	
	retrieveChartData();
	
});

/*******************
1. 필수 함수
********************/

function retrieveChartData(){
	
	var orgYyyymm = $("#selYearMonth").val();
	
	var gvMaxVal = 0;             // 30구간의 가장 높은 값
	var gvMinVal = 0;             // 30구간의 가장 낮은 값
	var gvDiff   = 0;  // 각 구간 별 차이
	
	$.ajax({
		url:'/retrieveHacTableData',
		type:'POST',
		cache:false,
		async: false,
		data : {orgYyyymm:orgYyyymm},
	    dataType: 'json',
		success:function(data){
			
			$('#td1').html( data.average );
			$('#td2').html( data.max );
			$('#td3').html( data.min );
			$('#td4').html( data.stdev );
			
			$('#avgForecastTemp').val(data.avgForecastTemp);
			$('#avgSenseTemp').val(data.avgSenseTemp);

			gvMaxVal = Number( data.max );             // 30구간의 가장 높은 값
			gvMinVal = Number( data.min );             // 30구간의 가장 낮은 값
			gvDiff   = Math.floor( ( gvMaxVal - gvMinVal ) / 30 );  // 각 구간 별 차이

		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	
	$.ajax({
		url:'/retrieveHacChartData',
		type:'POST',
		cache:false,
		async: false,
		data : {orgYyyymm:orgYyyymm,gvMaxVal:gvMaxVal,gvMinVal:gvMinVal},
	    dataType: 'json',
		success:function(data){

			$('#data0').val(data.data0);
			$('#data1').val(data.data1);
			$('#data2').val(data.data2);
			$('#data3').val(data.data3);
			$('#data4').val(data.data4);
			$('#data5').val(data.data5);
			$('#data6').val(data.data6);
			$('#data7').val(data.data7);
			$('#data8').val(data.data8);
			$('#data9').val(data.data9);
			$('#data10').val(data.data10);
			$('#data11').val(data.data11);
			$('#data12').val(data.data12);
			$('#data13').val(data.data13);
			$('#data14').val(data.data14);
			$('#data15').val(data.data15);
			$('#data16').val(data.data16);
			$('#data17').val(data.data17);
			$('#data18').val(data.data18);
			$('#data19').val(data.data19);
			$('#data20').val(data.data20);
			$('#data21').val(data.data21);
			$('#data22').val(data.data22);
			$('#data23').val(data.data23);
			$('#data24').val(data.data24);
			$('#data25').val(data.data25);
			$('#data26').val(data.data26);
			$('#data27').val(data.data27);
			$('#data28').val(data.data28);
			$('#data29').val(data.data29);
			
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

	$('#chrtUsedArea').empty();
	
	//면적당 냉난방전력량 분포
	var dataArr = new Array();
	for(var i = 0; i < 30; i++) {
		var tmp = new Array(2);
		tmp[0] = String(Math.floor( gvMinVal + ( i * gvDiff ) )).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		tmp[1] = $( "#data" + i ).val();
		
		dataArr[i] = tmp;
	}
	
	$.jqplot('chrtUsedArea', [dataArr], {
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
	    	label: '${smTempElecUsePerSpace}',
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
	
	$('#chrtUsedArea').bind('jqplotDataClick',
		function(ev, seriesIndex, pointIndex, data){
		
			var index    = pointIndex;
			var startVal = Math.floor( gvMinVal + (index * gvDiff) );
			var endVal   = Math.floor( gvMinVal + ( (index + 1) * gvDiff ) );
			var orgYyyymm = $("#selYearMonth").val();
			
			if( index == 29 ) {
				// 임의의 수
				endVal = 100000;
			}
			
			var args = new Array();
			args.push(orgYyyymm);
			args.push(startVal);
			args.push(endVal);

			fn_divPop("energyHacDistList", "팝업", 950, 750, args );
			
		}
	
	);
	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {

    menuLoadImgShow("loadingArea");
    retrieveChartData();
    menuLoadImgHide("loadingArea");

}

</script>
<!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
    <input type="hidden" id="popArg1" name="orgYyyymm"> 
    <input type="hidden" id="popArg2" name="startVal"> 
    <input type="hidden" id="popArg3" name="endVal"> 
</form>
<div id="loadingArea">
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>${smCompany}</th>
				<td>
				 	<c:if test="${selectVoListCnt == 1 }">
						<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
						<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
					</c:if>
					<c:if test="${selectVoListCnt > 1 }">			
						<select id="'scrCompanyCd'" name="scrCompanyCd'" style="width:100px;" class="searchSelect">
							<option value=''>--선택--</option>
								<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
									<option value='${vo.name}'>${vo.value}</option>
								</c:forEach>
						</select>
					</c:if>
				</td>
				<th>${smYearMonth}</th>
				<td>
					<select class="searchSelect" id="selYearMonth" name="selYearMonth" style="width:120px;" >
						<c:forEach items="${yearMonth}" var="item">
						<option value='${fn:replace(item.yearMonth,"-", "")}'>${item.yearMonth}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<!-- 
			<tr>
				<th></th>
				<td>
					<select class="content" id="strAreaSpec" name="strAreaSpec"></select>
				</td>
			</tr>
			 -->
		</table>
	
		<span class="search">
	        <button onclick="javascript:fncSearch()">${smRetrieve}</button>
	    </span>
	</div>
	
	<div class="r_inputTblTitle">
		<h3>${smHacElecUsePerSpaceDist}</h3>	
	</div>
	<div class="r_grid">
		<table>
			<tr>
				<th>${smAvg}</th>
				<td class="r_gridInput r_last"><span id="td1"></span></td>
				<th>${smMax}</th>
				<td class="r_gridInput r_last"><span id="td2"></span></td>
				<th>${smMin}</th>
				<td class="r_gridInput r_last"><span id="td3"></span></td>
				<th>${smStdDev}</th>
				<td class="r_gridInput r_last"><span id="td4"></span></td>
			</tr>
		</table>
	</div>
	<div class="r_perSpaceChart">
		<div id="chrtUsedArea" style="height:400px;"></div>
	</div>
	
	<input id="avgForecastTemp"  type="hidden" class="content" value="" readonly />
	<input id="avgSenseTemp" type="hidden" class="content" value="" readonly />				
	
	<input id="data0" type="hidden" class="content" value="" readonly />
	<input id="data1" type="hidden" class="content" value="" readonly />
	<input id="data2" type="hidden" class="content" value="" readonly />
	<input id="data3" type="hidden" class="content" value="" readonly />
	<input id="data4" type="hidden" class="content" value="" readonly />
	<input id="data5" type="hidden" class="content" value="" readonly />
	<input id="data6" type="hidden" class="content" value="" readonly />
	<input id="data7" type="hidden" class="content" value="" readonly />
	<input id="data8" type="hidden" class="content" value="" readonly />
	<input id="data9" type="hidden" class="content" value="" readonly />
	<input id="data10" type="hidden" class="content" value="" readonly />
	<input id="data11" type="hidden" class="content" value="" readonly />
	<input id="data12" type="hidden" class="content" value="" readonly />
	<input id="data13" type="hidden" class="content" value="" readonly />
	<input id="data14" type="hidden" class="content" value="" readonly />
	<input id="data15" type="hidden" class="content" value="" readonly />
	<input id="data16" type="hidden" class="content" value="" readonly />
	<input id="data17" type="hidden" class="content" value="" readonly />
	<input id="data18" type="hidden" class="content" value="" readonly />
	<input id="data19" type="hidden" class="content" value="" readonly />
	<input id="data20" type="hidden" class="content" value="" readonly />
	<input id="data21" type="hidden" class="content" value="" readonly />
	<input id="data22" type="hidden" class="content" value="" readonly />
	<input id="data23" type="hidden" class="content" value="" readonly />
	<input id="data24" type="hidden" class="content" value="" readonly />
	<input id="data25" type="hidden" class="content" value="" readonly />
	<input id="data26" type="hidden" class="content" value="" readonly />
	<input id="data27" type="hidden" class="content" value="" readonly />
	<input id="data28" type="hidden" class="content" value="" readonly />
	<input id="data29" type="hidden" class="content" value="" readonly />
</div>