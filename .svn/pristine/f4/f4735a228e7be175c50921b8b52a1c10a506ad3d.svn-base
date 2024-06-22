
// jquery 확장
/**
 *  
 * @author 이지홍
 * @Description :jquery 확장 form을 json타입으로 변환
 * @param  : form
 * @return : json
 */
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

function fn_divPopForm(str, title, width, height, formId, args){
	
	menuLoadImgShow("loadingArea");
	
	if(args != null && args.length > 0){
		for(var i=0;i < args.length; i++){
			$('#' + formId + ' #popArg'+(i+1)).val(args[i]);				
		}
	}
	
	$.ajaxSetup({
        cache:false,
        contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
        timeout: 50000,
        async: false,
        type: "POST"
    });
	
	var parmaData = $('#'+formId).serializeObject();
	
    setTimeout(function() {
    	
        $("#dialog-confirm").load(str, parmaData);
        $("#dialog-confirm").dialog({
            cache: false,
            resizable: false,
            width:width,
            height:height,
            modal: true,
            title: title,
            open: function (event, ui) {
                //$('#dialog-confirm').css('overflow', 'hidden'); //this line does the actual hiding
                menuLoadImgHide("loadingArea");
            }
                
        });
    }, 800);
}

function fn_divPop(str, title, width, height, args) {	
	
	menuLoadImgShow("loadingArea");		// 로딩바 START
	
	// async: false 설정
	$.ajaxSetup({
        cache:false,
        contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
        async: false,
        type: "POST"
    });	
	
	// 로딩바 fadein 시간이 800 이기에
	setTimeout(function() {
    	// Ajax page Load
        $("#dialog-confirm").load(str, args);
        
        // 모달창 오픈
        $("#dialog-confirm").dialog({
            cache: false,
            resizable: false,
            width:width,
            height:height,
            modal: true,
            title: title,
            open: function (event, ui) {
                menuLoadImgHide("loadingArea");		// 로딩바 END
                //console.log( args );
                // 이곳을 제외하곤 모두 async가 true이기 때문에 돌려놔야 함
                $.ajaxSetup({
                   async: true
                });
            }   
        });
    }, 800);
}


function fncDivPop1Close() {
	$("#dialog-confirm").dialog("close");
}


function fn_divPop2ndForm(str, title, width, height, formId, args){
	
	menuLoadImgShow("loadingArea");
	
	if(args != null && args.length > 0){
		for(var i=0;i < args.length; i++){
			$('#' + formId + ' #popArg'+(i+1)).val(args[i]);				
		}
	}
	
	$.ajaxSetup({
        cache:false,
        contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
        timeout: 50000,
        async: false,
        type: "POST"
    });
	
	var parmaData = $('#'+formId).serializeObject();
	
    setTimeout(function() {
    	
        $("#dialog-confirm-2nd").load(str, parmaData);
        $("#dialog-confirm-2nd").dialog({
            cache: false,
            resizable: false,
            width:width,
            height:height,
            modal: true,
            title: title,
            open: function (event, ui) {
                //$('#dialog-confirm').css('overflow', 'hidden'); //this line does the actual hiding
                menuLoadImgHide("loadingArea");
            }
                
        });
    }, 800);

}

function fn_divPop2nd(str, title, width, height, args){
	
	menuLoadImgShow("loadingArea");

	if(args != null && args.length > 0){
		for(var i=0;i < args.length; i++){
			$('#popArg'+(i+1)).val(args[i]);				
		}
	}
	
	$.ajaxSetup({
        cache:false,
        contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
        timeout: 50000,
        async: false,
        type: "POST"
    });
	
	var parmaData = $('#popupForm').serializeObject();

    setTimeout(function() {
    	
        $("#dialog-confirm-2nd").load(str, parmaData);
        $("#dialog-confirm-2nd").dialog({
            cache: false,
            resizable: false,
            width:width,
            height:height,
            modal: true,
            title: title,
            open: function (event, ui) {
                //$('#dialog-confirm').css('overflow', 'hidden'); //this line does the actual hiding
                menuLoadImgHide("loadingArea");
            }
                
        });
    }, 800);

}

function fncDivPop2Close() {
	$("#dialog-confirm-2nd").dialog("close");
}


/**
 *  
 * @author 이지홍
 * @Description : DIV POPUP2 모듈
 * @param  int, int, string, string, string, string
 * @return  
 */
/*
function fn_divPop3rd(str, title, width, height, args){
	if(args != null && args.length > 0){
		for(var i=0;i < args.length; i++){
			$('#popArg'+(i+1)).val(args[i]);				
		}
	}
	
	$.ajaxSetup({
        cache:false,
        contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
        timeout: 50000,
        async: false,
        type: "POST"
    });
	
	var parmaData = $('#popupForm').serializeObject();
	$("#dialog-confirm-3rd").load(str, parmaData);
	$("#dialog-confirm-3rd").dialog({
		cache: false,
		resizable: false,
		width:width,
		height:height,
		modal: true,
		title: title,
			
	});
	
	//$('.ui-dialog-titlebar-close').hide();
}


function fncDivPop3Close() {
	$("#dialog-confirm-3rd").dialog("close");
	//$("div[aria-describedby='dialog-confirm-3rd'] .ui-dialog-titlebar-close").click();
}*/