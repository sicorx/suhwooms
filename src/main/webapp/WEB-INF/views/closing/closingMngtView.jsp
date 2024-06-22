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
var status = "";
var searchByBtn = true; //search 버튼을 통한 조회인지 / 수정작업을 위한 특정리스트 조회인지 판단.
/*******************
1. 선행, 등록 스크립트
********************/

$(window).resize(function(){



    $("#gridList").setGridWidth($("#cont").width());


}).resize();

$(document).ready(function(){
	// 달력
    $( "#searchFromDate, #searchToDate" ).datepicker({  
        dateFormat: 'yy-mm-dd',
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        changeMonth: true,
        changeYear: true,
        buttonText: "달력",
        showMonthAfterYear: true,       
        // 달력 아이콘  
        showOn: "button",  
        buttonImage: "/images/btn_calendar_new.png",  
        buttonImageOnly: true,  
        // 달력 하단의 종료와 오늘 버튼 Show  
        showButtonPanel: true,  
        // date 포멧  
        showAnim : "",  
        // 다른 달의 일 보이기, 클릭 가능  
        numberOfMonths: 1,  
        showButtonPanel: true,          
    });
	
	//설치일자 두달전~ 오늘까지로 기본 셋팅
    $( "#searchFromDate" ).datepicker( "setDate",  func_makeDate(2) );      
    $( "#searchToDate" ).datepicker( "setDate", func_toDate() );
    
	$("#gridList").jqGrid({
	      url:'retrieveClosingList',
	      datatype: "json",
	      postData : {
	    	   searchVal : $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, ""),
	    	   searchFromDate : $("#searchFromDate").val().replace(/-/gi, ""),
	    	   searchToDate : $("#searchToDate").val().replace(/-/gi, ""),
	    	   vendorCd : $("#vendorCd").val(),
	    	   vendorClosingYn : $("#vendorClosingYn").val(),
	    	   closingYn : $("#closingYn").val(),
	    	   closingDate : $("#closingDate").val().replace(/-/gi, ""),
	    	   prtYn : $("#prtYn").val()
		  },
	      mtype: 'POST',
	      colNames:[
	    	    '',
	    	    'No',
	    	    '점포코드',
	    	    '점포명',
	    	    '설치일자',
	    	    '마감월',
	    	    '마감월(서버)',
	    	    '벤더구분',
	    	    '게이트웨이',
	    	    'TEMON',
	    	    'HACON',
	    	    'T-SENSOR',
	    	    '온도센서',
	    	    '미터기',
	    	    'CT',
	    	    'EMS BOX',
	    	    '설치작업',
	    	    '벤더마감여부',
	    	    '벤더마감자',
	    	    '벤더마감일자',
	    	    '마감여부',
	    	    '마감확정자',
	    	    '마감확정일자',
	    	    '견적서 발행여부'],
	      colModel:[
			    	  {name:'checkbox',             index:'checkbox',               width : 50,     align:'center', sortable:false, editable:true, hidden:true, edittype:'checkbox', formatter:cbxFormatter},
			    	  {name:'records',              index:'records',                width : 50,     align:'center', sortable:false, editable:false},
			    	  {name:'strCd',                index:'strCd',                  width : 70,     align:'center', sortable:true,  editable:false, formatter: strFormatter},
			    	  {name:'strNm',                index:'strNm',                  width : "100%", align:'left', sortable:true,  editable:false, formatter: strFormatter},
			    	  {name:'remsStartDt',          index:'remsStartDt',            width : 70,     align:'center', sortable:false, editable:false, formatter: dateFormatter},
			    	  {name:'closingYm',            index:'select',                 width : 100,    align:'center', sortable:false, editable:false, edittype:'select', formatter: selectFormatter},
			    	  {name:'closingYm',            index:'closingYm',              hidden : true},
			    	  {name:'remsDeivceVendor',     index:'remsDeivceVendor',       width : 70,     align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'cntGw',                index:'cntGw',                  width : 70,     align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'cntTemon',             index:'cntTemon',               width : 70,     align:'center', sortable:false, editable:false, editoptions : {dataInit: fncInputCheckNum}},
			    	  {name:'cntHacon',             index:'cntHacon',               width : 70,     align:'center', sortable:false, editable:false, editoptions : {dataInit: fncInputCheckNum}},
			    	  {name:'cntTsensor',           index:'cntTsensor',             width : 70,     align:'center', sortable:false, editable:false, editoptions : {dataInit: fncInputCheckNum}},
			    	  {name:'cntLine',              index:'cntLine',                width : 70,     align:'center', sortable:false, editable:false, editoptions : {dataInit: fncInputCheckNum}},
			    	  {name:'cntMeter',             index:'cntMeter',               width : 70,     align:'center', sortable:false, editable:false, editoptions : {dataInit: fncInputCheckNum}},
			    	  {name:'cntCt',                index:'cntCt',                  width : 70,     align:'center', sortable:false, editable:false, editoptions : {dataInit: fncInputCheckNum}},
			    	  {name:'cntBox',               index:'cntBox',                 width : 70,     align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'cntFe_before',         index:'cntFe_before',           width : 70,     align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'vendorClosingYn',      index:'vendorClosingYn',        width : 100,    align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'vendorClosingUserId',  index:'vendorClosingUserId',    width : 70,     align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'vendorClosingDttm',    index:'vendorClosingDttm',      width : 100,    align:'center', sortable:false, editable:false, formatter: dateFormatter},
			    	  {name:'managerClosingYn',     index:'managerClosingYn',       width : 70,     align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'managerClosingUserId', index:'managerClosingUserId',   width : 100,    align:'center', sortable:false, editable:false, formatter: strFormatter},
			    	  {name:'managerClosingDttm',   index:'managerClosingDttm',     width : 100,    align:'center', sortable:false, editable:false, formatter: dateFormatter},
			    	  {name:'prtYn',                index:'prtYn',                  width : 100,    align:'center', sortable:false, editable:false, formatter: strFormatter}
		    	    ],
	     jsonReader : {
	          repeatitems:false
	     },
	     loadComplete : function(){
             if(searchByBtn) {
                 fncBtnReset();
             } else {
            	 if(status == "modifyNumber"){
            		 
            		 $("#gridList").jqGrid('setColProp', 'cntTemon', {editable:true});
                     $("#gridList").jqGrid('setColProp', 'cntHacon', {editable:true});
                     $("#gridList").jqGrid('setColProp', 'cntTsensor', {editable:true});
                     $("#gridList").jqGrid('setColProp', 'cntLine', {editable:true});
                     $("#gridList").jqGrid('setColProp', 'cntMeter', {editable:true});
                     $("#gridList").jqGrid('setColProp', 'cntCt', {editable:true});
                     
	           	    var ids = $("#gridList").jqGrid('getDataIDs');
	           	    
	           	    for(var i = 0; i < ids.length; i++) {
	           	        $("#gridList").jqGrid("editRow", ids[i]);
	           	    }
	           	    
            	 }
             }
         },
	     rowNum:10,
	     rowList:[10,20,30],
	     pager: '#gridListPager',
	     recordtext: "건/페이지  (전체 {2} 건)",
		 emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'strNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: true,
	     shrinkToFit:false,
		 autowidth:true,
		 height : 260,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 var list = $("#gridList").getRowData(rowid);
			 if(status == "fixVendor" || status == "fixClosing") {
				 var isChecked = $("input[name='rowCheckbox']")[rowid-1].checked;
				 if(isChecked) {
					 $("input[name='rowCheckbox']")[rowid-1].checked = false;
				 } else {
					 $("input[name='rowCheckbox']")[rowid-1].checked = true;
				 }
				 // $('#gridList').jqGrid('editRow', rowid);
			 }
		 }
    });
	 
	$(window).on("beforeunload", function() {
		if(status == "modifyNumber" || status == "fixVendor" || status == "fixClosing") {
			return "현재까지의 수정사항이 모두 사라집니다. 계속 진행하시겠습니까?";
		}
	});
	
	//jqGrid Resize	
	jqGridResize('gridList');
	  
	// 엔터 키 이벤트
	$("input[name='scrVendorNm']").keydown(function (key) {
		if (key.keyCode == 13) {
			fncSearch();
        }
    });
	
});

//search 버튼 이벤트
function fncSearch() {
	if(status == "modifyNumber" || status == "fixVendor" || status == "fixClosing") {
		if(!confirm("현재까지의 수정사항이 모두 사라집니다. 계속 진행하시겠습니까?")) {
			return;
		}
	}
	searchByBtn = true;
	
	$("#gridList").setGridParam({"page":1});       // 1페이지로 이동	$("#gridList").setGridParam({
        postData : {
        	searchVal : $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, ""),
            searchFromDate : $("#searchFromDate").val().replace(/-/gi, ""),
            searchToDate : $("#searchToDate").val().replace(/-/gi, ""),
            vendorCd : $("#vendorCd").val(),
            vendorClosingYn : $("#vendorClosingYn").val(),
            closingYn : $("#closingYn").val(),
            closingDate : $("#closingDate").val().replace(/-/gi, ""),
            prtYn : $("#prtYn").val()
        }
    }).trigger("reloadGrid");

}

//Grid string formatter
function strFormatter(cellValue, options, rowObject) {
	var str = "";
    if(cellValue == null || cellValue == "") {
        str = "-";
    } else {
    	str = cellValue
    }
    return str;
}

//Grid date formatter
function dateFormatter(cellValue, options, rowObject) {
	var date = "";
	if(cellValue != null && cellValue != "") {
		date = cellValue.substr(0,4) + "-" + cellValue.substr(4,2) + "-" + cellValue.substr(6,2);
	} else {
		date = "-";
	}
	return date;
}

//Grid checkbox formatter
function cbxFormatter() {
	return "<input type='checkbox' name='rowCheckbox' />";
}

//Grid select formatter
function selectFormatter(cellValue, options, rowObject) {
	var select = '';
	
	var existYn = 'N';
	
	select += '<select name="dMonth">';
	select += '<c:if test="${gridComboList != null}">';     
	select += '    <c:forEach var="vo" items="${gridComboList}" varStatus="status" >';
	if(cellValue == '${vo.value}') {
		select += '        <option value=\'${vo.value}\' selected>${vo.name}</option>';
		existYn = 'Y';
	}else{
		select += '        <option value=\'${vo.value}\'>${vo.name}</option>';	
	}
	select += '    </c:forEach>';
	select += '</c:if>';
	
	if( existYn == 'N' ){
		if(cellValue != null || cellValue != '' ){
			var yyyy= cellValue.substring(0, 4 );
			var mm = cellValue.substring(4, 6 );
			var yyyymm = yyyy +'-'+ mm;
			select += '        <option value=\''+ cellValue +'\' selected index=1>'+ yyyymm +'</option>';
		}	
	}
	
	select += '</select>';
	
	return select;
}

//월기간 조회 버튼
function func_monthBtn(value)
{
    // Default Date Setting
    var DateFrom = func_makeDate(value);
    var DateTo = func_toDate();
    
    $( "#searchFromDate" ).datepicker( "setDate",  DateFrom );
    $( "#searchToDate" ).datepicker( "setDate", DateTo );
}

//현재 시간
function func_toDate()
{
    var YYYY, MM, DD;       
    var d = new Date(); 
    
    YYYY = d.getFullYear();     
    
    //한자릿수 월 앞에 0을 붙이기 위한 if문
    if(d.getMonth() < 9)            
        MM = '0'+(d.getMonth()+1);
    else
        MM = d.getMonth()+1;        
 
    if(d.getDate() < 9)
        DD = '0'+(d.getDate());
    else
        DD = d.getDate();       
    
    return YYYY+"-"+ MM +"-"+ DD;
}

//하루전, 한달전, 계산 (month:개월수)
function func_makeDate(month)
{        
    var YYYY, MM, DD;
    var date = new Date();
    var d = new Date(date.getFullYear(), date.getMonth() - month, date.getDate());    
    
    YYYY = d.getFullYear();     
    
    //한자릿수 월 앞에 0을 붙이기 위한 if문
    if(d.getMonth() < 9)            
        MM = '0'+(d.getMonth()+1);
    else
        MM = d.getMonth()+1;        
 
    if(d.getDate() < 9)
        DD = '0'+(d.getDate());
    else
        DD = d.getDate();       
    
    return YYYY+"-"+ MM +"-"+ DD;
}


//숫자입력 체크
function fncInputCheckNum(element) {
	 $(element).keyup(function(){
        var val = element.value;
        var num = new Number(val);
        if(isNaN(num)){
         alert("숫자만 입력해 주세요.");
         element.value = '';
        } else if(num < 0) {
        	alert("0 이상의 숫자로 입력해 주세요.");
            element.value = '';
        } else {
        	element.value = num;
        }
       });
}

//마감월변경
function fncModifyClosingMon() {
	//마감여부 N 으로 조회하여 수정 시작
    searchByBtn = false; //조회버튼을 통한 조회 아님
    status = "modifyClosingMon";
	$("#closingYn").val("N");
	$("#gridList").setGridParam({
        postData : {
            searchVal : $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, ""),
            searchFromDate : $("#searchFromDate").val().replace(/-/gi, ""),
            searchToDate : $("#searchToDate").val().replace(/-/gi, ""),
            vendorCd : $("#vendorCd").val(),
            vendorClosingYn : $("#vendorClosingYn").val(),
            closingYn : $("#closingYn").val(),
            closingDate : $("#closingDate").val().replace(/-/gi, ""),
            prtYn : $("#prtYn").val()
        }
    }).trigger("reloadGrid");
	
	$("#fixClosing").attr("disabled", true);
    $("#fixVendor").attr("disabled", true);
    $("#modifyNumber").attr("disabled", true);
    $("#modifyClosingMon").attr("disabled", true);
    $("#save").attr("disabled", false);
    $("#cancel").attr("disabled", false);
}

//수량변경
function fncModifyNumber() {
	if($("#vendorCd").val() == "") {
		alert("벤더구분을 선택하세요.")
		return;
	}
	
	//벤더구분이 선택되어있다면 벤더마감여부 N, 마감여부 N 으로 조회하여 수정 시작
	searchByBtn = false; //조회버튼을 통한 조회 아님
	status = "modifyNumber";
	$("#vendorClosingYn").val("N");
	$("#closingYn").val("N");
    $("#gridList").setGridParam({
        postData : {
            searchVal : $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, ""),
            searchFromDate : $("#searchFromDate").val().replace(/-/gi, ""),
            searchToDate : $("#searchToDate").val().replace(/-/gi, ""),
            vendorCd : $("#vendorCd").val(),
            vendorClosingYn : $("#vendorClosingYn").val(),
            closingYn : $("#closingYn").val(),
            closingDate : $("#closingDate").val().replace(/-/gi, ""),
            prtYn : $("#prtYn").val()
        }
    }).trigger("reloadGrid");
    
	$("#fixClosing").attr("disabled", true);
	$("#fixVendor").attr("disabled", true);
	$("#modifyNumber").attr("disabled", true);
	$("#modifyClosingMon").attr("disabled", true);
	$("#save").attr("disabled", false);
    $("#cancel").attr("disabled", false);
}

//벤더확정
function fncFixVendor() {
	if($("#vendorCd").val() == "" ) {
        alert("벤더구분을 선택하세요.")
        return;
    }
	
	//벤더구분이 선택되어있다면 벤더마감여부 N, 마감여부 N 으로 조회하여 수정 시작
	status = "fixVendor"
	searchByBtn = false; //조회버튼을 통한 조회 아님
    $("#vendorClosingYn").val("N");
    $("#closingYn").val("N");
    $("#gridList").setGridParam({
        postData : {
            searchVal : $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, ""),
            searchFromDate : $("#searchFromDate").val().replace(/-/gi, ""),
            searchToDate : $("#searchToDate").val().replace(/-/gi, ""),
            vendorCd : $("#vendorCd").val(),
            vendorClosingYn : $("#vendorClosingYn").val(),
            closingYn : $("#closingYn").val(),
            closingDate : $("#closingDate").val().replace(/-/gi, ""),
            prtYn : $("#prtYn").val()
        }
    }).trigger("reloadGrid");
	
	$("#fixClosing").attr("disabled", true);
    $("#fixVendor").attr("disabled", true);
    $("#modifyNumber").attr("disabled", true);
    $("#modifyClosingMon").attr("disabled", true);
    $("#save").attr("disabled", false);
    $("#cancel").attr("disabled", false);
    
    $("#gridList").showCol("checkbox");
    
    $("#allCheckBox").show();
}

//마감확정
function fncFixClosing() {
    //벤더마감여부 Y, 마감여부 N으로 조회하여 수정시작
    status = "fixClosing"
    searchByBtn = false; //조회버튼을 통한 조회 아님
    $("#vendorClosingYn").val("Y");
    $("#closingYn").val("N");
    $("#gridList").setGridParam({
        postData : {
            searchVal : $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, ""),
            searchFromDate : $("#searchFromDate").val().replace(/-/gi, ""),
            searchToDate : $("#searchToDate").val().replace(/-/gi, ""),
            vendorCd : $("#vendorCd").val(),
            vendorClosingYn : $("#vendorClosingYn").val(),
            closingYn : $("#closingYn").val(),
            closingDate : $("#closingDate").val().replace(/-/gi, ""),
            prtYn : $("#prtYn").val()
        }
    }).trigger("reloadGrid");
	    
    $("#fixClosing").attr("disabled", true);
    $("#fixVendor").attr("disabled", true);
    $("#modifyNumber").attr("disabled", true);
    $("#modifyClosingMon").attr("disabled", true);
    $("#save").attr("disabled", false);
    $("#cancel").attr("disabled", false);
    
    $("#gridList").showCol("checkbox");
    
    $("#allCheckBox").show();
    
}

//수량변경 저장
function fncSaveModifyNumber() {
	var paramList = new Array();
    var ids = $("#gridList").jqGrid('getDataIDs');
    var sel = document.getElementsByName("dMonth");
    for(var i = 1; i <= ids.length; i++){
        $("#gridList").jqGrid("saveRow", (i));
        var param = {"strCd" : "", "closingYm" : "", "itemInfo" : ""};
        var itemInfo = new Array();
        itemInfo.push("TM_" + $("#gridList").getRowData(i).cntTemon);
        itemInfo.push("HA_" + $("#gridList").getRowData(i).cntHacon);
        itemInfo.push("TS_" + $("#gridList").getRowData(i).cntTsensor);
        itemInfo.push("LS_" + $("#gridList").getRowData(i).cntLine);
        itemInfo.push("DM_" + $("#gridList").getRowData(i).cntMeter);
        itemInfo.push("CT_" + $("#gridList").getRowData(i).cntCt);
        
        var strCd = $("#gridList").getRowData(i).strCd;
        param.strCd = strCd.replace("-", "");
        param.closingYm = sel[i-1].value;
        param.itemInfo = itemInfo;

        paramList.push(param);
    }

    $.ajax({
        url:'/saveModifyNumber',
        type:'POST',
        cache:false,
        data: {paramList : JSON.stringify(paramList)},
        dataType:'json',
        success:function(data){
            if(data){
                alert('저장되었습니다.');
                status = "save";
                fncSearch();
            } else {
                alert('저장에 실패하였습니다.');
                status = "save";
                fncSearch();
            }
        },
        error:function(result){
            alert("에러가 발생했습니다.");
            status = "save";
            fncSearch();
        }
    });
}

//마감월변경 저장
function fncUpdateModifyClosingMon() {
	var paramList = new Array();
    var ids = $("#gridList").jqGrid('getDataIDs');
    var sel = document.getElementsByName("dMonth");
	
	for(var i = 1; i <= ids.length; i++){
		var param = {
		        "strCd" : "",
		        "closingYm_new" : ""
	    };
        
        var strCd = $("#gridList").getRowData(i).strCd;
        param.strCd = strCd.replace("-", "");
        var closingYm = sel[i-1].value;
        if( closingYm == '' ){
        	alert("마감년월을 입력하지 않았습니다.");
        	$("#gridList").jqGrid("setSelection", i);
        	return false;
        }
        
        param.closingYm_new = closingYm;
        
        param.closingYm_old = $("#gridList").getRowData(i).closingYm;

        paramList.push(param);
    }
	
	$.ajax({
        url:'/updateModifyClosingMon',
        type:'POST',
        cache:false,
        data: {paramList : JSON.stringify(paramList)},
        dataType:'json',
        success:function(data){
            if(data){
                alert('저장되었습니다.');
                status = "save";
                fncSearch();
            } else {
                alert('저장에 실패하였습니다.');
                status = "save";
                fncSearch();
            }
        },
        error:function(result){
        	status = "save";
            fncSearch();
            alert("에러가 발생했습니다.");
        }
    });
}

//벤더확정 저장
function fncUpdateFixVendor() {
	var paramList = new Array();
    var ids = $("#gridList").jqGrid('getDataIDs');
    var sel = document.getElementsByName("dMonth");
    
    for(var i = 0; i < ids.length; i++){
        var param = {
                "strCd" : "",
                "closingYm" : ""
        };
        var isChecked = $("input[name='rowCheckbox']")[i].checked;
        
        if(isChecked) {
	        var strCd = $("#gridList").getRowData(i+1).strCd;
	        param.strCd = strCd.replace("-", "");
	        param.closingYm = sel[i].value;
	        paramList.push(param);
        }
        
    }
    
    if(paramList.length < 1) {
	  	alert("선택된 정보가 없습니다.")
	  	return;
    }
	
	$.ajax({
        url:'/updateFixVendor',
        type:'POST',
        cache:false,
        data: {paramList : JSON.stringify(paramList)},
        dataType:'json',
        success:function(data){
            if(data){
                alert('저장되었습니다.');
                status = "save";
                fncSearch();
            } else {
                alert('저장에 실패하였습니다.');
                status = "save";
                fncSearch();
            }
        },
        error:function(result){
            alert("에러가 발생했습니다.");
            status = "save";
            fncSearch();
        }
    });
}

//마감확정 저장
function fncUpdateFixClosing() {
    var paramList = new Array();
    var ids = $("#gridList").jqGrid('getDataIDs');
    var sel = document.getElementsByName("dMonth");
    
    for(var i = 0; i < ids.length; i++){
        var param = {
                "strCd" : "",
                "closingYm" : ""
        };
        var isChecked = $("input[name='rowCheckbox']")[i].checked;
        
        if(isChecked) {
            var strCd = $("#gridList").getRowData(i+1).strCd;
            param.strCd = strCd.replace("-", "");
            param.closingYm = sel[i].value;
            paramList.push(param);
        }
        
    }
    
    if(paramList.length < 1) {
        alert("선택된 정보가 없습니다.")
        return;
    }
    
	$.ajax({
        url:'/updateFixClosing',
        type:'POST',
        cache:false,
        data: {paramList : JSON.stringify(paramList)},
        dataType:'json',
        success:function(data){
            if(data){
                alert('저장되었습니다.');
                status = "save";
                fncSearch();
            } else {
                alert('저장에 실패하였습니다.');
                status = "save";
                fncSearch();
            }
        },
        error:function(result){
            alert("에러가 발생했습니다.");
            status = "save";
            fncSearch();
        }
    });
}


//저장버튼
function fncSave() {
	if (confirm("저장하시겠습니까?")) {
		if(status == "modifyNumber") {
	        //수량변경 저장
	        fncSaveModifyNumber();
	    } else if(status == "modifyClosingMon") {
	        //마감월변경 저장
	        fncUpdateModifyClosingMon();
	    } else if(status == "fixVendor") {
	        //벤더확정 저장
	        fncUpdateFixVendor();
	    } else if(status == "fixClosing") {
	        //마감확정 저장
	        fncUpdateFixClosing();
	    }
	}
}

//취소버튼
function fncCancel() {
	if(confirm("취소하시겠습니까?")) {
		
		$("#allCheckBox").hide();
		
		var ids = $("#gridList").jqGrid('getDataIDs');
	    for(var i = 0; i < ids.length; i++) {
	           $("#gridList").jqGrid("restoreRow", ids[i+1]);
	    }
	    
	    if(status == "modifyNumber"){
	    	fncSearch();
   	 	}
		fncBtnReset();
	} 
}

//버튼 초기화
function fncBtnReset() {
	status = "";
	$("#gridList").hideCol("checkbox");
	$("#fixClosing").attr("disabled", false);
    $("#fixVendor").attr("disabled", false);
    $("#modifyNumber").attr("disabled", false);
    $("#modifyClosingMon").attr("disabled", false);
    $("#save").attr("disabled", true);
    $("#cancel").attr("disabled", true);
}

//전체체크박스
function fncCheckboxAll() {
	var chkList = $("input[name='rowCheckbox']");
	if($("#allCheck").is(":checked")) {
		for(var i = 0; i < chkList.length; i++) {
			chkList[i].checked = true;
		}
	} else {
		for(var i = 0; i < chkList.length; i++) {
            chkList[i].checked = false;
        }
	}
};




function fn_excelDownload(){
	
	if( !confirm("엑셀 다운로드 하시겠습니까?") ){
		return false;
	}
	   
	var searchVal = $("#searchVal").val().replace(/(^\s*)|(\s*$)/gi, "");
	var searchFromDate = $("#searchFromDate").val();
	var searchToDate = $("#searchToDate").val();
	var vendorCd = $("#vendorCd").val();	
	var vendorClosingYn = $("#vendorClosingYn").val();	
	var closingYn = $("#closingYn").val();	
	var closingDate = $("#closingDate").val().replace(/-/gi, "");	
	var prtYn = $("#prtYn").val();	
		
	$("#excel1").val(searchVal);
	$("#excel2").val(searchFromDate);
	$("#excel3").val(searchToDate);
	$("#excel4").val(vendorCd);	
	$("#excel5").val(vendorClosingYn);	
	$("#excel6").val(closingYn);	
	$("#excel7").val(closingDate);	
	$("#excel8").val(prtYn);	
	
	$('#excelDownload').attr("action", "/downloadClosingMngtExcel");
	$("#excelDownload").submit();

}
</script>

<div id="loadingArea">
<form id="excelDownload" name='excelDownload' method='post'>
	<input type="hidden" id="excel1" name="searchVal"> 
	<input type="hidden" id="excel2" name="searchFromDate"> 
	<input type="hidden" id="excel3" name="searchToDate"> 
	<input type="hidden" id="excel4" name="vendorCd">
	<input type="hidden" id="excel5" name="vendorClosingYn">
	<input type="hidden" id="excel6" name="closingYn" >
	<input type="hidden" id="excel7" name="closingDate" >
	<input type="hidden" id="excel8" name="prtYn" >
</form>
	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<table>
			<tr>
			    <th>매장명/코드</th>
                <td>
                    <input type="search" id="searchVal" name="searchVal" value="" placeholder="전체"  style="width:118px;" />
                </td>
				<th>설치일자</th>
				<td colspan="7">
					<input id="searchFromDate" name="searchFromDate" type="text" placeholder="javascript:func_toDate();" style="width:80px;" readonly />
					~ <input id="searchToDate" name="searchToDate" type="text" placeholder="javascript:func_toDate();" style="width:80px;" readonly />
			   		<button onclick="javascript:func_monthBtn(1);">1m</button>
			   		<button onclick="javascript:func_monthBtn(6);">6m</button>
			   		<button onclick="javascript:func_monthBtn(12);">1y</button>
				</td>
				
			</tr>
			<tr>
			 <th>벤더구분</th>
                <td>
                    <select id="vendorCd" name="vendorCd" class="searchSelect" style="width:80px;">
                        <option selected="selected" value="">전체</option>
                        <option value="TNM">TNM</option>
                        <option value="DIT">DIT</option>
                    </select>
                </td>
                <th>벤더마감여부</th>
                <td>
                    <select id="vendorClosingYn" name="vendorClosingYn" class="searchSelect" style="width:80px;">
                        <option value="">전체</option>
                        <option value="Y">Y</option>
                        <option value="N" selected="selected">N</option>
                    </select>
                </td>
				<th>마감여부</th>
				<td>
					<select id="closingYn" name="closingYn" class="searchSelect" style="width:80px;">
						<option value="">전체</option>
						<option value="Y">Y</option>
						<option value="N" selected="selected">N</option>
					</select>
				</td>
				<th>마감년월</th>
				<td>
					<c:if test="${searchComboList != null}">         
			            <select id="closingDate" name="closingDate" class="searchSelect">
		                    <c:forEach var="vo" items="${searchComboList}" varStatus="status" >
		                        <option value='${vo.value}'>${vo.name}</option>
		                    </c:forEach>
			            </select>
			        </c:if>
				</td>
				<th>발행여부</th>
				<td>
					<select id="prtYn" name="prtYn" class="searchSelect" style="width:80px;">
                        <option selected="selected" value="">전체</option>
                        <option value="Y">Y</option>
                        <option value="N">N</option>
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
		<div class="r_gridTitle relative">
			<h3 id="allCheckBox" class="bg_none absolute" style="top:5px; left:9px; display:none;">
				<input type="checkbox" id="allCheck" name="allCheck" onclick="javascript:fncCheckboxAll();" />
				<label for="allCheck">전체선택</label>
			</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
			<!-- 엑셀 download -->
			<div style="text-align:right">
				<!-- <img src="/images/upload_excel.png" onclick="javascript:fn_excelUpoad();" /> -->
				<img src="/images/download_excel.png" onclick="javascript:fn_excelDownload();" />
			</div>
			<!-- //엑셀 download -->
			
		</div>
		<table id="gridList"><tr><td></td></tr></table>
		<div id="gridListPager"></div>
	</div>
	<!-- //그리드 영역 -->
	
	<!-- 하단 버튼 그룹 -->
    <div class="r_pageBtnWrapper mr_0 ml0 border_none">
        <span class="pageNormal">
	       <button id="cancel" onclick="javascript:fncCancel();">취소</button>
		</span>
		<span class="pageNormal">
		    <button id="save" onclick="javascript:fncSave();">저장</button>
		</span>
		<span class="pageNormal">
		    <button id="fixClosing" onclick="javascript:fncFixClosing();">마감확정</button>
		</span>
		<span class="pageNormal">
		    <button id="fixVendor" onclick="javascript:fncFixVendor();">벤더확정</button>
		</span>
		<span class="pageNormal">
		    <button id="modifyNumber" onclick="javascript:fncModifyNumber();">수량변경</button>
		</span>
		<span class="pageNormal">
            <button id="modifyClosingMon" onclick="javascript:fncModifyClosingMon();">마감월변경</button>
        </span>
    </div>
    <!-- //하단 버튼 그룹 -->

</div>