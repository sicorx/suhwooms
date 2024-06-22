
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
import rems.energy.model.EpAlarmResultListVo;
import rems.energy.model.EpDashBoardVo;
import rems.energy.model.EpPredictVo;
import rems.energy.model.EpStatusVo;
import rems.energy.model.EpUsedAreaChrtVo;
import rems.energy.model.EpUsedAreaListVo;
import rems.energy.model.EpUsedAreaVo;
import rems.energy.model.EpUsedListVo;
import rems.energy.service.EnergyElecAllSvc;
import rems.system.model.ComCodeVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EnergyMainCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EnergyMainCtrl.class);
	
	@Autowired
	private EnergyElecAllSvc svc;

	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}

	
	/**
	 * 대쉬보드
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
/*
	@RequestMapping(value = "/1101", method = {RequestMethod.GET, RequestMethod.POST})
	public String showDashBoard(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.info("showTotal2 : " + sessionUserVo.showData() );
	
		sessionUserVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		UserVo userVo = new UserVo();
		userVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		userVo.setNow(sessionUserVo.getNow());
		
		//EpPredictVo epPredictVo = svc.retrievePredictUse(userVo);	//전력 예측 대비 사용률
		
		HashMap<String,Object> param = new HashMap<String,Object>();
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "strCD", sessionUserVo.getSessionStrCd() );
		EpDashBoardVo epDashBoardWatageVo = svc.retrieveDashBoardWatageStatus(param);		//전력현황
		
		model.addAttribute("bYesterDayWatage", epDashBoardWatageVo.getbYesterDayWatage());
		model.addAttribute("yesterDayWatage", epDashBoardWatageVo.getYesterDayWatage());
		model.addAttribute("toDayWatage", epDashBoardWatageVo.getToDayWatage());		
		
		//return "energy/main/energyMainStatus";
		return "energy/main/energyMainDashBoard";
		
	}
*/
	
	
	
	/**
	 * 통합관제현황 - 전체전력사용현황
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyUseStatus", method = {RequestMethod.GET, RequestMethod.POST})
	public String showTotal(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.info("showTotal : " + sessionUserVo.showData() );
		
		sessionUserVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd());		// 세션 업체 코드
		
		// 시스템 현재일자
		String toDayMonth = commonSvc.retrieveSysdate().substring(0, 7);
		
		// 전체매장수, 전체일평균총사용량, 일평균 매장별 사용량	
		EpStatusVo totalVal = svc.retrieveEpTotalStatus(params);
	
		model.addAttribute("userVo", 			params);		
		model.addAttribute("toDayMonth", 		toDayMonth);
		model.addAttribute("totalVal", 			totalVal);		
		
		return "energy/main/energyMainStatus";		
	}
	
	
	/**
	 * 전체 월별 사용량
	 * 
	 * @author JooYoung
	 * @param strCd : 시스템 매장코드
	 * @param scrDateFrom : 검색일자 From
	 * @param scrDateTo : 검색일자 To
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo : 월별 전력 현황 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyUseMonthStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpStatusVo> retrieveEnergyUseMonthStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srcStrCd", required = false) 		String strCd,						
			@RequestParam(value = "scrDateFrom", required = false) 		String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 		String scrDateTo,						
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.info("retrieveEnergyUseMonthStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd );
		params.put("scrDateFrom", scrDateFrom );
		params.put("scrDateTo", scrDateTo );		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("sidx", sidx);
		params.put("sord", sord);		
		
		List<EpStatusVo> epMonthStatsVo = svc.retrieveEpMonthStatus(params);	// 일별 전력량
		//List<EpStatusVo> epDayStatsVo = svc.retrieveEpDayStatus(params);		// 일별 전력량
		
		//EpPredictVo epPredictVo = svc.retrievePredictUse(userVo);	//전력 예측 대비 사용률
		
		//model.addAttribute(epStatusVo);
		//model.addAttribute(epMonthStatsVo);
		//model.addAttribute(epDayStatsVo);
		
		
		//List<EpUsedListVo> result = svc.retrieveUsedList(param);		//월별 전력량(Grid)
		
		GridVo<EpStatusVo> gridVo = new GridVo<EpStatusVo>();
		gridVo.setRows(epMonthStatsVo);
		
		return gridVo;
	}
	
	
	/**
	 * 전체 일별 사용량
	 * 
	 * @author JooYoung
	 * @param strCd : 시스템 매장코드
	 * @param yyyymm : 검색월	 * 
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo : 일별 전력 현황 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyUseDayStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpStatusVo> retrieveEnergyUseDayStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,			
			@RequestParam(value = "scrYyyymm", required = false)		String yyyymm,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.info("retrieveEnergyUseDayStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		
		params.put("srcYyyymm", yyyymm );		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		params.put("sidx", sidx);
		params.put("sord", sord);		
				
		List<EpStatusVo> epDayStatsVo = svc.retrieveEpDayStatus(params);		// 일별 전력량		
		
		GridVo<EpStatusVo> gridVo = new GridVo<EpStatusVo>();
		gridVo.setRows(epDayStatsVo);
		
		return gridVo;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	/**
	 * 월별 전체전력량 차트 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseMonth", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveUseMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo
			) {
		
		LOGGER.info("retrieveUseMonth : " + sessionUserVo.showData() );
		
		sessionUserVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		UserVo userVo = new UserVo();
		userVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		userVo.setNow(sessionUserVo.getNow());
		
		List<EpStatusVo> result1 = svc.retrieveUseMonth(userVo);		//월 사용 전력량
		
		List<String> yyyymm = new ArrayList<String>();
		List<String> temp = new ArrayList<String>();
		List<String> light = new ArrayList<String>();
		List<String> etc = new ArrayList<String>();
		
		for( EpStatusVo rtu : result1 ) {
			yyyymm.add( rtu.getYyyymm() );
			temp.add( rtu.getTemp() );
			light.add( rtu.getLight() );
			etc.add( rtu.getEtc() );
		}
		
		Object result2[] = new Object[4];
		result2[0] = yyyymm.toArray();
		result2[1] = temp.toArray();
		result2[2] = light.toArray();
		result2[3] = etc.toArray();
		
		return result2;
	}
	
	
	/**
	 * 면적당 전력량 분포 매핑
	 * 면적당 전력량 분표 요약 조회(테이블)
	 * 면적당 전력량 분포 조회(차트) 
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 조회년월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/1102", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedArea(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info("showUsedArea : " + sessionUserVo.showData() );

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
		
		return "energy/main/energyMainDist";
	}
	
	@RequestMapping(value = "/retrieveTotalTableData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody EpUsedAreaVo retrieveTotalTableData(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			HttpSession session) throws Exception {
		
		LOGGER.info("retrieveTotalTableData : " +yyyymm);
		
		UserVo param = new UserVo();
		param.setCompanyCd( sessionUserVo.getSessionCompanyCd() );
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		param.setYyyymm( yyyymm );
		
		// 면적당 사용전력 분포 요약(Table)
		EpUsedAreaVo epUsedAreaVo = svc.retrieveUsedArea(param);
		
		return epUsedAreaVo;
	}
	
	@RequestMapping(value = "/retrieveTotalChartData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody EpUsedAreaChrtVo retrieveTotalChartData(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "gvMaxVal", required = false) String maxValParam,
			@RequestParam(value = "gvMinVal", required = false) String minValParam,
			HttpSession session) throws Exception {
		
		LOGGER.info("retrieveTotalChartData : " + sessionUserVo.showData() );

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
		EpUsedAreaChrtVo rslt = svc.retrieveUsedAreaChrt(param);
		
		if( rslt == null ) {
			rslt = new EpUsedAreaChrtVo();
			rslt.setAllData( "0" );
		}
		
		return rslt;
	}
	
	/**
	 * 전체전력량 분포 목록 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 전체전력량 분포에서 넘긴 조회년월, 월별 전력량 목록에서 넘긴 조회년월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/energyDistList", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedAreaList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "startVal", required = false) String startVal,
			@RequestParam(value = "endVal", required = false) String endVal,
			ModelMap model) {
	
		LOGGER.info("showUsedAreaList session : " + sessionUserVo.showData() + " prev page : " + yyyymm + " : " + startVal + " : " + endVal);
		
		UserVo param = new UserVo();
		param.setCompanyCd( sessionUserVo.getSessionCompanyCd() );
		param.setStrCd( sessionUserVo.getSessionStrCd() );
		param.setYyyymm( yyyymm );
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		EpUsedAreaVo epUsedAreaVo = svc.retrieveUsedArea(param);		//면적당 사용전력량 목록(Table)
		
		model.addAttribute(epUsedAreaVo);
		model.addAttribute("orgYyyymm", yyyymm);
		model.addAttribute("startVal", startVal );
		model.addAttribute("endVal", endVal );
		
		return "energy/main/energyMainDistList";
	}
	
	
    /**
     * 전체전력량 분포 목록 그리드 조회 
     * @param sessionUserVo : 세션 사용자 정보
     * @param startVal : 전체전력량 분포 시작 값
     * @param endVal : 전체전력량 분포 끝 값
     * @return
     */
	@RequestMapping(value = "/retrieveUseAreaList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<EpUsedAreaListVo> retrieveUseAreaList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "startVal", required = false) String startVal,
			@RequestParam(value = "endVal", required = false) String endVal){
		
		LOGGER.info("retrieveUseAreaList : " + sessionUserVo.showData() );
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put("strCd", sessionUserVo.getSessionStrCd() );
		param.put("yyyymm", yyyymm );
		param.put("startVal", startVal );
		param.put("endVal", endVal );
		param.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpUsedAreaListVo> result = svc.retrieveUsedAreaList(param);		//면적당 사용전력량 목록(Grid)
				
		return result;
	}
	
	
	/**
	 * 월별, 일자별 전체전력량 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param orgYyyymm : 전체전력량 분포 화면에서 조회할 때 사용한 년월
	 * @param orgStartVal : 전체전력량 분포 화면에서 조회할 때 사용한 구간 시작
	 * @param orgEndVal : 전체전력량 분포 화면에서 조회할 때 사용한 구간 끝
	 * @return
	 */
	@RequestMapping(value = "/3101", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUsedList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgViewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "orgStrCd", required = false) String strCd,
			@RequestParam(value = "orgStrNm", required = false) String strNm,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgStartVal", required = false) String startVal,
			@RequestParam(value = "orgEndVal", required = false) String endVal,
			ModelMap model) {
			
		LOGGER.info("showUsedList : " +  yyyymm + " : " + startVal + " : " + endVal);

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

		
		return "energy/main/energyMainUseList";
	}
	

	/**
	 * 월별 전체전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param startMonth : 조회 월 시작 값 
	 * @param endMonth : 조회 월 끝 값
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseMonthList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpUsedListVo> retrieveUsedMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = false) String yyyymm) {
		
		LOGGER.info("retrieveUsedMonth : " + sessionUserVo.showData() + " srchYyyymm : " + yyyymm + " srchStrCd : " + strCd);
		
		UserVo param = new UserVo();
		param.setStrCd( strCd );
		param.setYyyymm( yyyymm );
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<EpUsedListVo> result = svc.retrieveUsedList(param);		//월별 전력량(Grid)
		
		GridVo<EpUsedListVo> gridVo = new GridVo<EpUsedListVo>();
		gridVo.setRows(result);
		
		return gridVo;
	}
		
	
	/**
	 * 일자별 전체전력량 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 조회할 월
	 * @return
	 */
	@RequestMapping(value = "/retrieveUseDailyList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<EpUsedListVo> retrieveUsedDaily(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm) {
		
		LOGGER.info("retrieveUsedDaily : " + sessionUserVo.showData() + " srchYyyymm : " + yyyymm + " srchStrCd : " + strCd );
		
		UserVo param = new UserVo();
		param.setStrCd( strCd );
		param.setYyyymm( yyyymm );
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );

		List<EpUsedListVo> result = svc.retrieveUsedDailyList(param);		//일별 전력량(Grid)

		return result;
	}
	
	
	/**
	 * 냉난방전력량, 조명전력량, 기타전력량 시간대별 차트 
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @param yyyymmdd : 조회할 일자
	 * @return
	 */
	@RequestMapping(value = "/retrieveMainUseHourlyChrt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<HashMap<String, String>> retrieveMainUseHourlyChrt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm,
			@RequestParam(value = "srchYyyymmdd", required = true) String yyyymmdd) {
		
		LOGGER.info("retrieveMainUseHourlyChrt : " + strCd + " : " + yyyymm + " : " + yyyymmdd );
		
		UserVo param = new UserVo();
		param.setStrCd(strCd);
		param.setYyyymm(yyyymm);
		param.setYyyymmdd(yyyymmdd);
		param.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		param.setNow(TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, String>> result = svc.retrieveMainUseHourlyChrt(param);		//일별 냉난방전력량(Grid)
				
		return result;
	}

	
	/**
	 * 온실가스배출량 화면 매핑
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/1103", method = {RequestMethod.GET, RequestMethod.POST})
	public String showGreenHouseGasEmit(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model
			) {
		
		LOGGER.info("showGreenHouseGasEmit : " + sessionUserVo.showData());
			
		return "energy/main/energyGhouseGasEmit";
	}
	
	
	
	/**
	 * 온실가스 차트
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveGhouseGasMonth", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveGhouseGasMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo
			) {
		
		LOGGER.info("retrieveUseMonth : " + sessionUserVo.showData() );
		
		sessionUserVo.setNow( TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		UserVo userVo = new UserVo();
		userVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		userVo.setNow(sessionUserVo.getNow());
		
		//List<EpStatusVo> result1 = svc.retrieveUseMonth(userVo);		//월 사용 전력량
		List<EpStatusVo> result1 = svc.retrieveGhouseGasMonth(userVo);		//월 사용 전력량
		
		List<String> yyyymm = new ArrayList<String>();
		List<String> total = new ArrayList<String>();		
		
		for( EpStatusVo rtu : result1 ) {
			yyyymm.add( rtu.getYyyymm() );
			total.add( rtu.getTotal() );			
		}
		
		Object result2[] = new Object[4];
		result2[0] = yyyymm.toArray();
		result2[1] = total.toArray();		
		
		return result2;
	}
	
	
	
	
	/**
	 * 공통코드 조회
	 * @param commGrpCd : 공통 그룹 코드
	 * @param commCd : 공통 코드
	 * @return
	 */
	@RequestMapping(value = "/retrieveComCodeElec", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object remsComCodeElecList(
			@RequestParam(value="commGrpCd",required=false) String commGrpCd,
			@RequestParam(value="commCd",required=false) String commCd ) {
		
		LOGGER.info("retrieveComCodeList : " + commGrpCd + ", " + commCd );

		ComCodeVo cond = new ComCodeVo();
    	if (commGrpCd == null || "".equals(commGrpCd)){
        	cond.setCommGrpCd("");
    	} 
    	else {
        	cond.setCommGrpCd(commGrpCd);
    	}
    	
    	if (commCd == null || "".equals(commCd)){
        	cond.setCommCd("");
    	} 
    	else {
        	cond.setCommCd(commCd);
    	}
    	
    	List<ComCodeVo> list = svc.retrieveComCodeList(cond);

		Object rslt = new Object();
		rslt = list.toArray();
		
		return rslt;
	}
	
	/**
	 * 대시보드 알람,피크 내역 클릭시
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 전체전력량 분포에서 넘긴 조회년월, 월별 전력량 목록에서 넘긴 조회년월
	 * @param model
	 * @return
	 */	
	@RequestMapping(value = "/energyDashBoardList", method = {RequestMethod.GET, RequestMethod.POST})
	public String energyDashBoardList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "asResultFlag", required = false) String asResultFlag,
			@RequestParam(value = "range", required = false) String range,
			ModelMap model) {
	
		LOGGER.info("energyDashBoardList session : " + sessionUserVo.showData() + "  : " + asResultFlag + " : " + range);
		
		
		
		HashMap<String,Object> param = new HashMap<String,Object>();
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "strCD", sessionUserVo.getSessionStrCd() );
		param.put( "asResultFlag", asResultFlag);
		param.put( "range", range);
		param.put( "userId", sessionUserVo.getSessionUserId());
		
		
		model.addAttribute("asResultFlag", asResultFlag);
		model.addAttribute("range", range);		
		
		return "energy/main/energyMainDashBoardList";
	}
	
	
	
	
	
	
	/**
	 * 시설물 알람 발생 매장 개수 가져오기
	 * @param sessionUserVo : 세션 사용자 정보 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveAlarmResultCntList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody EpAlarmResultListVo retrieveAlarmResultCntList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo )
			{
	
		LOGGER.info("retrieveAlarmResultList session : " + sessionUserVo.showData());
		
		
		
		HashMap<String,Object> param = new HashMap<String,Object>();
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "strCD", sessionUserVo.getSessionStrCd() );		
		param.put( "userId", sessionUserVo.getSessionUserId());		
		
		EpAlarmResultListVo rslt = svc.retrieveAlarmResultCntList(param);		// 시설물 알람 조치,미조치 내역
		
		
		return rslt;
	}
	
	
	
	
	
	
	
	
	
	/**
	 * 알람 내역 가지고 오기
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 전체전력량 분포에서 넘긴 조회년월, 월별 전력량 목록에서 넘긴 조회년월
	 * @param model
	 * @return
	 */	
	@RequestMapping(value = "/retrieveAlarmResultList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpAlarmResultListVo> retrieveAlarmResultList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "asResultFlag", required = false) String asResultFlag,
			@RequestParam(value = "range", required = false) String range,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
	
		LOGGER.info("retrieveAlarmResultList session : " + sessionUserVo.showData() + "  : " + asResultFlag + " : " + range);
		
		
		
		HashMap<String,Object> param = new HashMap<String,Object>();
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "strCD", sessionUserVo.getSessionStrCd() );
		param.put( "asResultFlag", asResultFlag);
		param.put( "range", range);
		param.put( "userId", sessionUserVo.getSessionUserId());
		param.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		param.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		param.put( "sidx", sidx );                        // 정렬 기준 컬럼
		param.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		List<EpAlarmResultListVo> rslt = svc.retrieveAlarmResultList(param);		// 시설물 알람 조치,미조치 내역
		
		int records = rslt.size();
		
		GridVo<EpAlarmResultListVo> gridVo = new GridVo<EpAlarmResultListVo>();
		gridVo.setRows( rslt );
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		
		
		
		return gridVo;
	}
	
	
	
	
	
	
	
	
}
