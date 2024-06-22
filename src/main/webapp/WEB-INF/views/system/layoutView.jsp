<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="smLogoutCnfm"><spring:message code="logoutCnfm"/></c:set>
<c:set var="smInvalidSession"><spring:message code="invalidSession"/></c:set>

<c:set var="smStr"><spring:message code="str"/></c:set>
<c:set var="smRetrieve"><spring:message code="retrieve"/></c:set>
<c:set var="smCnfm"><spring:message code="cnfm"/></c:set>
<c:set var="smClos"><spring:message code="clos"/></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>REMS</title>

    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/ui.jqgrid.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jquery.jqplot.css"/>
    <%--<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/smoothness/jquery-ui.css"/>--%>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jquery-ui-1.11.4/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/jstree.style.min.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/rems_global.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/rems_page.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="/resources/css/fancytree/skin-win8/ui.fancytree.css" />

    <script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
    <%--<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>--%>
    <script type="text/javascript" src="/resources/js/jquery-ui-1.11.4/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.datepick-ko.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.mtz.monthpicker.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.json-2.4.min.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>

    <script type="text/javascript" src="/resources/js/jstree.min.js"></script>
    <script type="text/javascript" src="/resources/js/rsh.compressed.js"></script>

    <script type="text/javascript" src="/resources/js/i18n/grid.locale-kr.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="/resources/js/popupDiv.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.oLoader.js"></script>

    <!--[if lt IE 10]>
    <script type="text/javascript" src="/resources/js/excanvas.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/resources/js/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.json2.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.barRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.categoryAxisRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.pointLabels.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.highlighter.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.canvasTextRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.canvasAxisTickRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.canvasAxisLabelRenderer.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.cursor.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.dateAxisRenderer.js"></script>
    <script type="text/javascript" src="/resources/js/jqplot.enhancedLegendRenderer.min.js"></script>

    <script type="text/javascript" src="resources/js/highstock.js"></script>
    <script type="text/javascript" src="resources/js/exporting.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.ui-contextmenu.min.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.fancytree-all.min.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.mousewheel.js"></script>
    <script type="text/javascript" src="/resources/js/globalize.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.easing.1.3.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.validate.js"></script>
    <script type="text/javascript" src="/resources/js/popup.js"></script>
    <script type="text/javascript" src="/resources/js/common.js"></script>
    <script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>


    <script type="text/javascript" src="/resources/js/jquery.form.min.js"></script>
    
    
    <!--  대시보드 Pie 차트 -->    
    <script type="text/javascript" src="/resources/js/Chart.js"></script>
    <script type="text/javascript" src="/resources/js/utils.js"></script>


<style>

div.ui-dialog-titlebar div.ui-widget-header
{
	background-color: red !important;
}

</style>
    <script type="text/javascript">
        /*******************
         메인 스크립트
         ********************/
        var gzSelViewId;
        var gzSelId;
        var gzUrlNodeIdMap = {};
        var gzUrlBack = false;

        /*******************
         메인 스크립트
         ********************/
        dhtmlHistory.create({
            debugMode: false,
            toJSON: function (o) {
                return $.toJSON(o);
            },
            fromJSON: function (s) {
                return $.parseJSON(s);
            }
        });

        $(document).ready(function () {
            // 뒤로가기 구현(rsh)
            dhtmlHistory.initialize();
            dhtmlHistory.addListener(function (newLocation, param) {
                gzUrlBack = true;
                fncCallPage(newLocation, param);
            });

            //메뉴 조회
            fncRetrieveMenu();
        });

        // 메뉴조회
        function fncRetrieveMenu() {
            $.ajax({
                type: "POST",
                cache: false,
                url: "/menu",
                data: {},
                success: function (data) {
                    if (!data || !data.success) return;

                    //조회해온 데이터 로딩하기
                    var json = eval(data.json);
                    gvNeedFindFirst = true;
                    loadMenuData(json);

                    //메뉴 구성하기
                    $('#menuTree').jstree({
                        'core': {
                            'data': json,
                            'multiple': false
                        },
                        'types': {
                            'default': {
                                'icon': false
                            }
                        },
                        'search': {
                            'show_only_matches': true,
                            'search_leaves_only': true
                        },
                        'plugins': ['types', 'wholerow', 'search']
                    }).on("select_node.jstree", function (event, data) {
                        $('#menuTree').jstree("toggle_node", data.node);
                        if (gzSelId == data.node.id) {
                            return;
                        }

                        if (data.node.original.menuType == "C") {
                            gzSelViewId = data.node.id;
                            fncCallPage(data.node.original.url, "");
                        }

                        //기존 선택된 메뉴 접기
                        if (gzSelId) {
                            var prevNode = fncGetMenuNode(gzSelId);
                            $("#" + gzSelId + "_anchor").removeClass("jstree-clicked");

                            if (prevNode.original.menuType == "C") {
                                prevNode = fncGetMenuNode(prevNode.parent);
                            }

                            if (prevNode.id !== data.node.id && prevNode.id !== data.node.parent) {
                                $('#menuTree').jstree("close_node", prevNode);

                                var gParentNode = fncGetMenuNode(data.node.parent);
                                if (prevNode.parent !== data.node.parent && (gParentNode && prevNode.parent !== gParentNode.parent)) {
                                    $('#menuTree').jstree("close_node", fncGetMenuNode(prevNode.parent));
                                }
                            }
                        }

                        gzSelId = data.node.id;
                    });

                    //대시보드 불러오기
                    fncCallPage("", "");
                }
            });
        }

        //메뉴 접기
        function closeMenu() {
            if (gzSelId) {
                var prevNode = fncGetMenuNode(gzSelId);
                $("#" + gzSelId + "_anchor").removeClass("jstree-clicked");

                if (prevNode.original.menuType == "C") {
                    prevNode = fncGetMenuNode(prevNode.parent);
                }

                if (prevNode.id) {
                    $('#menuTree').jstree("toggle_node", prevNode);

                    if (prevNode.parent) {
                        $('#menuTree').jstree("toggle_node", fncGetMenuNode(prevNode.parent));
                    }
                }
            }
        }

        //메뉴 데이터 구성
        function loadMenuData(data) {
            var obj;
            for (var i = 0; i < data.length; i++) {
                obj = data[i];

                if (obj.useYn === 'Y') {
                    obj.id = "menuId_" + obj.id;

                    if (!gzUrlNodeIdMap[obj.url]) {
                        gzUrlNodeIdMap[obj.url] = obj.id;
                    }

                    if (obj.children) {
                        loadMenuData(obj.children);
                    }
                } else {
                    data.splice(i, 1);
                    i--;
                }
            }
        }

        //메뉴노드 구하기
        function fncGetMenuNode(id) {
            return $('#menuTree').jstree("get_node", "#" + id);
        }

        //메뉴선택으로 페이지 호출
        function fncCallPage(url, param) {
            menuLoadImgShow("mainBody");

            var node = fncGetMenuNode(gzUrlNodeIdMap[url]);
            
            //console.log("ur2l : " + url );
            
            if (url === "") {
                url = 'dashboard';  
            } else {
                dhtmlHistory.add(url, param);
            }
			
            //console.log( url + "/" + param );
            //Top Area 정보 가져오기
            fncRetrieveTopAreaInfo();
            
            
            
            $.ajax({
                type: "POST",
                cache: false,
                url: url,
                data: param,
                success: function (data) {
                    // spring security 에서 access denied 발생하여
                    // entry point로 돌아갈 경우(로그인화면으로 돌아갈 경우)
                    if (data.indexOf("j_spring_security_check") != -1) {
                        alert("${smInvalidSession}");
                        location.href = "/";
                        
                    } else {
						
                        if (node) {
                            if (gzUrlBack) {
                                $('#menuTree').jstree("select_node", "#" + node.id);
                            } else if (node.id != gzSelViewId) {
                                return;
                            }

                            var parentNode  = (node.parent === "#") ? null : fncGetMenuNode(node.parent);
                            var gParentNode = (parentNode === null || parentNode.parent === "#") ? null : fncGetMenuNode(parentNode.parent);

                            $("#tSubMenu").text(node.text);

                            if (parentNode && parentNode.text) {
                                $("#sMidMenu").text(parentNode.text);
                                $("[id^='sMidMenu']").css("display", "inline");
                            } else {
                                $("#sTopMenu").text('');
                                $("[id^='sMidMenu']").css("display", "none");
                            }

                            if (gParentNode && gParentNode.text) {
                                $("#sTopMenu").text(gParentNode.text);
                                $("[id^='sTopMenu']").css("display", "inline");
                            } else {
                                $("#sTopMenu").text('');
                                $("[id^='sTopMenu']").css("display", "none");
                            }

                        } else {

                            closeMenu();

                            if (param.subText) {
                                $("#tSubMenu").text(param.subText);
                            } else {
                                $("#tSubMenu").text('');
                            }

                            if (param.midText) {
                                $("#sMidMenu").text(param.midText);
                                $("[id^='sMidMenu']").css("display", "inline");
                            } else {
                                $("#sTopMenu").text('');
                                $("[id^='sMidMenu']").css("display", "none");
                            }

                            if (param.topText) {
                                $("#sTopMenu").text(param.topText);
                                $("[id^='sTopMenu']").css("display", "inline");
                            } else {
                                $("#sTopMenu").text('');
                                $("[id^='sTopMenu']").css("display", "none");
                            }
                        }

                        
                        
                        
                        if (url == "dashboard") {           
                        	$('#homeTitle').css("display", "none");
                        	$("#tSubMenu").text("대시보드");
                        	$("#homeArrow").css("display", "none");
                        }
                        else
                        {
                        	$('#homeTitle').css("display", "inline");
                        	$("#homeArrow").css("display", "inline");
                        }
                        
                        

                        $("#r_contents").html(data);

                        gzUrlBack = false;
                    }

                    //menuLoadImgHide("mainBody");
                    //menuLoadImgHide("mainBody");
                },
                error: function(e) {
                    console.log(url + " 호출 실패", e);
                }
            });
        }

        //Top Area 정보 가져오기
        function fncRetrieveTopAreaInfo() {
            $.ajax({
                type: "POST",
                cache: false,
                url: "/topAreaInfo",
                data: {},
                success: function (data) {
                    $('#topMessageNum').html(data.messageCnt);
                    $('#topNoticeNum').html(data.noticeCnt);
                }
            });
        }

        //시스템 알림으로 페이지 전환
        function fncGotoMessage() {
        	
            //fncCallPage("retrieveEqmtMessageList", "");
            fncCallPage('/retrieveEqmtMessageList', {subText: "시설물알림", midText: "시설물", topText:"통합관제현황"} );
            
        }

        //공지사항으로 페이지 전환
        function fncGotoNotice() {
            //fncCallPage("retrieveNoticeList", {subText: "공지사항"});
        	fncCallPage('/retrieveNoticeList', {subText: "공지사항", midText: "공지사항관리", topText:"시스템관리"} );
            
        }

        //로그아웃
        function fncLogout() {
            if (confirm("${smLogoutCnfm}")) {
                location.href = "/signout";
            }
        }

        /*******************
         화면 공통 스크립트
         ********************/
        //로딩이미지 보이기
        function menuLoadImgShow(divId) {
            $('#' + divId).oLoader({
                backgroundColor: '#000',
                fadeInTime: 800,
                fadeLevel: 0.4,
                image: '/images/loader1.gif',
                style: 3
            });
        }

        //로딩이미지 숨기기
        function menuLoadImgHide(divId) {
            $('#' + divId).oLoader('hide');
        }

        // jqGrrid Resize
        function jqGridResize(gridId) {
            var parObj = $("#" + gridId).parent();

            $("#" + gridId).setGridWidth($(parObj).width() + 15);

            $(window).resize(function () {
                $("#" + gridId).setGridWidth($(parObj).width() + 15);
            });
        }
    </script>
    <%@ include file="/WEB-INF/views/system/validate.jsp" %>
</head>

<body class="mainBody">
<div class="r_popupTitle" id="dialog-confirm" title="" style="display:none;">
    <p>
    	<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">
    	</span>로딩중...
    </p>
</div>

<div id="dialog-confirm-2nd" title="" style="display:none;">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>로딩중...</p>
</div>
<div class="r_wrapper">
    <div class="r_left" id="r_left">
        <div class="r_info">
            <a href="/main" class="r_logo"><img src="/images/img_logo2.png" alt="Logo"/></a>
        </div>

		<!-- 좌측메뉴 전체영역 -->
        <div class="r_leftNav">
        
        	
        	<!-- 매장리스트 단독 메뉴 - 미사용
        	<div class="shop_list">
        		<a href="#">매장리스트</a>
        	</div>        	
        	//매장리스트 단독 메뉴 -->
        	
        	
        	<!-- 메뉴 트리 -->
            <div id="menuTree"></div>
            <!-- //메뉴 트리 -->
            
        </div>
        <!-- //좌측메뉴 전체영역 -->
        
    </div>

    <div id="r_title" class="r_title">
    
    	<!-- 헤더 좌측 영역 -->
    	<div class="r_title_left">
    		
    		<!-- 페이지 제목 -->
	        <h2 class="r_pageTitle">
	            <span id="tSubMenu"></span>
	        </h2>
	        <!-- //페이지 제목 -->

			<!-- 내비게이션 -->
	        <div class="r_pageNav">
	            <span id="sMidMenuArrow" style="display:none;">&lt;</span>
	            <span id="sMidMenu"      style="display:none;"></span>
	            <span id="sTopMenuArrow" style="display:none;">&lt;</span>
	            <span id="sTopMenu"      style="display:none;"></span>
	            <span id="homeArrow"     style="display:none;">&lt;</span>
	            <span id="homeTitle">Home</span>
	        </div>
	        <!-- //내비게이션 -->
	        
		</div>
		<!-- //헤더 좌측 영역 -->
		
		<!-- 헤더 우측 영역 -->
		<div class="r_title_right">
		
			<!-- 사용자 정보 -->
			<ul class="r_user">
				<li class="r_userTitle">${sessionUserVo.sessionCompanyCd}</li>
                <li class="r_userName">(${sessionUserVo.sessionUserNm})</li>
            </ul>
            <!-- //사용자 정보 -->
            
            <!-- 알림 -->
            <div class="message">
            	<a href="#" onclick="javascript:fncGotoMessage()">
            		<span><img src="images/btn_message.png" alt="알림" /></span>
            		<span class="message_num" id="topMessageNum"></span>
            	</a>
            </div>
            <!-- //알림 -->
             
            <!-- 공지사항 -->
            <div class="notice">
            	<a href="#" onclick="javascript:fncGotoNotice()">
            		<span><img src="images/btn_notice.png" alt="공지사항" /></span>
            		<span class="notice_num" id="topNoticeNum"></span>
            	</a>
            </div>
            <!-- //공지사항 -->
            
            <!-- 로그아웃 -->
            <div class="logout">
            	<span><a href="#" onclick="javascript:fncLogout()"><img src="images/btn_logout.png" alt="로그아웃" /></a></span>
            </div>
            <!-- //로그아웃 -->
		
		</div>
		<!-- //헤더 우측 영역 -->
		
    </div>

    <div id="r_contents" class="r_contents">
    </div>
</div>
</body>

</html>