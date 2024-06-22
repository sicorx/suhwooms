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

import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.system.model.GridDimmTimePolicyMgntVo;
import rems.system.model.GridDimmWeatherPolicyMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.DimmPolicyMgntSvc;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")

public class DimmPolicyMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(DimmPolicyMgntCtrl.class);

	@Autowired
	private DimmPolicyMgntSvc dimmPolicyMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@RequestMapping(value = "/4104", method = {RequestMethod.GET, RequestMethod.POST})
	public String showDPolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,
			ModelMap model) {

		LOGGER.info("showDPolicyMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
				
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		
		int selectVoListCnt = rslt.size();
	
		model.addAttribute("selectVoListCnt", selectVoListCnt);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
		
		return "system/dimmMgnt";
	}

	@RequestMapping(value = "/retrieveDimmTimePolicyList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<GridDimmTimePolicyMgntVo> retrieveDimmTimePolicyList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd
			) {
		
		LOGGER.info("retrieveDimmTimePolicyList : " + scrCompanyCd );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", scrCompanyCd );
		
		List<GridDimmTimePolicyMgntVo> rslt = dimmPolicyMgntSvc.retrieveDimmTimePolicyList(params);
		
		return rslt;
	}
	
	
	@RequestMapping(value = "/retrieveDimmWeatherPolicyList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<GridDimmWeatherPolicyMgntVo> retrieveDimmWeatherPolicyList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd
			) {
		
		LOGGER.info("retrieveDimmWeatherPolicyList " + scrCompanyCd );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", scrCompanyCd );
		
		List<GridDimmWeatherPolicyMgntVo> rslt = dimmPolicyMgntSvc.retrieveDimmWeatherPolicyList(params);
		
		return rslt;
	}
	

	@RequestMapping(value = "/saveDimmTimePolicyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveDimmTimePolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridDimmTimePolicyMgntVo gdtpmVo,			
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {		
		
		
		gdtpmVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		gdtpmVo.setRegiId(sessionUserVo.getSessionUserId());
		gdtpmVo.setRegiIdDttm(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));
				
		LOGGER.info("DimCd :	 			"+ gdtpmVo.getDimCd() );
		LOGGER.info("RegiId : 				"+ gdtpmVo.getRegiId() );
		LOGGER.info("CompanyCd : 			"+ gdtpmVo.getCompanyCd() );
		LOGGER.info("RegiIdDttm : 			"+ gdtpmVo.getRegiIdDttm() );
		LOGGER.info("timeSunDimmList : 		"+ gdtpmVo.getTimeSunDimmList() );
		LOGGER.info("timeUnSunDimmList :	"+ gdtpmVo.getTimeUnSunDimmList() );
		
		boolean rslt = dimmPolicyMgntSvc.saveDimmTimePolicyMgnt( gdtpmVo );
		LOGGER.info(" [ rslt Time      ] ################## "+rslt+" ================");
		
		return rslt;
		
	}
		
	@RequestMapping(value = "/saveDimmWeatherPolicyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveDimmWeatherPolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridDimmWeatherPolicyMgntVo gdwpmVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		gdwpmVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		gdwpmVo.setRegiId(sessionUserVo.getSessionUserId());
		gdwpmVo.setFinalId(sessionUserVo.getSessionUserId());
		gdwpmVo.setRegiIdDttm(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));
		gdwpmVo.setFinalModDttm(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));
		
		boolean rslt = dimmPolicyMgntSvc.saveDimmWeatherPolicyMgnt( gdwpmVo );
		LOGGER.info("[rslt Weather      ] =====weather======= "+rslt+" #######weather#########");
		
		return rslt;
		
	}
}