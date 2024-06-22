package rems.system.ctrl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.SystemSvc;
import rems.util.JstreeData;
import rems.util.TimezoneUtils;
import rems.util.TreeUtil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@SessionAttributes("sessionUserVo")
public class SystemGeneralCtrl {

    private static final Logger LOGGER = LoggerFactory.getLogger(SystemGeneralCtrl.class);

    @Autowired
    private SystemSvc systemSvc;


    @ModelAttribute("sessionUserVo")
    public SessionUserVo sessionUserVo() {
        return new SessionUserVo();
    }


    @RequestMapping(value = "/showAjaxPage", method = {RequestMethod.GET, RequestMethod.POST})
    public String showAjaxPage(
            @RequestParam(value = "pagePath", required = false) String pagePath,
            @RequestParam(value = "pageName", required = false) String pageName,
            ModelMap model) {

        LOGGER.info("showAjaxPage : " + pageName);

        String view = pagePath + "/" + pageName;

        if ("/".equals(view)) {
            view = "";
        }

        return view;
    }

    /**
     * 로그인 페이지 매핑
     *
     * @return 뷰이름
     */
    @RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    public String showLoginForm(
            HttpServletRequest req,
            ModelMap model) {

        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
        Locale loc = localeResolver.resolveLocale(req);

        LOGGER.info("showLoginForm : " + loc);

        String view = "system/auth";
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && RememberMeAuthenticationToken.class.isAssignableFrom(authentication.getClass())) {
            view = "redirect:main";
        }

        model.addAttribute("loc", loc);

        return view;
    }

    /**
     * 로그인 실패한 경우를 처리하는 메소드
     *
     * @param err security-context.xml 에서 지정한 err코드
     * @param header jsp페이지에서 넘어온 header정보
     * @param model 모델맵객체
     * @return 뷰이름
     */
    @RequestMapping(value = "/login_error", method = {RequestMethod.GET, RequestMethod.POST})
    public String showLoginErrorPage(
            @RequestParam(value = "err", required = false) String err,
            @RequestHeader("user-agent") String header,
            ModelMap model) {

        LOGGER.info("showLoginErrorPage : " + err + " : " + header);

        String message = "";

        if ("1".equals(err)) {
            message = "로그인 정보가 올바르지 않습니다.";
        } else if ("2".equals(err)) {
            message = "세션이 유효하지 않습니다.";
        } else if ("3".equals(err)) {
            message = "세션 정보가 올바르지 않습니다.";
        }

        model.addAttribute("message", message);

        return "system/auth";
    }

    /**
     * 로그인 성공할 경우, 세션 정보를 담아 첫 화면으로 포워딩
     *
     * @param userVo
     * @param req
     * @param model
     * @return
     */
    @RequestMapping(value = "/main", method = {RequestMethod.GET, RequestMethod.POST})
    public String retrieveMain(
            @ModelAttribute UserVo userVo,
            HttpServletRequest req,
            ModelMap model) {

        SecurityContext sc = SecurityContextHolder.getContext();
        Authentication auth = sc.getAuthentication();

        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
        Locale loc = localeResolver.resolveLocale(req);

        LOGGER.info("retrieveMain : auth name: {}, strCd: {}, locale: {}", new Object[] {auth.getName(), userVo.getStrCd(), loc});

        String resolve = "system/layout";

        userVo.setUserId(auth.getName());
        SessionUserVo sessionUserVo = systemSvc.retrieveLoginUser(userVo);

        String now = TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff());

        sessionUserVo.setSessionYyyyMmDd(now.substring(0, 8));
        sessionUserVo.setSessionYyyyMm(now.substring(0, 6));

        // 사용자 약관에 동의하지 않았을 경우, 동의 페이지로 이동
        if ("N".equals(sessionUserVo.getSessionEulaYn())) {
            resolve = "system/eula";

            model.addAttribute("loc", loc);
        }
        /*
        else {
            List<HashMap<String, String>> rslt1 = retrieveMenu(sessionUserVo);

            model.addAttribute("topMenu", rslt1);
        }
        */

        model.addAttribute("sessionUserVo", sessionUserVo);

        return resolve;
    }

    /**
     * 사용자약관 동의여부를 저장한다.
     *
     * @param sessionUserVo 세션사용자정보
     * @param eulaYn 사용자약관 동의여부
     * @return
     */
    @RequestMapping(value = "/saveEulaYn", method = RequestMethod.POST)
    public String saveEulaYn(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
            @RequestParam(value = "radEula", required = false) String eulaYn) {

        LOGGER.info("saveEulaYn : {}", eulaYn);

        String rslt = "redirect:/j_spring_security_logout";

        if ("Y".equals(eulaYn)) {
            HashMap<String, Object> params = new HashMap<>();
            params.put("eulaYn",    eulaYn);
            params.put("userId",    sessionUserVo.getSessionUserId());
            params.put("now",       TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

            if (systemSvc.saveEulaYn(params) == 1) {
                rslt = "redirect:/main";
            }
        }

        return rslt;
    }

    /**
     * 로케일을 변경한다.
     *
     * @param req HttpServletRequest객체
     * @param res HttpServletResponse객체
     * @param locale 로케일
     * @return 뷰이름
     */
    @RequestMapping(value = "/changeLocale", method = RequestMethod.GET)
    public String changeLocal(
            HttpServletRequest req,
            HttpServletResponse res,
            @RequestParam(required = false) String locale) {

        Locale loc;

        if (locale.matches("en")) {
            loc = Locale.ENGLISH;
        } else {
            loc = Locale.KOREAN;
        }

        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
        localeResolver.setLocale(req, res, loc);

        String rslt = "redirect:" + req.getHeader("referer");

        LOGGER.info("changedLocale : {}", locale);

        return rslt;
    }

    /**
     * 로그아웃
     *
     * @param vo 세션사용자정보
     * @param session SessionStatus객체
     * @param request HttpServletRequest객체
     * @param response HttpServletResponse객체
     * @return 뷰이름
     */
    @RequestMapping(value = "/signout", method = RequestMethod.GET)
    public String deleteSession(
            @ModelAttribute("sessionUserVo") SessionUserVo vo,
            SessionStatus session,
            HttpServletRequest request,
            HttpServletResponse response) {

        LOGGER.info("deleteSession : {}", vo.getSessionUserId());

        session.setComplete();

        String cookieName = "SPRING_SECURITY_REMEMBER_ME_COOKIE";
        Cookie cookie = new Cookie(cookieName, null);
        cookie.setMaxAge(0);
        cookie.setPath(StringUtils.hasLength(request.getContextPath()) ? request.getContextPath() : "/");
        response.addCookie(cookie);

        return "redirect:/j_spring_security_logout";
    }

    /**
     * TopArea 정보 조회
     *
     * @param sessionUserVo 세션사용자정보
     * @return 메뉴 JSON 문자열
     */
    @RequestMapping(value = "/topAreaInfo", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody Map<String, Object> retrieveTopAreaInfo(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo) {

        Map<String, String> param = new HashMap<>();
        param.put("userId",     sessionUserVo.getSessionUserId());
        param.put("companyCd",  sessionUserVo.getSessionCompanyCd());
        param.put("authId",     sessionUserVo.getSessionAuthId());

        Map<String, Object> topAreaInfo = systemSvc.retrieveTopAreaInfo(param);

        LOGGER.debug("topAreaInfo:\n{}", topAreaInfo);

        return topAreaInfo;
    }

    /**
     * 메뉴 조회
     *
     * @param sessionUserVo 세션사용자정보
     * @return 메뉴 JSON 문자열
     */
    @RequestMapping(value = "/menu", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody Map<String, Object> retrieveMenu(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo) {

        SecurityContext sc = SecurityContextHolder.getContext();
        Authentication auth = sc.getAuthentication();

        LOGGER.info("sc : {}", sc);
        LOGGER.info("retrieveMenu : {}", auth.getName());

        Map<String, String> param = new HashMap<>();
        param.put("userId",     sessionUserVo.getSessionUserId());
        param.put("companyCd",  sessionUserVo.getSessionCompanyCd());
        param.put("locale",     LocaleContextHolder.getLocale().getLanguage());

        List<Map<String, Object>> menuList = systemSvc.retrieveMenu(param);

        LOGGER.debug("menuList:\n{}", menuList);

        Map<String, String> optionAttrMap = new LinkedHashMap<>();
        optionAttrMap.put("menuId",     "menuId");
        optionAttrMap.put("menuType",   "menuType");
        optionAttrMap.put("url",        "url");
        optionAttrMap.put("indexHier",  "indexHier");
        optionAttrMap.put("useYn",      "useYn");

        String json = TreeUtil.makeJson(new JstreeData(menuList, "menuId", "text", "indexHier", optionAttrMap) {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "P".equals(map.get("menuType"));
            }
        });

        LOGGER.debug("json:\n{}", json);

        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("success", true);
        jsonObject.put("json", json);

        return jsonObject;
    }
}