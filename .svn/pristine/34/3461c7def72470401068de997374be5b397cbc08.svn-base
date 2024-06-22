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
import rems.system.model.GridMaintainEngineerMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.EngineerStrMapSvc;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : EngineerStrMapCtrl.java
 * @Description : 유지보수 > 엔지니어매장할당
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 3. 2.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 3. 2. 오후 5:30:47
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class EngineerStrMapCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(EngineerStrMapCtrl.class);
	
	@Autowired
	private EngineerStrMapSvc esmSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	@ModelAttribute("sessionUserVo")
	public SessionUserVo sessionUserVo() {
		return new SessionUserVo();
	}
	
	/**
	 * 유지보수 > 엔지니어매장할당 페이지
	 * 
	 * @author 유승만
	 * @param @param sessionUserVo : 세션 사용자 정보
	 * @return engineerStrMapList : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4603", method = {RequestMethod.GET, RequestMethod.POST})
	public String showEngineerStrMapListView(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		LOGGER.error("showEngineerStrMapListView" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		params.put( "vendorCd", sessionUserVo.getSessionVendorCd());		// 세션 회사 명
		
		System.out.println("4603:"+params );
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 업체 select
		List<SelectVo> rslt2 = commonSvc.retrieveVendorList(params);
		
		// 시스템 현재일자
		String toDay = commonSvc.retrieveSysdate().substring(0, 10);
		
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		model.addAttribute("toDay", toDay);
		
		return "system/engineerStrMapList";
	}
	
	/**
	 * 엔지니어 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrVendorCd : 업체 코드
	 * @param scrUserNm : 사용자명/ID 
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/searchVendorEngineerList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridMaintainEngineerMgntVo> searchVendorEngineerList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,
			@RequestParam(value = "scrUserNm", required = false) String scrUserNm,						
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("searchVendorEngineerList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "vendorCd", scrVendorCd );				// 업체 코드
		params.put( "userNm", scrUserNm );					// 사용자명/ID
		
		// 엔지니어 목록
		List<GridMaintainEngineerMgntVo> rslt = esmSvc.searchVendorEngineerList( params );		
		int records = rslt.size();
		
		GridVo<GridMaintainEngineerMgntVo> gridVo = new GridVo<GridMaintainEngineerMgntVo>();
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
	 * 엔지니어 할당된 매장 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrUserId : 사용자 ID
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/searchEngineerStrList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<GridMaintainEngineerMgntVo> searchEngineerStrList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("searchEngineerStrList : " + scrUserId);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "userId", scrUserId );					// 사용자 ID
		
		// 엔지니어 할당된 매장 목록
		List<GridMaintainEngineerMgntVo> rslt = esmSvc.searchEngineerStrList( params );		
		
		return rslt;
	}
	
	/**
	 * 할당매장선택 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrStrCd : 매장명/코드
	 * @param scrMapYn : 검색종류('':전체/Y:할당/N:미할당)
	 * @param scrDateFrom : 검색 시작일자
	 * @param scrDateTo : 검색 종료일자
	 * @param scrUserId : 사용자 ID
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/searchStrEngineerList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridMaintainEngineerMgntVo> searchStrEngineerList(
			@RequestParam(value = "scrCompanyCd", required = false) String companyCd,
			@RequestParam(value = "scrStrCd", required = false) String strCd,
			@RequestParam(value = "scrMapYn", required = false) String mapYn,
			@RequestParam(value = "scrDateFrom", required = false) String dateFrom,
			@RequestParam(value = "scrDateTo", required = false) String dateTo,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "scrVendorCd", required = false) String scrVendorCd,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("searchStrEngineerList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", companyCd );				// 회사 코드
		params.put( "strCd", strCd );						// 매장명/코드
		params.put( "mapYn", mapYn );						// 검색종류('':전체/Y:할당/N:미할당)
		params.put( "dateFrom", dateFrom );					// 검색 시작일자
		params.put( "dateTo", dateTo );						// 검색 종료일자
		params.put( "userId", scrUserId );					// 사용자 ID
		params.put( "vendorCd", scrVendorCd );				// 업체 코드
		
		
		// 할당매장선택 목록
		List<GridMaintainEngineerMgntVo> rslt = esmSvc.searchStrEngineerList( params );		
		int records = rslt.size();
		
		GridVo<GridMaintainEngineerMgntVo> gridVo = new GridVo<GridMaintainEngineerMgntVo>();
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
	 * 할당된 매장 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param companyCd : 회사 코드
	 * @param userId : 사용자(경영자) 아이디
	 * @param insertStrCdList : 등록할 매장코드 배열(콤마를 구분자로) 
	 * @param deleteStrCdList : 삭제할 매장코드 배열(콤마를 구분자로)
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveStrMappingEngineer", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveStrMappingEngineer(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "insertStrCdList", required = true) String insertStrCdList,
			@RequestParam(value = "deleteStrCdList", required = true) String deleteStrCdList,
			BindingResult bindingResult, 
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveStrMappingEngineer : "+sessionUserVo.getSessionStrCd() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", companyCd);									// 회사 코드
		params.put("userId", userId);										// 사용자 ID
		params.put("regiId", sessionUserVo.getSessionUserId());				// 등록 아이디
		params.put("finalModId", sessionUserVo.getSessionUserId());			// 최종 수정 아이디
		
		boolean rslt = false;
		
		// 할당된 매장 삭제
		if (null != deleteStrCdList && !"".equals(deleteStrCdList)) {
			String[] deleteStrCd =  deleteStrCdList.split(",");
			params.put("strCd", deleteStrCd );								// 매장코드 배열
		
			rslt = esmSvc.deleteStrMappingEngineer( params );
			LOGGER.error("[rslt1      ] ============ "+rslt+" ================");
		}
		
		// 할당된 매장 등록
		if (null != insertStrCdList && !"".equals(insertStrCdList)) {
			String[] insertStrCd =  insertStrCdList.split(",");
			params.put("strCd", insertStrCd );								// 매장코드 배열
			
			rslt = esmSvc.insertStrMappingEngineer( params );
			LOGGER.error("[rslt2      ] ============ "+rslt+" ================");
		}
		
		return rslt;
	}
	
}