<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smSeq"><spring:message code="seq"/></c:set><%--번호--%>
<c:set var="smSelect"><spring:message code="select"/></c:set><%--선택--%>
<c:set var="smOrg"><spring:message code="org"/></c:set><%--조직--%>
<c:set var="smStrCd"><spring:message code="strCd"/></c:set><%--매장코드--%>
<c:set var="smStrNm"><spring:message code="strNm"/></c:set><%--매장명--%>
<c:set var="smArea"><spring:message code="area"/></c:set><%--기상지역--%>
<c:set var="smStartDt"><spring:message code="startDt"/></c:set><%--시작일자--%>
<c:set var="smEndDt"><spring:message code="endDt"/></c:set><%--종료일자--%>
<c:set var="smUseYn"><spring:message code="useYn"/></c:set><%--사용여부--%>
<c:set var="smRegiId"><spring:message code="regiId"/></c:set><%--작업자 ID--%>
<c:set var="smRegiNm"><spring:message code="regiNm"/></c:set><%--작업자 명--%>
<c:set var="smFinalModDt"><spring:message code="finalModDt"/></c:set><%--최종작업일자--%>
<c:set var="smCompany"><spring:message code="company"/></c:set><%--회사--%>
<c:set var="smDupChk"><spring:message code="dupChk"/></c:set><%--중복확인--%>
<c:set var="smClos"><spring:message code="clos"/></c:set><%--닫기--%>
<c:set var="smNew"><spring:message code="new"/></c:set><%--신규--%>
<c:set var="smUpdate"><spring:message code="update"/></c:set><%--수정--%>
<c:set var="smDelete"><spring:message code="delete"/></c:set><%--삭제--%>
<c:set var="smSave"><spring:message code="save"/></c:set><%--저장--%>
<c:set var="smStr"><spring:message code="str"/></c:set><%--매장--%>
<c:set var="smCompanySrch"><spring:message code="companySrch"/></c:set><%--회사를 선택해주세요.--%>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set><%--조회--%>

<c:set var="smCommMsgSel"><spring:message code="comm.msg.sel"/></c:set><%--먼저 선택 하세요.--%>
<c:set var="smCommMsgOpen"><spring:message code="comm.msg.open"/></c:set><%--열려있는 팝업을 먼저 닫으세요.--%>
<c:set var="smCommMsgDelCnf"><spring:message code="comm.msg.del.cnf"/></c:set><%--삭제하시겠습니까?--%>
<c:set var="smCommMsgDel"><spring:message code="comm.msg.del"/></c:set><%--삭제되었습니다.--%>
<c:set var="smCommMsgUse"><spring:message code="comm.msg.use"/></c:set><%--* 사용가능 합니다.--%>
<c:set var="smCommMsgStrExt"><spring:message code="comm.msg.str.ext"/></c:set><%--* 매장코드가 존재합니다.--%>
<c:set var="smCommMsgDupChk"><spring:message code="comm.msg.dupChk"/></c:set><%--중복 체크를 해야 합니다.--%>
<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set><%--저장하시겠습니까?--%>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set><%--저장되었습니다.--%>

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
    #loadingArea {
        overflow: auto;
        width: 1020px;
        height: 600px;
    }
    #treeDiv {
        overflow:auto;
        height:490px;
    }
    #tree {
        background-color: white;
        width: 960px;
        border: 0;
    }
    #buttonArea {
        width: 960px;
    }
    table.fancytree-ext-table tbody tr td {
        border: 0;
    }
    td input[name=menuEngNm] {
        width: 190px;
    }
    td input[name=url] {
        width: 340px;
    }
    .noUse {
        opacity: 0.35;
    }
</style>
<script type="text/javascript">
    var nodeObjList = {};
    var newIndex = 0;

    var CLIPBOARD = null;

    $(function () {
        <c:if test="${empty menuList}">
            newIndex++;
            nodeObjList['N' + newIndex] = {menuNm: '새메뉴_' + newIndex, menuEngNm: 'NewMenu_' + newIndex, menuType: 'P', url: '', useYn: 'Y'};
        </c:if>
        <c:forEach items="${menuList}" var="node">
            nodeObjList['${node.menuId}'] = {menuId:'${node.menuId}', menuNm:'${node.menuNm}', menuEngNm:'${node.menuEngNm}', menuType:'${node.menuType}', url:'${node.url}', indexHier:'${node.indexHier}', useYn:'${node.useYn}'};
        </c:forEach>

        $("#tree").fancytree({
            checkbox: false,
            titlesTabbable: true,   // Add all node titles to TAB chain
            quicksearch: false,     // Jump to nodes when pressing first character
            source: ${menuJson},
            //source: { url: "ajax-tree-products.json"},
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

                if (!nodeObj.indexHier) {
                    nodeObj.indexHier = node.getIndexHier(".", 2);
                }

                $tr.attr("id", "tr" + node.key);

                $tdList.eq(0).attr('id', 'menuNm' + node.key);
                $tdList.eq(1).html("<span class='r_radio'><input type='text' id='menuEngNm" + node.key + "' name='menuEngNm' value='" + nodeObj.menuEngNm + "' title='메뉴영문명' maxlength='100' class='c_menuEngNm' required/></span>");

                if (nodeObj.menuType == 'C') {
                    $tdList.eq(2).html("<span class='r_radio'><input type='text' id='url" + node.key + "' name='url' value='" + nodeObj.url + "' title='메뉴 URL' maxlength='200' class='c_url' required/></span>");
                }

                if (nodeObj.useYn === 'Y') {
                    $tdList.eq(3).html("<select name='useYn' title='사용여부' id='useYn" + node.key + "' class='c_useYn'><option value='Y' selected>사용</option><option value='N'>미사용</option></select>");
                } else {
                    $tdList.eq(0).addClass('noUse');
                    $tdList.eq(3).html("<select name='useYn' title='사용여부' id='useYn" + node.key + "' class='c_useYn'><option value='Y'>사용</option><option value='N' selected>미사용</option></select>");
                }

                $('#useYn' + node.key).change(function () {
                    var value = $(this).find("option:selected").val();
                    var key = $(this).attr('id').substring("useYn".length);

                    if (value == 'Y') {
                        $('#menuNm' + key).removeClass("noUse");
                    } else {
                        $('#menuNm' + key).addClass("noUse");
                    }
                });
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
                    if (nodeObj.menuType == 'C') break;
                    newIndex++;
                    nodeObjList['N' + newIndex] = {menuNm: '새메뉴_' + newIndex, menuEngNm: 'NewMenu_' + newIndex, menuType: 'P', url: '', useYn: 'Y'};
                    node.editCreateNode("child", {title: '새메뉴_' + newIndex, folder:true, key:'N' + newIndex});
                    break;
                case "addChild":
                    if (nodeObj.menuType == 'C') break;
                    newIndex++;
                    nodeObjList['N' + newIndex] = {menuNm: '새화면_' + newIndex, menuEngNm: 'NewView_' + newIndex, menuType: 'C', url: '', useYn: 'Y'};
                    node.editCreateNode("child", {title: '새화면_' + newIndex, folder:false, key:'N' + newIndex});
                    break;
                case "addSibling":
                    newIndex++;
                    if (node.folder) {
                        nodeObjList['N' + newIndex] = {menuNm: '새메뉴_' + newIndex, menuEngNm: 'NewMenu_' + newIndex, menuType: 'P', url: '', useYn: 'Y'};
                        node.editCreateNode("after", {title: '새메뉴_' + newIndex, folder:true, key:'N' + newIndex});
                    } else {
                        nodeObjList['N' + newIndex] = {menuNm: '새화면_' + newIndex, menuEngNm: 'NewView_' + newIndex, menuType: 'C', url: '', useYn: 'Y'};
                        node.editCreateNode("after", {title: '새화면_' + newIndex, folder:false, key:'N' + newIndex});
                    }
                    break;
                case "cut":
                case "copy":
                    CLIPBOARD = {mode: data.cmd, data: node};
                    break;
                case "clear":
                    CLIPBOARD = null;
                    break;
                case "paste":
                    if (nodeObj.menuType === 'C') break;
                    if (CLIPBOARD.mode === "cut") {
                        CLIPBOARD.data.moveTo(node, "child");
                        CLIPBOARD.data.setActive();
                    } else if (CLIPBOARD.mode === "copy") {
                        var child = CLIPBOARD.data.toDict(true, function (dict) {
                            var nodeKey = dict.key;
                            var orgObj = nodeObjList[nodeKey];

                            newIndex++;
                            dict.key = 'N' + newIndex;
                            dict.title = "Copy of " + dict.title;

                            var dictKey = dict.key;

                            nodeObjList[dictKey] = {menuId: dictKey, menuNm: dict.title, menuEngNm: "Copy of " + $('#menuEngNm' + nodeKey).val(), menuType: orgObj.menuType, url: $('#url' + nodeKey).val(), useYn: $('#useYn' + nodeKey).val()};
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
                {title: "자식 메뉴추가 <kbd>[Ctrl+Alt+N]</kbd>", cmd: "addChildMenu", uiIcon: "ui-icon-arrowreturn-1-e"},
                {title: "자식 화면추가 <kbd>[Ctrl+Shift+N]</kbd>", cmd: "addChild", uiIcon: "ui-icon-plus"},
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
                if (nodeObj.menuType == 'C') {
                    $tree.contextmenu("enableEntry", "addChildMenu", false);
                    $tree.contextmenu("enableEntry", "addChild", false);
                    $tree.contextmenu("enableEntry", "paste", false);
                } else {
                    $tree.contextmenu("enableEntry", "addChildMenu", true);
                    $tree.contextmenu("enableEntry", "addChild", true);
                    $tree.contextmenu("enableEntry", "paste", !!CLIPBOARD);
                }

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
            if (!pass && !confirm("하위 메뉴까지 전부 삭제하시겠습니까?")) {
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
            url: '/saveMenuList',
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
            var menuId      = node.key;
            var menuType    = node.folder ? "P" : "C";
            var indexHier   = node.getIndexHier(".", 2);

            //메뉴명/화면명 필수 체크
            var menuNm = node.title;
            if (!menuNm) {
                alert("메뉴명/화면명은 필수입니다.");
                isValid = false;
                node.editStart();
                return false;
            }

            //영문명 필수 체크
            var $menuEngNm = $('#menuEngNm' + menuId);
            var menuEngNm = $menuEngNm.val();
            if (!menuEngNm) {
                alert("영문명은 필수입니다.");
                isValid = false;
                $menuEngNm.focus();
                return false;
            }

            //url 필수 체크
            var $url = $('#url' + menuId);
            var url = $url.val() ? $url.val() : "";
            if (menuType === "C" && !url) {
                alert("화면명에서는 url이 필수입니다.");
                isValid = false;
                $url.focus();
                return false;
            }

            //3레벨까지만 메뉴작성하도록 체크
            if (indexHier.split(".").length > 3) {
                alert("메뉴는 3레벨까지만 지원합니다.");
                isValid = false;
                node.getParent().setActive();
                return false;
            }

            var useYn = $('#useYn' + menuId).val();
            var nodeObj = nodeObjList[menuId];

            if (menuId.substring(0, 1) === 'N' || menuNm != nodeObj.menuNm || menuEngNm != nodeObj.menuEngNm
                || (menuType === 'C' && url != nodeObj.url) || indexHier != nodeObj.indexHier || useYn != nodeObj.useYn) {
                var html  = "<input type='hidden' name='menuId'     value='" + menuId + "'/>\n";
                    html += "<input type='hidden' name='menuNm'     value='" + menuNm + "'/>\n";
                    html += "<input type='hidden' name='menuEngNm'  value='" + menuEngNm + "'/>\n";
                    html += "<input type='hidden' name='menuType'   value='" + menuType + "'/>\n";
                    html += "<input type='hidden' name='url'        value='" + url + "'/>\n";
                    html += "<input type='hidden' name='indexHier'  value='" + indexHier + "'/>\n";
                    html += "<input type='hidden' name='useYn'      value='" + useYn + "'/>\n";

                $frm.append(html);
            }
        });

        if (isValid) {
            var deleteMenuIdList = [];
            for (var menuId in nodeObjList) {
                if (nodeObjList[menuId].isDelete) {
                    deleteMenuIdList.push(menuId);
                }
            }

            if (deleteMenuIdList.length > 0) {
                $frm.append('<input type="hidden" name="deleteMenuIds" value="' + deleteMenuIdList.join(",") + '"/>\n');
            }
        }

        if (!$frm.html()) {
            alert("변경된 사항이 없습니다.");
            return false;
        }

        return isValid;
    }
</script>
<div id="loadingArea">
    <div id="treeDiv">
        <table id="tree" border="0" cellpadding="0" cellspacing="0" style="width:100%;">
            <colgroup>
                <col width="350px">
                <col width="200px">
                <col width="*">
                <col width="60px">
            </colgroup>
            <thead>
            <tr>
                <th>메뉴명/화면명</th>
                <th>영문명</th>
                <th>URL</th>
                <th>사용여부</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <form id="saveForm" name="saveForm"></form>

    <div id="buttonArea" class="r_pageBtnWrapper mr_0 ml0 border_none">
        <span class="pageNormal">
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