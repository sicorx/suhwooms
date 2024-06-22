<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<c:set var="smRequired"><spring:message code="valid_required"/></c:set>
<c:set var="smRemote"><spring:message code="valid_remote"/></c:set>
<c:set var="smEmail"><spring:message code="valid_email"/></c:set>
<c:set var="smUrl"><spring:message code="valid_url"/></c:set>
<c:set var="smDate"><spring:message code="valid_date"/></c:set>
<c:set var="smDateISO"><spring:message code="valid_dateISO"/></c:set>
<c:set var="smNumber"><spring:message code="valid_number"/></c:set>
<c:set var="smDigits"><spring:message code="valid_digits"/></c:set>
<c:set var="smCreditcard"><spring:message code="valid_creditcard"/></c:set>
<c:set var="smEqualTo"><spring:message code="valid_equalTo"/></c:set>
<c:set var="smAccept"><spring:message code="valid_accept"/></c:set>
<c:set var="smMaxlength"><spring:message code="valid_maxlength"/></c:set>
<c:set var="smMinlength"><spring:message code="valid_minlength"/></c:set>
<c:set var="smRangelength"><spring:message code="valid_rangelength"/></c:set>
<c:set var="smRange"><spring:message code="vaild_range"/></c:set>
<c:set var="smMax"><spring:message code="valid_max"/></c:set>
<c:set var="smMin"><spring:message code="valid_min"/></c:set>


<script type="text/javascript">

jQuery.extend(jQuery.validator.messages,{
	required:'${smRequired}',
	remote: '${smRemote}',
	email: '${smEmail}',
	url: '${smUrl}',
	date: '${smDate}',
	dateISO: '${smDateISO}',
	number: '${smNumber}',
	digits: '${smDigits}',
	creditcard: '${smCreditcard}',
	equalTo: '${smEqualTo}',
	accept: '${smAccept}',
	maxlength: $.validator.format('${smMaxlength}'),
	minlength: $.validator.format('${smMinlength}'),
	rangelength: $.validator.format('${smRangelength}'),
	range: $.validator.format('${smRange}'),
	max: $.validator.format('${smMax}'),
	min: $.validator.format('${smMin}')	
});
</script>

