<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smCommMsgSaveCnf"><spring:message code="comm.msg.save.cnf"/></c:set>
<c:set var="smCommMsgSave"><spring:message code="comm.msg.save"/></c:set>

<style type="text/css">
    .ui-menu {
        width: 180px;
        font-size: 63%;
    }
    .ui-menu kbd { /* Keyboard shortcuts for ui-contextmenu titles */
        float: right;
        background-color: white;
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
    #leftTreeDiv, #rightTreeDiv {
        overflow:auto;
        height:570px;
    }
    #leftTree {
        background-color: white;
        border: 0;
    }
    table.fancytree-node tbody tr td span {
        text-align: left;
        line-height: normal;
    }
    table.fancytree-ext-table tbody tr td {
        border: 0;
    }
    td input[name=authDesc] {
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
    var selectedAuthId = null;

    var menuAuthList = {};

    $(function () {

        <c:forEach items="${authList}" var="node">
            nodeObjList['${node.authId}'] = {authNm: '${node.authNm}', authDesc: '${node.authDesc}', useYn: '${node.useYn}', type: '${node.type}', orderSeq:'${node.indexHier}'};
        </c:forEach>

        $("#leftTree").fancytree({
            checkbox: false,
            titlesTabbable: true,   // Add all node titles to TAB chain
            quicksearch: false,     // Jump to nodes when pressing first character
            source: ${authJson},
            //source: { url: "ajax-tree-products.json"},
            extensions: ["edit", "dnd", "table", "gridnav"],
            dnd: {
                preventVoidMoves: true,
                preventRecursiveMoves: true,
                autoExpandMS: 400,
                dragStart: function (node, data) {
                    if (nodeObjList[node.key].type === 'CODE') {
                        alert("권한구분은 이동할 수 없습니다.");
                        return false;
                    }
                    return true;
                },
                dragEnter: function (node, data) {
                    return true;
                },
                dragDrop: function (node, data) {
                    if (nodeObjList[node.key].type === 'CODE') {
                        alert("권한구분은 이동할 수 없습니다.");
                    } else {
                        data.otherNode.moveTo(node, data.hitMode);
                    }
                }
            },
            edit: {
                triggerStart: ["f2", "shift+click", "mac+enter"],
                beforeEdit: function(event, data) {
                    if (nodeObjList[data.node.key].type === 'CODE') {
                        alert("권한구분은 수정할 수 없습니다.");
                        return false;
                    }
                },
                close: function (event, data) {
                    if (data.save && data.isNew) {
                        // Quick-enter: add new nodes until we hit [enter] on an empty title
//                        $("#leftTree").trigger("nodeCommand", {cmd: "addSibling"});
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

                if (!nodeObj.orderSeq) {
                    nodeObj.orderSeq = node.getIndexHier();
                }

                $tr.attr("id", "tr" + node.key);

                $tdList.eq(0).attr('id', 'authNm' + node.key);

                if (nodeObj.type === 'AUTH') {
                    $tdList.eq(1).html("<span class='r_radio'><input type='text' id='authDesc" + node.key + "' name='authDesc' value='" + nodeObj.authDesc + "' title='권한설명' maxlength='50' class='c_authDesc' required/></span>");
                    if (nodeObj.useYn === 'Y') {
                        $tdList.eq(2).html("<select name='useYn' title='사용여부' id='useYn" + node.key + "' class='c_useYn'><option value='Y' selected>사용</option><option value='N'>미사용</option></select>");
                    } else {
                        $tdList.eq(0).addClass('noUse');
                        $tdList.eq(2).html("<select name='useYn' title='사용여부' id='useYn" + node.key + "' class='c_useYn'><option value='Y'>사용</option><option value='N' selected>미사용</option></select>");
                    }

                    $('#useYn' + node.key).change(function () {
                        var value = $(this).find("option:selected").val();
                        var key = $(this).attr('id').substring("useYn".length);

                        if (value == 'Y') {
                            $('#authNm' + key).removeClass("noUse");
                        } else {
                            $('#authNm' + key).addClass("noUse");
                        }
                    });
                }
            },
            // The following options are only required, if we have more than one tree on one page:
            cookieId: "fancytree-left",
            idPrefix: "fancytree-left-"

        }).on("nodeCommand", function (event, data) {
            var refNode,
                tree = $(this).fancytree("getTree"),
                node = tree.getActiveNode();
            var nodeObj = nodeObjList[node.key];

            switch (data.cmd) {
                case "moveUp":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분은 수정할 수 없습니다.");
                        break;
                    }
                    refNode = node.getPrevSibling();
                    if (refNode) {
                        node.moveTo(refNode, "before");
                        node.setActive();
                    }
                    break;
                case "moveDown":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분은 수정할 수 없습니다.");
                        break;
                    }
                    refNode = node.getNextSibling();
                    if (refNode) {
                        node.moveTo(refNode, "after");
                        node.setActive();
                    }
                    break;
                case "indent":
                case "outdent":
                    break;
                case "rename":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분은 수정할 수 없습니다.");
                        break;
                    }
                    node.editStart();
                    break;
                case "remove":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분을 삭제할 수 없습니다.");
                        break;
                    }
                    if (node.key === '1') {
                        alert("본부관리자는 삭제할 수 없습니다.");
                        break;
                    }
                    refNode = node.getNextSibling() || node.getPrevSibling() || node.getParent();
                    if (node.key.substring(0, 3) === '[N]') {
                        delete nodeObjList[node.key];
                    } else {
                        nodeObjList[node.key].isDelete = true;
                    }
                    node.remove();
                    if (refNode) {
                        refNode.setActive();
                    }
                    break;
                case "addChild":
                    if (nodeObj.type === 'AUTH') {
                        alert("권한 아래에 권한을 추가할 수 없습니다.");
                        break;
                    }
                    newIndex++;
                    nodeObjList['N' + newIndex] = {authNm: '새권한_' + newIndex, type: 'AUTH', authDesc: '', useYn: 'Y'};
                    node.editCreateNode("child", {title: '새권한_' + newIndex, folder:false, key:'N' + newIndex});
                    break;
                case "addSibling":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분을 추가할 수 없습니다.");
                        break;
                    }
                    newIndex++;
                    nodeObjList['N' + newIndex] = {authNm: '새권한_' + newIndex, type: 'AUTH', authDesc: '', useYn: 'Y'};
                    node.editCreateNode("child", {title: '새권한_' + newIndex, folder:false, key:'N' + newIndex});
                    break;
                case "cut":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분을 자르기할 수 없습니다.");
                        break;
                    }
                    CLIPBOARD = {mode: data.cmd, data: node};
                    break;
                case "copy":
                    if (nodeObj.type === 'CODE') {
                        alert("권한구분을 복사할 수 없습니다.");
                        break;
                    }
                    CLIPBOARD = {
                        mode: data.cmd,
                        data: node.toDict(function (n) {
                            delete n.key;
                        })
                    };
                    break;
                case "clear":
                    CLIPBOARD = null;
                    break;
                case "paste":
                    if (nodeObj.type === 'AUTH') {
                        alert("권한 아래에 붙여넣기 할 수 없습니다.");
                        break;
                    }
                    if (CLIPBOARD.mode === "cut") {
                        CLIPBOARD.data.moveTo(node, "child");
                        CLIPBOARD.data.setActive();
                    } else if (CLIPBOARD.mode === "copy") {
                        node.addChildren(CLIPBOARD.data).setActive();
                    }
                    break;
                default:
                    alert("Unhandled command: " + data.cmd);
                    return;
            }

        }).on("click", function (e) {
            var clickAuth = $(e.target).closest('tr').attr('id').substring("tr".length);
            if (selectedAuthId !== clickAuth) {
                selectedAuthId = clickAuth;
                if (nodeObjList[selectedAuthId].type === 'AUTH') {
                    fncLoadMenuAuth();
                }
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
                {title: "자식 권한추가 <kbd>[Ctrl+Shift+N]</kbd>", cmd: "addChild", uiIcon: "ui-icon-arrowreturn-1-e"},
                {title: "----"},
                {title: "자르기 <kbd>Ctrl+X</kbd>", cmd: "cut", uiIcon: "ui-icon-scissors"},
                {title: "복사하기 <kbd>Ctrl-C</kbd>", cmd: "copy", uiIcon: "ui-icon-copy"},
                {title: "자식으로 붙여넣기<kbd>Ctrl+V</kbd>", cmd: "paste", uiIcon: "ui-icon-clipboard", disabled: true}
            ],
            beforeOpen: function (event, ui) {
                var node = $.ui.fancytree.getNode(ui.target);
                var $tree = $("#leftTree");

                if (node.isFolder()) {
                    $tree.contextmenu("enableEntry", "rename",      false);
                    $tree.contextmenu("enableEntry", "remove",      false);
                    $tree.contextmenu("enableEntry", "addSibling",  false);
                    $tree.contextmenu("enableEntry", "addChild",    true);
                    $tree.contextmenu("enableEntry", "cut",         false);
                    $tree.contextmenu("enableEntry", "copy",        false);
                    $tree.contextmenu("enableEntry", "paste",       !!CLIPBOARD);
                } else {
                    $tree.contextmenu("enableEntry", "rename",      true);
                    $tree.contextmenu("enableEntry", "remove",      true);
                    $tree.contextmenu("enableEntry", "addSibling",  true);
                    $tree.contextmenu("enableEntry", "addChild",    false);
                    $tree.contextmenu("enableEntry", "cut",         true);
                    $tree.contextmenu("enableEntry", "copy",        true);
                    $tree.contextmenu("enableEntry", "paste",       false);
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

        fncExpandAll("leftTree");

    });

    //버튼 : 전체 펼치기
    function fncExpandAll(treeId) {
        $("#" + treeId).fancytree("getRootNode").visit(function(node){
            node.setExpanded(true);
        });
    }

    //버튼 : 전체 접기
    function fncCollapseAll(treeId) {
        $("#" + treeId).fancytree("getRootNode").visit(function(node){
            node.setExpanded(false);
        });
    }

    //권한에 해당하는 메뉴권한 가져오기
    function fncLoadMenuAuth() {
        $.ajax({
            url: '/retrieveMenuAuthList',
            type: 'POST',
            cache: false,
            data: {authId: selectedAuthId},
            dataType: 'json',
            success: function (data) {
                if (data && data.success) {
                    fncRightTreeReload(eval(data.json));
                } else {
                    alert('메뉴권한 조회에 실패 했습니다');
                }
            },
            error: function (result) {
                alert('에러가 발생 했습니다');
            }
        });
    }

    //메뉴권한 리로드
    function fncRightTreeReload(source) {
        $("#rightTreeDiv").html('<div id="rightTree"></div>');

        menuAuthList = {};
        loadMenuAuthList(source);

        $("#rightTree").fancytree({
            checkbox: true,
            selectMode: 3,
            source: source,
            loadChildren: function (event, ctx) {

            },
            select: function (event, data) {

            },
            dblclick: function (event, data) {
                data.node.toggleSelected();
            },
            keydown: function (event, data) {
                if (event.which === 32) {
                    data.node.toggleSelected();
                    return false;
                }
            },
            // The following options are only required, if we have more than one tree on one page:
            cookieId: "fancytree-right",
            idPrefix: "fancytree-right-"
        });

        fncExpandAll('rightTree');
    }

    function loadMenuAuthList(json) {
        var obj;
        for (var i = 0, size = json.length; i < size; i++) {
            obj = json[i];
            menuAuthList[obj.key] = !!obj.selected;
            if (obj.folder && obj.children) {
                loadMenuAuthList(obj.children);
            }
        }
    }

    //저장 : 권한목록
    function fncAuthSave() {
        if (!confirm("권한목록을 저장하시겠습니까?")) {
            return false;
        }

        if (!addFormAuthData()) return;

        $.ajax({
            url: '/saveAuthList',
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

    //페이지 리로딩
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

    //권한목록 수정사항 폼데이터에 적용하기
    function addFormAuthData() {
        var $frm = $("#saveForm");
        $frm.html('');

        var isValid = true;

        $("#leftTree").fancytree("getRootNode").visit(function(node) {
            var authId = node.key;
            var nodeObj = nodeObjList[authId];

            if (nodeObj.type === 'AUTH') {
                var authNm = node.title;
                if (!authNm) {
                    alert("권한명은 필수입니다.");
                    isValid = false;
                    node.editStart();
                    return false;
                }

                var authDesc = $('#authDesc' + authId).val();
                var orderSeq = node.getIndexHier();
                var useYn = $('#useYn' + authId).val();

                if (authId.substring(0, 1) === 'N' || authNm != nodeObj.authNm || authDesc != nodeObj.authDesc || orderSeq != nodeObj.orderSeq || useYn != nodeObj.useYn) {
                    var html  = "<input type='hidden' name='authId'     value='" + authId + "'/>\n";
                        html += "<input type='hidden' name='authSp'     value='" + node.parent.key + "'/>\n";
                        html += "<input type='hidden' name='authNm'     value='" + authNm + "'/>\n";
                        html += "<input type='hidden' name='authDesc'   value='" + authDesc + "'/>\n";
                        html += "<input type='hidden' name='orderSeq'   value='" + orderSeq.substring(orderSeq.indexOf(".") + 1) + "'/>\n";
                        html += "<input type='hidden' name='useYn'      value='" + useYn + "'/>\n";

                    $frm.append(html);
                }
            }
        });

        if (isValid) {
            var deleteAuthIdList = [];
            for (var authId in nodeObjList) {
                if (nodeObjList[authId].isDelete) {
                    deleteAuthIdList.push(authId);
                }
            }

            if (deleteAuthIdList.length > 0) {
                $frm.append('<input type="hidden" name="deleteAuthIds" value="' + deleteAuthIdList.join(",") + '"/>\n');
            }
        }

        if (!$frm.html()) {
            alert("변경된 사항이 없습니다.");
            return false;
        }

        return isValid;
    }

    //저장 : 메뉴권한
    function fncMenuAuthSave() {
        if (!confirm("메뉴권한을 저장하시겠습니까?")) {
            return false;
        }

        if (!addFormMenuAuthData()) return;

        $.ajax({
            url: '/saveMenuAuthList',
            type: 'POST',
            cache: false,
            data: $('#saveForm').serialize(),
            dataType: 'json',
            success: function (data) {
                if (data && data.success) {
                    alert('${smCommMsgSave}');
                    fncLoadMenuAuth();
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

    //메뉴권한 수정사항 폼데이터에 적용하기
    function addFormMenuAuthData() {
        var $frm = $("#saveForm");
        $frm.html('');

        var isValid = true;

        $("#rightTree").fancytree("getRootNode").visit(function(node) {
            var menuId = node.key;
            var selected = !!node.selected || !!node.partsel;
            var old_selected = menuAuthList[menuId];

            if (selected !== old_selected) {
                var html  = "<input type='hidden' name='menuId'     value='" + menuId + "'/>\n";
                    html += "<input type='hidden' name='selected'   value='" + selected + "'/>\n";

                $frm.append(html);
            }
        });

        if (!$frm.html()) {
            alert("변경된 사항이 없습니다.");
            return false;
        } else {
            $frm.append("<input type='hidden' name='authId'   value='" + selectedAuthId + "'/>");
        }

        return isValid;
    }
</script>

<div id="loadingArea">
    <div class="r_halfGridContainer">
        <div class="r_halfGrid_l r_secondTbl">
            <div class="r_inputTblTitle">
                <h3>권한 목록</h3>
            </div>
            <div id="leftTreeDiv">
                <table id="leftTree" border="0" cellpadding="0" cellspacing="0">
                    <colgroup>
                        <col width="40%">
                        <col width="48%">
                        <col width="12%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>권한구분/권한명</th>
                        <th>권한설명</th>
                        <th>사용여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="r_halfGrid_r r_secondTbl">
            <div class="r_inputTblTitle">
                <h3>메뉴 권한</h3>
            </div>
            <div id="rightTreeDiv">
                <div id="rightTree"></div>
            </div>
        </div>
    </div>

    <div class="r_halfGridContainer">
        <div class="r_halfGrid_l r_secondTbl">
            <div class="r_pageBtnWrapper">
                <span class="pageNormal">
                    <button onclick="javascript:fncAuthSave();">저장</button>
                </span>
            </div>
        </div>
        <div class="r_halfGrid_r r_secondTbl">
            <div class="r_pageBtnWrapper">
                <span class="pageNormal">
                    <button onclick="javascript:fncMenuAuthSave();">저장</button>
                </span>
            </div>
        </div>
    </div>

    <form id="saveForm" name="saveForm">
    </form>

</div>