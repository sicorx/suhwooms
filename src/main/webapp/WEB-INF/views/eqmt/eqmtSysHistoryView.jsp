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
<c:set var="smUser"><spring:message code="user"/></c:set>
<c:set var="smUserId"><spring:message code="userId" /></c:set>
<c:set var="smUserNm"><spring:message code="userNm" /></c:set>
<c:set var="smAuth"><spring:message code="auth" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smUserInfo"><spring:message code="userInfo" /></c:set>
<c:set var="smMultStrList"><spring:message code="multStrList" /></c:set>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<c:set var="smUserSrch"><spring:message code="userSrch"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smInqry"><spring:message code="inqry"/></c:set>
<style>
.chk1 {
	background: #92D050;
}

.chk2 {
	background: #FFC000;
}
</style>
<script type="text/javascript">

	var selTab = "a";
	
	$(function() {
		// 달력
		$("#search_dateFrom, #search_dateTo").datepicker();
	});
	
	$(document).ready(function(){	
		
		init();		
		
		init_A();	
		init_B();
		
		
		// 탭
		$('.tab_tab').click(function(e) {

			e.preventDefault();
			
			var id = $(this).attr('id');
			var selId = id.substring(0, id.length - "_tab".length);		
			if( selTab == selId )
				return;
			
			if (selTab) $("#" + selTab).attr("style", "display:none;");
			$(this).tab('show');
			
			var id = $.trim($(this).attr('id'));
			if (id == "a_tab") {			
				fncSearch_A();
			} else if(id == "b_tab") {
				fncSearch_B();
			}
		}).on('shown', function(e) {
			var id = $(this).attr('id');
			var selId = id.substring(0, id.length - "_tab".length);
			$("#" + selId).attr("style", "display:block;");
			selTab = selId;
			
			grid_resize();
		});			
	});
	
	$(window).resize(function(){

		grid_resize();
		
	}).resize();
	
	
	function grid_resize(){
		var parObj = $("#gridStoreMgnt").parent();
	    $("#gridStoreMgnt").setGridWidth($("#cont1").width());

	    var parObj = $("#gridStoreMgnt2").parent();
	    $("#gridStoreMgnt2").setGridWidth($("#cont2").width());	
	}
    
	
	function init_A() {
		// Grid 출력
		$("#gridStoreMgnt").jqGrid({
			url:'retrieveSysHistory',
		    datatype: "json",
		    mtype: 'POST',
		    postData : {
				userId:$("#userId").val(),
				authId:$("#authId option:selected").val(), 
				scrDateFrom: $("#search_dateFrom").val(),
				scrDateTo: $("#search_dateTo").val(),			 
			},
		  	colNames:['No', '사용자ID', '사용자명', '역할', '기간 접속횟수'],
		  	colModel:[ 	  		
   	  			{name:'records', index:'records', width:15, align:'center', sortable:true, editable:false, editoptions : {readonly : true,size : 10}},
   	  			{name:'userId',	 index:'userId',  width:30, align:'center', sortable:true, editable:false},
               	{name:'userNm',	 index:'userNm',  width:30, align:'left', sortable:true, editable:false},
               	{name:'authNm',	 index:'authNm',  width:30, align:'center', sortable:true, editable:false},
               	{name:'sysCnt',	 index:'sysCnt',  width:30, align:'center',  sortable:true, editable:false},	 
		           ],
		     jsonReader : {
		          repeatitems:false
		     },
			rowNum:20,
		    rowList:[10,20,50,100],
		    pager: '#gridStoreMgntPager',
		    recordtext: "건/페이지  (전체 {2} 건)",
		    emptyrecords : "검색 결과가 존재하지 않습니다.",
		    loadtext: "Loading...",
		    sortname: 'userId',
		    viewrecords: true,
		    sortorder: "desc",	     
		    hidegrid: false,
		    shrinkToFit:true,
			autowidth:true,
			height : 360,		 
			onClickRow : function(rowid, iRow, iCol, e ) {
				 
			 },	
		   	ondblClickRow: function (rowid,iRow,iCol,e) {

			},
			loadComplete : function(data) {
				var list   = $("#gridStoreMgnt").getRowData();
				var rowCnt = list.length;
							
				// 첫번째 row를 선택
				if( rowCnt > 0 ) {
					$("#gridStoreMgnt").jqGrid('setSelection', 1);
				}
			}				
			
		 });	 		
	}
	
	
	function init_B(){
		$("#gridStoreMgnt2").jqGrid({
			url:'retrieveSysHistory2',
		    datatype: "json",
		    mtype: 'POST',
		    postData : {
				userId:$("#userId").val(),
				authId:$("#authId option:selected").val(), 
				scrDateFrom: $("#search_dateFrom").val(),
				scrDateTo: $("#search_dateTo").val(),			 
			},
		  	colNames:['No', '메뉴ID', '메뉴명', '화면 접속횟수'],
		  	colModel:[ 	  		
   	  			{name:'records', index:'records', width:200, align:'center', sortable:true, editable:false, editoptions : {readonly : true,size : 10}},
   	  			{name:'menuId',	 index:'menuId',  width:450, align:'center', sortable:true, editable:false},
               	{name:'menuNm',	 index:'menuNm',  width:450, align:'left', sortable:true, editable:false},
               	{name:'sysCnt',	 index:'sysCnt',  width:470, align:'center',  sortable:true, editable:false},	 
		           ],
		     jsonReader : {
		          repeatitems:false
		     },
			rowNum:20,
		    rowList:[10,20,50,100],
		    pager: '#gridStoreMgntPager2',
		    recordtext: "건/페이지  (전체 {2} 건)",
		    emptyrecords : "검색 결과가 존재하지 않습니다.",
		    loadtext: "Loading...",
		    sortname: 'sysCnt',
		    viewrecords: true,
		    sortorder: "desc",	     
		    hidegrid: false,
		 //   shrinkToFit:true,
		//	autowidth:true,
			height : 360,		 
			loadComplete : function(data) {
				var list   = $("#gridStoreMgnt2").getRowData();
				var rowCnt = list.length;
							
				// 첫번째 row를 선택
				if( rowCnt > 0 ) {
					$("#gridStoreMgnt2").jqGrid('setSelection', 1);
				}
			}			
		 });			
	}
	
	function fncSearch_A() {
		if($("#search_dateFrom").val() > $("#search_dateTo").val()){
			alert("조회기간을 확인해주세요.");
			return false;
		}
		
		$("#gridStoreMgnt").clearGridData();
		$("#gridStoreMgnt").setGridParam({
			datatype : "json",		
			postData : {
				userId:$("#userId").val(),
				authId:$("#authId option:selected").val(), 
				scrDateFrom: $("#search_dateFrom").val(),
				scrDateTo: $("#search_dateTo").val(),
			}
		}).trigger("reloadGrid");
	}
	
	function fncSearch_B() {
		if($("#search_dateFrom").val() > $("#search_dateTo").val()){
			alert("조회기간을 확인해주세요.");
			return false;
		}
		
		$("#gridStoreMgnt2").clearGridData();
		$("#gridStoreMgnt2").setGridParam({
			datatype : "json",		
			postData : {
				userId:$("#userId").val(),
				authId:$("#authId option:selected").val(), 
				scrDateFrom: $("#search_dateFrom").val(),
				scrDateTo: $("#search_dateTo").val(),
			}
		}).trigger("reloadGrid");
	}	
	
	
	
	function init(){	
		if('${scrValue.scrDateFrom}' == "" ){		
			var DateFrom = func_makeDate(31);
			$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );		
		}else{		
			$('#scrDateFrom').val( 		'${scrValue.scrDateFrom}' );
		}
		
		if('${scrValue.scrDateTo}' == "" ){
			var DateTo = func_toDate();
			$( "#search_dateTo" ).datepicker( "setDate", DateTo );
		}else{
			$('#scrDateTo').val( 		'${scrValue.scrDateTo}' );	
		}
	}	
	
	

	// 현재 시간
	function func_toDate() {
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

	// 하루전, 한달전, 계산 
	function func_makeDate(day){		 
	    var YYYY, MM, DD;
	    var date = new Date();
	    var d = new Date(Date.parse(date)-86400000*day);	
	    
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

	function func_monthBtn(value){
		var DateTo = $( "#search_dateTo" ).val();
		var DateFrom = gfnDateAdd(DateTo, 'M', (value*-1), '-');
		$( "#search_dateFrom" ).datepicker( "setDate",  DateFrom );
	}

	// 조회 버튼
	function fncSearch() {
		if($("#search_dateFrom").val() > $("#search_dateTo").val()){
			alert("조회기간을 확인해주세요.");
			return false;
		}
		
		$("#gridStoreMgnt").setGridParam({"page":1});		// 1페이지로 이동
		$("#gridStoreMgnt").setGridParam({
			 postData : {
				userId:$("#userId").val(),
				authId:$("#authId option:selected").val(), 
				scrDateFrom: $("#search_dateFrom").val(),
				scrDateTo: $("#search_dateTo").val(),	
			 }
		 }).trigger("reloadGrid");
		
		$("#gridStoreMgnt2").setGridParam({"page":1});		// 1페이지로 이동
		$("#gridStoreMgnt2").setGridParam({
			 postData : {
				userId:$("#userId").val(),
				authId:$("#authId option:selected").val(), 
				scrDateFrom: $("#search_dateFrom").val(),
				scrDateTo: $("#search_dateTo").val(),	
			 }
		 }).trigger("reloadGrid");		
	}
	
	// ID/사용자 입력 Enter 시 수행
	$("#userId").keyup(function(event){			
		if(event.which == 13)		// Enter Key Press
		{		
			fncSearch();			// 사용자 조회				
		}
	});
	
</script>

<div id="loadingArea">
	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<table>
			<tr>
				<th>기간</th>
				<td>
					<input id="search_dateFrom" type="text" placeholder="" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
					~ <input id="search_dateTo" type="text" placeholder="" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
			   		<button onclick="javascript:func_monthBtn(1);">1m</button>
			   		<button onclick="javascript:func_monthBtn(6);">6m</button>
			   		<button onclick="javascript:func_monthBtn(12);">1y</button>
				</td>
				<th>사용자구분</th>
				<td>
					<select id="authId" name="authId" style="width:130px;" class="tblSelect">
						<option value=''>--전체--</option>
							<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
								<option value='${vo.authId}'<c:if test="${scrValue.authId == vo.authId}">selected</c:if>>${vo.authNm}</option>
							</c:forEach>
					</select>				
				</td>
				<th>ID/사용자</th>
				<td>
					<input type='text' id='userId' name='userId' value='${scrValue.title}' placeholder="전체" style="width:220px;" />
				</td>				
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->
	
	<div class="tab_group">
		<ul class="nav nav-tabs" id="myTab">
			<li class="active"><a href="#a" id="a_tab" class="tab_tab" onfocus="this.blur()">사용자별현황</a></li>
		  	<li><a href="#b" id="b_tab" class="tab_tab" onfocus="this.blur()">메뉴별현황</a></li>
		</ul>
	
		<div class="tab-content">
		  	<div class="tab-pane active" id="a">
				<!-- 그리드 영역 -->
				<div class="r_grid tab_only" id="cont1">
					<div class="r_gridTitle">			
						<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->						
						<!-- 엑셀 download -->
						<!-- div style="text-align:right">
							<img src="/images/download_excel.png"/>
						</div -->
						<!-- //엑셀 download -->
					</div>
					<table id="gridStoreMgnt"><tr><td></td></tr></table>
					<div id="gridStoreMgntPager"></div>
				</div>
				<!-- //그리드 영역 -->
			</div>
		
			<div class="tab-pane" id="b" style="display:none;">
				<!-- 그리드 영역 -->
				<div class="r_grid tab_only" id="cont2">
					<div class="r_gridTitle">			
						<h3 class="blind">타이틀 입력요함</h3> <!-- 타이틀 숨김 해제시 blind제거 -->
						<!-- 엑셀 download -->
						<!-- div style="text-align:right">
							<img src="/images/download_excel.png"/>
						</div -->
						<!-- //엑셀 download -->
					</div>
					<table id="gridStoreMgnt2"><tr><td></td></tr></table>
					<div id="gridStoreMgntPager2"></div>
				</div>
				<!-- //그리드 영역 -->
			</div>
		</div>
	</div>		
</div>