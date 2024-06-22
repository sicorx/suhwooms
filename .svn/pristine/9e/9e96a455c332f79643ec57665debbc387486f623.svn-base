package rems.eqmt.ctrl;

import java.io.UnsupportedEncodingException;
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

import rems.common.model.SelectVo;
import rems.common.service.CommonSvc;
import rems.eqmt.model.PlantStatusListVo;
import rems.eqmt.service.EqmtLayoutSvc;
import rems.eqmt.service.EqmtStatusSvc;
import rems.system.model.SessionUserVo;
import rems.util.TimezoneUtils;


@Controller
@SessionAttributes("sessionUserVo")
public class EqmtLayoutCtrl {

	@Autowired
	private EqmtLayoutSvc svc;
	
	@Autowired
	private EqmtStatusSvc eqmtStatusSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtLayoutCtrl.class);
	
	@ModelAttribute("seesionUserVo")
	public SessionUserVo sessionUserVo() {
		
		return new SessionUserVo();
	}
	
	
	/**
	 * 매장 레이아웃 화면 매핑
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/3203", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreEqmtLayout(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgStrCd", required = false) String orgStrCd,
			@RequestParam(value = "orgStrNm", required = false) String orgStrNm,
			ModelMap model) {
	
		LOGGER.info( "showStoreEqmtLayout" );		

		// 회사목록 조회
		HashMap<String,Object> param3 = new HashMap<String,Object>();
		param3.put( "userId", sessionUserVo.getSessionUserId() );
		param3.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param3.put( "companyNm", sessionUserVo.getSessionCompanyNm() );

		List<SelectVo> rslt3 = commonSvc.retrieveCompanyCd(param3);
		int selectVoListCnt = rslt3.size();
		
		model.addAttribute("selectVoList", rslt3);
		model.addAttribute("userVo", param3);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		model.addAttribute("orgStrCd", orgStrCd);
		model.addAttribute("orgStrNm", orgStrNm);
				
		return "eqmt/layout/eqmtLayout";
	}
	
	
	/**
	 * 매장 레이아웃 화면의 도면 조회	
	 * @param userVo 세션 사용자 정보
	 * @param strcd 조회할 매장 코드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveStoreEqmtLayout", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveStoreEqmtLayout(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			ModelMap model) {	
		
		LOGGER.info( "retrieveStoreEqmtLayout : " + sessionUserVo.showData() );
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("companyCd", sessionUserVo.getSessionCompanyCd());
		map.put("strCd"    , strCd);		
		map.put("now"      , TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		
		// 모든 시설물의 현재 온도 및 알람 값 조회 
		List<HashMap<String, String>> curTempAlarm = svc.retrieveEqmtCurTempAlarm(map);

		ArrayList<HashMap<String, String>> temon  = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> almon  = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> zigbee = new ArrayList<HashMap<String, String>>();
		
		for(int i = 0; i < curTempAlarm.size(); i++) {
			HashMap<String, String> tmp = curTempAlarm.get( i );
			
			String temonType = tmp.get( "temonType" );
			if( "A".equals( temonType ) ) {
				
				almon.add( tmp );
			}
			else if( "T".equals( temonType ) ) {
				
				temon.add( tmp );
			}
			else if( "Z".equals( temonType ) ) {
				
				zigbee.add( tmp );
			}
		}
		
		model.addAttribute( "temonList" , temon );
		model.addAttribute( "almonList" , almon );
		model.addAttribute( "zigbeeList", zigbee );
		model.addAttribute( "srchStrCd", strCd.toUpperCase() );
		
		String resolve = ""; 
		
		if( "RGS000001".equals( strCd.toUpperCase() ) ) {
			// 명일점
			resolve = "eqmt/layout/layout_myongil";
		}
		else if( "RGS000002".equals( strCd.toUpperCase() ) ) {
			// 잠실점
			resolve = "eqmt/layout/layout_jamsil";
		}
		else if( "RGS000003".equals( strCd.toUpperCase() ) ) {
			// 상암점
			resolve = "eqmt/layout/layout_sangam";
		}
		
		return resolve;
	}	
	
	
	
	/** 
	 * 시설물 온도 팝업 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/eqmtTempSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String showEqmtTempSrch(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			ModelMap model) {
	
		LOGGER.info("showEqmtTempSrch : " + sessionUserVo.showData() );
				
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strCd"    , strCd );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "now"      , TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		//시설물 조회
		List <PlantStatusListVo> eqmtList = eqmtStatusSvc.retrievePlantSearch(params);
		
		model.addAttribute("eqmtList", eqmtList);
		model.addAttribute("srchStrCd", strCd);
		
		return "eqmt/layout/eqmtTempSrchPop";
	}
	
	/**
	 * 시설물 온도 조회(5분 로 데이터)
	 * @param userVo    : 세션 사용자 정보
	 * @param srchStrCd : 조회할 매장 코드
	 * @param yyyymmdd  : 조회할 년월일자
	 * @param temonId   : 테몬 ID
	 * @param portNo    : 포트번호
	 * @param temonType : 테몬 타입
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveEqmtTempChrt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object retrieveEqmtTempChrt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "yyyymmdd" , required = false) String yyyymmdd,
			@RequestParam(value = "hubId"    , required = false) String hubId,
			@RequestParam(value = "temonId"  , required = false) String temonId,
			@RequestParam(value = "portNo"   , required = false) String portNo,
			@RequestParam(value = "temonType", required = false) String temonType,
			ModelMap model) throws UnsupportedEncodingException {
		
		LOGGER.info( "retrieveEqmtTempChart 시작 " );
					
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("strCd"    , strCd);		
		map.put("yyyymmdd" , yyyymmdd);
		map.put("hubId"    , hubId);
		map.put("temonId"  , temonId);
		map.put("portNo"   , portNo);
		map.put("temonType", temonType);	
		map.put("now"      , TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));	
		
		return svc.retrieveEqmtTempChrt(map);
	}		
	
	/** 
	 * 시설물 알람 목록 팝업 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/eqmtAlarmSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String showEqmtAlarmSrch(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			ModelMap model) {
	
		LOGGER.info("showEqmtAlarmSrch : " + sessionUserVo.showData() );
				
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strCd"    , strCd );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "now"      , TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		//시설물 조회
		List <PlantStatusListVo> eqmtList = eqmtStatusSvc.retrievePlantSearch(params);
		
		model.addAttribute("eqmtList", eqmtList);
		model.addAttribute("srchStrCd", strCd);
		
		return "eqmt/layout/eqmtAlarmSrchPop";
	}
	
	
	/**
	 * 시설물 알람 목록 조회(5분 로 데이터)
	 * @param userVo    : 세션 사용자 정보
	 * @param srchStrCd : 조회할 매장 코드
	 * @param yyyymmdd  : 조회할 년월일자
	 * @param temonId   : 테몬 ID
	 * @param portNo    : 포트번호
	 * @param temonType : 테몬 타입
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveEqmtAlarmList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object retrieveEqmtAlarmList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "yyyymmdd" , required = false) String yyyymmdd,
			@RequestParam(value = "hubId"    , required = false) String hubId,
			@RequestParam(value = "temonId"  , required = false) String temonId,
			@RequestParam(value = "portNo"   , required = false) String portNo,
			@RequestParam(value = "temonType", required = false) String temonType,
			@RequestParam(value = "alarmYn"  , required = false) String alarmYn,
			ModelMap model) throws UnsupportedEncodingException {
		
		LOGGER.info( "retrieveEqmtAlarmList 시작 " );
					
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("strCd"    , strCd);		
		map.put("yyyymmdd" , yyyymmdd);
		map.put("hubId"    , hubId);
		map.put("temonId"  , temonId);
		map.put("portNo"   , portNo);
		map.put("temonType", temonType);
		map.put("alarmYn"  , alarmYn);
		map.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		return svc.retrieveEqmtAlarmList(map);
	}		
}
