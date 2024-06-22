/* 
 * get 방식 팝업호출
 */
function showPopup(url, windowName, width, height){
	
	
	//스크린의 크기
	var sw=screen.availWidth;
	var sh=screen.availHeight;

	
	 //열 창의 포지션
	var px=(sw-width)/2;
	var py=(sh-height)/2;
	

	var options = 'location=no,status=no,toolbar=no,scrollbars=no,resizeble=no,left='+px+',top='+py+',width='+width+',height='+height;	
	
	return window.open(url, windowName,options);
}

/* 
 * post 방식 팝업호출
 * 
 * 
 * 
 * <!-- post 방식 window open -->
<form id='popupForm' name='popupForm' method='post'> 
<input type="hidden" id="popArg1" name="strCd"> 
<input type="hidden" id="popArg2" name="viewStrCd"> 
<input type="hidden" id="popArg3" name="companyCd"> 
<input type="hidden" id="popArg4" name="companyNm"> 
</form>
 * 
 * 
 */

var callbackMethod = null;
function showPopupPost(url, windowName, width, height, args){
	
	//스크린의 크기
	var sw=screen.availWidth;
	var sh=screen.availHeight;

	
	 //열 창의 포지션
	var px=(sw-width)/2;
	var py=(sh-height)/2;
	
	var winObj;

	var options = 'location=no,status=no,toolbar=no,scrollbars=no,resizeble=no,left='+px+',top='+py+',width='+width+',height='+height;	
	
	winObj =  window.open('', windowName,options);
	
	if(args != null && args.length > 0){
		for(var i=0;i < args.length; i++){
			$('#popArg'+(i+1)).val(args[i]);				
		}
	}	
	
	document.popupForm.target = windowName;
	document.popupForm.action = url;
	document.popupForm.submit();
	
	return winObj;
}


/*
 * Object 형태로 파라미터 넘기는 팝업호출함수 
 */
function fncWindowPopup(url) {

	var sw = screen.availWidth;
	var sh = screen.availHeight;
	var px = 0;
	var py = 0;
	
	var width = 0;
	var height = 0;
	
	var target = "";
	
	if( url.indexOf("?") > 0 ) {
		target = url.substring(0, url.indexOf("?")); 
	}
	else {
		target = url;
	}
	
	switch(target) {
	
	case 'showOrgSrch' :
		width = 500;
	    height = 400;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;
	case 'storeMngSrch' :
		width = 650;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;
	case 'areaSrch' :
		width = 650;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;
	case 'userMngSrch' :
		width = 650;
	    height = 560;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;
	case 'particularStoreSrch' :
		width = 650;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;
	case 'energyDistList' :
		width = 800;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;		
	case 'energyHacDistList' :
		width = 800;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;	
	case 'energyContExcessList' :
		width = 800;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;	
	case 'eqmtAlarmSrch' :
		width = 600;
	    height = 700;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;	
	case 'eqmtTempSrch' :
		width = 600;
	    height = 600;
	    px = (sw - width) / 2;
		py = (sh - height) / 2;
		break;
	default :
		width = 0;
    	height = 0;
    	px = (sw - width) / 2;
    	py = (sh - height) / 2;
		break;
	}
	
	var winObj;
	
	var options = 'location=no,status=no,toolbar=no,scrollbars=no,resizeble=no,left='+px+',top='+py+',width='+width+',height='+height;	
	
	winObj = window.open(url, '',options);

	return winObj;	
}

//jqGrrid even
function jqGridEven(gridId){
	$("#"+gridId+" tr:even").each(function(i){			
		$(this).addClass("r_even");
	});				
}

function fncCancel() {
	self.close();
}

