package rems.eqmt.ctrl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
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
import rems.eqmt.model.GridEqmtAlarmListVo;
import rems.eqmt.model.PlantAlarmListVo;
import rems.eqmt.model.PlantStatusListVo;
import rems.eqmt.model.PlantStatusVo;
import rems.eqmt.service.EqmtStatusSvc;
import rems.system.model.SessionUserVo;
import rems.util.ExcelWriter;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtStatusCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtStatusCtrl.class);
	
	@Autowired
	private EqmtStatusSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;	

	/** 
	 * 시설물 현황 매핑, 시설물 현황과 시설물 가동 상태 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	/**
	 * 통합관제현황 - 시설물 - 시설물현황
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEqmtStatus", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveEqmtStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info("showPlantStatus : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		
		model.addAttribute("userVo", 			params);				
		
		List<PlantStatusVo> plantStatusVo = svc.retrievePlantStatus(params);	   	//시설물 현황 
		List<SelectVo> selectVoList = svc.retrieveEqmtTypeList(params);				// 장비유형
		
		model.addAttribute("plantStatus", plantStatusVo);
		model.addAttribute("selectVoList", selectVoList);
		
		return "eqmt/eqmtStatus";
	}
		
	
	
	// 시설물 목록
	@RequestMapping(value = "/retrieveEqmtStoreMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<PlantStatusListVo> retrieveEqmtStoreMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) String scrOrgNm,	
			@RequestParam(value = "scrDeviceType", required = false) String scrDeviceType,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveEqmtStoreMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );
		params.put( "strNm", scrStrNm );
		params.put( "orgCd", scrOrgCd );
		params.put( "orgNm", scrOrgNm );	
		params.put( "scrDeviceType", scrDeviceType );		
		
		
		List<PlantStatusListVo> rslt = svc.retrieveEqmtStoreMgnt( params );
		
		int records = rslt.size();		
		
		GridVo<PlantStatusListVo> gridVo = new GridVo<PlantStatusListVo>();
		
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));	
		}
		
		return gridVo;
		
	}
	
	
	
	
	/**
	 * 시설물 온도 그래프
	 * 
	 * @author JooYoung
	 * @param strCd : 시스템매장코드
	 * @param deviceLoc : 장비명
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEqmtTempChart", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveEqmtTempChart(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) 		String strCd,
			@RequestParam(value = "temonType", required = false) 	String temonType,
			@RequestParam(value = "temonId", required = false) 		String temonId,
			@RequestParam(value = "portNo", required = false) 		String portNo,
			@RequestParam(value = "deviceLoc", required = false) 	String deviceLoc,			
			ModelMap model) {

		LOGGER.info( "retrieveEqmtTempChart ");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strCd", 		strCd );
		params.put( "temonType",	temonType );
		params.put( "temonId",  	temonId );
		params.put( "portNo", 		portNo );
		
		
		List<PlantStatusListVo> result = svc.retrieveEqmtTempChart(params);
		
		List<String> yyyymmdd    = 		new ArrayList<String>();
		List<String> hhmin  = 			new ArrayList<String>();
		List<String> sensTemp = 		new ArrayList<String>();
		List<String> deviceLocName  = 	new ArrayList<String>();
		
		try {
			for(PlantStatusListVo rtu : result ) {
				yyyymmdd.add( rtu.getYyyymmdd() );
				hhmin.add( rtu.getHhmin() );
				sensTemp.add( rtu.getSensTemp() );				
				deviceLocName.add( new String( deviceLoc.getBytes("iso-8859-1"), "utf-8" ) );		// 한글 인코딩
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		Object rslt[] = new Object[4];
		rslt[0] = yyyymmdd.toArray();
		rslt[1] = hhmin.toArray();
		rslt[2] = sensTemp.toArray();
		rslt[3] = deviceLocName.toArray();		
		
		return rslt;
	}
	
	/**
	 * 	통합관제현황 - 시설물 - 시설물알림
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEqmtMessageList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveEqmtMessageList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "resultYn", required = false) 			String resultYn,
			ModelMap model) {
	
		LOGGER.info("showPlantStatus : " + sessionUserVo.showData() );
		
		System.out.println("resultYn : " + resultYn );	// 0 전체 1 미조치 2 조치
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "userNm", sessionUserVo.getSessionUserNm() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		params.put( "resultYn", resultYn );
		
		model.addAttribute("userVo", 			params);		
		
		
		// 업체 select
		List<SelectVo> selectVoVendorList = 	commonSvc.retrieveVendorList(params);		// 업체 선택 리스트		
		List<SelectVo> selectVoEqmtList = 		svc.retrieveEqmtList(params);				// 장비 선택 리스트
		List<SelectVo> selectVoEqmtTypeList =	svc.retrieveEqmtTypeList(params);			// 장비 유형 리스트
				
		model.addAttribute("selectVoVendorList", 	selectVoVendorList);
		model.addAttribute("selectVoEqmtList", 		selectVoEqmtList);
		model.addAttribute("selectVoEqmtTypeList", 	selectVoEqmtTypeList);		
		
		return "eqmt/eqmtMessageList";
		
	}
	
	
	
	/**
	 * 시설물 알림 Grid
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEqmtAlarmStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridEqmtAlarmListVo> retrieveEqmtAlarmStatus(
			@RequestParam(value = "scrCompanyCd", required = false) 		String scrCompanyCd,
			@RequestParam(value = "scrDateFrom", required = false) 			String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 			String scrDateTo,
			@RequestParam(value = "scrEqmt", required = false) 				String scrEqmt,
			@RequestParam(value = "scrEqmtType", required = false) 			String scrEqmtType,
			@RequestParam(value = "scrAsVendorNm", required = false) 		String scrAsVendorNm,
			@RequestParam(value = "scrAsEngineer", required = false) 		String scrAsEngineer,
			@RequestParam(value = "scrAsResult", required = false) 			String scrAsResult,				//  Y, N
			@RequestParam(value = "scrCloseStore", required = false) 		String scrCloseStore,
			@RequestParam(value = "page", required = false) 				int page,
			@RequestParam(value = "rows", required = false) 				int rows,
			@RequestParam(value = "sidx", required = false) 				String sidx,
			@RequestParam(value = "sord", required = false) 				String sord) {
		
		LOGGER.info("retrieveEqmtAlarmStatus : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd",		scrCompanyCd );
		params.put( "dateFrom", 		scrDateFrom );
		params.put( "dateTo", 			scrDateTo );
		params.put( "deviceType",		scrEqmt );
		params.put( "temonType", 		scrEqmtType );
		params.put( "asVendorNm", 		scrAsVendorNm );		
		params.put( "asEngineer", 		scrAsEngineer );
		params.put( "asResult", 		scrAsResult );
		params.put( "closeStore", 		scrCloseStore );
		
		List<GridEqmtAlarmListVo> rslt = svc.retrieveEqmtAlarmStatus( params );
		
		int records = rslt.size();		
		
		GridVo<GridEqmtAlarmListVo> gridVo = new GridVo<GridEqmtAlarmListVo>();
		
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));	
		}		
		return gridVo;		
	}
	
	/**
	 * 시설물 알림 - 팝업
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/eqmtMessagePop", method = {RequestMethod.GET, RequestMethod.POST})
	public String eqmtMessagePop(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info("eqmtMessagePop : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		
		model.addAttribute("userVo", 			params);
		
		
		List<SelectVo> selectVoAsTypeList = svc.retrieveEqmtAsTypeList(params);				// 장비유형
		
		model.addAttribute("selectVoAsTypeList", selectVoAsTypeList);
		
		
		
		return "eqmt/eqmtMessagePop";
	}
	
	
	
	
	/**
	 * 시설물 알림 - 조치 내역(팝업)
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEqmtAlarmAsResult", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridEqmtAlarmListVo retrieveEqmtAlarmAsResult(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = true) 		String strCd,
			@RequestParam(value = "yyyymmdd", required = true) 		String yyyymmdd,
			@RequestParam(value = "hhmin", required = true) 		String hhmin,
			@RequestParam(value = "temonId", required = true) 		String temonId,
			@RequestParam(value = "temonType", required = true) 	String temonType,
			@RequestParam(value = "portNo", required = true) 		String portNo,
			ModelMap model) throws UnsupportedEncodingException {

		LOGGER.info("retrievePlantMonthList : " + strCd );		
			
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", 			sessionUserVo.getSessionUserId() );
		params.put( "companyCd", 		sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", 		sessionUserVo.getSessionCompanyNm() );		
		params.put( "strCd", 			strCd);
		params.put( "yyyymmdd", 		yyyymmdd);
		params.put( "hhmin", 			hhmin);
		params.put( "yyyymmdd", 		yyyymmdd);
		params.put( "temonId", 			temonId);
		params.put( "temonType", 		temonType);
		params.put( "portNo", 			portNo);
		
		GridEqmtAlarmListVo rslt = svc.retrieveEqmtAlarmAsResult( params );

		return rslt;
	}
	
	
	/**
	 * 시설물 알림 AS 조치 유무 확인
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveAsResultYn", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody String retrieveAsResultYn(
			@ModelAttribute("sessionUserVo") 								SessionUserVo sessionUserVo,
			@RequestParam(value = "popMode",     required = false) 			String mode,	
			@RequestParam(value = "popStrCd",     required = false) 			String strCd,			
			@RequestParam(value = "popTemonId",     required = false) 			String temonId,
			@RequestParam(value = "popTemonType",     required = false) 		String temonType,
			@RequestParam(value = "popPortNo",     required = false) 			String portNo,
			@RequestParam(value = "popAsEngineer",     required = false) 		String asEngineer,
			@RequestParam(value = "popAsMethod",     required = false) 		String asMethod,			
			@RequestParam(value = "popAsNote",     required = false) 			String asNote,
			@RequestParam(value = "popStrNm",     required = false) 			String strNm,
			@RequestParam(value = "popViewStrCd",     required = false) 		String viewStrCd,
			@RequestParam(value = "popDeviceLoc",     required = false) 		String deviceLoc,
			@RequestParam(value = "popYyyymmdd",     required = false) 		String yyyymmdd,
			@RequestParam(value = "popHhmin",     required = false) 			String hhmin,			
			BindingResult bindingResult,
			ModelMap model) throws UnsupportedEncodingException {
		
		LOGGER.info( "retrieveAsResultYn : " );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", 			sessionUserVo.getSessionUserId() );
		params.put( "companyCd", 		sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", 		sessionUserVo.getSessionCompanyNm() );				
		params.put(	"strCd", 			strCd);
		params.put(	"temonId", 			temonId);
		params.put(	"temonType",		temonType);
		params.put(	"portNo", 			portNo);		
		params.put(	"asEngineer", 		asEngineer);		
		params.put(	"asMethod", 		asMethod);		
		params.put(	"asNote", 			asNote);
		params.put(	"strNm", 			strNm);
		params.put(	"viewStrCd", 		viewStrCd);
		params.put(	"deviceLoc", 		deviceLoc);
		params.put(	"yyyymmdd", 		yyyymmdd);
		params.put(	"hhmin", 			hhmin);
		
		String rslt 	= svc.retrieveAsResultYn( params );		// 조치 내역 DB 입력
		
		System.out.println( "Y".equals( rslt) );
		System.out.println( rslt );
		
		if( "Y".equals( rslt) )
			return "1";	
		else
			return "0";
		
	}
	
	
	/**
	 * 시설물 알림 AS 조치 입력 전송
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveEqmtAlarmAsResult", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody int saveEqmtAlarmAsResult(
			@ModelAttribute("sessionUserVo") 								SessionUserVo sessionUserVo,
			@RequestParam(value = "popMode",     required = false) 			String mode,	
			@RequestParam(value = "popStrCd",     required = false) 		String strCd,			
			@RequestParam(value = "popTemonId",     required = false) 		String temonId,
			@RequestParam(value = "popTemonType",     required = false) 	String temonType,
			@RequestParam(value = "popPortNo",     required = false) 		String portNo,
			@RequestParam(value = "popAsEngineer",     required = false) 	String asEngineer,
			@RequestParam(value = "popAsMethod",     required = false) 		String asMethod,			
			@RequestParam(value = "popAsNote",     required = false) 		String asNote,
			@RequestParam(value = "popStrNm",     required = false) 		String strNm,
			@RequestParam(value = "popViewStrCd",     required = false) 	String viewStrCd,
			@RequestParam(value = "popDeviceLoc",     required = false) 	String deviceLoc,
			@RequestParam(value = "popYyyymmdd",     required = false) 		String yyyymmdd,
			@RequestParam(value = "popHhmin",     required = false) 		String hhmin,			
			BindingResult bindingResult,
			ModelMap model) throws UnsupportedEncodingException {
		
		LOGGER.info( "saveEqmtAlarmAsResult : " );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", 			sessionUserVo.getSessionUserId() );
		params.put( "companyCd", 		sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", 		sessionUserVo.getSessionCompanyNm() );				
		params.put(	"strCd", 			strCd);
		params.put(	"temonId", 			temonId);
		params.put(	"temonType",		temonType);
		params.put(	"portNo", 			portNo);		
		params.put(	"asEngineer", 		asEngineer);		
		params.put(	"asMethod", 		asMethod);		
		params.put(	"asNote", 			asNote);
		params.put(	"strNm", 			strNm);
		params.put(	"viewStrCd", 		viewStrCd);
		params.put(	"deviceLoc", 		deviceLoc);
		params.put(	"yyyymmdd", 		yyyymmdd);
		params.put(	"hhmin", 			hhmin);
		
		int rslt 	= svc.saveEqmtAlarmAsResult( params );		// 조치 내역 DB 입력
		
		int rsltGCM = 0; 
		if( "INPUT".equals(mode) )
			rsltGCM = svc.saveEqmtAlarmAsResultPush( params );	// 경영주에게 푸시메세지 전송				
		
		return rslt;		
		
	}
	
	/** 
	 * 월 알람 발생 횟수 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveAlarmCntMonth", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveAlamrCntMonth(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo, 
			ModelMap model) {
		
		LOGGER.info("retrieveAlarmCntMonth : " + sessionUserVo.showData() );
		
		HashMap<String, Object> params = new HashMap<String, Object>();		
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );

		List<PlantStatusVo> result1 = svc.retrieveAlarmCntMonth(params);		//월 알람 발생 횟수
		
		List<String> cat = new ArrayList<String>();
		List<String> rif = new ArrayList<String>();
		List<String> wic = new ArrayList<String>();
		List<String> osc = new ArrayList<String>();
		
		for( PlantStatusVo rtu : result1 ) {
			cat.add( rtu.getYyyymm() );
			rif.add( rtu.getRif() );
			wic.add( rtu.getWic() );
			osc.add( rtu.getOsc() );
		}
		
		Object result2[] = new Object[4];
		result2[0] = cat.toArray();
		result2[1] = rif.toArray();
		result2[2] = wic.toArray();
		result2[3] = osc.toArray();
		
		return result2;
	}
	
	/** 
	 * 알람 발생 시설물 목록 화면 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyymm : 이전 화면에서 요청한 조회년월
	 * @param deviceType : 이전 화면에서 요청한 시설물 종류
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/2002", method = {RequestMethod.GET, RequestMethod.POST})
	public String showPlantAreaList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgDeviceType", required = false) String deviceType,
			ModelMap model) {
		
		LOGGER.info("showPlantAreaList : " + sessionUserVo.showData() + ", " + yyyymm + ", " + deviceType);
		
		model.addAttribute("orgDeviceType", deviceType);
		model.addAttribute("orgYyyymm", yyyymm);
		
		// 조회년월 조회
		HashMap<String, Object> param2 = new HashMap<String, Object>();
		param2.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, Object>> rslt2 = commonSvc.retrieveYearMonth(param2);
		
		model.addAttribute("yearMonth", rslt2);

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
		
		return "eqmt/eqmtAlarmList";
	}
	
	/** 
	 * 알람 발생 시설물 목록
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 조회년월
	 * @param deviceType : 조회할 시설물 종류
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrievePlantAlarmList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<PlantAlarmListVo> retrievePlantAlarmList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = false) String yyyymm,
			@RequestParam(value = "srchDeviceType", required = false) String deviceType,
			ModelMap model){
		
		LOGGER.info("retrievePlantAlarmList : " + yyyymm + ", " + deviceType + " session : " + sessionUserVo.showData());
		
		HashMap<String, Object> params = new HashMap<String, Object>();		
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "strCd", strCd );
		params.put( "yyyymm", yyyymm );
		params.put( "deviceType", deviceType );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<PlantAlarmListVo> result = svc.retrievePlantAlarmList(params);		//알람 발생 시설물 목록(Grid)
		
		GridVo<PlantAlarmListVo> gridVo = new GridVo<PlantAlarmListVo>();
		gridVo.setRows(result);
		
		return gridVo;
	}	

	/** 
	 * 알람 발생 시설물 상세 목록
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param yyyymm : 조회년월
	 * @param deviceType : 조회할 점포코드
	 * @param deviceType : 조회할 시설물 종류
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrievePlantAlarmDtlList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<HashMap<String, String>> retrievePlantAlarmDtlList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = false) String strCd,
			@RequestParam(value = "srchYyyymm", required = false) String yyyymm,
			@RequestParam(value = "srchDeviceType", required = false) String deviceType,
			ModelMap model){
		
		LOGGER.info("retrievePlantAlarmDtlList : " + strCd + ", " + yyyymm + ", " + deviceType + " session : " + sessionUserVo.showData());
		
		HashMap<String, Object> params = new HashMap<String, Object>();		
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "strCd", strCd );
		params.put( "yyyymm", yyyymm );
		params.put( "deviceType", deviceType );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<HashMap<String, String>> result = svc.retrievePlantAlarmDtlList(params);
				
		return result;
	}
	
	/** 
	 * 시설물 조회 상세 매핑
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/3201", method = {RequestMethod.GET, RequestMethod.POST})
	public String showPlantSearch(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "orgYyyymm", required = false) String yyyymm,
			@RequestParam(value = "orgDeviceType", required = false) String deviceType,
			@RequestParam(value = "orgViewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "orgStrCd", required = false) String strCd,
			@RequestParam(value = "orgStrNm", required = false) String strNm,
			ModelMap model) {
		
		LOGGER.info("showPlantSearch : " + yyyymm + ", " + deviceType + ", " + sessionUserVo.showData() );		

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, Object>> rslt1 = commonSvc.retrieveYearMonth(param);

		model.addAttribute("yearMonth", rslt1);
		model.addAttribute("orgStrCd", strCd);
		model.addAttribute("orgStrNm", strNm);
		model.addAttribute("orgViewStrCd", viewStrCd);
		model.addAttribute("orgDeviceType", deviceType);
		model.addAttribute("orgYyyymm", yyyymm);

		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		//회사 select
		List<SelectVo> rslt2 = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt2.size();
		
		model.addAttribute("selectVoList", rslt2);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );

		
		return "eqmt/eqmtStatusList";
	}

	/** 
	 * 점포별 시설물 조회(그리드와 차트를 동적으로 생성하기 위한 정보)
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 조회할 매장 코드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrieveStorePlant", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<PlantStatusListVo> retrieveStorePlant(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			ModelMap model){			

		LOGGER.info("retrieveStorePlant : " + strCd + " : " + sessionUserVo.showData() );		
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "strCd", strCd );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		//시설물 조회
		List <PlantStatusListVo> plantSearch = svc.retrievePlantSearch(params);
				
		return plantSearch;
	}

	/** 
	 * 월별 시설물 평균 온도 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param colmo : 쿼리로 넘겨줄 컬럼명
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrievePlantMonthList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<HashMap<String, String>> retrievePlantMonthList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "temonIdArr", required = true) ArrayList<String> temonIdArr,
			@RequestParam(value = "hubIdArr", required = true) ArrayList<String> hubIdArr,
			@RequestParam(value = "temonTypeArr", required = true) ArrayList<String> temonTypeArr,
			@RequestParam(value = "portNoArr", required = true) ArrayList<String> portNoArr,
			@RequestParam(value = "deviceTypeArr", required = true) ArrayList<String> deviceTypeArr,
			@RequestParam(value = "deviceLocArr", required = true) ArrayList<String> deviceLocArr,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm,
			ModelMap model) throws UnsupportedEncodingException {

		LOGGER.info("retrievePlantMonthList : " + strCd + " : " + yyyymm + " : " + sessionUserVo.showData());
		
		List<HashMap<String, String>> eqmtArr = new ArrayList<HashMap<String, String>>(); // 쿼리에서 사용할 컬럼 명
		
		for(int i = 0; i < portNoArr.size(); i++) {
			HashMap<String, String> temp = new HashMap<String, String>();
			temp.put("temonId", temonIdArr.get(i));
			temp.put("hubId", hubIdArr.get(i));
			temp.put("temonType", temonTypeArr.get(i));
			temp.put("portNo", portNoArr.get(i));
			temp.put("deviceType", deviceTypeArr.get(i));
			temp.put("columnNm", temonIdArr.get(i) + temonTypeArr.get(i) + hubIdArr.get(i) + portNoArr.get(i) + deviceTypeArr.get(i));
			eqmtArr.add( temp );
		}
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put("strCd", strCd);
		params.put("yyyymm", yyyymm);
		params.put("eqmtArr", eqmtArr);
		params.put( "now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ) );
		
		List<HashMap<String, String>> rslt = svc.retrievePlantMonthList(params);		//월별 시설물

		return rslt;
	}
	
	/** 
	 * 일자별 시설물 평균 온도 조회
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param colmo : 쿼리로 넘겨줄 컬럼명
	 * @param strCd : 조회할 매장
	 * @param yyyymm : 조회할 연월
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/retrievePlantDailyList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public  @ResponseBody List<HashMap<String, String>> retrievePlantDailyList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "temonIdArr", required = true) ArrayList<String> temonIdArr,
			@RequestParam(value = "hubIdArr", required = true) ArrayList<String> hubIdArr,
			@RequestParam(value = "temonTypeArr", required = true) ArrayList<String> temonTypeArr,
			@RequestParam(value = "portNoArr", required = true) ArrayList<String> portNoArr,
			@RequestParam(value = "deviceTypeArr", required = true) ArrayList<String> deviceTypeArr,
			@RequestParam(value = "deviceLocArr", required = true) ArrayList<String> deviceLocArr,
			@RequestParam(value = "srchStrCd", required = true) String strCd,			
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm,
			ModelMap model){

		LOGGER.info("retrievePlantDailyList : " + strCd + " : " + yyyymm + " session : " + sessionUserVo.showData());

		List<HashMap<String, String>> eqmtArr = new ArrayList<HashMap<String, String>>(); // 쿼리에서 사용할 컬럼 명
		
		for(int i = 0; i < portNoArr.size(); i++) {
			HashMap<String, String> temp = new HashMap<String, String>();
			temp.put("temonId", temonIdArr.get(i));
			temp.put("hubId", hubIdArr.get(i));
			temp.put("temonType", temonTypeArr.get(i));
			temp.put("portNo", portNoArr.get(i));
			temp.put("deviceType", deviceTypeArr.get(i));
			temp.put("columnNm", temonIdArr.get(i) + temonTypeArr.get(i) + hubIdArr.get(i) + portNoArr.get(i) + deviceTypeArr.get(i));
			eqmtArr.add( temp );
		}

		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("strCd", strCd);
		params.put("yyyymm", yyyymm);
		params.put("eqmtArr", eqmtArr);
		params.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		List<HashMap<String, String>> rslt = svc.retrievePlantDailyList(params);		//일별 시설물
		
		return rslt;
	}
	
	/**
	 * 시설물 온도 조회(5분 로 데이터)
	 * @param userVo : 세션 사용자 정보
	 * @param colmo : 쿼리로 넘겨줄 컬럼명
	 * @param strCd : 조회할 매장 코드
	 * @param yyyymm : 조회할 년월
	 * @param dd : 조회할 일자
	 * @param startVal : 조회할 시간
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/retrieveDailyPlantChart", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody ArrayList<Object> retrievePlantStatusChrt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "temonIdArr", required = true) ArrayList<String> temonIdArr,
			@RequestParam(value = "hubIdArr", required = true) ArrayList<String> hubIdArr,
			@RequestParam(value = "temonTypeArr", required = true) ArrayList<String> temonTypeArr,
			@RequestParam(value = "portNoArr", required = true) ArrayList<String> portNoArr,
			@RequestParam(value = "deviceTypeArr", required = true) ArrayList<String> deviceTypeArr,
			@RequestParam(value = "deviceLocArr", required = true) ArrayList<String> deviceLocArr,
			@RequestParam(value = "srchStrCd", required = true) String strCd,
			@RequestParam(value = "srchYyyymm", required = true) String yyyymm,
			@RequestParam(value = "srchDd", required = true) String dd,
			ModelMap model){
		
		LOGGER.info("retrievePlantStatusChrt : " + strCd + " : " + yyyymm + " : " + dd + " : " + sessionUserVo.showData());

		List<HashMap<String, String>> eqmtArr = new ArrayList<HashMap<String, String>>(); // 쿼리에서 사용할 컬럼 명
		
		for(int i = 0; i < portNoArr.size(); i++) {
			HashMap<String, String> temp = new HashMap<String, String>();
			temp.put("temonId", temonIdArr.get(i));
			temp.put("hubId", hubIdArr.get(i));
			temp.put("temonType", temonTypeArr.get(i));
			temp.put("portNo", portNoArr.get(i));
			temp.put("deviceType", deviceTypeArr.get(i));
			temp.put("columnNm", temonIdArr.get(i) + temonTypeArr.get(i) + hubIdArr.get(i) + portNoArr.get(i) + deviceTypeArr.get(i));
			eqmtArr.add( temp );
		}

		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("strCd", strCd);
		params.put("eqmtArr", eqmtArr);
		params.put("yyyymm", yyyymm);
		params.put("yyyymmdd", dd);
		params.put("now", TimezoneUtils.retrieveNowByTimediff( sessionUserVo.getSessionTimeDiff() ));
		
		//시설물 조회
		List <PlantStatusListVo> plantSearch = svc.retrievePlantSearch(params);

		//시설물 상태 조회		
		List<HashMap<String, String>> rslt = svc.retrievePlantStatusChrt(params);	
			
		//결과값을 담을 변수 선언
		ArrayList<Object> rslt1 = new ArrayList<Object>();		
		
		if( rslt.size() > 0 ) {

			List<String> key = new ArrayList<String>();
			for(String k : rslt.get(0).keySet() ) {
				key.add( k );
			}
			
			// 컬럼명이 동적으로 변경되나, 최대 18개를 넘길 수 없음
			Object col[] = new Object[18];
			for(int i = 0; i < 18; i++) {
				col[i] = new ArrayList<String>();
			}
			
			for(int i = 0; i < rslt.size(); i++) {
				HashMap<String, String> tmp = rslt.get( i );

				for(int j = 0; j < key.size(); j++) {

					((ArrayList<String>) col[j]).add( String.valueOf( tmp.get( key.get( j ) ) ) );
				}			
			}
			
			rslt1.add( key );
			
			ArrayList<String> colNm = new ArrayList<String>();		
			// 시설물 명과 상태 매핑
			for(int i = 0; i < key.size(); i++) {
				String finding = key.get( i );

				if( "hhmin".equals( finding ) ) {
					continue;
				}
				
				for(int j = 0; j < plantSearch.size(); j++) {
					PlantStatusListVo vo = plantSearch.get( j );
					String name = vo.getTemonId() + vo.getTemonType() + vo.getHubId() + vo.getPortNo() + vo.getDeviceType();

					if( finding.equals( name ) ) {

						colNm.add( vo.getDeviceLoc() + " " + vo.getDeviceNm() );
						break;
					}
				}
			}
			
			rslt1.add( colNm );
			
			for(int i = 0; i < key.size(); i++) {
				rslt1.add( col[i] );
			}			
		}
		
		return rslt1;
	}
	
	@RequestMapping(value = "/downloadeqmtMessageExcel", method = {RequestMethod.GET, RequestMethod.POST})
	public void downloadStoreExcel (
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			@RequestParam(value = "scrEqmt", required = false) String scrEqmt,
			@RequestParam(value = "scrEqmtType", required = false) String scrEqmtType,
			@RequestParam(value = "scrAsVendorNm", required = false) String scrAsVendorNm,
			@RequestParam(value = "scrAsEngineer", required = false) String scrAsEngineer,
			@RequestParam(value = "scrAsResult", required = false) String scrAsResult,
			@RequestParam(value = "scrCloseStore", required = false) String scrCloseStore,
			HttpServletResponse response) {
		
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put( "companyCd", scrCompanyCd );			
			params.put( "dateFrom", scrDateFrom );					
			params.put( "dateTo", scrDateTo );					
			params.put( "deviceType", scrEqmt );
			params.put( "temonType", scrEqmtType );
			params.put( "asVendorNm", scrAsVendorNm );					
			params.put( "asEngineer", scrAsEngineer );					
			params.put( "asResult", scrAsResult );
			params.put( "closeStore", scrCloseStore );
			
		
		//셀렉트한 리스트는 HashMap 타입
		List rslt = svc.retrieveEqmtAlarmExcelStatus( params );
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HHmmss" ); 
		Date currentTime = new Date ( ); 
		String dTime = formatter.format ( currentTime ); 
		
		String excelRealPath = new String("c:\\");//엑셀파일 저장경로(서버측 저장경로)
		String FileNm= "시설물알림조회_"+ dTime +".xls";				//파일명
		String sheetNm = "시설물알림현황";				//엑셀 시트명
		
		String arrColNm[] = new String[13]; //엑셀파일 컬럼명 (가운데정렬)
		arrColNm[0] = "장비명";
		arrColNm[1] = "매장명";
		arrColNm[2] = "알람시작시간";
		arrColNm[3] = "최종알람시간";
		arrColNm[4] = "장비유형";
		arrColNm[5] = "상태";
		arrColNm[6] = "장애내용";
		arrColNm[7] = "업체명";
		arrColNm[8] = "A/S기사";
		arrColNm[9] = "조치일시";
		arrColNm[10] = "조치방법";
		arrColNm[11] = "조치내용";
		arrColNm[12] = "최근알림";

		String arrDbColNm[] = new String[13]; //db에서 셀렉트한 컬럼명
		arrDbColNm[0] = "deviceLoc";
		arrDbColNm[1] = "strNm";
		arrDbColNm[2] = "alarmDateS";
		arrDbColNm[3] = "alarmDateE";
		arrDbColNm[4] = "temonTypeNm";
		arrDbColNm[5] = "asResult";
		arrDbColNm[6] = "alarmMessage";
		arrDbColNm[7] = "asVendorNm";
		arrDbColNm[8] = "asEngineer";
		arrDbColNm[9] = "asDate";
		arrDbColNm[10] = "asContents";
		arrDbColNm[11] = "asNote";
		arrDbColNm[12] = "alarmCnt";
		
		String alignType[] = new String[13]; //엑셀데이터 각컬럼별 정렬방향
		alignType[0] = "center";
		alignType[1] = "center";
		alignType[2] = "center";
		alignType[3] = "center";
		alignType[4] = "center";
		alignType[5] = "center";
		alignType[6] = "center";
		alignType[7] = "center";
		alignType[8] = "center";
		alignType[9] = "center";
		alignType[10] = "center";
		alignType[11] = "center";
		alignType[12] = "center";
		
		ExcelWriter.makeExeclData(wb, sheetNm, arrColNm, arrDbColNm, alignType, rslt);
		
		FileOutputStream fileOut = null;
		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;
	
		long time = Calendar.getInstance().getTimeInMillis();
		String realPath = excelRealPath;
		File filePath = new File(realPath);
		if(!filePath.exists()){
			filePath.mkdirs();
		}
		
		String file_name = FileNm;
		OutputStream out = null;
		File fullFilePath = new File(realPath +"/"+ file_name);
		FileInputStream fis = null;
		try{
		
			out = response.getOutputStream();
			
			fileOut = new FileOutputStream(fullFilePath);
			wb.write(fileOut);
			fileOut.close();
			
			response.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(FileNm,"UTF-8")+"\";");
			response.setHeader("Content-Transger-Encoding", "binary");
		
			fis = new FileInputStream(fullFilePath);
			FileCopyUtils.copy(fis, out);
			out.flush();
			
			fullFilePath.delete();
		}catch(Exception e){
			LOGGER.error(e.toString());
		}finally{
			if(fis != null){
				try{
					fis.close();
				}catch(Exception e){}
			}
		}
	}
}