package rems.energy.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import rems.energy.model.AnhAreaDistListVo;
import rems.energy.model.AnhAreaDistVo;
import rems.energy.model.AnhAreaListVo;
import rems.energy.model.AnhStatusVo;
import rems.energy.model.AnhTempVo;
import rems.energy.model.AnhUsedAreaChrtVo;
import rems.energy.service.EnergyAnhElecSvc;
import rems.system.model.ComCodeVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EnergyHacCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EnergyHacCtrl.class);
	
	@Autowired
	private EnergyAnhElecSvc svc;

	@Autowired
	private CommonSvc commonSvc;
	
    /**
     * 냉난방전력 현황 매핑
     * @param sessionUserVo : 세션 사용자 정보
     * @param model
     * @return
     */
	@RequestMapping(value = "/1201", method = {RequestMethod.GET, RequestMethod.POST})
	public String showTotal(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info("anhStatus : " + sessionUserVo.showData() );
	
		UserVo userVo = new UserVo();
		userVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		userVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		AnhStatusVo anhStatusVo = svc.retrieveAnhStatus(userVo);	//냉난방 전력 현황
		AnhTempVo anhTempVo 	= svc.retrieveAnhTemp(userVo);		//온도 현황
		
		model.addAttribute(anhStatusVo);
		model.addAttribute(anhTempVo);
		
		return "energy/hac/energyHacStatus";
	}
	

	/**
	 * 월별 냉난방전력량 조회(차트)
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveEnergyUsePerMonth", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveEnergyUsePerMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.info("retrieveEnergyUsePerMonth : " + sessionUserVo.showData() );
		
		sessionUserVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );

		UserVo userVo = new UserVo();
		userVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		userVo.setNow(sessionUserVo.getNow());
		
		List<AnhStatusVo> result1 = svc.retrieveEnergyUsePerMonth(userVo);		//월 사용전력량(냉난방)
		
		List<String> yyyymm = new ArrayList<String>();
		List<String> temp     = new ArrayList<String>();
		
		for( AnhStatusVo rtu : result1 ) {
			yyyymm.add( rtu.getYyyymm() );
			temp.add( rtu.getTemp() );
		}
		
		Object result2[] = new Object[2];
		result2[0] = yyyymm.toArray();
		result2[1] = temp.toArray();
		
		return result2;
	}
	
	
	/**
	 * 면적당 냉난방전력량 분포 매핑
	 * 면적당 냉난방전력량 분표 요약 조회(테이블)
	 * 면적당 냉난방전력량 분포 조회(차트)
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 이전 화면에서 넘어온 조회 년월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/1202", method = {RequestMethod.GET, RequestMethod.POST})
	public String showHacUsedDist(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info("showHacUsedDist : " + sessionUserVo.showData() );
	
		String yyyymm = sessionUserVo.getSessionYyyyMm();
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		params.put( "yyyymm", yyyymm );
		params.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();
		
		// 조회년월 조회
		List<HashMap<String, Object>> rslt2 = commonSvc.retrieveYearMonth(params);
		
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
		model.addAttribute("yearMonth", rslt2);
		
		return "energy/hac/energyHacDist";
	}	
	
	@RequestMapping(value = "/retrieveHacTableData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody AnhAreaDistVo retrieveHacTableData(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			HttpSession session) throws Exception {
		
		LOGGER.info("retrieveHacTableData : " +yyyymm);
		
		UserVo param1 = new UserVo();
		param1.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param1.setYyyymm(yyyymm);
		param1.setNow(TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		// 면적당 냉난방전력량 분포 요약(Table)
		AnhAreaDistVo anhAreaDistVo = svc.retrieveAnhAreaDist(param1);
		
		return anhAreaDistVo;
	}
	
	@RequestMapping(value = "/retrieveHacChartData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody AnhUsedAreaChrtVo retrieveHacChartData(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "gvMaxVal", required = false) String maxValParam,
			@RequestParam(value = "gvMinVal", required = false) String minValParam,
			HttpSession session) throws Exception {
		
		LOGGER.info("retrieveHacChartData : " + sessionUserVo.showData() );

		float maxVal = Float.parseFloat( maxValParam );
		float minVal = Float.parseFloat( minValParam );
		double sep = Math.floor( (maxVal - minVal) / 30 );
		ArrayList<String> separator = new ArrayList<String>();
		
		for(int i = 0; i < 30; i++) {
			separator.add( String.valueOf( Math.floor( minVal + ( ( i * sep ) ) ) ) );
		}
		
		UserVo param = new UserVo();
		param.setMinVal( String.valueOf( minVal ) );
		param.setSeparator( separator );
		param.setYyyymm( yyyymm );
		param.setCompanyCd( sessionUserVo.getSessionCompanyCd() );
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		// 면적당 사용전력 분포(Chart)
		AnhUsedAreaChrtVo rslt = svc.retrieveUsedAreaChrt(param);
		
		if( rslt == null ) {
			rslt = new AnhUsedAreaChrtVo();
			rslt.setAllData( "0" );
		}
		
		return rslt;
	}

	/**
	 * 면적당 냉난방전력량 목록 매핑
	 * 면적당 냉난방전력량 분표 요약 조회(테이블)
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 이전 화면에서 넘어온 조회 년월
	 * @param startVal : 이전 화면에서 넘어온 조회 구간 시작
	 * @param endVal : 이전 화면에서 넘어온 조회 구간 끝
	 * @param model
	 * @return
	 */	
	@RequestMapping(value = "/energyHacDistList", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedAreaDistList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "startVal", required = false) String startVal,
			@RequestParam(value = "endVal", required = false) String endVal,
			ModelMap model) {
		
		LOGGER.info("showUsedAreaDistList : "+ sessionUserVo.showData());
		
		UserVo param = new UserVo();
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setYyyymm(yyyymm);
		param.setNow(TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		AnhAreaDistVo anhAreaDistVo = svc.retrieveAnhAreaDist(param);		//면적당 냉난방사용전력량 목록(Table)
		
		model.addAttribute(anhAreaDistVo);
		model.addAttribute("orgYyyymm", yyyymm);
		model.addAttribute("orgStartVal", startVal);
		model.addAttribute("orgEndVal", endVal);
		
		return "energy/hac/energyHacDistList";
	}
	

	/**
	 * 면적당 냉난방전력량 목록 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 이전 화면에서 넘어온 조회 년월
	 * @param startVal : 이전 화면에서 넘어온 조회 구간 시작
	 * @param endVal : 이전 화면에서 넘어온 조회 구간 끝
	 * @return
	 */
	@RequestMapping(value = "/retrieveAnhAreaDistList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AnhAreaDistListVo> retrieveAnhDistList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgStartVal", required = false) String startVal,
			@RequestParam(value = "orgEndVal", required = false) String endVal) {
		
		LOGGER.info("retrieveAnhDistList : "+ sessionUserVo.showData() );
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("companyCd", sessionUserVo.getSessionCompanyCd());
		param.put("yyyymm", yyyymm);
		param.put("startVal", startVal);
		param.put("endVal", endVal);
		param.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<AnhAreaDistListVo> rslt = svc.retrieveAnhAreaDistList(param);		//면적당 냉난방사용전력량 목록(Grid)
		
		GridVo<AnhAreaDistListVo> gridVo = new GridVo<AnhAreaDistListVo>();
		gridVo.setRows( rslt );
		
		return gridVo;
	}
	

	/**
	 * 냉난방전력량 상세 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param viewStrCd : 이전 화면에서 넘어온 뷰매장 코드
	 * @param strCd : 이전 화면에서 넘어온 매장 코드
	 * @param strNm : 이전 화면에서 넘어온 매장 명
	 * @param yyyymm : 이전 화면에서 넘어온 조회 년월
	 * @param startVal : 이전 화면에서 넘어온 조회 구간 시작
	 * @param endVal : 이전 화면에서 넘어온 조회 구간 끝
	 * @return
	 */
	@RequestMapping(value = "/3102", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedDistList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgViewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "orgStrCd", required = false) String strCd,
			@RequestParam(value = "orgStrNm", required = false) String strNm,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgStartVal", required = false) String startVal,
			@RequestParam(value = "orgEndVal", required = false) String endVal,
			ModelMap model) {

		LOGGER.info("showAnhUsedList : ");

		// 년월 조회
		HashMap<String, Object> param1 = new HashMap<String, Object>();
		param1.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, Object>> rslt1 = commonSvc.retrieveYearMonth(param1);
		
		model.addAttribute("yearMonth", rslt1);
		model.addAttribute("orgViewStrCd", viewStrCd);
		model.addAttribute("orgStrCd", strCd);
		model.addAttribute("orgStrNm", strNm);
		model.addAttribute("orgYyyymm", yyyymm);
		model.addAttribute("orgStartVal", startVal);
		model.addAttribute("orgEndVal", endVal);
		
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

		
		return "energy/hac/energyHacUseList";
	}
	

	/**
	 * 월별 냉난방전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseMonthDistList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AnhAreaListVo> retrieveUsedDistMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchOrgCd", required = false) String orgCd,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = false) String yyyymm) {
		
		LOGGER.info("retrieveUsedDistMonth : " + strCd + " : " + yyyymm + " : " + sessionUserVo.showData() );
		
		HashMap<String, String> param = new HashMap<String, String>();

		param.put( "orgCd", orgCd);
		param.put( "strCd", strCd);
		param.put( "yyyymm", yyyymm );
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		param.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<AnhAreaListVo> result = svc.retrieveAnhDistList(param);		//월별 냉난방전력량(Grid)
		
		GridVo<AnhAreaListVo> gridVo = new GridVo<AnhAreaListVo>();
		gridVo.setRows(result);
		
		return gridVo;
	}
	

	/**
	 * 일자별 냉난방전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @return
	 */	
	@RequestMapping(value = "/retrieveUseDailyDistList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<AnhAreaListVo> retrieveUsedDistDaily(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = false) String yyyymm) {
		
		LOGGER.info("retrieveUsedDaily : " + strCd + " : " + yyyymm + " : " + sessionUserVo.showData() );
		
		UserVo param = new UserVo();
		param.setStrCd(strCd);
		param.setYyyymm(yyyymm);
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow(TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));

		List<AnhAreaListVo> result = svc.retrieveUsedDailyDistList(param);		//일별 냉난방전력량(Grid)
		
		GridVo<AnhAreaListVo> gridVo = new GridVo<AnhAreaListVo>();
		gridVo.setRows(result);                      
		
		return gridVo;
	}


	/**
	 * 냉난방사용전력, 실내온도, 실외온도 시간대별 차트 
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @param yyyymmdd
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseHourlyChrt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<HashMap<String, String>> retrieveUsedHourlyChrt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm,
			@RequestParam(value = "srchYyyymmdd", required = true) String yyyymmdd) {
		
		LOGGER.info("retrieveUsedHourlyChrt : " + strCd + " : " + yyyymm + " : " + yyyymmdd );
		
		UserVo param = new UserVo();
		param.setStrCd(strCd);
		param.setYyyymm(yyyymm);
		param.setYyyymmdd(yyyymmdd);
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow(TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, String>> result = svc.retrieveUsedHourlyChrt(param);		//일별 냉난방전력량(Grid)
				
		return result;
	}
	

	/**
	 * 공통코드 조회
	 * @param model
	 * @param commGrpCd
	 * @param commCd
	 * @return
	 */
	@RequestMapping(value = "/retrieveComCodeAnh", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object remsComCodeAnhList(
			@RequestParam(value="commGrpCd",required=false) String commGrpCd,
			@RequestParam(value="commCd",required=false) String commCd,
			ModelMap model) {
		
		LOGGER.info("retrieveComCodeList : " + commGrpCd + ", " + commCd );

		ComCodeVo cond = new ComCodeVo();
    	if (commGrpCd == null || "".equals(commGrpCd)){
        	cond.setCommGrpCd("");
    	} else {
        	cond.setCommGrpCd(commGrpCd);
    	}
    	if (commCd == null || "".equals(commCd)){
        	cond.setCommCd("");
    	} else {
        	cond.setCommCd(commCd);
    	}
    	
    	List<ComCodeVo> list = svc.retrieveComCodeList(cond);

		Object rslt = new Object();
		rslt = list.toArray();
		
		return rslt;
	}	
}