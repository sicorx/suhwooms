package rems.monitoring.ctrl;

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
import rems.monitoring.model.MonitoringStoreDataVo;
import rems.monitoring.service.MonitoringMgntSvc;
import rems.system.model.DashBoardStoreDataVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class MonitoringMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(MonitoringMgntCtrl.class);

	@Autowired
	private CommonSvc commonSvc;				// 공통
	
	@Autowired
	private MonitoringMgntSvc svc;			
		
	
	
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
	@RequestMapping(value = "/monitoring", method = {RequestMethod.GET, RequestMethod.POST})
	public String monitoring(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute UserVo userVo,			
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,			
			@RequestParam(value = "scrUseYn", required = false) 	String scrUseYn,
			@RequestParam(value = "scrDateFrom", required = false) 	String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) 	String scrDateTo,
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 	String scrOrgNm,
			ModelMap model) {			

		
		LOGGER.info("monitor : " + sessionUserVo.showData() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );	
		params.put( "authId", sessionUserVo.getSessionAuthId() );
		params.put( "strCd", sessionUserVo.getSessionStrCd() );
		
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
		
		return "monitoring/monitoring";		
	}
	
	/**
	 * 매장정보 조회
	 * 
	 * @param SessionUserVo : 세션 정보
	 * @param UserVo : 유저 정보
	 * @param strCd : 시스템 매장코드 
	 * @return
	 */	
	@RequestMapping(value = "/monitoringStoreMstData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody MonitoringStoreDataVo monitoringStoreMstData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@ModelAttribute 									UserVo userVo,
			@RequestParam(value = "strCd", required = false) 	String strCd ) {
		
		LOGGER.info("monitoringStoreMstData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd);
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("userId", sessionUserVo.getSessionUserId());
		
		MonitoringStoreDataVo rslt = svc.monitoringStoreMstData( params );		// 매장정보
		String storeCount = svc.monitoringStoreCount( params );		// 매장정보
		
		rslt.setStoreCount(storeCount);
		
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
	@RequestMapping(value = "/monitoringStoreEqmtData", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<DashBoardStoreDataVo> monitoringStoreEqmtData(
			@ModelAttribute("sessionUserVo") 					SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) 	String strCd) {
		
		LOGGER.info("monitoringStoreEqmtData" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", 	strCd);			
		
		List<DashBoardStoreDataVo> rslt = svc.monitoringStoreEqmtData( params );		// 매장 정보
		
		GridVo<DashBoardStoreDataVo> gridVo = new GridVo<DashBoardStoreDataVo>();
		gridVo.setRows( rslt );                         // 결과값
		
		return gridVo;
	}
	
	/**
	 * 경영 매장 조회 팝업 페이지
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @param strNm : 매장명/코드
	 * @param orgCd : 조직 코드
	 * @param searchType : 검색 타입(org=조직관리에서 호출)
	 * @return view : storeSrch
	 * @exception Exception
	 */
	@RequestMapping(value = "/monitoringStoreSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String storeMngSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "orgCd", required = false) String orgCd,
			@RequestParam(value = "searchType", required = false) String searchType,
			ModelMap model) {

		LOGGER.error("monitoringStoreSrch");
		
		model.addAttribute("companyCd", companyCd);		// 회사 코드
		model.addAttribute("userId", userId);				// 사용자ID						
		model.addAttribute("orgCd", orgCd);				// 조직 코드(조직관리에서 호출)
		model.addAttribute("searchType", searchType);	// 검색 타입(org=조직관리에서 호출)
		
		return "monitoring/monitoringStoreSrch";
	}
	
	/**
	 * 매장 조회 목록(팝업)
	 * 
	 * @author 유승만
	 * @param srcCompanyCd : 회사 코드
	 * @param srcOrgCd : 조직 코드
	 * @param srcSearchType : 검색 타입(org=조직관리에서 호출)
	 * @param srchStrNm : 매장명/코드
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/monitoringRetrieveStoreSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreMgntVo> retrieveStoreSrch(
			@ModelAttribute("sessionUserVo") SessionUserVo vo,
			@RequestParam(value = "srcCompanyCd", required = false) String srcCompanyCd,
			@RequestParam(value = "srcOrgCd", required = false) String srcOrgCd,
			@RequestParam(value = "srcSearchType", required = false) String srcSearchType,
			@RequestParam(value = "srcUserId", required = false) String srcUserId,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("monitoringRetrieveStoreSrch : " + page + ", " + rows + ", " + sidx + ", " + sord + ", " + srcUserId + ", " + srcOrgCd + ", " + srcSearchType);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", srcCompanyCd );			// 회사 코드
		params.put( "orgCd", srcOrgCd );					// 조직 코드
		params.put( "searchType", srcSearchType );			// 검색 타입(org=조직관리에서 호출)
		params.put( "userId", srcUserId );					// 매장명/코드
		
		
		List<GridStoreMgntVo> rslt = svc.monitoringRetrieveStrCd( params );
		int records = rslt.size();
		
		GridVo<GridStoreMgntVo> gridVo = new GridVo<GridStoreMgntVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
}
