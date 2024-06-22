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

var rowIdx = 0;
var dupChk = false;
var oldVendorCd = "";
var re1 = /[0-9]$/;
var re2 = /[A-Za-z]$/;
var excelYYYYmm = "";
/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	// 조건 조건 달력 셋팅
	$('#scrDate').monthpicker({pattern: 'yyyy-mm', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    selectedYear: 2017,
	    startYear: 2010,
	    finalYear: 2050,
	    openOnFocus: false});			
	
	$('#scrDateBtn').bind('click', function () {
		$('#scrDate').monthpicker('show');
	});
	
	$('#fncToDayMonthBtn').bind('click', function () {
		$('#scrDate').val('${toDayMonth}');
	});
		$('#scrDate').val('${toDayMonth}');
		$('#foucusMonth').val('${foucusMonth}');
	init();
	
});

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());

    

}).resize();


function init()
{
	
	fncPeakMonth();
	var scrDate = "";
	if($('#foucusMonth').val() != ""){
		scrDate = ( $("#foucusMonth").val() ).replace("-","");
	}else{
		scrDate = ( $("#scrDate").val() ).replace("-","");
	}
	
	excelYYYYmm = scrDate;
	$('#SelectMonth').text(scrDate.substring(0,4) + "년 " + scrDate.substring(4,6)+"월");
	console.log( "dfdf : " + scrDate );
	// 피크발생매장 상세정보
	$("#gridStoreMgnt").jqGrid({
	      url:'retrievePeakMonthStatus',
	      datatype: "json",	     
	      postData : {			 
			 scrDate:scrDate		 
		  },
	      mtype: 'POST',
	      colNames:['No', '매장명', '매장코드', '조직명', '제어횟수', '계약전력(kW)', '최대수요전력(kW)', '여유전력(kW)', '최대냉난방전력(kW)','주소','전화번호'],
	      colModel:[
	                {name:'records',	index:'records',	width:10,	align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
	                {name:'strNm',		index:'strNm', 		width:40, 	align:'left' },
	                {name:'viewStrCd',	index:'viewStrCd', 	width:20, 	align:'center' },
	                {name:'orgFullNm',	index:'orgFullNm',	width:40, 	align:'left' },
	                {name:'peakCnt',	index:'peakCnt', 	width:20, 	align:'center' },
	                {name:'contPower',	index:'contPower', 	width:30, 	align:'center', formatter:'number', formatoptions:{decimalPlaces:1} },
	                {name:'mainTotal',	index:'mainTotal', 	width:30, 	align:'right', formatter:'number', formatoptions:{decimalPlaces:1} },
	                {name:'freePower',	index:'freePower', 	width:30, 	align:'right', formatter:'number', formatoptions:{decimalPlaces:1} },
	                {name:'temp',		index:'temp', 		width:30, 	align:'right', formatter:'number', formatoptions:{decimalPlaces:1} },
	                {name:'addr',		index:'addr', 		width:70, 	align:'left' },
	                {name:'telNo',		index:'telNo', 		width:40, 	align:'center' },
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
		 height : 400,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 
			 //var list = $("#gridStoreMgnt").getRowData(rowid);
			 
		},
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='11'>검색 결과가 없습니다.</td></tr>");
			}
		},
		
		
	 });
	 //jqGrid Resize	
	 jqGridResize('gridStoreMgnt');
	  
	  
	// validate
	$('#saveForm').validate({
		rules:{
			vendorCd:{required:true, minlength:3, maxlength:10, checkCd:true},
			vendorNm:{required:true},
			useYn:{required:true},
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
	 
	jQuery.validator.addMethod("checkCd", function(value, element) {
	    return this.optional(element) || ( re1.test($('#vendorCd').val()) || re2.test($('#vendorCd').val() ) );
	}, "영문과 숫자만 가능 합니다");
	
	

}

//피크제어매장현황
function fncPeakMonth()
{	
	
	//var scrDate = $('#scrDate').val();
	
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var scrDate = $("#scrDate").val().replace("-","");
	$('#SelectMonth').text(scrDate.substring(0,4) + "년 " + scrDate.substring(4,6)+"월");
	var param = new Object();
	param.companyCd = companyCd;
	param.scrDate = scrDate;
	
	
	var yyyymm 		= new Array("-","-","-","-","-","-","-","-","-","-","-","-");
	var peakCnt 	= new Array("-","-","-","-","-","-","-","-","-","-","-","-");

	
	var yyyy = scrDate.substring(0,4);
	var mm = scrDate.substring(4,6);
	
	console.log( "scrDate : ", scrDate );
	console.log( "yyyy : ", yyyy );
	console.log( "mm : ", mm - 0 );
	mm = mm - 0;
	
	// clear 
	for(var i=0; i<12; i++)		
	{	
		$('#mPeakCnt'+i).removeClass("sky_blue_box blue_box pink_box");
		$('#mPeakCnt'+i).addClass("sky_blue_box");
		if( mm < 10 )
		{
			$('#month'+i).text( yyyy + "년 0" + mm + "월" );
			$('#month'+i).val( i );
		}
		else
		{
			$('#month'+i).text( yyyy + "년 " + mm + "월" );
			$('#month'+i).val( i );
		}

		var abc = $('#yyyymm'+i).val();
		$('#mPeakCnt'+i).text( "0" );
				
		mm = mm - 1;		
		if( mm == 0 )
		{
			yyyy = yyyy -1;
			mm = 12;
		}		
		
			
	}
	
	
	$.ajax({
		url:'/retrievePeakMonth',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		async : false,
		success:function(data){	
			
			$.each(data, function(key, value) {	
				console.log( data );
				if(key == 0) {											
					$.each(value, function(idx, val) {
						
						for(var j=0; j<12; j++)
						{
							var yyyymmTemp = $('#month'+j).text();
							if( yyyymmTemp == val ){								
								$('#mPeakCnt'+index).removeClass("sky_blue_box blue_box pink_box");	
								var index = $('#month'+j).val();					
								
								$('#mPeakCnt'+index ).text( data[1][idx] );
								
								//$('#mPeakCnt'+index).addClass("blue_box");
								if( data[1][idx] < 10 )
								{
									$('#mPeakCnt'+index).addClass("pink_box");	
								}else if( data[1][idx] < 100 )
								{
									$('#mPeakCnt'+index).addClass("blue_box");
								}else
								{
									$('#mPeakCnt'+index).addClass("pink_box");
								}

							}
						}
					});
				}
				else if(key == 1) {
					$.each(value, function(idx, val) {
						
						//$('#mPeakCnt'+idx).text( val );
					});
				}
				
			});
		

		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}
/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncSearch() {
	
	var companyCd  = $("#scrCompanyCd").val();
	
	var scrDate = $("#scrDate").val().replace("-","");
	excelYYYYmm = scrDate;
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	
	fncPeakMonth();
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrDate: scrDate,
		 }
	 }).trigger("reloadGrid");
	
}

// 피크제어매장현황 버튼 클릭시
function fncPeakList(val)
{	
	//var scrDate1 = $('#month'+val).val();
	var scrDate = $('#month'+val).text();
	var yyyy 	= scrDate.substring(0,4);
	var mm 		= scrDate.substring(6,8);
	var yyyymm = yyyy + "" + mm;
	
	excelYYYYmm = yyyymm;

	$('#SelectMonth').text(yyyy + "년 " + mm+"월");
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrDate: yyyymm,
		 }
	 }).trigger("reloadGrid");
	
}

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrDate = excelYYYYmm;
	
	$("#excel1").val(scrDate);
	
	$('#excelDownload').attr("action", "/downloadPeakMonthStatusExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">

<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrDate"> 
</form>

	<!-- 조회조건 -->
	<div class="r_search multiLine">
			<input type='hidden' id='foucusMonth' name='foucusMonth' value='${foucusMonth}' />
			<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
			<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;display:none;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>		
		<table>
			<tr>
				<th>피크제어매장현황</th>
				<td>				 	
				 	<input id="scrDate" name="scrDate" type="text" placeholder="" value='${toDayMonth}' style="width:80px;" readonly />
					<button class="monthBtn" id="scrDateBtn"><img src="/images/btn_calendar_new.png"></button>
					<button id="fncToDayMonthBtn" class="ml_5" style="width:54px; height:20px !important;">이번달</button>
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 테이블 영역 -->
	<div class="r_inputTbl r_horizonTbl white">
		<form id="saveForm" name="saveForm" method="post">
			<input type="hidden" id="companyCd" name="companyCd" value="" />		
			
			<div class="r_gridTitle">
				<h3>피크제어매장현황</h3> 
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
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    	<col width="" />
			    </colgroup>
			    <thead>
			    <tr>
			    	<th>년월</th>
			    	<th id="month11">-</th>
			    	<th id="month10">-</th>
			    	<th id="month9">-</th>
			    	<th id="month8">-</th>
			    	<th id="month7">-</th>
			    	<th id="month6">-</th>
			    	<th id="month5">-</th>
			    	<th id="month4">-</th>
			    	<th id="month3">-</th>
			    	<th id="month2">-</th>
			    	<th id="month1">-</th>
			    	<th id="month0">-</th>
			    </tr>
			    </thead>
		    	<tbody>
	       		<tr>
	         		<th>발생<br />매장수</th>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn11" onclick="javascript:fncPeakList(11)" >	<span id="mPeakCnt11">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn10" onclick="javascript:fncPeakList(10)" >	<span id="mPeakCnt10">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn9" onclick="javascript:fncPeakList(9)" >	<span id="mPeakCnt9">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn8" onclick="javascript:fncPeakList(8)" >	<span id="mPeakCnt8">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn7" onclick="javascript:fncPeakList(7)" >	<span id="mPeakCnt7">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn6" onclick="javascript:fncPeakList(6)" >	<span id="mPeakCnt6">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn5" onclick="javascript:fncPeakList(5)" >	<span id="mPeakCnt5">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn4" onclick="javascript:fncPeakList(4)" >	<span id="mPeakCnt4">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn3" onclick="javascript:fncPeakList(3)" >	<span id="mPeakCnt3">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn2" onclick="javascript:fncPeakList(2)" >	<span id="mPeakCnt2">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn1" onclick="javascript:fncPeakList(1)" >	<span id="mPeakCnt1">-</span></div>
	         		</td>
	         		<td>
	         			<div class="" style="cursor:pointer" id="mPeakCtnBtn0" onclick="javascript:fncPeakList(0)" >	<span id="mPeakCnt0">-</span></div>
	         		</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- //테이블 영역 -->
	
	<!-- 그리드 영역 -->
	<div class="r_grid" id="cont">
		<div class="r_gridTitle">
			<h3>피크제어매장현황&nbsp-&nbsp<span id ="SelectMonth" style="font-color:black;font-size: 14px;"></span></h3>
			
			<!-- 엑셀 download -->
			<div style="text-align:right;">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
			</div>
			<!-- //엑셀 download -->
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
</div>