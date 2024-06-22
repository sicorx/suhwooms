package rems.system.ctrl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.system.model.ComCodeVo;
import rems.system.model.HVACPolicyMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.HVACPolicyMgntSvc;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : HVACPolicyMgntCtrl.java
 * @Description : 시스템관리 > 정책관리 > 냉난방정책
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 24.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 24. 오후 5:48:18
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class HVACPolicyMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(HVACPolicyMgntCtrl.class);
	
	@Autowired
	private HVACPolicyMgntSvc hvacPolicyMgntSvc;			// 서비스 변수
	
	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}
	
	/**
	 * 시스템관리 > 정책관리 > 냉난방정책 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return hvacPolicyMgntMst : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4105", method = {RequestMethod.GET, RequestMethod.POST})
	public String showSeasonPolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.error("showSeasonPolicyMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 공통코드 select
		ComCodeVo cond = new ComCodeVo();
		cond.setCommGrpCd("VIEW11");
		List<ComCodeVo> rslt2 = commonSvc.retrieveComCodeList(cond);
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList2", rslt2);
		
		return "system/hvacPolicyMgntMst";
	}
	
	/**
	 * 냉난방정책 상세내역
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveSeasonPolicyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<HVACPolicyMgntVo> retrieveSeasonPolicyMgnt(
			@RequestParam(value = "companyCd", required = false) String companyCd
			) {
		
		LOGGER.error("retrieveSeasonPolicyMgnt : " + companyCd );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );		// 회사 코드
		
		// 냉난방정책 상세내역
		HVACPolicyMgntVo rslt = hvacPolicyMgntSvc.retrieveSeasonPolicyMgnt( params );
		
		return rslt;
	}
	
	/**
	 * 냉난방정책 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param HVACPolicyMgntVo : 낸난방정책Vo
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveAirConditionPolicyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveAirConditionPolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute HVACPolicyMgntVo paramVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveAirConditionPolicyMgnt : "+ paramVo.getCompanyCd() +", "+paramVo.getMm()  );

		paramVo.setRegiId(sessionUserVo.getSessionUserId());		// 등록 아이디
		paramVo.setFinalModId(sessionUserVo.getSessionUserId());	// 최종 수정 아이디

		// 냉난방정책 저장
		boolean rslt = hvacPolicyMgntSvc.saveAirConditionPolicyMgnt( paramVo );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
}