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
/*******************
1. 선행, 등록 스크립트
********************/
var selTab;


$(document).ready(function(){
	
	  //탭
	  $('.tab_tab').click(function(e) {
		  e.preventDefault();
		  if (selTab) $("#" + selTab).attr("style", "display:none;");
		  $(this).tab('show');
	
	  }).on('shown', function(e) {
		  var id = $(this).attr('id');
		  var selId = id.substring(0, id.length - "_tab".length);
		  $("#" + selId).attr("style", "display:block;");
		  selTab = selId;
	  });
	
	$('input:radio[name="scrUseYn"]').eq(0).attr('checked', true);
	
	
	  $("#gridVendorMgnt").jqGrid({
	      url:'retrieveVendorMgnt',
	      datatype: "json",
	      postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrVendorNm:$("#scrVendorNm").val(),
			 scrUseYn: $(':radio[name="scrUseYn"]:checked').val()
		  },
	      mtype: 'POST',
	      colNames:['No', '업체코드', '업체명', '사용여부', '최종 수정자', '최종수정일시', '회사코드', '사용여부코드'],
	      colModel:[
	                {name:'records',index : 'records',width : 50,align : 'center', sortable:false, editable : false,editoptions : {readonly : true,size : 10}},
	                {name:'vendorCd',index:'vendorCd', width:85, align:'center', sortable:true, editable:false},
	                {name:'vendorNm',index:'vendorNm', width:85, align:'center', sortable:true, editable:false},
	                {name:'useYnNm',index:'useYnNm', width:30, align:'center', sortable:true, editable:false},
	                {name:'finalUserNm',index:'finalUserNm', width:50, align:'center', sortable:false, editable:false},
	                {name:'finalModDttm',index:'finalModDttm', width:93, align:'center', sortable:false, editable:false},
	                {name:'companyCd',index:'companyCd', hidden:true},
	                {name:'useYn',index:'useYn', hidden:true}
	           ],
	     jsonReader : {
	          repeatitems:false
	     },
	     rowNum:20,
	     rowList:[10,20,50,100],
	     pager: '#gridVendorMgntPager',
	     recordtext: "건/페이지  (전체 {2} 건)",
		 emptyrecords : "검색 결과가 존재하지 않습니다.",
		 loadtext: "Loading...",
	     sortname: 'vendorNm',
	     viewrecords: true,
	     sortorder: "asc",	     
	     hidegrid: false,
	     shrinkToFit:true,
		 autowidth:true,
		 height : 260,
		 onSelectRow : function(rowid, iRow, iCol, e) {
			 var list = $("#gridVendorMgnt").getRowData(rowid);
			 
			 // 수정
			 fncUpt(list);
		}
	 });
	  //jqGrid Resize	
	  jqGridResize('gridVendorMgnt');
	  
	  // 최초 신규버튼 클릭
	  fncAdd();
	  
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
	
	// 엔터 키 이벤트
	$("input[name='scrVendorNm']").keydown(function (key) {
		if (key.keyCode == 13) {
			fncSearch();
        }
    });
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
	
	$("#gridVendorMgnt").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridVendorMgnt").setGridParam({
		 postData : {
			 scrCompanyCd:$("#scrCompanyCd").val(),
			 scrVendorNm:$("#scrVendorNm").val(),
			 scrUseYn: $('input:radio[name="scrUseYn"]:checked').val()
		 }
	 }).trigger("reloadGrid");
	
}

// 신규
function fncAdd() {	
	var companyCd = $.trim($("#scrCompanyCd").val());
	var companyNm = $.trim($("#scrCompanyNm").val());

	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = false;
	oldVendorCd = "";
	$('#dupMsg').html('');
	
	$("#vendorCd").val("").attr("readonly", false);
	$(".innerBtn").show();
	$("#vendorNm").val("");
	$("input:radio[name='useYn']:input[value='Y']").prop("checked", true);	
}

// 수정
function fncUpt(list) {
	var companyCd = $.trim(list.companyCd);
	var companyNm = $.trim($("#scrCompanyNm").val());
	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	$("#companyCd").val(companyCd);
	
	dupChk = true;
	oldVendorCd = "";
	$('#dupMsg').html('');
	 
 	var vendorCd = $.trim(list.vendorCd);
	$("#vendorCd").val(vendorCd).attr("readonly", true);
	$(".innerBtn").hide();
	var vendorNm = $.trim(list.vendorNm);
	$("#vendorNm").val(vendorNm);
 	var useYn = $.trim(list.useYn);
 	$("input:radio[name='useYn']:input[value='" + useYn + "']").prop("checked", true);	
}

// 중복확인 초기화
function fncDupInit() {
	if (oldVendorCd != $('#vendorCd').val()) {
		dupChk = false;
		$('#dupMsg').html('');
	}
}

// 중복확인
function fncVendorCdDupChk(){
	
	if($('#vendorCd').valid()){
		
		oldVendorCd = vendorCd;
		
		var companyCd = $('#companyCd').val();
		var vendorCd = $('#vendorCd').val();
		
		$.ajax({
			url:'/checkVendorCd',
			type:'POST',
			cache:false,
			data : {companyCd:companyCd,vendorCd:vendorCd},
			dataType:'json',
			success:function(data){		
				if(data == true ){
					$('#dupMsg').html('사용 가능');
					dupChk = true;
				}else{
					$('#dupMsg').html('중복 정보');
					dupChk = false;
				}
			},
			error:function(result){
				$('#dupMsg').html('에러 발생');
				dupChk = false;
			}
		});
	}
}

// 저장
function fncSave() {
	if ($('#saveForm').valid()) {
		
		if (!dupChk) {
			$('#dupMsg').html('${smCommMsgDupChk}');
			return;
		}
		
		if (confirm("${smCommMsgSaveCnf}")) {
			$.ajax({
				url:'/saveVendorMgnt',
				type:'POST',
				cache:false,
				data:$('#saveForm').serialize(),
				dataType:'json',
				success:function(data){
					alert('${smCommMsgSave}');
					fncSearch();
				},
				error:function(result){
					alert("에러가 발생했습니다.");
				}
			});
		}
	}
}

// 삭제
function fncDel() {
	var selrow = $.trim($("#gridVendorMgnt").getGridParam("selrow"));	// 선택된 로우
	var vendorCd = $.trim($("#vendorCd").val());						// 선택된 업체코드
	if (selrow == "" || vendorCd == "") {
		alert("삭제할 행을 선택하세요.");
		return false;
	}
	
	if(confirm("선택한 행을 삭제하시겠습니까?")){
		$.ajax({
			url:'/deleteVendorMgnt',
			type:'POST',
			cache:false,
			data:$('#saveForm').serialize(),
			dataType:'text',
			success:function(data){
				if (data == "DENY") {
					alert("등록된 엔지니어가 있어서 삭제가 불가합니다.");
				} else {
					alert('${smCommMsgDel}');
					fncSearch();	
				}
			},
			error:function(result){
				alert("에러가 발생했습니다.");
			}				
		});
	}
}
</script>

<div id="loadingArea">

	<!-- 조회조건 -->
	<div class="r_search multiLine">
		<c:if test="${selectVoListCnt == 1 }">
			<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
			<input type='text' id='scrCompanyNm' name='scrCompanyNm' style='width:100px;display:none;' value='${userVo.companyNm}' class='r_Input r_disable' readonly='readonly'/>
		</c:if>
		<c:if test="${selectVoListCnt > 1 }">			
			<select id="scrCompanyCd" name="scrCompanyCd" style="width:112px;display:none;" class="searchSelect">
				<option value=''>--선택--</option>
					<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
						<option value='${vo.value}'>${vo.name}</option>
					</c:forEach>
			</select>
		</c:if>
		<table>
			<tr>
				<th>매장명/코드</th>
				<td>
					<div class="r_innerSearch">
						<input type='text' id='scrOrgNm' name='scrOrgNm' value="" style="width:118px;" class="r_Input r_disable" required />
						<img src="/images/ico_remove2.png" alt="inner search" onclick="javascript:fncOrgClear();" style="cursor:pointer; right:4px;"/>
					</div>
					<img src="/images/ico_innerSearch.png" alt="inner search"  onclick="javascript:fncOrgSearch();" class="icon_search" />
					<input type='text' id='' name='scrOrgNm' value="" style="width:51px;" class="r_Input r_disable" readonly="readonly" required />
					<input type='text' id='' name='scrOrgNm' value="" style="width:188px;" class="r_Input r_disable" readonly="readonly" required />
					<input type='text' id='' name='scrOrgNm' value="" style="width:188px;" class="r_Input r_disable" readonly="readonly" required />
				</td>
			</tr>
		</table>
		<span class="search">
	        <button onclick="javascript:fncSearch()">Search</button>
	    </span>
	</div>
	<!-- //조회조건 -->
	
	<!-- 탭 전체 그룹 -->
	<div class="tab_group">
		<ul class="nav nav-tabs" id="myTab">
		  <li class="active"><a href="#a" id="a_tab" class="tab_tab" onfocus="this.blur()">Dashboard</a></li>
		  <li><a href="#b" id="b_tab" class="tab_tab" onfocus="this.blur()">에너지사용현황</a></li>
		  <li><a href="#c" id="c_tab" class="tab_tab" onfocus="this.blur()">계약전력</a></li>
		  <li><a href="#d" id="d_tab" class="tab_tab" onfocus="this.blur()">시설물현황</a></li>
		  <li><a href="#e" id="e_tab" class="tab_tab" onfocus="this.blur()">알림현황(3)</a></li>
		</ul>
		 
		<div class="tab-content">
		  <div class="tab-pane dashboard active" id="a">
		  
			<!-- 위젯 -->
			<h3 class="blind">위젯으로 전체 현황 보기</h3>
			<ul class="tab_widgets">
				<li class="date_weather_group">
					<!-- 날짜 -->
					<div class="date">
						<h4 class="blind">날짜</h4>
						<p class="year_month">2016년/12월</p>
						<p class="day">16<span class="blind">일</span></p>
						<p class="week_time">금요일/01:52pm</p>
					</div>
					<!-- //날짜 -->
					<!-- 날씨 -->
					<div class="weather">
						<h4 class="blind">날씨</h4>
						<p class="icon_weather"><img src="/images/icon_weather.png" alt="비옴" /></p>
						<h5 class="outside">실외</h5>
						<p class="outside_temperature">6.4℃</p>
						<h5 class="interior">실내</h5>
						<p class="interior_temperature">19.4℃</p>
					</div>
					<!-- //날씨 -->
				</li>
				<li><img src="/images/tab_line_widgets_01.png" alt="" /></li>
				<li class="air_heat">
					<p class="off">OFF</p>
					<h4>냉난방</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="refrigerator">
					<p class="on">정상</p>
					<h4>냉장비</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="sign">
					<p class="on">ON</p>
					<h4>간판</h4>
				</li>
				<li><img src="/images/tab_line_widgets_02.png" alt="" /></li>
				<li class="sems">
					<p class="on">정상</p>
					<h4>SEMS</h4>
				</li>
			</ul>
			<!-- //위젯 -->
		  	
		  	<!-- 대시보드 본문 -->
			<div class="tab_dashboard_body">
			
				<!-- 1단 -->
				<div class="level_01">
			
					<!-- 에너지사용량 -->
					<div class="energy_area">
						<h3>에너지사용량</h3>
						<p class="btn_month_day">
							<a href="#" title="day"><img src="images/btn_month.png" alt="month" /></a>
							<!-- <a href="#" title="month"><img src="images/btn_day.png" alt="month" /></a> -->
						</p>
						<div class="table_block">
							<ul class="energy_list">
								<li>
									<p class="title"><span class="pr_10">매장계약전력(kw)</span></p>
									<p class="num_gray"><span class="pl_10">23</span></p>
								</li>
								<li>
									<p class="title"><span class="pr_10">지난달(kwh)</span></p>
									<p class="num_gray"><span class="pl_10">3,203</span></p>
								</li>
								<li>
									<p class="title"><span class="pr_10">이번달(kwh)</span></p>
									<p class="num_blue"><span class="pl_10">1,561</span></p>
								</li>
								<li>
									<p class="title"><span class="pr_10">이번달 예측(kwh)</span></p>
									<p class="num_gray"><span class="pl_10">3,621</span></p>
								</li>
								<li>
									<p class="inquiry_time">조회시간 : 2016/12/19 10:20</p>
								</li>
							</ul>
							<div class="graph_area">
								<img src="/images/sample_graph_03.png" alt="샘플 그래프" />
							</div>
						</div>
						
					</div>
					<!-- //에너지사용량 -->
					
				</div>
				<!-- //1단 -->
				
				<!-- 2단 -->
				<div class="level_02">
			
					<!-- 시설물 알림 처리현황 -->
					<div class="message_condition">
						<h3>시설물 알림 처리현황</h3>
						<ul class="graph_area">
							<li>
								<div class="graph"><img src="/images/sample_graph_04.png" alt="샘플 그래프" /></div>
							</li>
							<li>
								<div class="inactions">
									<h4 class="title_inactions">미조치</h4>
									<p class="num_Inactions">7</p>
								</div>
							</li>
							<li>
								<div class="action">
									<h4 class="title_action">조치완료</h4>
									<p class="num_action">3</p>
								</div>
							</li>
							<li>
								<div class="total">
									<h4 class="title_total">총건수</h4>
									<p class="num_total">10</p>
								</div>
							</li>
						</ul>
					</div>
					<!-- //시설물 알림 처리현황 -->

					<!-- 시설물현황 -->
					<div class="use_condition">
						<h3>시설물현황</h3>
						<div class="table_use_condition">
							<table summery="이 표에서는 계약전력 사용현황을 보여줍니다.">
								<caption>계약전력 사용현황 표</caption>
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
								<tr>
									<th>장비명</th>
									<th>온도</th>
									<th>상태</th>
									<th>최근한달알림</th>
									<th>그래프보기</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td class="tleft">WIC</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">OSC1</td>
									<td>8.0℃</td>
									<td><span class="pink">이상</span></td>
									<td><span class="pink">2</span></td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">OSC2</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">INV_WIC</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">INV_OSC(좌)</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								<tr>
									<td class="tleft">INV_OSC(우)</td>
									<td>8.0℃</td>
									<td>정상</td>
									<td>0</td>
									<td class="tcenter"><a href="#" title="그래프보기"><img src="images/icon_graph.png" alt="그래프" /></a></td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //시설물현황 -->
					
				</div>
				<!-- //2단 -->
				
			</div>
			<!-- //대시보드 본문 -->
		  	
		  </div>
		  <div class="tab-pane" id="b" style="display:none;">
		  
			  <!-- 탭  조회조건 -->
			  <div class="r_search multiLine">
				<table>
					<tr>
						<th>기간</th>
						<td>
							<input id="search_dateFrom" type="text" placeholder="2017-01-11" value='${scrValue.scrDateFrom}' style="width:80px;" readonly />
							~ <input id="search_dateTo" type="text" placeholder="2017-01-11" value='${scrValue.scrDateTo}'style="width:80px;" readonly />
							<!-- <button onclick="javascript:func_AllBtn();" class="ml_5">전체</button> -->
					   		<button onclick="javascript:func_monthBtn(1);">1m</button>
					   		<button onclick="javascript:func_monthBtn(6);">6m</button>
					   		<button onclick="javascript:func_monthBtn(12);">1y</button>
						</td>
					</tr>
				</table>
				<span class="search">
			        <button onclick="javascript:fncSearch()">Search</button>
			    </span>
			</div>
			<!-- //탭  조회조건 -->
			
			<!-- 좌우그리드그룹 -->
			<div class="r_halfGridContainer">
				<div class=r_oneThirdGrid_l2>
					<div class="r_grid r_inputTblTitle mt_10">
						<h3>월별 전력량</h3>
					</div>
					<div class="r_grid">
						<table id="gridUserList"><tr><td></td></tr></table>
						<div id="gridUserListPager"></div>
					</div>
				</div>
				<div class=r_twoThirdGrid_l2>
					<div class="r_grid r_inputTblTitle mt_10">
						<h3>일별 전력량</h3>
					</div>
					<div class="r_grid">
						<table id="gridStoreMgnt"><tr><td></td></tr></table>
					</div>
				</div>
			</div>
			<!-- //좌우그리드그룹 -->
			
			<!-- 그래프 영역 -->
			<div class="common_section">
				<div class="common_section_title">
					<h3 class="float_n">월별 온실가스 배출 현황</h3>
				</div>
				<div class="graph_area">그래프 영역</div>
			</div>
			<!-- //그래프 영역 -->
		  
		  </div>
		  <div class="tab-pane" id="c" style="display:none;">c</div>
		  <div class="tab-pane" id="d" style="display:none;">d</div>
		  <div class="tab-pane" id="e" style="display:none;">e</div>
		</div>
		
	</div>
	<!-- 탭 전체 그룹 -->
	
</div>