<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="smSeq"><spring:message code="seq"/></c:set>
<c:set var="smSelect"><spring:message code="select"/></c:set>
<c:set var="smOrg"><spring:message code="org"/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smStr"><spring:message code="str" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>
<c:set var="smStrInq"><spring:message code="strInq" /></c:set>

<script type="text/javascript">

/*******************
1. 기타 필수 전역 변수
********************/

var popParam = new Object();

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	$("#companyCd").val('${companyCd}');
	
	$("#gridStoreSrch").jqGrid({
		url : 'retrieveStoreSrch',
		datatype : "json",
		mtype : 'POST',
		async: false,
		cache: false,
		colNames : [ '${smSeq}', '${smOrg}', '${smStrCd}', '${smStrNm}', 'strCd' ],
		colModel : [ {
			name : 'records',
			index : 'records',
			width : 50,
			align : 'center',
			sortable : true,
			editable : false,
			editoptions : {
				readonly : true,
				size : 10
			}
		},
		{
			name : 'orgNm',
			index : 'orgNm',
			width : 100,
			align : 'center',
			sortable : true,
			editable : false
			}, {
			name : 'viewStrCd',
			index : 'viewStrCd',
			width : 100,
			align : 'center',
			sortable : true,
			editable : false,
			editoptions : {
				readonly : true,
				size : 10
				}
			}, 
			{
				name : 'strNm',
				index : 'strNm',
				width : 200,
				align : 'left',
				sortable : true,
				editable : false
			}, {
				name : 'strCd',
				index : 'strCd',
				hidden : true
			} ],
			jsonReader : {
				repeatitems : false
			},
			rowNum : 10,
			rowList : [],
			sortname : 'strCd',
			viewrecords : true,
			sortorder : "asc",
			hidegrid : false,				
			shrinkToFit : true,
			//autowidth: true,
			width: '700',
			height : 230,
			pager : '#gridStoreSrchPager',
			postData : {
				srchCompanyCd : $("#companyCd").val(),
				srchViewStrCd : $("#viewStrCd").val(),
				srchStrNm : $("#strNm").val()
			},
			onCellSelect : function(rowid, iCol) {
				var list = $("#gridStoreSrch").getRowData(rowid);
				popParam.strCd     = list.strCd;
				popParam.strNm     = list.strNm;
				popParam.viewStrCd = list.viewStrCd;
			},
			ondblClickRow : function(rowid, iRow, iCol, e) {
				var list = $("#gridStoreSrch").getRowData(rowid);
				popParam.strCd     = list.strCd;
				popParam.strNm     = list.strNm;
				popParam.viewStrCd = list.viewStrCd;
				
				fncConfirm();
			},
			gridComplete : function(data) {
				 jqGridEven('gridStoreSrch');	
			}				
		}).trigger("reloadGrid");		
	
});


/*******************
1. 기타 필수 스크립트
********************/

function fncStrPopupSearch() {
	
	$("#gridStoreSrch").setGridParam({"page":1});		// 1페이지로 이동
	$("#gridStoreSrch").setGridParam({
		datatype : "json",
		postData : {
			srchViewStrCd : $("#viewStrCd").val(),
			srchStrNm : $("#strNm").val()
		}
	}).trigger("reloadGrid");	
}

/*******************
1. 조회 
2. 생성
3. 갱신
4. 삭제  
********************/

function fncConfirm() {
	fncSetStore(popParam);	
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
	
}

function fncCancel() {
	fncDivPop1Close();
	//fncDivPop2Close();		// 주영추가 ( 창이 안닫혀서 모든걸 닫어버리자는 차원)
	//$("#dialog-confirm-2nd").dialog("close");
}
</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<h2 class="r_popupTitle">매장요약정보</h2>
	<!-- //팝업 타이틀 -->
	
	<!-- 닫기 버튼 -->
	<p class="close_popup"><a href="#" title="팝업창닫기"><img src="/images/btn_close_popup.png" alt="당기" /></a></p>
	<!-- //닫기버튼 -->
	
	<!-- 팝업 본문 -->
	<div class="r_popupCont_pop">
		<div class="dashboard_popup_title">
			<h3 class="shop_name">DDMC점</h3>
			<ul>
				<li class="shop_code">VO395</li>
				<li class="shop_address">OO시 마포구 매봉산로 75</li>
				<li class="shop_tel">02-OOO-OOOO</li>
			</ul>
		</div>
		<div class="dashborad_popup_body">
		
			<!-- 위젯 -->
			<h3 class="blind">위젯으로 전체 현황 보기</h3>
			<ul class="pop_widgets">
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
			<div class="pop_dashboard_body">
			
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
		
		<!-- 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
			<span class="pageNormal detail">
				<button onclick="javascript:fncConfirm()">상세정보</button>
			</span>
		</div>
		<!-- //버튼 그룹 -->
		
	</div>
	<!-- //팝업 본문 -->
	
</div>
