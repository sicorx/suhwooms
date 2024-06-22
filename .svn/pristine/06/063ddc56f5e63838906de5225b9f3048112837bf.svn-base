package rems.system.ctrl;

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
import rems.energy.model.EpContDemandListVo;
import rems.energy.model.EpStatusVo;
import rems.eqmt.model.GridEqmtAlarmListVo;
import rems.eqmt.model.PlantStatusListVo;
import rems.eqmt.service.EqmtStatusSvc;
import rems.system.model.DashBoardStoreDataVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.DashBoardMgntSvc;
import rems.util.StringUtil;

@Controller
@SessionAttributes("sessionUserVo")
public class DashBoardMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(DashBoardMgntCtrl.class);

	@Autowired
	private CommonSvc commonSvc;				// 공통
	
	@Autowired
	private EqmtStatusSvc eqmtSvc;
	
	@Autowired
	private DashBoardMgntSvc svc;			
		
	
	
	/**
	 * 매장리스트( 로그인 후 첫화면 )
	 * 
	 * @author JooYoung
	 * @param seesionuserVo : 세션 변수
	 * @param userVo : 유저 변수 
	 * @param scrStrNm : 조회조건 - 매장명/코드
	 * @param scrUserYn : 조회조건 - 사용유무 
	 * @param scrDateFrom : 조회조건 - 일시 From
	 * @param scrDateTo : 조회조건 - 일시 To
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/dashboard", method = {RequestMethod.GET, RequestMethod.POST})
	public String dashdash(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,			
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,			
			@RequestParam(value = "scrUseYn", required = false) 	String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) 	String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 	String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 	String scrOrgNm,
			ModelMap model) {			

		
		LOGGER.info("dashdash : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );	
		params.put( "authId", sessionUserVo.getSessionAuthId() );
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();

		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
				
		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put( "scrStrNm", 	scrStrNm );			// 매장명/코드 
		scr_params.put( "scrUseYn", 	scrUseYn );			// 사용유무
		scr_params.put( "scrDateFrom", 	scrDateFrom );		// 설치일자 From
		scr_params.put( "scrDateTo", 	scrDateTo );		// 설치일자 To
		scr_params.put( "scrOrgCd", 	scrOrgCd );			// 조직코드
		scr_params.put( "scrOrgNm", 	scrOrgNm );			// 조직명
		
		model.addAttribute("scrValue", scr_params );
		
		return "system/dashBoard";		
	}
	
	/**
	 * 매장리스트
	 * 
	 * @author JooYoung
	 * @param seesionuserVo : 세션 변수
	 * @param userVo : 유저 변수 
	 * @param scrStrNm : 조회조건 - 매장명/코드
	 * @param scrUserYn : 조회조건 - 사용유무 
	 * @param scrDateFrom : 조회조건 - 일시 From
	 * @param scrDateTo : 조회조건 - 일시 To
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveDashStoreList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveDashStoreList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,			
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,			
			@RequestParam(value = "scrUseYn", required = false) 	String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) 	String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 	String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 	String scrOrgNm,
			ModelMap model) {			

		
		LOGGER.info("retrieveDashStoreList : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();

		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
				
		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put( "scrStrNm", 	scrStrNm );			// 매장명/코드 
		scr_params.put( "scrUseYn", 	scrUseYn );			// 사용유무
		scr_params.put( "scrDateFrom", 	scrDateFrom );		// 설치일자 From
		scr_params.put( "scrDateTo", 	scrDateTo );		// 설치일자 To
		scr_params.put( "scrOrgCd", 	scrOrgCd );			// 조직코드
		scr_params.put( "scrOrgNm", 	scrOrgNm );			// 조직명
		
		model.addAttribute("scrValue", scr_params );
		
		return "system/storeListMst";		
	}
	
	
	/**
	 * 매장리스트 - 대쉬보드 팝업
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/dashBoardPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String dashBoardPop(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
	
		LOGGER.info("dashBoardPop : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		
		model.addAttribute("userVo", 			params);
		
		return "system/dashBoardPop";
	}
	

	/**
	 * 매장정보 조회
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveStoreMstData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveStoreMstData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd ) {
		
		LOGGER.info("retrieveStoreMstData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd);			
		
		DashBoardStoreDataVo rslt = svc.retrieveStoreMstData( params );		// 매장정보
		
		return rslt;
	}	
	
	/**
	 * 매장관제현황 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param strCd : 매장 코드
	 * @return storeStatusMgnt : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStoreStatus", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveStoreStatus(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) String strCd,
			ModelMap model) {			

		LOGGER.error("retrieveStoreStatus");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userId", sessionUserVo.getSessionUserId());
		params.put("userNm", sessionUserVo.getSessionUserNm());
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("companyNm", sessionUserVo.getSessionCompanyNm());		
		
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 장비 선택 리스트
		List<SelectVo> selectVoEqmtList = eqmtSvc.retrieveEqmtList(params);				
		
		// 업체 선택 리스트
		List<SelectVo> selectVoVendorList = commonSvc.retrieveVendorList(params);			
		
		// 시스템 현재일자
		String toDay = commonSvc.retrieveSysdate().substring(0, 10);
		String toDayMonth = toDay.substring(0, 7);
		String toDayYear = toDay.substring(0, 4);
		
		// 매장정보
		strCd = StringUtil.ConvertNull(strCd);
		if (!"".equals(strCd)) {
			params.put("strCd", strCd);
			DashBoardStoreDataVo rslt2 = svc.retrieveStoreMstData( params );
			
			model.addAttribute("strInfo", rslt2);
		}
		
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoEqmtList", selectVoEqmtList);
		model.addAttribute("selectVoVendorList", selectVoVendorList);
		model.addAttribute("toDay", toDay);
		model.addAttribute("toDayMonth", toDayMonth);
		model.addAttribute("toDayYear", toDayYear);
		model.addAttribute("userVo", params);
		
		return "system/storeStatusMgnt";		
	}
	
	/**
	 * 매장 상단정보
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveStoreRealData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveStoreRealData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd ) {
		
		LOGGER.info("retrieveStoreRealData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd);			
		
		DashBoardStoreDataVo rslt = svc.retrieveStoreRealData( params );		// 매장 정보
		
		return rslt;
	}
	
	/**
	 * 매장 1단 매장정보( 에너지사용량)
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveStoreEnergyData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveStoreEnergyData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd ) {
		
		LOGGER.info("retrieveStoreEnergyData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd);			
		
		DashBoardStoreDataVo rslt = svc.retrieveStoreEnergyData( params );		// 매장 정보
		
		return rslt;
	}
	
	/**
	 * 매장 1단 매장정보( 에너지사용량 차트 데이터 )
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStoreEnergyChartData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveStoreEnergyChartData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd ) {		
		
		LOGGER.info("retrieveUseMonth : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd);			
		
		List<DashBoardStoreDataVo> rslt = svc.retrieveStoreEnergyChartData( params );		// 매장 정보
		
		List<String> yyyymm 	= new ArrayList<String>();
		List<String> total 		= new ArrayList<String>();		
		List<String> temp 		= new ArrayList<String>();		
		List<String> etc 		= new ArrayList<String>();		
		
		for( DashBoardStoreDataVo rtu : rslt ) {
			yyyymm.add( 	rtu.getYyyymm() );
			total.add( 		rtu.getTotal() );			
			temp.add( 		rtu.getTemp() );
			etc.add( 		rtu.getEtc() );
		}
		
		Object result[] = new Object[4];
		result[0] 		= yyyymm.toArray();
		result[1] 		= total.toArray();
		result[2] 		= temp.toArray();
		result[3] 		= etc.toArray();		
		
		return result;
	}
	
	
	/**
	 * 매장 시설물 알람처리현황
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveStoreAlarmData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveStoreAlarmData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd ) {
		
		LOGGER.info("retrieveStoreAlarmData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd);			
		
		DashBoardStoreDataVo rslt = svc.retrieveStoreAlarmData( params );		// 매장 정보
		
		return rslt;
	}
	
	/**
	 * 매장 시설물 현황
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveStoreEqmtData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<DashBoardStoreDataVo> retrieveStoreEqmtData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd,
			@RequestParam(value = "page", required = false) 	int page,
			@RequestParam(value = "rows", required = false) 	int rows,
			@RequestParam(value = "sidx", required = false) 	String sidx,
			@RequestParam(value = "sord", required = false) 	String sord) {
		
		LOGGER.info("retrieveStoreEqmtData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", 	rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", 	sidx );                        // 정렬 기준 컬럼
		params.put( "sord", 	sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "strCd", 	strCd);			
		
		List<DashBoardStoreDataVo> rslt = svc.retrieveStoreEqmtData( params );		// 매장 정보
		int records = rslt.size();
		
		GridVo<DashBoardStoreDataVo> gridVo = new GridVo<DashBoardStoreDataVo>();
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
	 * 매장관제현황 > 에너지사용현황 탭 > 월별 전력량
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param scrDateFrom : 검색일자 From
	 * @param scrDateTo : 검색일자 To
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyMonthStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpStatusVo> retrieveEnergyMonthStatus(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,						
			@RequestParam(value = "scrDateFrom", required = false) 		String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 		String scrDateTo,						
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveEnergyMonthStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd );
		params.put("scrDateFrom", scrDateFrom );
		params.put("scrDateTo", scrDateTo );		
		params.put("sidx", sidx);
		params.put("sord", sord);		
		
		List<EpStatusVo> epMonthStatsVo = svc.retrieveEnergyMonthStatus(params);	// 월별 전력량
		
		GridVo<EpStatusVo> gridVo = new GridVo<EpStatusVo>();
		gridVo.setRows(epMonthStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 에너지사용현황 탭 > 일별 전력량
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param yyyymm : 검색월 
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyDayStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpStatusVo> retrieveEnergyDayStatus(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrYyyymm", required = false)		String yyyymm,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveEnergyDayStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		params.put("strCd", strCd );
		params.put("srcYyyymm", yyyymm );		
		params.put("sidx", sidx);
		params.put("sord", sord);		
				
		List<EpStatusVo> epDayStatsVo = svc.retrieveEnergyDayStatus(params);		// 일별 전력량
		
		GridVo<EpStatusVo> gridVo = new GridVo<EpStatusVo>();
		gridVo.setRows(epDayStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 에너지사용현황 탭 > 일별 전력량 ( tab )
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param yyyymm : 검색월 
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyDayStatus_tab", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpStatusVo> retrieveEnergyDayStatus_tab(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrYyyymm", required = false)		String yyyymm,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveEnergyDayStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		params.put("strCd", strCd );
		params.put("srcYyyymm", yyyymm );		
		params.put("sidx", sidx);
		params.put("sord", sord);		
				
		//List<EpStatusVo> epDayStatsVo = svc.retrieveEnergyDayStatus(params);		// 일별 전력량
		List<EpStatusVo> epDayStatsVo = svc.retrieveEnergyDayStatus_tab(params);		// 일별 전력량
		
		GridVo<EpStatusVo> gridVo = new GridVo<EpStatusVo>();
		gridVo.setRows(epDayStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 에너지사용현황 탭 > 일별 상세 전력량(차트)
	 * 
	 * @author 유승만
	 * @param scrStrCd : 매장 코드
	 * @param scrYyyymmdd : 검색년월일 
	 * @return	gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveEnergyDayStatusChart", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpStatusVo> retrieveEnergyDayStatusChart(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrYyyymmdd", required = false)		String yyyymmdd) {
		
		LOGGER.error("retrieveEnergyDayStatusChart : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		params.put("strCd", strCd );
		params.put("yyyymmdd", yyyymmdd );
				
		List<EpStatusVo> epDayStatsVo = svc.retrieveEnergyDayStatusChart(params);		// 일별 상세 전력량		
		
		GridVo<EpStatusVo> gridVo = new GridVo<EpStatusVo>();
		gridVo.setRows(epDayStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 계약전력 탭 > 월별 계약전력량
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param scrDateFrom : 검색일자 From
	 * @param scrDateTo : 검색일자 To
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveDemandEnergyMonthStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpContDemandListVo> retrieveDemandEnergyMonthStatus(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,						
			@RequestParam(value = "scrDateFrom", required = false) 		String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 		String scrDateTo,						
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveDemandEnergyMonthStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd );
		params.put("scrDateFrom", scrDateFrom );
		params.put("scrDateTo", scrDateTo );		
		params.put("sidx", sidx);
		params.put("sord", sord);		
		
		List<EpContDemandListVo> epCondtDemandMonthStatsVo = svc.retrieveDemandEnergyMonthStatus(params);	// 월별 전력량
		
		GridVo<EpContDemandListVo> gridVo = new GridVo<EpContDemandListVo>();
		gridVo.setRows(epCondtDemandMonthStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 계약전력 탭 > 일별 계약전력 대비 사용량
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param yyyymm : 검색월 
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveDemandEnergyDayStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpContDemandListVo> retrieveDemandEnergyDayStatus(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrYyyymm", required = false)		String yyyymm,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveDemandEnergyDayStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		params.put("strCd", strCd );
		params.put("srcYyyymm", yyyymm );		
		params.put("sidx", sidx);
		params.put("sord", sord);		
				
		List<EpContDemandListVo> epCondDemandDayStatsVo = svc.retrieveDemandEnergyDayStatus(params);		// 일별 계약전력 대비 사용량
		
		GridVo<EpContDemandListVo> gridVo = new GridVo<EpContDemandListVo>();
		gridVo.setRows(epCondDemandDayStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 계약전력 탭 > 일별 상세 계약전력량(차트)
	 * 
	 * @author 유승만
	 * @param scrStrCd : 매장 코드
	 * @param scrYyyymmdd : 검색년월일 
	 * @return	gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveDemandEnergyDayStatusChart", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<EpContDemandListVo> retrieveDemandEnergyDayStatusChart(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrYyyymmdd", required = false)		String yyyymmdd) {
		
		LOGGER.error("retrieveDemandEnergyDayStatusChart : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		params.put("strCd", strCd );
		params.put("yyyymmdd", yyyymmdd );
				
		List<EpContDemandListVo> epCondDemandDayStatsVo = svc.retrieveDemandEnergyDayStatusChart(params);		// 일별 상세 전력량		
		
		GridVo<EpContDemandListVo> gridVo = new GridVo<EpContDemandListVo>();
		gridVo.setRows(epCondDemandDayStatsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 시설물현황 탭 > 시설물 목록
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param scrYyyymmdd : 검색일자
	 * @param sidx : 정렬 기준
	 * @param sidx : 정렬 방식 ( asc, desc )
	 * @return	gridVo 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveFacilityStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<PlantStatusListVo> retrieveFacilityStatus(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrYyyymmdd", required = false) 		String scrYyyymmdd,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveFacilityStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd );
		params.put("scrYyyymmdd", scrYyyymmdd );	
		params.put("sidx", sidx);
		params.put("sord", sord);		
		
		List<PlantStatusListVo> statsVo = svc.retrieveFacilityStatus(params);	// 시설물 목록
		
		GridVo<PlantStatusListVo> gridVo = new GridVo<PlantStatusListVo>();
		gridVo.setRows(statsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 시설물현황 탭 > 시설물 온도(차트)
	 * 
	 * @author 유승만
	 * @param scrStrCd : 매장 코드
	 * @param scrTemonId : 테몬 아이디
	 * @param scrTemonType : 테몬 타입
	 * @param scrPortNo : 포트 번호
	 * @param scrYyyymmdd : 검색년월일 
	 * @return	gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveFacilityStatusChart", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<PlantStatusListVo> retrieveFacilityStatusChart(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrTemonId", required = false) 		String temonId,
			@RequestParam(value = "scrTemonType", required = false) 	String temonType,
			@RequestParam(value = "scrPortNo", required = false) 		String portNo,
			@RequestParam(value = "scrYyyymmdd", required = false)		String yyyymmdd) {
		
		LOGGER.error("retrieveFacilityStatusChart : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();						
		params.put("strCd", strCd );
		params.put("temonId", temonId );
		params.put("temonType", temonType );
		params.put("portNo", portNo );
		params.put("yyyymmdd", yyyymmdd );
				
		List<PlantStatusListVo> statsVo = svc.retrieveFacilityStatusChart(params);		// 시설물 온도(차트)
		
		GridVo<PlantStatusListVo> gridVo = new GridVo<PlantStatusListVo>();
		gridVo.setRows(statsVo);
		
		return gridVo;
	}
	
	/**
	 * 매장관제현황 > 알림현황 탭 > 알림 목록
	 * 
	 * @author 유승만
	 * @param strCd : 매장 코드
	 * @param scrDateFrom : 검색 시작일자
	 * @param scrDateTo : 검색 종료일자
	 * @param scrEqmt : 장비 코드
	 * @param scrAsResult : 조치 여부
	 * @param scrVendorNm : 업체 명
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return	gridVo 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveAlarmStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridEqmtAlarmListVo> retrieveAlarmStatus(
			@RequestParam(value = "scrStrCd", required = false) 		String strCd,
			@RequestParam(value = "scrDateFrom", required = false) 		String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 		String scrDateTo,				
			@RequestParam(value = "scrEqmt", required = false) 			String scrEqmt,
			@RequestParam(value = "scrAsResult", required = false) 		String scrAsResult,
			@RequestParam(value = "scrVendorNm", required = false) 		String scrVendorNm,
			@RequestParam(value = "page", required = false) 			int page,
			@RequestParam(value = "rows", required = false) 			int rows,
			@RequestParam(value = "sidx", required = false) 			String sidx,
			@RequestParam(value = "sord", required = false) 			String sord) {
		
		LOGGER.error("retrieveAlarmStatus : ");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put("limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx );                        	// 정렬 기준 컬럼
		params.put("sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put("strCd", strCd);
		params.put("scrDateFrom", scrDateFrom);	
		params.put("scrDateTo", scrDateTo);
		params.put("scrEqmt", scrEqmt);
		params.put("scrAsResult", scrAsResult);
		params.put("scrVendorNm", scrVendorNm);
		
		List<GridEqmtAlarmListVo> rslt = svc.retrieveAlarmStatus(params);	// 알림 목록
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
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 전체 대시보드
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/**
	 * 대시보드 - 상당정보
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/retrieveDashStoreMstData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveDashStoreMstData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo ) {
		
		LOGGER.info("retrieveDashStoreMstData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd() );			
		
		DashBoardStoreDataVo rslt = svc.retrieveDashStoreMstData( params );		// 매장정보
		
		return rslt;
	}	
	
	
	/**
	 * 대시보드 - 계약전력 사용 현황
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStoreContPowerData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<DashBoardStoreDataVo> retrieveStoreContPowerData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "page", required = false) 	int page,
			@RequestParam(value = "rows", required = false) 	int rows,
			@RequestParam(value = "sidx", required = false) 	String sidx,
			@RequestParam(value = "sord", required = false) 	String sord) {
		
		LOGGER.info("retrieveStoreContPowerData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", 		rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", 		sidx );                        // 정렬 기준 컬럼
		params.put( "sord", 		sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", 	sessionUserVo.getSessionCompanyCd());			
		
		List<DashBoardStoreDataVo> rslt = svc.retrieveStoreContPowerData( params );		// 매장 정보
		int records = rslt.size();
		
		GridVo<DashBoardStoreDataVo> gridVo = new GridVo<DashBoardStoreDataVo>();
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
	 * 대시보드 - 매장 시설물 알람처리현황
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveDashStoreAlarmData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveDashStoreAlarmData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo) {
		
		LOGGER.info("retrieveDashStoreAlarmData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", 	sessionUserVo.getSessionCompanyCd());			
		
		DashBoardStoreDataVo rslt = svc.retrieveDashStoreAlarmData( params );		// 매장 정보
		
		return rslt;
	}
		
	/**
	 * 대시보드 - 피크현황 차트 데이터
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStorePeakChartData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody Object[] retrieveStorePeakChartData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,	
			@RequestParam(value = "yyyymm", required = false) 	String yyyymm,
			ModelMap model) {
		
		LOGGER.info( "retrievePeakMonth : " + sessionUserVo.showData() );

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "yyyymm", yyyymm );		
		
		List<DashBoardStoreDataVo> rslt = svc.retrieveStorePeakChartData( params );
		
		List<String> getYyyymm = new ArrayList<String>();
		List<String> getPeakCnt = new ArrayList<String>();
		
		for( DashBoardStoreDataVo rtu : rslt ) {
			getYyyymm.add( rtu.getYyyymm() );
			getPeakCnt.add( rtu.getPeakCnt() );
		}
		
		Object rslt2[] = new Object[2];
		rslt2[0] = getYyyymm.toArray();
		rslt2[1] = getPeakCnt.toArray();
		
		return rslt2;
	}	
	
	/**
	 * 매장별 계약전력 팝업
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/contDemandPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String contDemandPop(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) 	String strCd,
			@RequestParam(value = "strNm", required = false) 	String strNm,
			ModelMap model) {
	
		LOGGER.info("contDemandPop : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		params.put( "strCd", strCd);
		params.put( "strNm", strNm);
		
		model.addAttribute("param", 			params);
		model.addAttribute("userVo", 			params);
		
		return "system/contDemandPop";
	}
	
	/**
	 * 대시보드 - 실시간알람 개수
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveDashDataCount", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody DashBoardStoreDataVo retrieveDashDataCount(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "authId", required = false) String authId) {
		
		LOGGER.info("retrieveDashDataCount" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		params.put("userId", sessionUserVo.getSessionUserId());
		
		if("".equals(authId) || null == authId){
			params.put("authId", sessionUserVo.getSessionAuthId());
		}else{
			params.put("authId", authId);
		}
		
		DashBoardStoreDataVo rslt = svc.retrieveDashDataCount( params );		// 실시간알람 개수
		
		return rslt;
	}
}
