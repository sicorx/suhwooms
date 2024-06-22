package rems.monitoring.ctrl;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.SystemSvc;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class MonitoringGeneralCtrl {

    private static final Logger LOGGER = LoggerFactory.getLogger(MonitoringGeneralCtrl.class);

    @Autowired
    private SystemSvc systemSvc;


    @ModelAttribute("sessionUserVo")
    public SessionUserVo sessionUserVo() {
        return new SessionUserVo();
    }

    /**
     * 로그인 페이지 매핑
     *
     * @return 뷰이름
     */
    @RequestMapping(value = "/mnt", method = {RequestMethod.GET, RequestMethod.POST})
    public String showLoginForm(
            HttpServletRequest req,
            ModelMap model) {

        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
        Locale loc = localeResolver.resolveLocale(req);

        LOGGER.info("showLoginForm : " + loc);

        String view = "monitoring/login";
//        String view = "/monitoring";
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && RememberMeAuthenticationToken.class.isAssignableFrom(authentication.getClass())) {
            view = "redirect:main2";
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
    @RequestMapping(value = "/login_error2", method = {RequestMethod.GET, RequestMethod.POST})
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

        return "monitoring/login";
    }

    /**
     * 로그인 성공할 경우, 세션 정보를 담아 첫 화면으로 포워딩
     *
     * @param userVo
     * @param req
     * @param model
     * @return
     */
    @RequestMapping(value = "/main2", method = {RequestMethod.GET, RequestMethod.POST})
    public String retrieveMain(
            @ModelAttribute UserVo userVo,
            HttpServletRequest req,
            ModelMap model) {

        SecurityContext sc = SecurityContextHolder.getContext();
        Authentication auth = sc.getAuthentication();

        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(req);
        Locale loc = localeResolver.resolveLocale(req);

        LOGGER.info("retrieveMain : auth name: {}, strCd: {}, locale: {}", new Object[] {auth.getName(), userVo.getStrCd(), loc});

        String resolve = "monitoring/layout";

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

        model.addAttribute("sessionUserVo", sessionUserVo);

        return resolve;
    }
}