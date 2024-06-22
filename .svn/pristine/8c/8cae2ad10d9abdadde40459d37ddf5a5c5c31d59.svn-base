<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var rowIdx = 0;

/*******************
1. 선행, 등록 스크립트
********************/

var excelData;

$(document).ready(function(){
	
	
	// Excel 파일 업로드 ////////////////////////////////////////////////////
	
	gridExcelDataList();			// 빈 grid 표시 
	
	$('#excelForm').ajaxForm({
		type : "POST",
		cache : false,
		async: false,
		url: "/excelRead",
		dataType : "json",
		beforeSend: function()
		{
			
		},
		success: function(result) {
			//alert( result );
			//alert( JSON.stringify(result));			
			excelData = result;
			console.log( result );
			
			$("#gridInputExcelList").clearGridData();		// 데이터 초기화
			
			$("#gridInputExcelList").jqGrid('setGridParam', { data: result});
			$("#gridInputExcelList").trigger('reloadGrid');
			
			$('#inputDbBtn').show();
			
			
			
		},
        error: function(result) {
        	alert('잘못된 파일 or 형식이 잘못되었습니다.');
        }
		
	});
	/////////////////////////////////////////////////////////////////////
	
	
});


function inputDB()
{
	//alert('DB 적용');
	
	var yesno = confirm('데이터베이스에 적용합니까 ? ');
	
	if( yesno == false )
		return;
	var fileValue = $("#file").val().split("\\");
	var fileName = fileValue[fileValue.length-1]; // 파일명

	//alert( fileName );
	
	$.ajax({
		url:'/excelInput',
		type:'POST',
		cache:false,
		data : {fileName:fileName},
		dataType:'json',
		success:function(result){
			excelData = result;
			
			$("#gridInputExcelList").jqGrid('setGridParam', { data: result});
			$("#gridInputExcelList").trigger('reloadGrid'); 
			
		},
        error: function(result) {
        	alert('잘못된 파일 or 형식이 잘못되었습니다.');
        }		
	});
	
	
}

function gridExcelDataList(  )
{
	$("#gridInputExcelList").jqGrid({
		datatype:'local',
		//data: excelData,
		colNames:[	'매장코드','매장명', '점포코드', '주소', '계약전력', 
		          	'M', 'T', 'Ha', 'Ts', 'Te', 'In', 'Si', 
		          	'성공',
		          	'strInfoDB', 'gwInfoDB', 'remsPartCntDB', 'strConfDB', 'temonInfoDB', 'invInfoDB'      ],
		colModel:[
			{name:'strCd',index:'strCd', 							align:'center'},
			{name:'strNm',index:'strNm', 							align:'center'},
			{name:'viewStrCd',index:'viewStrCd',	 				align:'center'},
			{name:'addr',index:'addr',	 							width:200, align:'center'},
			{name:'contDemandPower',index:'contDemandPower',	 	align:'center'},			
			
			{name:'mainMeter',index:'mainMeter',	 				width:40, align:'center'},
			{name:'subMeterTemp',index:'subMeterTemp',	 			width:40, align:'center'},
			{name:'hacon',index:'hacon',	 						width:40, align:'center'},
			{name:'tSensor',index:'tSensor',	 					width:40, align:'center'},
			{name:'temon',index:'temon',	 						width:40, align:'center'},			
			{name:'inv',index:'inv',	 							width:40, align:'center'},
			{name:'sign',index:'sign',	 							width:40, align:'center'},
			
			{name:'allDataDB',index:'allDataDB',	 				align:'center'},
			
			{name:'strInfoDB',index:'strInfoDB',	 				width:20, align:'center', hidden:'true'},
			{name:'gwInfoDB',index:'gwInfoDB',	 					width:20, align:'center', hidden:'true'},
			{name:'remsPartCntDB',index:'remsPartCntDB',	 		width:20, align:'center', hidden:'true'},
			{name:'strConfDB',index:'strConfDB',	 				width:20, align:'center', hidden:'true'},
			{name:'temonInfoDB',index:'temonInfoDB',	 			width:20, align:'center', hidden:'true'},
			{name:'invInfoDB',index:'invInfoDB',	 				width:20, align:'center', hidden:'true'}
			
		],
		jsonReader : {
		     repeatitems:false
		},
		formatter : {
	  		number : {
				decimalSeparator: ".",
				thousandsSeparator: ",", 
				decimalPlaces: 1,
				defaultValue: '0'
			}
		},
		rowNum:15,
		rowList:[],
		rownumbers: true,
		autowidth: true,
		//width: 1000,		
		height: '500',
		pager: '#gridInputExcelListPager',
		//sortname: 'strNm',
		sortorder: "desc",
	    viewrecords: true,			    
		hidegrid: false,
		shrinkToFit:true
	});
	
	
	
}

function chboxFormatter(cellvalue, options, rowObject){
	return '<input type="checkbox" name="choice" id="choice_'+options.rowId+'" '+(cellvalue == 'Y' ? 'checked="checked"':'') + 'onclick="onCheckboxClick('+options.rowId+')"/>';
}

function onCheckboxClick(rowId){	

	rowIdx = rowId; 
	$('input:checkbox[name="choice"]').each(function(i){
		if(this.id == 'choice_'+rowId && !this.checked){
			this.checked = false;
		}else if(this.id == 'choice_'+rowId && this.checked){
			this.checked = true;
		}else{
			this.checked = false;
		}
	});		
}

function onCheckboxDbClick(rowId){	
	
	rowIdx = rowId; 
	$('input:checkbox[name="choice"]').each(function(i){
		if(this.id == 'choice_'+rowId){
			this.checked = true;		
		}else{
			this.checked = false;
		}
	});
}



function checkFile()
{
	var fileValue = $("#file").val().split("\\");
	var fileName = fileValue[fileValue.length-1]; // 파일명

	if( fileName.substr(0,5) == "input" )
	{
		$('#upLoadBtn').show();
	}
	else
	{
		alert('잘못된 파일형식 입니다.');	
		$('#upLoadBtn').hide();
		$('#dbInsertBtn').hide();
	}
	
	
	//alert( $('#file').val() );
}

</script>

<form id='popupForm' name='popupForm' method='post'>
	<input type="hidden" id="popArg1" name="strCd">
	<input type="hidden" id="popArg2" name="strNm">
	<input type="hidden" id="popArg3" name="viewStrCd">
	<input type="hidden" id="popArg4" name="companyCd">
	<input type="hidden" id="popArg5" name="companyNm">
</form>
<div id="loadingArea">
	<div class="r_popup">
		<div class="r_popupCont">
			
			<div class='r_grid'>
				<table id="gridInputExcelList"><tr><td></td></tr></table>
				<div id="gridInputExcelListPager"></div>
			</div>
		</div>
		<div class="r_pageBtnWrapper">	
			<form id="excelForm" name="excelForm" enctype="multipart/form-data" method="post" >
				<span class="pageNormal">
					<input type="file" id="file" name="excelFile" onchange="javascript:checkFile();" style="width:500px; font-size:13px; height:33px; min-width:400px; font-weight:bold; text-align:center; vertical-align:middle; padding:0 15px;" />
				</span>
				<span class="pageNormal">
					<input type="submit" id="upLoadBtn" name="upLoad" 	value="읽어오기" style="display:none;"/>
				</span>
			</form>
		
		
			<span class="pageNormal">
				<button id="inputDbBtn"  onClick="javascript:inputDB()" style="display:none;">적 용</button>
			</span>	
				
		</div>
	</div>
	
</div>	

		