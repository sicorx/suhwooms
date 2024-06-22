<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


 <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/ui.jqgrid.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jquery.jqplot.css"/>
    <%--<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/smoothness/jquery-ui.css"/>--%>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jquery-ui-1.11.4/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jstree.style.min.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/rems_global.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/rems_page.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/fancytree/skin-win8/ui.fancytree.css" />

	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
    <%--<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>--%>
    <script type="text/javascript" src="/resources/js/jquery-ui-1.11.4/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.datepick-ko.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.mtz.monthpicker.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.json-2.4.min.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>

    <script type="text/javascript" src="/resources/js/jstree.min.js"></script>
    <script type="text/javascript" src="/resources/js/rsh.compressed.js"></script>

    <script type="text/javascript" src="/resources/js/i18n/grid.locale-kr.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="/resources/js/popupDiv.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.oLoader.js"></script>

    <!--[if lt IE 10]>
    <script type="text/javascript" src="/resources/js/excanvas.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/resources/js/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.json2.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.barRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.categoryAxisRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.pointLabels.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.highlighter.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.canvasTextRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.canvasAxisTickRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.canvasAxisLabelRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.cursor.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.dateAxisRenderer.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.enhancedLegendRenderer.min.js"></script>

    <script type="text/javascript" src="resources/js/highstock.js"></script>
    <script type="text/javascript" src="resources/js/exporting.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.ui-contextmenu.min.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.fancytree-all.min.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.mousewheel.js"></script>
    <script type="text/javascript" src="/resources/js/globalize.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.easing.1.3.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/resources/js/popup.js"></script>
    <script type="text/javascript" src="/resources/js/common.js"></script>
    <script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>


    <script type="text/javascript" src="/resources/js/jquery.form.min.js"></script>
    
    
    <!--  대시보드 Pie 차트 -->    
    <script type="text/javascript" src="/resources/js/Chart.js"></script>
    <script type="text/javascript" src="/resources/js/utils.js"></script>


	
	
	
	
<script type="text/javascript">


// 페이지 사용 - jooyoung

/*******************
1. 선행, 등록 스크립트
********************/




$(document).ready(function(){	
	
	
	//alert('111');
	init();			// 초기 셋팅 
	 	
});


function init()
{
	/*
	var toDayDate = gfnTodayDate("-");
	
	// 조회 변수 셋팅
	$('#scrStrNm').val( 		'${scrValue.scrStrNm}' );	
	
	if( '${scrValue.scrUseYn}' == 'Y' )
		$(':radio[name="search_radio"]:radio[value="Y"]').attr('checked', true);
	if( '${scrValue.scrUseYn}' == 'N' )
		$(':radio[name="search_radio"]:radio[value="N"]').attr('checked', true);
	
	if('${scrValue.scrDateFrom}' == "" )
	{	
		// Default Date Setting
		var DateFrom = gfnDateAdd(toDayDate, 'M', -12, '-');
		$( "#scrDateFrom" ).datepicker( "setDate",  DateFrom );
		
	}
	else
	{		
		$('#scrDateFrom').val( 		'${scrValue.scrDateFrom}' );
	}
	
	if('${scrValue.scrDateTo}' == "" )
	{	
		$( "#scrDateTo" ).datepicker( 	"setDate",  toDayDate );
	}
	else
	{
		$('#scrDateTo').val( 		'${scrValue.scrDateTo}' );	
	}    
	*/
	
	  
	// Grid 출력
	$("#gridStoreMgnt").jqGrid({
	    url:'retrieveBleMgnt',
	    datatype: "json",
	    mtype: 'POST',
	    postData : {				
		},
	    colNames:['No', '매장코드', '매장명', '전기', '전기체크', '냉장비', '냉장비체크',  ' 네트웍', '네트워크체크', '간판', '간판체크', '착공일', '준공일', '전기체크', '냉장비체크', '네트워크체크','간판체크', '통신','TnM체크', '착공점검','중간점검','준공점검','오픈점검','비고','저장'],
	    colModel:[
	                {name:'records',			index:'records',			width:10, 	align:'center',	sortable : false},
	                {name:'strCd',				index:'strCd', 				width:10, 	align:'center' },
	                {name:'strNm',				index:'strNm', 				width:50, 	align:'center' },	                  
	                {name:'elecVendorNm',		index:'elecVendorNm', 		width:20, 	align:'center' },
	                
	                {name:'elecNotiDate',		index:'elecNotiDate',		width:28, 	align:'center' },
	                {name:'sensorVendorNm',		index:'sensorVendorNm', 	width:20, 	align:'center' },
	                {name:'sensorNotiDate',		index:'sensorNotiDate', 	width:28, 	align:'center' },
	                {name:'networkVendorNm',	index:'networkVendorNm', 	width:20, 	align:'center' },
	                {name:'networkNotiDate',	index:'networkNotiDate', 	width:28, 	align:'center' },	                
	                {name:'signVendorNm',		index:'signVendorNm', 		width:20, 	align:'center' },
	                {name:'signNotiDate',		index:'signNotiDate', 		width:28, 	align:'center' },
	                	                
	                {name:'remsReadyDt',		index:'remsReadyDt', 		width:25, 	align:'center' },
	                {name:'remsStartDt',		index:'remsStartDt', 		width:25, 	align:'center' },
	                	                
	                {name:'elecCheck',			index:'elecCheck', 			width:15, 	align:'center' },
	                {name:'sensorCheck',		index:'sensorCheck', 		width:15, 	align:'center' },
	                {name:'networkCheck',		index:'networkCheck', 		width:15, 	align:'center' },
	                {name:'signCheck',			index:'signCheck', 			width:15, 	align:'center' },
	                
	                {name:'gwStatusYn',			index:'gwStatusYn', 		width:10, 	align:'center' },	                
	                {name:'checkSuccess',		index:'checkSuccess', 		width:15, 	align:'center', editable:true, edittype: 'select', editoptions:{value:{'N':'N', 'Y': 'Y'}}},	      
	                
	                {name:'oneContents',		index:'oneContents', 		width:50, 	align:'left', editable:true},	                
	                {name:'twoContents',		index:'twoContents', 		width:30, 	align:'left', editable:true},
	                {name:'threeContents',		index:'threeContents', 		width:50, 	align:'left', editable:true},
	                {name:'fourContents',		index:'fourContents', 		width:50, 	align:'left', editable:true},
	                {name:'etcContents',		index:'etcContents', 		width:15, 	align:'left', editable:true},
	                {name:'saveCancle',			index:'saveCancle', 		width:25, 	align:'left'}
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
	    rowNum:50,
	    rowList:[10,20,50,100],
	    pager: '#gridStoreMgntPager',
	    recordtext: "{1} 건/페이지  (전체 {2} 건)",
	    emptyrecords : "검색 결과가 존재하지 않습니다.",
	    loadtext: "Loading...",
	    sortname: 'remsStartDt',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 500,		 
		onSelectRow : function(rowid, iRow, iCol, e ) {
			
			/*
			var ids = $("#gridStoreMgnt").jqGrid('getDataIDs');
			
			for(var i=0; i< ids.length; i++)
			{
				$('#gridStoreMgnt').saveRow( ids[i] );
			}
			
			$('#gridStoreMgnt').editRow( rowid );
			*/
			
		},	
		ondblClickRow : function(rowid, iRow, iCol, e) {
			
			var list = $("#gridStoreMgnt").getRowData(rowid);	
			
			var args = new Object();
			
			args.strCd = list.strCd;
			args.strNm = list.strNm;
			args.elecNotiDate = list.elecNotiDate;
			args.sensorNotiDate = list.sensorNotiDate;
			args.networkNotiDate = list.networkNotiDate;
			args.signNotiDate = list.signNotiDate;
			
			
			fn_divPop("bleMgntMstPop", "매장 BLE 수집 정보", 1000, 850, args);		// 대시보드 팝업
		},
		gridComplete : function()
		{
			jqGridEven('gridStoreMgnt');			 
			var rsltCount = $("#gridStoreMgnt").getGridParam("reccount");			
			
			if( rsltCount == 0)		// 결과가 한개이면 경고 메세지
			{								
				$("#gridStoreMgnt >tbody").append("<tr><td align='center' colspan='24'>검색 결과가 없습니다.</td></tr>");
			}
			
			
			var ids = $("#gridStoreMgnt").jqGrid('getDataIDs');
			
			for(var i=0;i < ids.length;i++){
				var cl = ids[i];				
				detail = "<input style='' type='button' value='상세' onclick=\"javascript:fncDetail('"+cl+"');\"  />&nbsp;";
				edit = "<input style='' type='button' value='편집' onclick=\"$('#gridStoreMgnt').editRow('"+cl+"');\"  /><br>";
				cancle = "<input style='' type='button' value='취소' onclick=\"javascript:fncCancle('"+cl+"');\"  />&nbsp;";
				save = "<input style='' type='button' value='저장' onclick=\"javascript:fncSave('"+cl+"');\"  />";
				jQuery("#gridStoreMgnt").jqGrid('setRowData',ids[i],{saveCancle:detail+edit+cancle+save});
			}
			
		}
		
	 });
	  //jqGrid Resize	
	 jqGridResize('gridStoreMgnt');	 
	  
	  
	  
	  
}






//달력 기간 버튼
function fncMonthBtn(val)
{
	var DateTo = $( "#scrDateTo" ).val();
	var DateFrom = gfnDateAdd(DateTo, 'M', (val*-1), '-');
	$( "#scrDateFrom" ).datepicker( "setDate",  DateFrom );
}


// 전체 
function funAllBtn()
{
	
	var toDayDate = gfnTodayDate("-");
	
	$( "#scrDateFrom" ).datepicker( "setDate",  "2010-01-01" );
	$( "#scrDateTo" ).datepicker( "setDate", toDayDate );
}


// 취소 버튼



function fncDetail( rowNum )
{		
	var list = $("#gridStoreMgnt").getRowData(rowNum);	
	
	var args = new Object();
	
	args.strCd = list.strCd;
	args.strNm = list.strNm;
	args.elecNotiDate = list.elecNotiDate;
	args.sensorNotiDate = list.sensorNotiDate;
	args.networkNotiDate = list.networkNotiDate;
	args.signNotiDate = list.signNotiDate;
	
	fn_divPop("bleMgntMstPop", "매장 BLE 수집 정보", 1000, 850, args);		// 대시보드 팝업	
}


function fncCancle( rowNum )
{	
	$('#gridStoreMgnt').restoreRow( rowNum );
}

// 저장 버튼
function fncSave( rowNum )
{	
	$('#gridStoreMgnt').saveRow( rowNum );
	
	
	var list = $("#gridStoreMgnt").getRowData(rowNum);	
	
	var param = new Object();
	
	param.strCd	=				list.strCd;
	param.oneContents = 		list.oneContents;
	param.twoContents = 		list.twoContents;
	param.threeContents = 		list.threeContents;
	param.fourContents = 		list.fourContents;
	param.etcContents = 		list.etcContents;
	param.checkSuccess = 		list.checkSuccess;
	
	$.ajax({
		url:'/saveBleCheck',
		type:'POST',
		cache:false,
		data : param,
		dataType:'json',
		success:function(data){
			
			alert('save 완료');
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
	
		
}

// 삭제 버튼
function func_DelBtn()
{
	// 미사용	
}

// 선택된 리스트
function getSelectedRow() 
{
	var grid = $("#gridStoreMgnt");
	var rowKey = grid.jqGrid('getGridParam',"selrow");
	
	if (rowKey)
	{
		//alert("Selected row primary key is: " + rowKey);
		return rowKey;
	}
	else
	{
		alert("선택된 매장이 없습니다.");
		return '';
	}
}

/*******************
버튼 스크립트 
1. 조회 
2. 신규
3. 수정
4. 삭제  
********************/

// 조회 버튼
function fncSearch() {
	
	
	$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreMgnt").setGridParam({
		 postData : {
			 scrStrNm:$("#scrStrNm").val(),
			 scrStrCd:$("#scrStrCd").val(),
			 scrReadyDt:$("#scrReadyDt").val(),
			 scrStartDt:$("#scrStartDt").val(),
			 scrElecCheck:$("#scrElecCheck").val(),
			 scrSensorCheck:$("#scrSensorCheck").val(),
			 scrNetworkCheck:$("#scrNetworkCheck").val(),
			 scrSignCheck:$("#scrSignCheck").val(),
			 checkSuccess:$("#checkSuccess").val(),
			 elecVendorNm:$("#elecVendorNm").val(),
			 sensorVendorNm:$("#sensorVendorNm").val(),
			 networkVendorNm:$("#networkVendorNm").val(),
			 signVendorNm:$("#signVendorNm").val()
			 
		 }
	 }).trigger("reloadGrid");
}

/*******************
1. 조직 팝업  
********************/
// 조직명 검색
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

// 조직 검색 버튼
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

function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	
	var scrCompanyCd = $("#scrCompanyCd").val();
	var scrOrgCd = $("#scrOrgCd").val();
	var scrStrCd = $("#scrStrCd").val();
	var scrStrNm = $("#scrStrNm").val();
	var scrUseYn = $(':radio[name="search_radio"]:checked').val();
	var scrDateFrom = $("#scrDateFrom").val();
	var scrDateTo = $("#scrDateTo").val();
	
	$("#excel1").val(scrCompanyCd);
	$("#excel2").val(scrOrgCd);
	$("#excel3").val(scrStrCd);
	$("#excel4").val(scrStrNm);
	$("#excel5").val(scrUseYn);
	$("#excel6").val(scrDateFrom);
	$("#excel7").val(scrDateTo);
	
	$('#excelDownload').attr("action", "/downloadStoreExcel");
	$("#excelDownload").submit();

}



function menuLoadImgShow(divId) {
    $('#' + divId).oLoader({
        backgroundColor: '#000',
        fadeInTime: 800,
        fadeLevel: 0.4,
        image: '/images/loader1.gif',
        style: 3
    });
}

//로딩이미지 숨기기
function menuLoadImgHide(divId) {
    $('#' + divId).oLoader('hide');
}

// jqGrrid Resize
function jqGridResize(gridId) {
    var parObj = $("#" + gridId).parent();

    $("#" + gridId).setGridWidth($(parObj).width() + 15);

    $(window).resize(function () {
        $("#" + gridId).setGridWidth($(parObj).width() + 15);
    });
}






</script>


<style>
.ui-jqgrid {font-size:0.8em}

</style>



<body class="mainBody">

<div class="r_popupTitle" id="dialog-confirm" title="" style="display:none;">
    <p>
    	<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">
    	</span>로딩중...
    </p>
</div>



<form id='popupForm' name='popupForm' method='post'> 
	<input type="hidden" id="popArg1" name="strCd"> 
	<input type="hidden" id="popArg2" name="viewStrCd"> 
	<input type="hidden" id="popArg3" name="companyCd"> 
	<input type="hidden" id="popArg4" name="companyNm"> 
</form>

<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="scrCompanyCd"> 
	<input type="hidden" id="excel2" name="scrOrgCd"> 
	<input type="hidden" id="excel3" name="scrStrCd"> 
	<input type="hidden" id="excel4" name="scrStrNm">
	<input type="hidden" id="excel5" name="scrUseYn">
	<input type="hidden" id="excel6" name="scrDateFrom">
	<input type="hidden" id="excel7" name="scrDateTo">
</form>

<div class="bleDiv">

	<!-- 조회조건 -->
	<div class="r_search multiLine">
			
		<table>
			<tr>
				<th>매장명</th>
				<td>
				 	<input type='search' id='scrStrNm' name='scrStrNm' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>매장코드</th>
				<td>
				 	<input type='search' id='scrStrCd' name='scrStrCd' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>착공일</th>
				<td>
				 	<input type='search' id='scrReadyDt' name='scrReadyDt' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>준공일</th>
				<td>
				 	<input type='search' id='scrStartDt' name='scrStartDt' value='' placeholder="전체" style="width:118px;" />
				</td>
			</tr>
			
			<tr>
				<th>전기체크</th>
				<td>
					<input type='search' id='scrElecCheck' name='scrElecCheck' value='' placeholder="전체" style="width:118px;" />
				</td>				
				<th>유지보수체크</th>
				<td>
					<input type='search' id='scrSensorCheck' name='scrSensorCheck' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>네트워크체크</th>
				<td>
					<input type='search' id='scrNetworkCheck' name='scrNetworkCheck' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>간판체크</th>
				<td>
					<input type='search' id='scrSignCheck' name='scrSignCheck' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>TnM체크</th>
				<td>
					<input type='search' id='checkSuccess' name='checkSuccess' value='' placeholder="전체" style="width:118px;" />
				</td>
			</tr>
			
			<tr>
				<th>전기업체명</th>
				<td>
					<input type='search' id='elecVendorNm' name='elecVendorNm' value='' placeholder="전체" style="width:118px;" />
				</td>				
				<th>유지보수업체명</th>
				<td>
					<input type='search' id='sensorVendorNm' name='sensorVendorNm' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>네트워크업체명</th>
				<td>
					<input type='search' id='networkVendorNm' name='networkVendorNm' value='' placeholder="전체" style="width:118px;" />
				</td>
				<th>간판업체명</th>
				<td>
					<input type='search' id='signVendorNm' name='signVendorNm' value='' placeholder="전체" style="width:118px;" />
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
			<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
			
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table class="gridPointer" id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
		
	</div>
	
	<!-- //그리드 영역 -->
		
	<!-- 하단 버튼 그룹 -->
	<!-- div class="r_pageBtnWrapper mr_0 ml0 border_none">
	 	<span class="pageNormal save">
	    	<button onclick="javascript:fncSave();">저장</button>
	   	</span>	
	   	<span class="pageNormal">
	    	<button onclick="javascript:fncCancle();">취소</button>
	   	</span>
	</div -->
	<!-- //하단 버튼 그룹 -->
	

</div>

</body>