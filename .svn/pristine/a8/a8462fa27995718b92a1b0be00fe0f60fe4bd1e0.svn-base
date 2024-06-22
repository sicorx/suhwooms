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

$(document).ready(function(){
	
});

</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<!-- <h2 class="r_popupTitle">공지사항</h2> -->
	<!-- //팝업 타이틀 -->
	
	<!-- 닫기 버튼 -->
<!-- <p class="close_popup"><a href="" title="팝업창닫기"><img src="/images/btn_close_popup.png" alt="당기" /></a></p> -->
	<!-- //닫기버튼 -->
	
	<!-- 팝업 본문 -->
	<div class="r_popupCont_notice">
		<h3>[${noticeDtl.noticeTypeNm}] [${noticeDtl.title}]</h3>
		<div class="notice_popup_title">
			<p class="p1">${noticeDtl.pubAuthNm}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${noticeDtl.pubDttm}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;게시기간 ${noticeDtl.pubStartDt} ~ ${noticeDtl.pubEndDt}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회 <span>${noticeDtl.viewCnt}</span></p>
		</div>
		<div class="notice_popup_body">
			<textarea id="contents" name="contents" rows="20" cols="40" style="width:100%;" readonly="readonly">${noticeDtl.contents}</textarea>
		</div>
		
		<!-- 버튼 그룹 -->
		<div class="r_pageBtnWrapper">
			<span class="pageNormal">
				<button onclick="javascript:fncCancel()">${smClos}</button>
			</span>
		</div>
		<!-- //버튼 그룹 -->
		
	</div>
	<!-- //팝업 본문 -->
	
</div>
