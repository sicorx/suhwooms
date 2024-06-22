package rems.energy.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.energy.model.EpLightStatusVo;
import rems.energy.model.EpLightUsedListVo;
import rems.energy.model.EpWeatherStatusListVo;
import rems.energy.service.EnergyLightEpAllSvc;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EnergyLightCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EnergyLightCtrl.class);
	
	@Autowired
	private EnergyLightEpAllSvc EnergyLightEpAllSvc;

	@Autowired
	private CommonSvc commonSvc;	
	
	
	/**
	 * 조명 전력 현황 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/1301", method = {RequestMethod.GET, RequestMethod.POST})
	public String showLight(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model
			) {

		LOGGER.info("showLight : " + sessionUserVo.showData());
		
		UserVo userVo = new UserVo();
		userVo.setCompanyCd( sessionUserVo.getSessionCompanyCd() );
		userVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		EpLightStatusVo epLightStatusVo = EnergyLightEpAllSvc.retrieveEpLightStatus(userVo);	                      //조명전력 현황		
		List<EpWeatherStatusListVo> epWeatherStatusListVo = EnergyLightEpAllSvc.retrieveWeatherStatusList( userVo ); // 월 사용전력량(조명)

		model.addAttribute( epLightStatusVo );
		model.addAttribute( "epWeatherStatus", epWeatherStatusListVo );
		
		return "energy/light/energyLightStatus";
	}

	
	/**
	 * 월 조명전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseMonthLight", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] remsUseMonthLight(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model
			) {
		
		LOGGER.info( "remsUseMonthLight : " + sessionUserVo.showData() );
		
		UserVo userVo = new UserVo();
		userVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		userVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
				
		List<EpLightStatusVo> rslt1 = EnergyLightEpAllSvc.retrieveUseMonthLight( userVo );
		
		List<String> yyyymm = new ArrayList<String>();
		List<String> light = new ArrayList<String>();
		
		for( EpLightStatusVo rtn : rslt1 ) {
			yyyymm.add( rtn.getYyyymm() );
			light.add( rtn.getLight() );
		}
		
		Object rslt2[] = new Object[2];
		
		rslt2[0] = yyyymm.toArray();
		rslt2[1] = light.toArray();
		
		return rslt2;
	}	

	
	/**
	 * 조명 전력량 상세 조회 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/3103", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedListLight(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "flag", required = false) String flag,
			ModelMap model) {

		LOGGER.info( "showUsedListLight : " );

		// 년월 조회
		HashMap<String, Object> param1 = new HashMap<String, Object>();
		param1.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, Object>> rslt1 = commonSvc.retrieveYearMonth(param1);
		
		model.addAttribute("flag", flag);
		model.addAttribute("yearMonth", rslt1);
		
		// 회사목록 조회
		HashMap<String,Object> param2 = new HashMap<String,Object>();
		param2.put( "userId", sessionUserVo.getSessionUserId() );
		param2.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param2.put( "companyNm", sessionUserVo.getSessionCompanyNm() );

		List<SelectVo> rslt2 = commonSvc.retrieveCompanyCd(param2);
		int selectVoListCnt = rslt2.size();
		
		model.addAttribute("selectVoList", rslt2);
		model.addAttribute("userVo", param2);
		model.addAttribute("selectVoListCnt", selectVoListCnt );

		
		return "energy/light/energyLightUseList";
	}

	
	/**
	 * 월별 조명전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseMonthListLight", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpLightUsedListVo> retrieveLightUsedMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			ModelMap model) {
		
		LOGGER.info("remsUseMonthListLight" + sessionUserVo.showData() );
		
		UserVo param = new UserVo();
		param.setStrCd(strCd);
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpLightUsedListVo> rslt = EnergyLightEpAllSvc.retrieveLightUsedList( param );
		
		GridVo<EpLightUsedListVo> gridVo = new GridVo<EpLightUsedListVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}

	
	/**
	 * 일자별 조명전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseDailyListLight", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpLightUsedListVo> retrieveLightUsedDaily(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = false) String yyyymm,
			ModelMap model) {
		
		LOGGER.info("remsUseDailyListLight" + sessionUserVo.showData() );
		
		UserVo param = new UserVo();
		param.setStrCd(strCd);
		param.setYyyymm(yyyymm);
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpLightUsedListVo> rslt = EnergyLightEpAllSvc.retrieveLightUsedDailyList( param );
		
		GridVo<EpLightUsedListVo> gridVo = new GridVo<EpLightUsedListVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}

}
