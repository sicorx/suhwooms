<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/


var dupChk = false;
var oldVendorCd = "";
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;
/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());

    

}).resize();

$(document).ready(function(){
	
	
	$('input:radio[name="scrUseYn"]').eq(0).attr('checked', true);
	
	// 엔터 키 이벤트
	$("input[name='scrStrFullNm']").on({
		keydown: function(key) {
			if (key.keyCode == 13) {
				fncStoreSearchBtn();
	        }
		}
	});	
	
	var prevCellVal1 = { cellId: undefined, value: undefined };
	var prevCellVal2 = { cellId: undefined, value: undefined };
	
	var style = "";
	
	// Grid 출력
	$("#gridStoreMgnt").jqGrid({
	      url:'retrieveEqmtStoreMgnt',
	      datatype: "json",
	      mtype: 'POST',
	      postData : {
				 scrCompanyCd:$("#scrCompanyCd").val(),
				 scrOrgCd:$("#scrOrgCd").val(),
				 scrStrCd:$("#scrStrCd").val(),
				 scrStrNm:$("#scrStrNm").val(),				 				 			 
				 scrStrNm:$("#scrDeviceType").val(),
		  },
	      colNames:['No', '매장명', '조직', '장비명', '장비유형', '최고온도(℃)', '최저온도(℃)', '해당월알림', 'strCd', 'orgCd','temonType','portNo','temonId'],
	      colModel:[
	                {name:'records',index : 'records',width : 15,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10} },
	                {name:'strNm',index:'strNm', width:60, align:'left', sortable:true, editable:false,
                	cellattr: function(rowId, val, rawObject, cm, rdata) {
                		var result;
                		
                		if (prevCellVal1.value == val) {
                			result = ' style="display: none" rowspanid="' + prevCellVal1.cellId + '"';
                			style = "";
                		} else {
                			var cellId = this.id + '_row_' + rowId + '_' + cm.name;
                			result = ' rowspan="1" id="' + cellId + '"';
                			prevCellVal1 = { cellId: cellId, value: val };
                			style = "0";
                		}
                		
                		return result;
                    }},
	                {name:'orgFullNm',index:'orgFullNm', width:50, align:'left', sortable:true, editable:false,
                	cellattr: function(rowId, val, rawObject, cm, rdata) {
                		var result;
                		
                		if (prevCellVal2.value == val && style == "") {
                			result = ' style="display: none" rowspanid="' + prevCellVal2.cellId + '"';
                		} else {
                			var cellId = this.id + '_row_' + rowId + '_' + cm.name;
                			result = ' rowspan="1" id="' + cellId + '"';
                			prevCellVal2 = { cellId: cellId, value: val };
                		}
                		
                		return result;
                    }},
	                {name:'deviceLoc',index:'deviceLoc', width:40, align:'left', sortable:true, editable:false},
	                {name:'temonTypeName',index:'temonTypeName', width:40, align:'center', sortable:true, editable:false},	                	                
	                {name:'maxSensTemp',index:'maxSensTemp', width:40, align:'right', sortable:true, editable:false, formatter:'number', formatoptions:{decimalPlaces:0} },	                
	                {name:'minSensTemp',index:'minSensTemp', width:40, align:'right', sortable:true, editable:false, formatter:'number', formatoptions:{decimalPlaces:0} },	                
	                {name:'alarmCnt',index:'alarmCnt', width:50, align:'center', sortable:true, editable:false},
	                {name:'strCd',index:'strCd', hidden:true},
	                {name:'orgCd',index:'orgCd', hidden:true},
	                {name:'temonType',index:'temonType', hidden:true},
	                {name:'portNo',index:'portNo', hidden:true},
	                {name:'temonId',index:'temonId', hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     formatter : {
		  		number : {
					decimalSeparator: ".",
					thousandsSeparator: ",", 
					decimalPlaces: 0,
					defaultValue: '0'
			}
		 },
	     rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridStoreMgntPager',
	     recordtext: "{1} 건/페이지  (전체 {2} 건)",
	     emptyrecords : "검색 결과가 존재하지 않습니다.",
	     loadtext: "Loading...",
	     sortname: 'strNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 250,	
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 
			var list   = $("#gridStoreMgnt").getRowData(rowid);			
			fncEqmtTempChartData(list);			// 일별 매장 온도 그래프

		},		 	 
		gridComplete : function()
		{
			var grid = this;
			prevCellVal1 = { cellId: undefined, value: undefined };
			prevCellVal2 = { cellId: undefined, value: undefined };

		    $('td[rowspan="1"]', grid).each(function () {
		      var spans = $('td[rowspanid="' + this.id + '"]', grid).length + 1;
		      
		      if (spans > 1) {
		        $(this).attr('rowspan', spans);
		      }
		    });
		    
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='8'>검색 결과가 없습니다.</td></tr>");
			}	
		},
		
	 });
	  //jqGrid Resize	
	 jqGridResize('gridStoreMgnt')
	  
	 
	 
});

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}	
		
	$("#gridStoreMgnt").clearGridData();
	
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrStrCd:$("#scrStrCd").val(),
			 scrStrNm:$("#scrStrNm").val(),		
			 scrDeviceType:$("#scrDeviceType").val()
		 }
	}).trigger("reloadGrid");
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
		
	$('#chrtMain').html('');
	
	
}

//조직명 검색
function fncSearchOrgCd() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#scrOrgNm").val());
	
	var param = new Object();
	param.companyCd = companyCd;
	param.orgNm = orgNm;
	
	$.ajax({
		url:'/retrieveOrgCdCnt',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
			$("input[name='scrOrgCd']").val("");
			var orgCnt = data.orgCnt;
			// 0개 일때
			if (orgCnt == "0") {
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (orgCnt == "1") {
				$("#scrOrgCd").val(data.orgCd)
				$("#scrOrgNm").val(data.orgNm + "(" + data.orgCd + ")");
			// 2개 이상일때	
			} else {
				// 조직 팝업
				fncOrgSearch();
			}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}



//조직 검색 버튼
function fncOrgSearchBtn() {
	var orgNm = $.trim($("#scrOrgNm").val());
	if (orgNm == "") {
		// 조직 팝업
		fncOrgSearch();
	} else {
		$("input[name='scrOrgNm']").blur();
	}
}

// 조직 팝업
function fncOrgSearch() {
	
	var companyCd = $.trim($("#scrCompanyCd").val());
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgNm = $.trim($("#scrOrgNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.orgNm = orgNm;
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd)
	$("#scrOrgNm").val(data.orgNm + "(" + data.orgCd + ")");
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}


//매장명 검색
function fncStoreSearchBtn() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var strNm = $.trim($("#scrStrFullNm").val());
	
	var param = new Object();
	param.companyCd 	= companyCd;
	param.strNm 		= strNm;
	
	$.ajax({
		url:'/retrieveStoreCnt',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
			
			var strCnt = data.strCnt;
			// 0개 일때
			if (strCnt == "0") {
				$("#scrStrCd").val("")
				$("#scrStrNm").val("");
				alert("해당 내용이 없습니다.");
			// 1개 일때
			} else if (strCnt == "1") {
				$("#scrStrCd").val(data.strCd)
				$("#scrStrNm").val(data.strNm);
				$("#scrStrFullNm").val(data.strNm);
			// 2개 이상일때	
			} else {
				// 조직 팝업
				fncStoreSearch();
			}
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
	
	
	
}


// 매장 팝업
function fncStoreSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#scrStrFullNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;
	
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );
}

function fncSetStore(data){
	$("#scrStrCd").val(data.strCd);
	$("#scrStrNm").val(data.strNm);
	$("#scrStrFullNm").val(data.strNm + "(" + data.strCd + ")");
}

function fncStoreClear(){
	$("#scrStrCd").val("");
	$("#scrStrNm").val("");
	$("#scrStrFullNm").val("");
}



// 차트 데이터
function fncEqmtTempChartData(list) {
	
	$('#chrtMain').html('');	
	
	var param = new Object();	
	param.strCd = 			list.strCd;
	param.temonType = 		list.temonType;
	param.portNo = 			list.portNo;
	param.temonId = 		list.temonId;
	param.deviceLoc =		list.deviceLoc;
	
	$.ajax({
		async: false,
		url : "retrieveEqmtTempChart",
		dataType : "json",
		data : param,
		success : function(data) {			
						
			fncEqmtTempChart( data );		// 차트 그리기 		
			
		}
	});
	
}



//차트 그리기
function fncEqmtTempChart( data )
{	
	var yyyymmdd 	= new Array();
	var hhmin  		= new Array();
	var sensTemp	= new Array();
	var deviceLoc  	= new Array();
	
	var deviceLocName = "";
	
	var chartData	= new Array();	// 차트 계약전력	
	
	
	$.each(data, function(key, value) {	
		
		if(key == 0) {											
			$.each(value, function(idx, val) {
				yyyymmdd.push( val );				
				
			});
		}
		else if(key == 1) {
			$.each(value, function(idx, val) {
				hhmin.push( val );
			});
		}
		else if(key == 2) {
			$.each(value, function(idx, val) {
				sensTemp.push( Number(val) );				
			});
		}
		else if(key == 3) {
			$.each(value, function(idx, val) {
				deviceLoc.push( val );				
			});
		}
			
	});

	
	for(var i=0; i<yyyymmdd.length; i++) 
	{		
		
		var getDateTime = 
			Date.UTC( 
					Number( (String)(yyyymmdd[i]).substr(0,4) ), 
					( Number( (String)(yyyymmdd[i]).substr(4,2) )-1 ),  
					Number( (String)(yyyymmdd[i]).substr(6,2) ),  
					Number( (String)(hhmin[i]).substr(0,2) ),  
					Number( (String)(hhmin[i]).substr(2,2) )
					
				);		
				
		chartData.push( [ getDateTime, Number( sensTemp[i] ) ]  );
		deviceLocName = deviceLoc[i];
		
	}	
	
	
		
		
	Highcharts.setOptions({
	lang: {
			weekdays: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			shortMonths: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			rangeSelectorZoom : '',
			loading : "Loading...",
		}
	});	
	

	$('#chrtMain').highcharts('StockChart', {

		chart : {
			borderWidth : 1,
			borderColor : "#E8E8E8",
			plotBorderWidth : 1,
			spacingRight : 15,
			spacingLeft : 15,
			height : 300,
			panning : true,
		},
		credits : {
			enabled : false
		},
		//colors : ['#D80546', '#F5516C'],
		exporting : {
			enabled : false
		},
		legend : { 
			enabled : true,
			align : 'center'

		},
		rangeSelector: {
	    	enabled: true,
			buttons: [{
				type: 'minute',
				count: 180,
				text: '3시간'
			}, {
				type: 'minute',
				count: 360,
				text: '6시간'
			}, {
				type: 'all',
				text: '전체'
			}],
			selected: 3,
			inputEnabled: false

	    },
		loading : {
			style : {
				backgroundColor : 'silver'
			},
			labelStyle : {
				color : 'white'
			}
		},						
		series : [{
			name : deviceLocName,
			type : 'line',
			data : chartData,			
			tooltip : {
				
				shared : false,
				valueSuffix : ' ℃',
				positioner : function() {
					return {
						x : 10,
						y : 40
						};
					},
				}			
			},			
		],
		
		xAxis : {
			type: 'datetime',
			dateTimeLabelFormats: {
				second: '%Y-%m-%d<br/>%H:%M:%S',
				minute: '%Y-%m-%d<br/>%H:%M',
				hour: '%d일 %H시',
				day: '%d일',
				week: '%Y<br/>%m-%d',
				month: '%Y-%m',
				year: '%Y'
			},
			tickInterval: 24 * 3600 * 1000
		},
		yAxis : {
			
			labels: {				
				align: 'left',			
	    		formatter: function() {
	    			return this.value + '℃';
	    		}
	    	},
	    	min: -50,
	    	max: 50
		},
		
	});
	
}


</script>

<div id="loadingArea">

	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl">
		<form id="saveForm" name="saveForm" method="post">
			<div class="r_gridTitle top_table">
				<h3>시설물보유현황</h3>
			</div>
			<table>
				<colgroup>
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    </colgroup>
		    	<tbody>
		    		<tr>		       		
		       		<c:forEach items="${plantStatus}" var="plantStatus">					
						<c:if test="${plantStatus.device == 'W' }">
							<th>WIC</th>
						</c:if>
						<c:if test="${plantStatus.device == 'O' }">
							<th>OSC</th>
						</c:if>
						<c:if test="${plantStatus.device == 'R' }">
							<th>RIF</th>
						</c:if>						
						<c:if test="${plantStatus.device == 'I' }">
							<th>ICE</th>
						</c:if>
						<c:if test="${plantStatus.device == 'C' }">
							<th>Comp.</th>
						</c:if>
	          			<td class="r_gridInput r_last">${plantStatus.count}</td>	           		
					</c:forEach>				
					<c:if test="${plantStatus == '' }">					
						<th>WIC</th>
						<td class="r_gridInput r_lasat">0</td>					
						<th>OSC</th>
						<td class="r_gridInput r_lasat">0</td>					
						<th>RIF</th>
						<td class="r_gridInput r_lasat">0</td>
						<th>Comp.</th>
						<td class="r_gridInput r_lasat">0</td>										
					</c:if>
					</tr>	
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->

	<!-- 조회조건 -->
	<div class="r_search multiLine" style="margin-top:15px !important;">
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />						
		<table>
			<tr>
				<th>매장명(코드)</th>
				<td>
					<input type='hidden' id='scrStrCd' name='scrStrCd' value="" />
					<input type='hidden' id='scrStrNm' name='scrStrNm' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrStrFullNm' name='scrStrFullNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncStoreSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>
			
				<th>조직명(코드)</th>
				<td><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable"  placeholder="전체"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearchBtn();" class="icon_search" style="cursor:pointer"/>
				</td>			
				<th>장비유형</th>
				<td>				
					<select id="scrDeviceType" name="scrDeviceType" class="searchSelect">							
							<option value="">--전체--</option>
						<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
							<option value='${vo.value}'>${vo.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>			
		</table>
		<span class="search">
			<button onclick="javascript:fncSearch()">Search</button>
		</span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">
			<h3>시설물목록</h3>
			<!-- 엑셀 download -->
			<!-- div style="text-align:right">
				<img src="/images/download_excel.png"/>
			</div -->
			<!-- //엑셀 download -->
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
	<!-- 그래프 영역 -->
	<div class="common_section">
		<div class="common_section_title">
			<h3>시설물온도</h3>
		</div>
		<div id="chrtMain" class="chrtMain"></div>
	</div>
	<!-- //그래프 영역 -->
	
</div>