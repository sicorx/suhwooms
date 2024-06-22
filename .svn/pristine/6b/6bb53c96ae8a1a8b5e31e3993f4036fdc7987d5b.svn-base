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
<c:set var="smAlmon"><spring:message code="almon"/></c:set>
<c:set var="smTemon"><spring:message code="temon"/></c:set>
<c:set var="smZigbee"><spring:message code="zigbee"/></c:set>
<c:set var="smStrCdSrch"><spring:message code="strCdSrch"/></c:set>
<c:set var="smStrCdExtSrch"><spring:message code="strCdExtSrch"/></c:set>
<c:set var="smAlarmGenTim"><spring:message code="alarmGenTim"/></c:set>
<c:set var="smStrStat"><spring:message code="strStat"/></c:set>
<c:set var="smFailInfo"><spring:message code="failInfo"/></c:set>
<c:set var="smAlarm"><spring:message code="alarm"/></c:set>
<c:set var="smAll"><spring:message code="all"/></c:set>
<c:set var="smObstacle"><spring:message code="obstacle"/></c:set>
<c:set var="smTempH"><spring:message code="tempH"/></c:set>
<c:set var="smTempL"><spring:message code="tempL"/></c:set>
<c:set var="smErr"><spring:message code="err"/></c:set>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnt"><spring:message code="cnt" /></c:set>

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

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('input:radio[name="scrAlarmYn"]').eq(0).attr('checked', true);	
	  $("#gridStoreMgnt").jqGrid({
	      url:'retrieveStoreInverterList',
	      datatype: "json",
	      mtype: 'POST',
	      colNames:['${smSeq}', '${smOrg}', '${smStrNm}', '${smStrStat}', '${smAlarmGenTim}', '${smFailInfo}', 'strCd', 'highTemp', 'lowTemp', 'inSensor', 'deSensor', 'highPressure', 'lowPressure', 'comp', 'link', 'temp1', 'temp2', 'temp3', 'temp4', 'temp5', 'temp6', 'temp7', 'temp8', 'viewStrCd', 'alarm'],
	      colModel:[
	                {name:'records',index : 'records',width : 50,align : 'center',sortable : true,editable : false,editoptions : {readonly : true,size : 10}},
	                {name:'orgNm',index:'orgNm', width:85, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	                {name:'strNm',index:'strNm', width:85, align:'center', sortable:true, editable:false},
	                {name:'alarmCnt',index:'alarmCnt', width:50, align:'center', sortable:true, editable:false},
	                {name:'alarmGenTime',index:'alarmGenTime', width:85, align:'center', sortable:true, editable:false},
	                {name:'failInfo',index:'failInfo', width:93, align:'center', sortable:true, editable:false},
	                {name:'strCd',index:'strCd', hidden:true},
	                {name:'highTemp',index:'highTemp', hidden:true},
	                {name:'lowTemp',index:'lowTemp', hidden:true},
	                {name:'inSensor',index:'inSensor', hidden:true},
	                {name:'deSensor',index:'deSensor', hidden:true},
	                {name:'highPressure',index:'highPressure', hidden:true},
	                {name:'lowPressure',index:'lowPressure', hidden:true},
	                {name:'comp',index:'comp', hidden:true},
	                {name:'link',index:'link', hidden:true},
	                {name:'temp1',index:'temp1', hidden:true},
	                {name:'temp2',index:'temp2', hidden:true},
	                {name:'temp3',index:'temp3', hidden:true},
	                {name:'temp4',index:'temp4', hidden:true},
	                {name:'temp5',index:'temp5', hidden:true},
	                {name:'temp6',index:'temp6', hidden:true},
	                {name:'temp7',index:'temp7', hidden:true},
	                {name:'temp8',index:'temp8', hidden:true},
	                {name:'viewStrCd',index:'viewStrCd', hidden:true},
	                {name:'alarm',index:'alarm', hidden:true}
	                
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     rowList:[],
	     pager: '#gridStoreMgntPager',
	     sortname: 'strCd',
	     viewrecords: true,
	     //rowList:[10,20,30,50],
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 360,
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrStrCd:$("#scrStrCd").val(),
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrAlarmYn: $('input:radio[name="scrAlarmYn"]:checked').val()
		 },
		ondblClickRow : function(rowid, iRow, iCol, e) {

			var list = $("#gridStoreMgnt").getRowData(rowid);

			onCheckboxDbClick(rowid);
			
			var target = '3202';
			
			var param  = new Object();

			param.companyCd = $("#scrCompanyCd").val();
			param.strCd     = list.strCd;
			param.strNm     = list.strNm;
			param.viewStrCd = list.viewStrCd;
			
			fncMove(target, param);
		 },		
		 loadComplete : function(data) {
			 
			var list   = $("#gridStoreMgnt").getRowData();
			var rowCnt = list.length;
			
			for(var i=0;i<rowCnt;i++){
				
				var failInfo = "";
				if(list[i].alarmCnt == 0){
					$("#gridStoreMgnt").setCell((i+1),'alarmCnt','<img src="/images/ico_status_normal.png"/>','');	
					$("#gridStoreMgnt").setCell((i+1),'failInfo',' ','');	
				}else{
					$("#gridStoreMgnt").setCell((i+1),'alarmCnt','<img src="/images/ico_status_error.png"/>','');
					
					if(list[i].highTemp != 0){						
						failInfo =  failInfo + "[고온] ";
					}
					if(list[i].lowTemp != 0){						
						failInfo =  failInfo + "[저온] ";
					}
					if(list[i].inSensor != 0){						
						failInfo =  failInfo + "[온도센서] ";
					}
					if(list[i].deSensor != 0){
						failInfo =  failInfo + "[제상센서] ";
					}
					if(list[i].highPressure != 0){						
						failInfo =  failInfo + "[고압] ";
					}
					if(list[i].lowPressure != 0){						
						failInfo =  failInfo + "[저압] ";
					}
					if(list[i].comp != 0){						
						failInfo =  failInfo + "[콤프레셔] ";
					}
					if(list[i].link != 0){						
						failInfo =  failInfo + "[통신] ";
					}					
					if(list[i].alarm != 0){
						failInfo =  failInfo + "[장비이상]";
					}
					
					
					$("#gridStoreMgnt").setCell((i+1),'failInfo',failInfo,'');		
				}
			}	
		}
	 });
	  jqGridResize('gridStoreMgnt');
});

/*******************
1. 기타 필수 스크립트
********************/

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


/*******************
1. 팝업  
********************/

function fncStrSearch(){
	var companyCd = $.trim($("#scrCompanyCd").val());
	var strNm = $.trim($("#scrStrNm").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.strNm = strNm;

	fn_divPop("storeMngSrch", "팝업", 800, 650, args );	
}

function fncSetStore(data){
	$("#scrViewStrCd").val(data.viewStrCd);
	$("#scrStrNm").val(data.strNm);
	$("#scrStrCd").val(data.strCd);
}

function fncStoreClear(){
	$("#scrViewStrCd").val("");
	$("#scrStrNm").val("");
	$("#scrStrCd").val("");
}

function fncOrgSearch(){
	var companyCd  = $("#scrCompanyCd").val();
	
	if( companyCd == '' || companyCd == null ) {
		alert("${smCompanySrch}");
		return false;
	}
	
	var args = new Array();
	
	args.push(companyCd);
	
	fn_divPop("showOrgSrch", "팝업", 800, 650, args );
}

function fncSetOrg(data){
	$("#scrOrgCd").val(data.orgCd);
	$("#scrOrgNm").val(data.orgNm);
}

function fncOrgClear(){
	$("#scrOrgCd").val("");
	$("#scrOrgNm").val("");
}

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
	
	if( $("#scrOrgNm").val() == "" || $("#scrOrgNm").val() == null ) {
		$("#scrOrgCd").val('');
	}

	$("#gridStoreMgnt").setGridParam({
		 datatype: "json",
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrStrCd:$("#scrStrCd").val(),
			 scrOrgCd:$("#scrOrgCd").val(),
			 scrAlarmYn: $('input:radio[name="scrAlarmYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
}
</script>

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
				<th>${smOrg}</th>
				<td colspan="2"><input type='hidden' id='scrOrgCd' name='scrOrgCd' value="" />
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value=""  style="width:140px;" class="r_Input r_disable" readonly="readonly" required/>
						<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" style="cursor:pointer"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncOrgClear();" style="cursor:pointer;right:4px;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>${smStr}</th>
				<td>
					<input type='hidden' id='scrStrCd' name='scrStrCd' value='' />
					<input type='text' id='scrViewStrCd' name='scrViewStrCd' value='${storeStatusVo.viewStrCd}' style="width:100px;" class="r_Input r_disable" readonly />
					<div class="r_innerSearch">
						<input type='text' id='scrStrNm' name='scrStrNm' value='${storeStatusVo.strNm}' style="width:100px;" class="r_Input r_disable" readonly />
						<img src="/images/ico_innerSearch.png" alt="inner search" id="innerSearch"  onclick="javascript:fncStrSearch();" style="cursor:pointer"/>
						<img src="/images/ico_remove2.png" alt="inner search"  onclick="javascript:fncStoreClear();" style="cursor:pointer;right:4px;"/>
					</div>
				</td>
				<th>${smAlarm}</th>
				<td>
					<span class="r_radio">
						<input type='radio' id="scrAlarmYn1" name='scrAlarmYn' value='Y'/><label for="scrAlarmYn1">${smAlarm}</label>&nbsp;
						<input type='radio' id="scrAlarmYn2" name='scrAlarmYn' value='N' /><label for="scrAlarmYn2">${smAll}</label>
					</span>
				</td>
			</tr>
		</table>
		<span class="search">
	       	<button onclick="javascript:fncSearch()">${smRetrieve}</button>
		</span>
	</div>    
	<div class="r_grid">		
		<table id="gridStoreMgnt"><tr><td></td></tr></table>
		<div id="gridStoreMgntPager"></div>
	</div>
</div>