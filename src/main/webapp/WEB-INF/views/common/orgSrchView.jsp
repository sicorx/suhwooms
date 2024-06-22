<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var='sm_orgTree'><spring:message code='orgTree'/></c:set>
<c:set var="smStrCd"><spring:message code="strCd" /></c:set>
<c:set var="smStrNm"><spring:message code="strNm" /></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve" /></c:set>
<c:set var="smCnfm"><spring:message code="cnfm" /></c:set>
<c:set var="smClos"><spring:message code="clos" /></c:set>

<style type="text/css">
#treeDiv {
    overflow:auto;
    height:380px;
}
#tree {
    background-color: white;
    width: 700px;
    border: 0;
}
</style>
    
<script type="text/javascript">
// 트리
$(function () {
    $("#tree").fancytree({
        quicksearch: true,     // Jump to nodes when pressing first character
        source: ${orgJson},
        extensions: ["filter"],
        filter: {
          autoApply: true,   // Re-apply last filter if lazy data is loaded
          autoExpand: false, // Expand all branches that contain matches while filtered
          counter: true,     // Show a badge with number of matching child nodes near parent icons
          fuzzy: false,      // Match single characters in order, e.g. 'fb' will match 'FooBar'
          hideExpandedCounter: true,  // Hide counter badge if parent is expanded
          hideExpanders: false,       // Hide expanders if all child nodes are hidden by filter
          highlight: true,   // Highlight matches by wrapping inside <mark> tags
          leavesOnly: false, // Match end nodes only
          nodata: true,      // Display a 'no data' status node if result is empty
          mode: "dimm"       // Grayout unmatched nodes (pass "hide" to remove unmatched node instead)
        },
        activate: function(event, data) {
          $("#choOrgCd").val($.trim(data.node.key));
          $("#choOrgNm").val($.trim(data.node.title));
        }
    });

    $("input[name=search]").keyup(function(e) {
        var n,
          tree = $.ui.fancytree.getTree(),
          args = "autoApply autoExpand fuzzy hideExpanders highlight leavesOnly nodata".split(" "),
          opts = {},
          filterFunc = $("#branchMode").is(":checked") ? tree.filterBranches : tree.filterNodes,
          match = $(this).val();

        $.each(args, function(i, o) {
            opts[o] = $("#" + o).is(":checked");
        });
        opts.mode = $("#hideMode").is(":checked") ? "hide" : "dimm";

        if(e && e.which === $.ui.keyCode.ESCAPE || $.trim(match) === ""){
            $("button#btnResetSearch").click();
            return;
        }
        if($("#regex").is(":checked")) {
            // Pass function to perform match
            n = filterFunc.call(tree, function(node) {
                return new RegExp(match, "i").test(node.title);
            }, opts);
        } else {
            // Pass a string to perform case insensitive matching
            n = filterFunc.call(tree, match, opts);
        }
        $("button#btnResetSearch").attr("disabled", false);
        $("span#matches").text("(" + n + " matches)");
    }).focus();

    $("button#btnResetSearch").click(function(e){
      $("input[name=search]").val("");
      $("span#matches").text("");
      tree.clearFilter();
    }).attr("disabled", true);
});

/*******************
1. 선행, 등록 스크립트
********************/

$(document).ready(function(){
	
	$('#dialog-confirm').css('overflow', 'hidden');
	
	// 전체 펼치기
	$("#tree").fancytree("getRootNode").visit(function(node){
		node.setExpanded(true);
	});

	// 필터 바로 적용
	$("input[name=search]").keyup();
});

// 선택
function fncConfirm() {
	var orgCd = $.trim($("#choOrgCd").val());	// 조직 선택된 코드
	var orgNm = $.trim($("#choOrgNm").val());	// 조직 선택된 명
	if (orgCd == "") {
		alert("조직을 먼저 선택하세요.");
		return false;
	}
	
	var param = new Object();
	param.orgCd = orgCd;
	param.orgNm = orgNm;

	fncSetOrg(param);	
	fncDivPop1Close();
}

function fncCancel() {
	fncDivPop1Close();
}
</script>
<div class="r_popup">

	<!-- 팝업 타이틀 -->
	<!-- <h2 class="r_popupTitle">조직조회</h2> -->
	<!-- //팝업 타이틀 -->
	
	<div class="r_popupCont">
		<!-- 조회조건 -->
		<div class="r_search multiLine">
			<table>
				<tr>
					<th>매장명/코드</th>
					<td>
						<input type='search' id='search' name='search' placeholder="Filter..." autocomplete="off" value="${orgNm}" />
						
					</td>
				</tr>
			</table>
		</div>
		<!-- //조회조건 -->
		
		<!-- 트리 영역 -->
		<input type="hidden" id="choOrgCd" name="choOrgCd" /><!-- 선택한 조직 코드 -->
		<input type="hidden" id="choOrgNm" name="choOrgNm" /><!-- 선택한 조직 명 -->
		<div id="treeDiv">
			<div id="tree"></div>
		</div>
		<!-- //트리 영역 -->
		
	</div>
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_pageBtnWrapper">
		<span class="pageNormal">
			<button onclick="javascript:fncCancel()">${smClos}</button>
		</span>
		<span class="pageNormal">
			<button onclick="javascript:fncConfirm()">선택</button>
		</span>
	</div>
	<!-- //하단 버튼 그룹 -->

</div>