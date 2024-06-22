package rems.eqmt.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import rems.eqmt.service.EqmtCurrentAlarmSvc;
import rems.system.model.SessionUserVo;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtCurrentAlarmCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtCurrentAlarmCtrl.class);
	
	@Autowired
	private EqmtCurrentAlarmSvc svc;

	/**
	 * 알람시설물 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	//@RequestMapping(value = "/5201", method = {RequestMethod.GET, RequestMethod.POST})
	public String showCurrentStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		
		LOGGER.info( "showPlantCurrentStatus : " + sessionUserVo.showData() );
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		Map<String, String> rslt = svc.retrieveQueryDate(param);
		
		model.addAttribute( "yyyymmdd", rslt.get( "yyyymmdd" ) );
		model.addAttribute( "dayOfWeek", rslt.get( "dayOfWeek" ) );
		model.addAttribute( "weekBefore", rslt.get( "weekBefore" ) );
		model.addAttribute( "monthBefore", rslt.get( "monthBefore" ) );
		
		return "eqmt/eqmtCurrentAlarm"; 
	}

	
	/**
	 * 알람 횟수(2014-08-22 현재 사용하지 않음) 
	 * @param vo
	 * @param binding
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveEquipmentFailure", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> retrieveEquipmentFailure(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			BindingResult binding,
			ModelMap model) {
		
		LOGGER.info( "retrieveEquipmentFailure : " + sessionUserVo.getSessionCompanyCd() + " : " + sessionUserVo.getSessionStrCd() );
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		return svc.retrieveEquipmentFailure(param);
	}
	
	
	/**
	 * 알람시설물 목록 조회
	 * @param params : 화면에서 넘어온 쿼리 스트링
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return
	 */
	@RequestMapping(value = "/retrieveEquipmentFailureList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, String>> retrieveEquipmentFailureList(
			@RequestBody String params,
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo
			) {
		
		LOGGER.info( "retrieveEquipmentFailureList : " + sessionUserVo.showData() );
		
		String temp[] = params.split("&");
		
		List<String> pkCombi = new ArrayList<String>(); // 쿼리에서 사용할 컬럼 명
		
		for(int i = 0; i < temp.length; i++) {
			if( temp[i].startsWith( "param" ) ) {
				String tmp = temp[i].substring( temp[i].indexOf("=") + 1 );
				pkCombi.add( tmp );			
			}
		}
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put( "params", pkCombi );
		param.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		param.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		return svc.retrieveEquipmentFailureList(param);
	}	

	
	/**
	 * 최근온도 조회(차트)
	 * @param strCd : 그리드에서 클릭한 매장
	 * @param portNo : 그리드에서 클릭한 시설물의 포트번호
	 * @param yyyymmdd : 일자
	 * @param hhmin : 시분
	 * @return
	 */
	@RequestMapping(value = "/retrieveLatestTemp", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, String>> retrieveLatestTemp(
			@RequestParam(value = "strCd"    , required = true) String strCd,
			@RequestParam(value = "portNo"   , required = true) String portNo,
			@RequestParam(value = "temonId"  , required = true) String temonId,
			@RequestParam(value = "temonType", required = true) String temonType,
			@RequestParam(value = "yyyymmdd" , required = true) String yyyymmdd,
			@RequestParam(value = "hhmin"    , required = true) String hhmin,
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo
			) {
		
		LOGGER.info( "retrieveLatestTemp : " + strCd + " : " + portNo + " : " + yyyymmdd + " : " + hhmin );
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put( "strCd"    , strCd );
		param.put( "portNo"   , portNo );
		param.put( "temonId"  , temonId );
		param.put( "temonType", temonType );
		param.put( "yyyymmdd" , yyyymmdd );
		param.put( "hhmin"    , hhmin );
		param.put( "now"      , TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		return svc.retrieveLatestTemp(param);
	}	
}
