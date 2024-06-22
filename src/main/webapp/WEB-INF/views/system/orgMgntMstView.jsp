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

<!-- 페이지 사용 - jooyoung -->
<style type="text/css">
.ui-menu {
    width: 180px;
    font-size: 63%;
}
.ui-menu kbd { /* Keyboard shortcuts for ui-contextmenu titles */
    float: right;
    background-color: transparent;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    box-shadow: none;
    box-sizing: content-box;
    color: #222222;
    cursor: pointer;
    font-family: monospace;
    line-height: normal;
    padding-bottom: 0;
    padding-left: 0;
    padding-right: 0;
    padding-top: 0;
}
.r_halfGridContainer {
    height:600px;
}
#treeDiv {
    overflow:auto;
    height:570px;
}
#tree {
    background-color: white;
    border: 0;
}
table.fancytree-ext-table tbody tr td {
    border: 0;
}
td input[name=orgCd] {
    width: 90px;
}
.noUse {
    opacity: 0.35;
}
</style>
<script type="text/javascript">
var nodeObjList = {};
var newIndex = 0;

var CLIPBOARD = null;

<c:if test="${empty orgList}">
newIndex++;
nodeObjList['N' + newIndex] = {orgNm: '새조직_' + newIndex, orgCd: 'orgCd_' + newIndex, useYn: 'Y'};
</c:if>
<c:forEach items="${orgList}" var="node">
nodeObjList['${node.orgCd}'] = {orgCd:'${node.orgCd}', orgNm:'${node.orgNm}', indexHier:'${node.indexHier}', useYn:'${node.useYn}'};
</c:forEach>

$(window).resize(function(){



    $("#gridStoreMgnt").setGridWidth($("#cont").width());


}).resize();


$(function () {
    $("#tree").fancytree({
        checkbox: false,
        titlesTabbable: true,   // Add all node titles to TAB chain
        quicksearch: false,     // Jump to nodes when pressing first character
        source: ${orgJson},
        extensions: ["edit", "dnd", "table", "gridnav"],
        dnd: {
            preventVoidMoves: true,
            preventRecursiveMoves: true,
            autoExpandMS: 400,
            dragStart: function (node, data) {
                return true;
            },
            dragEnter: function (node, data) {
                return true;
            },
            dragDrop: function (node, data) {
                data.otherNode.moveTo(node, data.hitMode);
            }
        },
        edit: {
            triggerStart: ["f2", "shift+click", "mac+enter"],
            close: function (event, data) {
                if (data.save && data.isNew) {
                    // Quick-enter: add new nodes until we hit [enter] on an empty title
                    // $("#tree").trigger("nodeCommand", {cmd: "addSibling"});
                }
            }
        },
        table: {
            indentation: 20,
            nodeColumnIdx: 0
        },
        gridnav: {
            autofocusInput: false,
            handleCursorKeys: true
        },
        createNode: function (event, data) {
        },
        renderColumns: function (event, data) {
            var node = data.node,
                $tr = $(node.tr),
                $tdList = $tr.find(">td"),
                nodeObj = nodeObjList[node.key];

            nodeObj.indexHier = node.getIndexHier(".", 2);

            $tr.attr("id", "tr" + node.key);

            $tdList.eq(0).attr('id', 'orgNm' + node.key);
           // $tdList.eq(1).html("<span class='r_radio'><input type='text' id='orgCd" + node.key + "' name='orgCd' value='" + node.key + "' title='조직코드' maxlength='100' class='c_orgCd' readonly /></span>");

            if (nodeObj.useYn === 'Y') {
                $tdList.eq(1).html("<select name='useYn' title='사용여부' id='useYn" + node.key + "' class='c_useYn'><option value='Y' selected>사용</option><option value='N'>미사용</option></select>");
            } else {
                $tdList.eq(0).addClass('noUse');
                $tdList.eq(1).html("<select name='useYn' title='사용여부' id='useYn" + node.key + "' class='c_useYn'><option value='Y'>사용</option><option value='N' selected>미사용</option></select>");
            }

            $('#useYn' + node.key).change(function () {
                var value = $(this).find("option:selected").val();
                var key = $(this).attr('id').substring("useYn".length);

                if (value == 'Y') {
                    $('#orgNm' + key).removeClass("noUse");
                } else {
                    $('#orgNm' + key).addClass("noUse");
                }
            });
        },
        activate: function (event, data) {
        	var node = data.node;
        	var orgCd = $.trim(node.key);
        	var useYn = $.trim($("#useYn" + node.key).val());
        	
        	if (useYn == "Y" && orgCd.substring(0, 1) != "N") {
        		// 매장목록
        		$("#srcOrgCd").val(node.key);
        		fncStrMapSearch();
        	}
        }
    }).on("nodeCommand", function (event, data) {
        var refNode,
            tree = $(this).fancytree("getTree"),
            node = tree.getActiveNode();
        var nodeObj = nodeObjList[node.key];

        switch (data.cmd) {
            case "moveUp":
                refNode = node.getPrevSibling();
                if (refNode) {
                    node.moveTo(refNode, "before");
                    node.setActive();
                }
                break;
            case "moveDown":
                refNode = node.getNextSibling();
                if (refNode) {
                    node.moveTo(refNode, "after");
                    node.setActive();
                }
                break;
            case "indent":
                refNode = node.getPrevSibling();
                if( refNode ) {
                    node.moveTo(refNode, "child");
                    refNode.setExpanded();
                    node.setActive();
                }
                break;
            case "outdent":
                if( !node.isTopLevel() ) {
                    node.moveTo(node.getParent(), "after");
                    node.setActive();
                }
                break;
            case "rename":
                node.editStart();
                break;
            case "remove":
                refNode = node.getNextSibling() || node.getPrevSibling() || node.getParent();
                removeNode(node);
                if (refNode) {
                    refNode.setActive();
                }
                break;
            case "addChildMenu":
                newIndex++;
                nodeObjList['N' + newIndex] = {orgNm: '새조직_' + newIndex, orgCd: 'orgCd_' + newIndex, useYn: 'Y'};
                node.editCreateNode("child", {title: '새조직_' + newIndex, key: 'N' + newIndex});
                break;
            case "addSibling":
                newIndex++;
                nodeObjList['N' + newIndex] = {orgNm: '새조직_' + newIndex, orgCd: 'orgCd_' + newIndex, useYn: 'Y'};
                node.editCreateNode("after", {title: '새조직_' + newIndex, key: 'N' + newIndex});
                break;
            case "cut":
            case "copy":
                CLIPBOARD = {mode: data.cmd, data: node};
                break;
            case "clear":
                CLIPBOARD = null;
                break;
            case "paste":
                if (CLIPBOARD.mode === "cut") {
                    CLIPBOARD.data.moveTo(node, "child");
                    CLIPBOARD.data.setActive();
                } else if (CLIPBOARD.mode === "copy") {
                    var child = CLIPBOARD.data.toDict(true, function (dict) {
                        var nodeKey = dict.key;
                        var orgObj = nodeObjList[nodeKey];
                        console.log("nodeKey:", nodeKey);

                        newIndex++;
                        dict.key = 'N' + newIndex;
                        dict.title = "Copy of " + dict.title;

                        var dictKey = dict.key;

                        nodeObjList[dictKey] = {orgCd: dictKey, orgNm: dict.title, useYn: $('#useYn' + nodeKey).val()};
                        console.log("nodeObjList[" + dictKey + "]:", nodeObjList[dictKey]);
                    });

                    node.addChildren(child).setActive();
                }
                break;
            default:
                alert("Unhandled command: " + data.cmd);
                return;
        }

    }).on("keydown", function (e) {
        var cmd = null;

        switch ($.ui.fancytree.eventToString(e)) {
            case "ctrl+alt+n":
            case "meta+alt+n": // mac
                cmd = "addChildMenu";
                break;
            case "ctrl+shift+n":
            case "meta+shift+n": // mac: cmd+shift+n
                cmd = "addChild";
                break;
            case "ctrl+c":
            case "meta+c": // mac
                cmd = "copy";
                break;
            case "ctrl+v":
            case "meta+v": // mac
                cmd = "paste";
                break;
            case "ctrl+x":
            case "meta+x": // mac
                cmd = "cut";
                break;
            case "ctrl+n":
            case "meta+n": // mac
                cmd = "addSibling";
                break;
            case "del":
            case "meta+backspace": // mac
                cmd = "remove";
                break;
// already triggered by ext-edit pluging
//                case "f2":
//                    cmd = "rename";
//                    break;
            case "ctrl+up":
                cmd = "moveUp";
                break;
            case "ctrl+down":
                cmd = "moveDown";
                break;
            case "ctrl+right":
            case "ctrl+shift+right": // mac
                cmd = "indent";
                break;
            case "ctrl+left":
            case "ctrl+shift+left": // mac
                cmd = "outdent";
        }
        if (cmd) {
            $(this).trigger("nodeCommand", {cmd: cmd});
            // e.preventDefault();
            // e.stopPropagation();
            return false;
        }
    }).contextmenu({
        delegate: "span.fancytree-node",
        menu: [
            {title: "수정 <kbd>[F2]</kbd>", cmd: "rename", uiIcon: "ui-icon-pencil"},
            {title: "삭제 <kbd>[Del]</kbd>", cmd: "remove", uiIcon: "ui-icon-trash"},
            {title: "----"},
            {title: "형제 추가 <kbd>[Ctrl+N]</kbd>", cmd: "addSibling", uiIcon: "ui-icon-triangle-1-s"},
            {title: "자식 추가 <kbd>[Ctrl+Alt+N]</kbd>", cmd: "addChildMenu", uiIcon: "ui-icon-arrowreturn-1-e"},
            {title: "----"},
            {title: "자르기 <kbd>Ctrl+X</kbd>", cmd: "cut", uiIcon: "ui-icon-scissors"},
            {title: "복사하기 <kbd>Ctrl-C</kbd>", cmd: "copy", uiIcon: "ui-icon-copy"},
            {title: "자식으로 붙여넣기<kbd>Ctrl+V</kbd>", cmd: "paste", uiIcon: "ui-icon-clipboard", disabled: true}
        ],
        beforeOpen: function (event, ui) {
            var node = $.ui.fancytree.getNode(ui.target);
            var nodeObj = nodeObjList[node.key];
            var $tree = $("#tree");

            $tree.contextmenu("enableEntry", "rename", true);
            $tree.contextmenu("enableEntry", "remove", true);
            $tree.contextmenu("enableEntry", "addSibling", true);
            $tree.contextmenu("enableEntry", "cut", true);
            $tree.contextmenu("enableEntry", "copy", true);
            $tree.contextmenu("enableEntry", "addChild", true);
            $tree.contextmenu("enableEntry", "paste", !!CLIPBOARD);

            node.setActive();
        },
        select: function (event, ui) {
            var that = this;
            // delay the event, so the menu can close and the click event does
            // not interfere with the edit control
            setTimeout(function () {
                $(that).trigger("nodeCommand", {cmd: ui.cmd});
            }, 100);
        }
    });

    fncExpandAll();
    fncCollapseAll();
});

//노드 삭제
function removeNode(node, pass) {
    var children = node.children;

    if (children && children.length > 0) {
        if (!pass && !confirm("하위 조직까지 전부 삭제하시겠습니까?")) {
            return false;
        }

        for (var i = 0, size = children.length; i < size; i++) {
            removeNode(children[i], true);
        }
    }

    if (node.key.substring(0, 1) === 'N') {
        delete nodeObjList[node.key];
    } else {
        nodeObjList[node.key].isDelete = true;
    }

    if (!pass) node.remove();
}

//버튼 : 전체 펼치기
function fncExpandAll() {
    $("#tree").fancytree("getRootNode").visit(function(node){
        node.setExpanded(true);
    });
}

//버튼 : 전체 접기
function fncCollapseAll() {
    $("#tree").fancytree("getRootNode").visit(function(node){
        node.setExpanded(false);
    });
}

//버튼 : 저장
function fncSave() {
    if (!confirm("저장하시겠습니까?")) {
        return false;
    }

    if (!addFormNodeData()) return;

    $.ajax({
        url: '/saveOrgList',
        type: 'POST',
        cache: false,
        data: $('#saveForm').serialize(),
        dataType: 'json',
        success: function (data) {
            if (data && data.success) {
                alert('${smCommMsgSave}');
                reload();
            } else {
                var msg = '저장에 실패 했습니다.';
                if (data && data.errMsg) {
                    msg += '\n' + data.errMsg;
                }
                alert(msg);
            }
        },
        error: function (result) {
            alert('에러가 발생 했습니다');
        }
    });
}

function reload() {
    $.ajax({
        type: "POST",
        cache: false,
        url: window.dhtmlHistory.currentLocation,
        data: '',
        success: function (data) {
            $("#r_contents").html(data);
        }
    });
}

//메뉴내용 폼데이터에 적용하기
function addFormNodeData() {
    var $frm = $("#saveForm");
    $frm.html('');

    var isValid = true;

    $("#tree").fancytree("getRootNode").visit(function(node){
        var orgCd      = node.key;
        var orgType    = node.folder ? "P" : "C";
        var indexHier   = node.getIndexHier(".", 2);

        // 조직명 필수 체크
        var orgNm = node.title;
        if (!orgNm) {
            alert("조직명은 필수입니다.");
            isValid = false;
            node.editStart();
            return false;
        }

        //3레벨까지만 메뉴작성하도록 체크
        if (indexHier.split(".").length > 3) {
            alert("조직은 3레벨까지만 지원합니다.");
            isValid = false;
            node.getParent().setActive();
            return false;
        }

        var useYn = $('#useYn' + orgCd).val();
        var nodeObj = nodeObjList[orgCd];

        if (orgCd.substring(0, 1) === 'N' || orgNm != nodeObj.orgNm || indexHier != nodeObj.indexHier || useYn != nodeObj.useYn) {
            console.log("orgCd:", orgCd, ", orgNm:", orgNm, "|", nodeObj.orgNm, ", orgType:", orgType, "|", nodeObj.orgType,
                      ", indexHier:", indexHier, "|", nodeObj.indexHier,", useYn:", useYn, "|", nodeObj.useYn);

            var html  = "<input type='hidden' name='orgCd'     value='" + orgCd + "'/>\n";
                html += "<input type='hidden' name='orgNm'     value='" + orgNm + "'/>\n";
                html += "<input type='hidden' name='orgType'   value='" + orgType + "'/>\n";
                html += "<input type='hidden' name='indexHier'  value='" + indexHier + "'/>\n";
                html += "<input type='hidden' name='useYn'      value='" + useYn + "'/>\n";

            $frm.append(html);
        }
    });

    if (isValid) {
        var deleteOrgCdList = [];
        for (var orgCd in nodeObjList) {
            if (nodeObjList[orgCd].isDelete) {
            	deleteOrgCdList.push(orgCd);
            }
        }

        if (deleteOrgCdList.length > 0) {
            $frm.append('<input type="hidden" name="deleteOrgCds" value="' + deleteOrgCdList.join(",") + '"/>\n');
        }
    }

    if (!$frm.html()) {
        alert("변경된 사항이 없습니다.");
        return false;
    }

    return isValid;
}


$(document).ready(function(){

	// 매장 목록 
 	$("#gridStoreMgnt").jqGrid({
		url:'retrieveStrList',
	    datatype: "local",
	    mtype: 'POST',
	    colNames:['No', 'V', '${smStrCd}', '${smStrNm}', '주소', '전화번호', 'strCd'],
	    colModel:[
	    		{name:'records',index : 'records',width : 50,align : 'center',sortable :false, editable : false,editoptions : {readonly : true,size : 10}},
	            {name:'choice',index :'choice',width : 50,align : 'center',sortable :false, formatter :chboxFormatter,formatoptions : {disabled:false},editable : true,edittype : 'checkbox',editoptions : {value:"1:0"}},  
	            {name:'viewStrCd',index:'viewStrCd', width:85, align:'center', sortable:true, editable:false, editoptions:{readonly:true,size:10}},
	            {name:'strNm',index:'strNm', width:93, align:'center', sortable:true, editable:false},
	            {name:'addr',index:'addr', width:93, align:'center', sortable:true, editable:false},
	            {name:'telNo',index:'telNo', width:93, align:'center', sortable:true, editable:false},
	            {name:'strCd',index:'strCd', hidden:true}
		],
	    jsonReader : {
	    	repeatitems:false
	    },
	    rowNum:-1,
	    pager: '#gridStoreMgntPager',
        recordtext: "전체 {2} 건",
	    emptyrecords : "검색 결과가 존재하지 않습니다.",
		loadtext: "Loading...",
	    sortname: 'strNm',
	    viewrecords: true,
	    sortorder: "asc",	     
	    hidegrid: false,
	    shrinkToFit:true,
		autowidth:true,
		height : 500,
		loadComplete : function(data) {
	    	// 페이징 숨기기
	    	$("#gridStoreMgntPager_center").hide();
		}
	});
	
});

function chboxFormatter(cellvalue, options, rowObject) {
	return "<input type=\"checkbox\" name=\"choice_grid\" id=\"choice_grid_" + options.rowId + "\" strCd=\"" + rowObject.strCd + "\" />";
}

// 매장 목록
function fncStrMapSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgCd = $.trim($("#srcOrgCd").val());	
	if (orgCd == "") {
		alert("조직을 선택하세요.");
		return false;
	}
	
	$("#gridStoreMgnt").clearGridData();
	$("#gridStoreMgnt").setGridParam({
		 datatype : "json",		
		 postData : {
			 scrCompanyCd:companyCd,
			 scrOrgCd:orgCd
		 }
	 }).trigger("reloadGrid");
}

// 신규
function fncAdd() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgCd = $.trim($("#srcOrgCd").val());	
	if (orgCd == "") {
		alert("조직을 선택하세요.");
		return false;
	}
	
	// 매장 팝업
	fncStrSearch();
}

// 매장 팝업
function fncStrSearch() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	var orgCd = $.trim($("#srcOrgCd").val());
	
	var args = new Object();
	args.companyCd = companyCd;
	args.orgCd = orgCd;
	args.searchType = "org";
		
	fn_divPop("storeMngSrch", "팝업", 800, 650, args );
}

// 팝업에서 전달
function fncSetStore(param) {
	// 저장
	fncInsert(param);
}

// 신규 저장
function fncInsert(param) {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var orgCd = $.trim($("#srcOrgCd").val());	
	if (orgCd == "") {
		alert("조직을 선택하세요.");
		return false;
	}
	
	param.companyCd = companyCd;
	param.orgCd = orgCd;
	
	$.ajax({
		url:'/updateStrMgntOrgCd',
		type:'POST',
		cache:false,
		data:param,
		dataType:'json',
		success:function(data){
			alert('${smCommMsgSave}');
			fncStrMapSearch();
		},
		error:function(result){
			alert("에러가 발생했습니다.");
		}
	});
}

// 삭제
function fncDel() {
	var companyCd = $.trim($("#scrCompanyCd").val());	
	if (companyCd == "") {
		alert("${smCompanySrch}");
		return false;
	}
	
	var chkCnt = $("input:checkbox[name='choice_grid']:checked").size();
	if (chkCnt == 0) {
		alert("매장목록에서 체크박스를 선택하세요.");
		return false;
	}
	
	var strCds = "";
	var strCd = "";
	// 선택한 로우만 작업
	$("input:checkbox[name='choice_grid']:checked").each(function() {
		strCd = $.trim($(this).attr("strCd"));
		strCds += strCd + ",";
	});
	strCds = strCds.substring(0, strCds.length - 1);

	// 파라미터
	var param  = new Object();
	param.companyCd = companyCd;
	param.strCds = strCds;
	
	if (confirm("매장목록 정보를 " + "${smCommMsgDelCnf}")) {
		$.ajax({
			url:'/updateStrMgntOrgCdNull',
			type:'POST',
			cache:false,
			data:param,
			dataType:'json',
			success:function(data){
				alert('${smCommMsgDel}');
				fncStrMapSearch();
			},
			error:function(result){
				alert("에러가 발생했습니다.");
			}
		});
	}
}
</script>
<div id="loadingArea">

	<c:if test="${selectVoListCnt == 1 }">
		<input type='hidden' id='scrCompanyCd' name='scrCompanyCd' value='${userVo.companyCd}' />
		<input type='hidden' id='scrCompanyNm' name='scrCompanyNm' value='${userVo.companyNm}' />
	</c:if>
	<c:if test="${selectVoListCnt > 1 }">			
		<select id="scrCompanyCd" name="scrCompanyCd" style="display:none;">
			<option value=''>--선택--</option>
				<c:forEach var="vo" items="${selectVoList}" varStatus="status" >
					<option value='${vo.value}'>${vo.name}</option>
				</c:forEach>
		</select>
	</c:if>
	<input type="hidden" id="srcOrgCd" name="srcOrgCd" /><!-- 선택한 ORG_CD -->

	<div class="r_halfGridContainer">
		<!-- 트리 영역 -->
		<div class="r_halfGrid_l r_secondTbl">
	        <div id="treeDiv">
	        	<div class="r_gridTitle">
					<h3>조직관리</h3>
				</div>
	            <table id="tree" border="0" cellpadding="0" cellspacing="0">
	                <colgroup>
	                    <col width="250px">
	                    <%-- <col width="100px"> --%>
	                    <col width="100px">
	                </colgroup>
	                <thead>
	                <tr>
	                    <th>조직명</th>
	                    <!-- <th>조직코드</th> -->
	                    <th>사용여부</th>
	                </tr>
	                </thead>
	                <tbody>
	                </tbody>
	            </table>
	        </div>        
		</div>
		<!-- //트리 영역 -->
		
		<!-- 그리드 영역 -->
		<div class="r_halfGrid_r r_secondTbl">
			<div class="r_grid" id ="cont">
				<div class="r_gridTitle">
					<h3>매장목록</h3>
				</div>
				<table id="gridStoreMgnt"><tr><td></td></tr></table>
				<div id="gridStoreMgntPager"></div>
			</div>
		</div>
		<!-- //그리드 영역 -->
	</div>
	
	<!-- 하단 버튼 그룹 -->
	<div class="r_halfGridContainer">
        <div class="r_halfGrid_l r_secondTbl">
	        <div id="buttonArea" class="r_pageBtnWrapper mr_0 ml0 border_none">
	            <span class="pageNormal save">
	                <button onclick="javascript:fncSave();">저장</button>
	            </span>
	            <span class="pageNormal">
	                <button onclick="javascript:fncCollapseAll();">전체접기</button>
	            </span>
	            <span class="pageNormal">
	                <button onclick="javascript:fncExpandAll();">전체펼치기</button>
	            </span>
	        </div>
		</div>
		<div class="r_halfGrid_r r_secondTbl">
			<div class="r_pageBtnWrapper mr_0 ml0 border_none">
				<span class="pageNormal">
			    	<button onclick="javascript:fncDel();">${smDelete}</button>
			   	</span>	
			 	<span class="pageNormal">
			    	<button onclick="javascript:fncAdd();">${smNew}</button>
			   	</span>
			</div>
		</div>
	</div>
	<!-- //하단 버튼 그룹 -->
            
    <form id="saveForm" name="saveForm"></form>
            
</div>