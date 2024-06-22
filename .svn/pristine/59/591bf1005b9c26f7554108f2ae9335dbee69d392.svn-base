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
<c:set var="smClos"><spring:message code="clos"/></c:set>
<c:set var="smNew"><spring:message code="new"/></c:set>
<c:set var="smUpdate"><spring:message code="update"/></c:set>
<c:set var="smDelete"><spring:message code="delete"/></c:set>
<c:set var="smSave"><spring:message code="save"/></c:set>
<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smPartSrch"><spring:message code="partSrch"/></c:set>
<c:set var="smPartIdSrch"><spring:message code="partIdSrch"/></c:set>
<c:set var="smPartQtySrch"><spring:message code="partQtySrch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smAlmon"><spring:message code="almon"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>
<c:set var="smDevice"><spring:message code="device"/></c:set>
<c:set var="smPortNo"><spring:message code="portNo"/></c:set>
<c:set var="smContents"><spring:message code="contents"/></c:set>
<c:set var="smUpperLimit"><spring:message code="upperLimit"/></c:set>
<c:set var="smLowerLimit"><spring:message code="lowerLimit"/></c:set>
<c:set var="smDetDelay"><spring:message code="detDelay"/></c:set>
<c:set var="smTempComp"><spring:message code="tempComp"/></c:set>
<c:set var="smUseYn"><spring:message code="useYn"/></c:set>
<c:set var="smMinute"><spring:message code="minute"/></c:set>
<c:set var="smPeriod"><spring:message code="period"/></c:set>
<c:set var="smDevDePortInfoInUpt"><spring:message code="devDePortInfoInUpt"/></c:set>
<c:set var="smDevQtyIns"><spring:message code="devQtyIns"/></c:set>
<c:set var="smStrFcltyInsUpt"><spring:message code="strFcltyInsUpt"/></c:set>
<c:set var="smInqry"><spring:message code="inqry"/></c:set>
<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<script type="text/javascript">


// 페이지 사용 - jooyoung

/*******************
1. 기타 필수 전역 변수
********************/

var title = js_er_title ='Error';
var peakAccordion = 0;
var tempAccordion = 0;
var dimmAccordion = 0;
var signAccordion = 0;
var prevChk = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function() {
	
	
	console.log( "userVo.strCd : " + "${userVo.strCd}" );
	
	$('#dialog-confirm').css('overflow', 'auto');
	
	jQuery.validator.addMethod("checkValue", function(value, element) {
	    return ( (value % 5) == 0 );
	}, "5단위로 입력하세요");
	
	
	// Form validate
	$('#saveForm').validate({
		rules:{			
			'peakCheckbox[]' :{required:true, minlength: 1 },
			peakConfVal :{required:true, number:true, maxlength:10 },
			'tempCheckbox[]' :{required:true, minlength: 1 },
			tempConfVal :{required:true, maxlength:2},
			tempOper :{required:true},			
			c0 :{required:true},
			c1 :{required:true},
			h0 :{required:true},
			h1 :{required:true},			
			'signCheckbox[]' :{required:true, minlength: 1 },
			signConfVal1 :{required:true, maxlength:2},
			signConfVal2 :{required:true, maxlength:2},
			signConfVal3 :{required:true, maxlength:2},
			signConfVal4 :{required:true, maxlength:2},
			sd1 :{required:true, maxlength:3},
			sd2 :{required:true, maxlength:3}
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
	          $.each(this.validElements(), function (index, element) {
	              var $element = $(element);
	              $element.data("title", "").removeClass("error").tooltip("destroy");
	          });
	          $.each(errorList, function (index, error) {
	              var $element = $(error.element);
	              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
	          });
	          $.each(this.validElements(), function (index, element) {
	              var $element = $(element);
	              $element.data("title", "").removeClass("error").tooltip("destroy");
	          });
	          $.each(errorList, function (index, error) {
	              var $element = $(error.element);
	              $element.tooltip("destroy").data("title", error.message).addClass("error").tooltip();
	          });
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
	
	if( "${userVo.strCd}" != null && "${userVo.strCd}" != "" ){
		fncStoreConfigSetting();
	}
});

/*******************
1. 기타 필수 스크립트
********************/

function fncPeakAccordion(){
	if( $("#strCd").val() == null || $("#strCd").val() == "" ){
		alert("매장을 선택하세요");
		return;
	}
	if( peakAccordion == 0 ){
		$('#peakAccordion').show();
		peakAccordion = 1;
	}else{
		$('#peakAccordion').hide();
		peakAccordion = 0;
	}		
}

function fncTempAccordion(){
	if( $("#strCd").val() == null || $("#strCd").val() == "" ){
		alert("매장을 선택하세요");
		return;
	}
	if( tempAccordion == 0 ){
		$('#tempAccordion').show();
		tempAccordion = 1;
	}else{
		$('#tempAccordion').hide();
		tempAccordion = 0;
	}
}

function fncSignAccordion(){
	if( $("#strCd").val() == null || $("#strCd").val() == "" ){
		alert("매장을 선택하세요");
		return;
	}
	if( signAccordion == 0 ){
		$('#signAccordion').show();
		signAccordion = 1;
	}else{
		$('#signAccordion').hide();
		signAccordion = 0;
	}
}

// 피크 라디오박스 선택
function peakCheckBox(chk){
	var obj = document.getElementsByName("peakCheckbox[]");	
	for(var i=0; i<obj.length; i++){
    	if(obj[i] != chk){
        	obj[i].checked = false;
    	}
	}
}

// 냉난방 체크박스 선택시
function tempCheckBox(chk){
	
	var obj = document.getElementsByName("tempCheckbox[]");

	if(prevChk == chk){
		
		if( obj[1] == chk ){
			
	    	if( $('#tempWind_0').attr("disabled")){
	        	//$('#h0').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#h1').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#c0').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#c1').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#tempWind_0').attr("disabled",false);
	        	//$('#tempWind_1').attr("disabled",false);
	        	//$('#tempWind_2').attr("disabled",false);
	        	//$('#tm').attr("disabled",false).removeClass("r_Input r_disable");
	        	
	        }else{
	        	//$('#h0').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#h1').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#c0').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#c1').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tempWind_0').attr("disabled",true).data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tempWind_1').attr("disabled",true).data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tempWind_2').attr("disabled",true).data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tm').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#tm').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        }

		}else{
			//$('#h0').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	    	//$('#h1').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	    	//$('#c0').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	    	//$('#c1').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	    	//$('#tempWind_0').attr("disabled",true);
	    	//$('#tempWind_1').attr("disabled",true);
	    	//$('#tempWind_2').attr("disabled",true);
	    	//$('#tm').attr("disabled",false).removeClass("r_Input r_disable");
	    	//$('#tm').attr("disabled",true).addClass("r_Input r_disable");
		}
    	
	}else{
		
		for(var i=0; i<obj.length; i++){

    		if(obj[i] != chk){
    			obj[i].checked = false;
	    	}
    		
    		//if(obj[3] == chk || obj[4] == chk){
	    	if(obj[1] == chk){
	        	//$('#h0').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#h1').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#c0').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#c1').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#tempWind_0').attr("disabled",false);
	        	//$('#tempWind_1').attr("disabled",false);
	        	//$('#tempWind_2').attr("disabled",false);
	        	//$('#tm').attr("disabled",false).removeClass("r_Input r_disable");
	        }else{
	        	//$('#h0').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#h1').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#c0').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#c1').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tempWind_0').attr("disabled",true).data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tempWind_1').attr("disabled",true).data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tempWind_2').attr("disabled",true).data("title", "").removeClass("error").tooltip("destroy");
	        	//$('#tm').attr("disabled",false).removeClass("r_Input r_disable");
	        	//$('#tm').attr("disabled",true).addClass("r_Input r_disable").data("title", "").removeClass("error").tooltip("destroy");
	        }
    	}
	}
	prevChk = chk;
}

function signCheckBox(chk){
	var obj = document.getElementsByName("signCheckbox[]");
	
	for(var i=0; i<obj.length; i++){
    	if(obj[i] != chk){
        	obj[i].checked = false;
    	}
	}
}



// 초기 셋팅
function fncStoreConfigSetting(){
	
	var strCd = $("#strCd").val();
	
	console.log( "strCd : " + strCd );
	
	// 계약전력 가져오기
	$.ajax({
		url:'/retrieveStoreContractPower',
		type:'POST',
		cache:false,
		data:{strCd:strCd},
		dataType:'json',
		success:function(data){
			$("#peakConfVal").val(data);
			$("#peakConfValOld").val(data);
		},
		error:function(result){
			$("#peakConfVal").val(0);
			$("#peakConfValOld").val(0);
		}
	});
	
	
	// PEAK 모드 정보 가져오기
	var mode="PEAK_TYPE";
	$.ajax({
		url:'/retrieveRemsConfigParticularData',
		type:'POST',
		cache:false,
		data:{strCd:strCd,mode:mode},
		dataType:'json',
		success:function(data){			
			if( data.confVal == "P0" ){
				$("input:radio[id='peakCheckbox_1']").attr("checked", true);  
			}else{
				$("input:radio[id='peakCheckbox_2']").attr("checked", true);
			}
		},
		error:function(result){			
			
			
			$("input[name='peakCheckbox[]']:radio").each(function() {
				$(this).attr("checked", false);
			});
			
			/*
			var defaultTime = new Date();
			var getDefaultTime = defaultTime.getFullYear()+""+fillzero(defaultTime.getMonth()+1,2)+""+"01";
			//alert( getDefaultTime );
			// GS매장 피크모드 디폴트 셋팅( P0 )
			*/
			$("input:radio[id='peakCheckbox_1']").attr("checked", true);			
			
		}
	});
		
	// 낸난방 모드 정보 가져오기
	var mode="TEMP_TYPE";
	$.ajax({
		url:'/retrieveRemsConfigParticularData',
		type:'POST',
		cache:false,
		data:{strCd:strCd,mode:mode},
		dataType:'json',
		success:function(data){
			
			$("#tempConfVal").val(data.strConfVal);			
			$("#tempConfValOld").val(data.strConfVal);			
			if( data.confVal == "T0" ){
				$("input:radio[id='tempCheckbox_1']").attr("checked", true);
			}else if( data.confVal == "T1" ){
				$("input:radio[id='tempCheckbox_2']").attr("checked", true);			// 미사용
			}else if( data.confVal == "T2" ){
				$("input:radio[id='tempCheckbox_3']").attr("checked", true);			// 미사용
			}else if( data.confVal == "T3" ){
				$("input:radio[id='tempCheckbox_4']").attr("checked", true);			// 미사용
			}else if( data.confVal == "T4" ){
				$("input:radio[id='tempCheckbox_5']").attr("checked", true);
			}else if( data.confVal == "T5" ){
				$("input:radio[id='tempCheckbox_6']").attr("checked", true);			// 미사용
			}
		},
		error:function(result){
			
			$("#tempConfVal").val(20);
			$("#tempConfValOld").val(20);
			$("input[name='tempCheckbox[]']:radio").each(function() {
				$(this).attr("checked", false);
			});
			
			// GS매장 디폴트 셋팅( T0 )
			$("input:radio[id='tempCheckbox_1']").attr("checked", true);
			//var defaultTime = new Date();
			//var getDefaultTime = defaultTime.getFullYear()+""+fillzero(defaultTime.getMonth()+1,2)+""+"01";
			//$("#tempAppdtDt").val(getDefaultTime);
			
			
		}
	});
	
	// 냉난방기 가동 최소운영 전력
	var mode="OPER_ELEC";
	$.ajax({
		url:'/retrieveRemsConfigParticularData',
		type:'POST',
		cache:false,
		data:{strCd:strCd,mode:mode},
		dataType:'json',
		success:function(data){
			$("#tempOper").val(data.strConfVal);
			$("#tempOperOld").val(data.strConfVal);
		},
		error:function(result){
			
			// GS매장 디폴트 셋팅
			$("#tempOper").val(100);
			$("#tempOperOld").val(100);
		}
	});	
	
	// 냉난방 ONOFF 보정값 정보 가져오기
	var mode="TEMP_LEVL";
	$.ajax({
		url:'/retrieveRemsConfigTempLevelData',
		type:'POST',
		cache:false,
		data:{strCd:strCd,mode:mode},
		dataType:'json',
		success:function(data){
		    $("#c0").val(data.c0);
			$("#c1").val(data.c1);
			$("#h0").val(data.h0);
			$("#h1").val(data.h1);
			
		    $("#c0Old").val(data.c0);
			$("#c1Old").val(data.c1);
			$("#h0Old").val(data.h0);
			$("#h1Old").val(data.h1);
		},
		error:function(result){
			
			// GS매장 디폴트 셋팅
			$("#c0").val(-2);
			$("#c1").val(2);
			$("#h0").val(3);
			$("#h1").val(-2);
			
			$("#c0Old").val(-2);
			$("#c1Old").val(2);
			$("#h0Old").val(3);
			$("#h1Old").val(-2);
		}
	});
	
	// 간판 모드 정보 가져오기
	var mode="SIGN_TYPE";
	$.ajax({
		url:'/retrieveRemsConfigParticularData',
		type:'POST',
		cache:false,
		data:{strCd:strCd,mode:mode},
		dataType:'json',
		success:function(data){
			
			var arry = data.strConfVal.split(',');
			var arry2 = arry[0].split(':');
			var arry3 = arry[1].split(':');
			
			$("#signConfVal1").val(arry2[0]);				// ON시간
			$("#signConfVal2").val(arry2[1]);				// ON분
			$("#signConfVal3").val(arry3[0]);				// OFF시간
			$("#signConfVal4").val(arry3[1]);				// OFF분
			$("#signConfValOld").val(data.strConfVal);		// ON,OFF시간
			
			if( data.confVal == "S0" ){
				$("input:radio[id='signCheckbox_1']").attr("checked", true);
			}else if( data.confVal == "S1" ){
				$("input:radio[id='signCheckbox_2']").attr("checked", true);	
			}else if( data.confVal == "S2" ){
				$("input:radio[id='signCheckbox_3']").attr("checked", true);		// 미사용
			}else if( data.confVal == "S3" ){
				$("input:radio[id='signCheckbox_4']").attr("checked", true);		// 미사용
			}else if( data.confVal == "S4" ){
				$("input:radio[id='signCheckbox_5']").attr("checked", true);
			}
		},
		error:function(result){
			$("#signConfVal1").val("17");				// ON 시간
			$("#signConfVal2").val("00");				// ON 분
			$("#signConfVal3").val("08");				// OFF 시간
			$("#signConfVal4").val("00");				// OFF 분
			$("#signConfValOld").val("17:00,08:00");	// ON,OFF 시간Old
			$("#signAppdtDt").val("");
			$("input[name='signCheckbox[]']:radio").each(function() {
				$(this).attr("checked", false);
			});
			
			// GS매장 디폴트 셋팅
			$("input:radio[id='signCheckbox_2']").attr("checked", true);
			//var defaultTime = new Date();
			//var getDefaultTime = defaultTime.getFullYear()+""+fillzero(defaultTime.getMonth()+1,2)+""+"01";
			//$("#signAppdtDt").val(getDefaultTime);
			
			
		}
	});
	
	// 간판 일출,일몰 딜레이정보 가져오기
	var mode="SIGN_DELY";
	$.ajax({
		url:'/retrieveRemsConfigParticularData',
		type:'POST',
		cache:false,
		data:{strCd:strCd,mode:mode},
		dataType:'json',
		success:function(data){
			var arry = data.strConfVal.split(',');
			$("#sd1").val(arry[0]);
			$("#sd2").val(arry[1]);
			$("#sd1Old").val(arry[0]);
			$("#sd2Old").val(arry[1]);
		},
		error:function(result){
			$("#sd1").val(30);			// 디폴트 값 셋팅
			$("#sd2").val(-60);			// 디폴트 값 셋팅
			$("#sd1Old").val(30);		// 디폴트 값 셋팅
			$("#sd2Old").val(-60);		// 디폴트 값 셋팅
		}
	});
	
	// REMS 장비 개수 정보 가져오기
	$.ajax({
		url:'/retrieveStoreRemsPart',
		type:'POST',
		cache:false,
		data:{strCd:strCd},
		dataType:'json',
		success:function(data){
			
			// 미터 수집 여부
			if(data.mainMeter < 1 ){
				$('#peakAccordionTitle').attr('onclick', '').unbind('click');	
			}else{
				$('#peakAccordion').show();
				peakAccordion = 1;
			}			
			// 냉난방 제어 여부
			if(data.hacon < 1 ){
				$('#tempAccordionTitle').attr('onclick', '').unbind('click');	
			}else{
				$('#tempAccordion').show();
				tempAccordion = 1;
			}
			// 간판 제어 여부
			if(data.sign < 1 ){
				$('#signAccordionTitle').attr('onclick', '').unbind('click');	
			}else{
				$('#signAccordion').show();
				signAccordion = 1;
			}
		},
		error:function(result){
			alert("등록된 렘스 장치가 없습니다");
			$('#peakAccordionTitle').attr('onclick', '').unbind('click');			
			$('#tempAccordionTitle').attr('onclick', '').unbind('click');
			$('#signAccordionTitle').attr('onclick', '').unbind('click');
		}
	});
}



function fillzero(obj, len) 
{
	  obj= '00000000'+obj;
	  return obj.substring(obj.length-len);
} 

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

// 저장 버튼
function fncUpt() {
	if($("#peakConfVal").val() < 1000){
		alert("계약전력이 1000W보다 작습니다.\n1000W보다 큰 값을 입력해주세요.");
		return;
	}
	
	var param  = new Object();
	
	// 수정한 피크 모드 정보 변수	
	param.peakMode = $('input:radio[name="peakCheckbox[]"]:checked').val();	// 피크 모드 체크
	param.peakVal = $("#peakConfVal").val();							// 계약전력
	param.peakValOld = $("#peakConfValOld").val();						// 계약전력Old
		
	// 수정한 냉난방 모드 정보 변수
	param.tempMode = $('input:radio[name="tempCheckbox[]"]:checked').val();	// 냉난방 모드 체크
	param.tempVal = $("#tempConfVal").val();							// 냉난방 설정 온도 값
	param.tempValOld = $("#tempConfValOld").val();						// 냉난방 설정 온도 값Old
	param.tempOper = $("#tempOper").val();								// 냉난방 가동구분 전력량
	param.tempOperOld = $("#tempOperOld").val();						// 냉난방 가동구분 전력량Old
	param.c0 = $("#c0").val();											// 냉방 OFF 온도 보정값
	param.c1 = $("#c1").val();											// 냉방 ON 온도 보정값
	param.h0 = $("#h0").val();											// 난방 OFF 온도 보정값
	param.h1 = $("#h1").val();											// 난방 ON 온도 보정값
	param.c0Old = $("#c0Old").val();									// 냉방 OFF 온도 보정값Old
	param.c1Old = $("#c1Old").val();									// 냉방 ON 온도 보정값Old
	param.h0Old = $("#h0Old").val();									// 난방 OFF 온도 보정값Old
	param.h1Old = $("#h1Old").val();									// 난방 ON 온도 보정값Old
	
	// 수정한 간판 모드 정보 변수
	param.signMode = $('input:radio[name="signCheckbox[]"]:checked').val();	// 냉난방 모드 체크
	
	var signConfVal1 = "";
	var signConfVal2 = "";
	var signConfVal3 = "";
	var signConfVal4 = "";
	
	if( $("#signConfVal1").val().length == 1)	signConfVal1 = "0"+$("#signConfVal1").val();
	else signConfVal1 = $("#signConfVal1").val();
	
	if( $("#signConfVal2").val().length == 1)	signConfVal2 = "0"+$("#signConfVal2").val();
	else	signConfVal2 = $("#signConfVal2").val();
	
	if( $("#signConfVal3").val().length == 1)	signConfVal3 = "0"+$("#signConfVal3").val();
	else		signConfVal3 = $("#signConfVal3").val();
	
	if( $("#signConfVal4").val().length == 1)	signConfVal4 = "0"+$("#signConfVal4").val();
	else	signConfVal4 = $("#signConfVal4").val();

	var signVal1 = signConfVal1+":"+signConfVal2;		
	var signVal2 = signConfVal3+":"+signConfVal4;		
	param.signVal = signVal1 +","+ signVal2;				// 간판 ON,OFF 시간( 일출,일몰)
	param.signValOld = $("#signConfValOld").val();			// 간판 ON,OFF 시간( 일출,일몰)Old
	
	var sd1 = $("#sd1").val();							
	var sd2 = $("#sd2").val();							
	param.signDelay =  sd1 +","+ sd2;						// 간판 딜레이 ( 일출,일몰 )
	
	var sd1Old = $("#sd1Old").val();							
	var sd2Old = $("#sd2Old").val();							
	param.signDelayOld =  sd1Old +","+ sd2Old;				// 간판 딜레이 ( 일출,일몰 )
	
	param.companyCd = $("#companyCd").val();				// 회사 코드
	param.companyNm = $("#companyNm").val();				// 회사 명
	param.strCd = $("#strCd").val();						// 매장 시스템 코드	
	param.strNm = $("#strNm").val();						// 매장 명
	
	console.log( "save btn :");
	
	var str = "";
	for(key in param) 
	{
		str += key+"="+param[key]+"\n";
	}

    console.log(str);
	
	

	if(confirm('${smCommMsgSaveCnf}')){
		
		$.ajaxSettings.traditional = true;
		$.ajax({
			url:'/saveRemsConfigDataMgnt',
			type:'POST',
			cache:false,
			data: param,
			dataType:'json',
			success:function(data){
				
				console.log( "save success : " + data );
				if(data)
				{
					alert('${smCommMsgSave}');
				}else{
					alert('저장에 실패 했습니다');
				}
			},
			error:function(result){
				alert('에러가 발생 했습니다');
			}
		});		
		
	}
	
	return false;
}


// 취소 버튼
function fncCancel() {	
	
	if(confirm('이전으로 가시겠습니까?'))
	{
		var param  = new Object();
		param.mode = "BACK";
		param.scrStrNm = 		'${history.scrStrNm}';
		param.scrOrgCd 	= 		'${history.scrOrgCd}';
		param.scrOrgNm 	= 		'${history.scrOrgNm}';
		//var target = '5103';
			
		fncCallPage('4403', param);
	}
	
	
}
</script>
<!-- jQuery validate 다국어 메세지 -->
<%@ include file="/WEB-INF/views/system/validate.jsp" %>

<div id="loadingArea">
	<div class="r_inputTbl r_horizonTbl">
		<div class="r_gridTitle top_table">
			<h3>${smStrFcltyInsUpt}</h3>
		</div>
		<div class="r_inputTbl r_horizonTbl">
			<table>
				<colgroup>
					<col width="15%" />
					<col width="*" />
				</colgroup>
				<tbody>
				<tr>
					<th>매장명(코드)<span class="r_required">*</span></th>					
					<td class="tleft">
						<div class="r_innerSearch">
							<input type='hidden' id='companyCd' name='companyCd' value="${userVo.companyCd}"/>
							<input type='hidden' id='strCd' name='strCd' value="${userVo.strCd}" />
							<input type='hidden' id='viewStrCd' name='viewStrCd' value="${userVo.viewStrCd}" />							 
							<input type='text' id='strNm' name='strNm' value="${userVo.strNm}"  style="width:145px;" maxlength="30" class="r_Input r_disable" readonly="readonly" />							
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		
		<form id="saveForm" name="saveForm" method="post">    
		<div class="r_accordion r_open r_secondTbl">
			<!-- Peak 아코디언 -->
			<div class="r_accordionTitle"  onclick="fncPeakAccordion();" id="peakAccordionTitle">
				<span class="r_accordionIcon"></span>
				<h3>피크</h3>
			</div>
			
			<div class="r_accordionCont" id="peakAccordion" style="display:none">
			    <div class="r_inputTbl">
					<table>
				        <col width="10%"/>
				        <col width="10%"/>
				        <col width="10%"/>
				        <col width="35%" />
				        <col width="35%" />				        
				        <thead>
				        	<tr>
					            <th scope="col" class="tcenter">번호</th>
					            <th scope="col" class="tcenter">선택</th>
					            <th scope="col" class="tcenter">모드</th>
					            <th scope="col" class="tcenter">모드설명</th>
				        	</tr>
				        </thead>
				        <tbody>
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>1</td>
					            <td class="tcenter"><input type="radio" id="peakCheckbox_1" name="peakCheckbox[]" value="P0" onclick="peakCheckBox(this)" required /></td>
					            <td class="tcenter"><input type="text" style="width:30px; border:0px" readonly="readonly" value="P0"/></td>
					            <td class="tleft">${rcmVo.p0}</td>
					            <td rowspan="2" class="tleft">
					            	<input type="number" id="peakConfVal" name="confVal" style="width:70px;" required/>
					            	<input type="hidden" id="peakConfValOld" name="peakConfValOld"/>
					            </td>					            
							</tr>
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>2</td>
					            <td class="tcenter"><input type="radio" id="peakCheckbox_2" name="peakCheckbox[]" value="P1" onclick="peakCheckBox(this)" required></td>
					            <td class="tcenter"><input type="text" style="width:30px; border:0px" readonly="readonly" value="P1"/></td>
					            <td class="tcenter">${rcmVo.p1}</td>
							</tr>
						</tbody>
					</table>
				</div>					
			</div>
		</div>				
				
		<div class="r_accordion r_open r_secondTbl">
			<div class="r_accordionTitle"  onclick="fncTempAccordion();" id="tempAccordionTitle">
				<span class="r_accordionIcon"></span>
				<h3>냉난방</h3>
			</div>
			<div class="r_accordionCont"  id="tempAccordion"  style="display:none">
			    <div class="r_inputTbl">
					<table>
				        <col width="10%"/>
				        <col width="10%"/>
				        <col width="10%"/>
				        <col width="35%" />
				        <col width="35%" />		
				        <thead>
				        	<tr>
					            <th scope="col" class="tcenter">번호</th>
					            <th scope="col" class="tcenter">선택</th>
					            <th scope="col" class="tcenter">모드</th>
					            <th scope="col" class="tcenter">모드설명</th>
					            <th scope="col" class="tcenter">설정온도</th>					            
				        	</tr>
				        </thead>
				        <tbody>
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>1</td>
					            <td class="tcenter"><input type="radio" id="tempCheckbox_1" name="tempCheckbox[]" value="T0" onclick="tempCheckBox(this)" ></td>
  						        <td class="tcenter"><input type="text" id="mode" name="mode" style="width:30px; border:0px" readonly="readonly" value="T0"/></td>
					            <td class="tleft">${rcmVo.t0}</td>
					            <td class="tleft"><input type="text" id="confVal" name="confVal" style="width:70px; border:0px" readonly="readonly" class="tright" /></td>					            
							</tr>							
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>2</td>
					            <td class="tcenter"><input type="radio" id="tempCheckbox_5" name="tempCheckbox[]" value="T4" onclick="tempCheckBox(this)" ></td>
  						        <td class="tcenter"><input type="text" id="mode" name="mode" style="width:30px; border:0px" readonly="readonly" value="T4"/></td>
					            <td class="tleft">${rcmVo.t4}</td>
					            <td class="tleft">
					            	<input type="number" id="tempConfVal" name="tempConfVal" style="width:70px;" min="18" max="30" maxlength="2" required/>
					            	<input type="hidden" id="tempConfValOld" name="tempConfValOld"/>
					            </td>
							</tr>	
							<tr>
								<th colspan="3">최소운영전력(W)<span class="r_required">*</span></th>
								<td colspan="2" class="tleft">
									<input type='number' id='tempOper' name='tempOper' style="width:100px;" />
									<input type='hidden' id='tempOperOld' name='tempOperOld' />
								</td>
							</tr>						
							<tr>
								<th colspan="3">보정 값 설정<span class="r_required">*</span></th>
								<td colspan="2" class="tleft">
									<span>냉방 하한 : </span><input type='number' id='c0' name='c0' style="width:50px;" />
									<span style="padding:10px">냉방 상한 : </span><input type='number' id='c1' name='c1' style="width:50px;" />
									<span style="padding:10px">난방 하한 : </span><input type='number' id='h1' name='h1' style="width:50px;" />
									<span style="padding:10px">난방 상한 : </span><input type='number' id='h0' name='h0' style="width:50px;" />
									<input type='hidden' id='c0Old' name='c0Old' />
									<input type='hidden' id='c1Old' name='c1Old' />
									<input type='hidden' id='h1Old' name='h1Old' />
									<input type='hidden' id='h0Old' name='h0Old' />
								</td>
							</tr>						
						</tbody>
					</table>
				</div>				
			</div>
		</div>				

		<div class="r_accordion r_open r_secondTbl">
			<div class="r_accordionTitle" onclick="fncSignAccordion();" id="signAccordionTitle">
				<span class="r_accordionIcon"></span>
				<h3>간판</h3>
			</div>
			<div class="r_accordionCont" id="signAccordion"  style="display:none">
			    <div class="r_inputTbl">
					<table>
				       <col width="10%"/>
				        <col width="10%"/>
				        <col width="10%"/>
				        <col width="35%" />
				        <col width="35%" />					       
				        <thead>
				        	<tr>
					            <th scope="col" class="tcenter">번호</th>
					            <th scope="col" class="tcenter">선택</th>
					            <th scope="col" class="tcenter">모드</th>
					            <th scope="col" class="tcenter">모드설명</th>
					            <th scope="col" class="tcenter">일출/일몰</th>					            
				        	</tr>
				        </thead>
				        <tbody>
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>1</td>
					            <td class="tcenter"><input type="radio" id="signCheckbox_1" name="signCheckbox[]" value="S0" onclick="signCheckBox(this)" ></td>
  						        <td class="tcenter">
					            	<input type="hidden" id="type" name="type" value="SIGN_TYPE"/>
					            	<input type="text" id="mode" name="mode" style="width:30px; border:0px" readonly="readonly" value="S0"/>
					            </td>
					            <td class="tleft">${rcmVo.s0}</td>
					            <td class="tleft"></td>						            					            
							</tr>
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>2</td>
					            <td class="tcenter"><input type="radio" id="signCheckbox_2" name="signCheckbox[]" value="S1" onclick="signCheckBox(this)" ></td>
  						        <td class="tcenter"><input type="text" id="mode" name="mode" style="width:30px; border:0px" readonly="readonly" value="S1"/></td>
					            <td class="tleft">${rcmVo.s1}</td>
					            <td class="tleft"></td>					            
							</tr>							
							<tr>
					            <td class="tcenter"><input type="text" id="no" name="no" style="width:10px; border:0px"/>5</td>
					            <td class="tcenter"><input type="radio" id="signCheckbox_5" name="signCheckbox[]" value="S4" onclick="signCheckBox(this)" ></td>
  						        <td class="tcenter"><input type="text" id="mode" name="mode" style="width:30px; border:0px" readonly="readonly" value="S4"/></td>
					            <td class="tleft">${rcmVo.s4}</td>
					            <td class="tleft">
									<input type="number" id="signConfVal1" name="confVal1" style="width:45px;" min="0" max="24" maxlength="2" required/>&nbsp:
									<input type="number" id="signConfVal2" name="confVal2" style="width:45px;" min="0" max="60" maxlength="2" required/>&nbsp,
					                <input type="number" id="signConfVal3" name="confVal3" style="width:45px;" min="0" max="24" maxlength="2" required/>&nbsp:
					                <input type="number" id="signConfVal4" name="confVal4" style="width:45px;" min="0" max="60" maxlength="2" required/>
									<input type="hidden" id="signConfValOld" name="confValOld" />
					            </td>					            
							</tr>
							<tr>
								<th colspan="3" style="width:30%">간판 딜레이(일출,일몰)<span class="r_required">*</span></th>
								<td colspan="2" class="tleft">
									<input type='number' id='sd1' name='sd1' style="width:50px;" min="-60" max="60" maxlength="2" value="0" required/>
									<input type='number' id='sd2' name='sd2' style="width:50px;" min="-60" max="60" maxlength="2" value="-60" required/>
									<input type='hidden' id='sd1Old' name='sd1Old' />
									<input type='hidden' id='sd2Old' name='sd2Old' />
								</td>
							</tr>
							
						</tbody>
					</table>
				</div>				
				
			</div>
		</div>		
		<br></br>
		</form>
		
		<div class="r_pageBtnWrapper mr_0 ml0 border_none">
	     	<span class="pageNormal">    			   				     		
	     		<button onclick="javascript:fncUpt();">${smSave}</button>
	     		<button onclick="javascript:fncCancel()">이전</button>
	     	</span>
	     	<br></br>
		</div>
	</div>
</div>