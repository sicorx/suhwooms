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

import rems.common.model.AreaVo;
import rems.common.model.GridVo;
import rems.common.model.SelectVo;
import rems.common.model.UserMngVo;
import rems.common.service.CommonSvc;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.MultOperMgntSvc;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : MultOperMgntCtrl.java
 * @Description : 시스템관리 > 마스터관리 > 복수경영주
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 1.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 1. 오전 11:40:05
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class MultOperMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(StoreMgntCtrl.class);

	@Autowired
	private MultOperMgntSvc MultOperMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;

	/**
	 * 시스템관리 > 마스터관리 > 복수경영주 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return multOperMgnt : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4202", method = {RequestMethod.GET, RequestMethod.POST})
	public String showMultOperMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("showMultOperMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 지역 select
		List<AreaVo> rslt2 = commonSvc.retrieveAreaNm(params);
		
		model.addAttribute("selectVoListCnt", selectVoListCnt);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("userVo", params );
		
		return "system/multOperMgnt";
	}	
	
	/**
	 * 경영자 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrUserNm : 사용자명/ID
	 * @param scrStrNm : 매장명/코드
	 * @param scrStrNm : 지역(시도)
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/multOperUserList", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody GridVo<UserMngVo> retrieveMultOperUserList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrUserNm", required = false) String scrUserNm,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrAreaNm", required = false) String scrAreaNm,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveMultOperUserList : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "userNm", scrUserNm );					// 사용자명/ID
		params.put( "strNm", scrStrNm );					// 매장명/코드
		params.put( "areaNm", scrAreaNm );					// 지역(시도)
		
		// 경영자 목록
		List<UserMngVo> rslt = MultOperMgntSvc.retrieveUserList( params );
		int records = rslt.size();
		
		GridVo<UserMngVo> gridVo = new GridVo<UserMngVo>();
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
	 * 소유매장 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrUserId : 사용자 ID
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/multOperRemsStoreMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<GridStoreMgntVo> retrieveMultOperRemsStoreMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveMultOperRemsStoreMgnt : " + scrUserId);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "userId", scrUserId );					// 사용자 ID
		
		// 소유매장 목록
		List<GridStoreMgntVo> rslt = MultOperMgntSvc.retrieveRemsStoreMgnt( params );
		
		return rslt;
	}
	
	/**
	 * 전체매장 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrStrCd : 매장명/코드
	 * @param scrStrKd : 매장종류(0:미할당매장/1:단일경영자매장/2:복수경영자매장)
	 * @param scrUserId : 사용자 ID
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/operRemsStoreMgnt", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody GridVo<GridStoreMgntVo> retrieveOperRemsStoreMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrKd", required = false) String scrStrKd,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveOperRemsStoreMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "strCd", scrStrCd );					// 매장명/코드
		params.put( "strKd", scrStrKd );					// 매장종류(0:미할당매장/1:단일경영자매장/2:복수경영자매장)
		params.put( "userId", scrUserId );					// 사용자 ID
		
		// 전체매장 목록
		List<GridStoreMgntVo> rslt = MultOperMgntSvc.retrieveOperRemsStoreMgnt( params );
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
	
	/**
	 * 소유매장 저장
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
	@RequestMapping(value = "/saveStrMapMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveStrMapMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "insertStrCdList", required = true) String insertStrCdList,
			@RequestParam(value = "deleteStrCdList", required = true) String deleteStrCdList,
			BindingResult bindingResult, 
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveStrMapMgnt : "+sessionUserVo.getSessionStrCd() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", companyCd);									// 회사 코드
		params.put("userId", userId);										// 사용자 ID
		params.put("regiId", sessionUserVo.getSessionUserId());				// 등록 아이디
		params.put("finalModId", sessionUserVo.getSessionUserId());			// 최종 수정 아이디
		
		boolean rslt = false;
		
		// 소유매장 삭제
		if (null != deleteStrCdList && !"".equals(deleteStrCdList)) {
			String[] deleteStrCd =  deleteStrCdList.split(",");
			params.put("strCd", deleteStrCd );								// 매장코드 배열
		
			rslt = MultOperMgntSvc.deleteStrMapMgnt( params );
			LOGGER.error("[rslt1      ] ============ "+rslt+" ================");
		}
		
		// 소유매장 등록
		if (null != insertStrCdList && !"".equals(insertStrCdList)) {
			String[] insertStrCd =  insertStrCdList.split(",");
			params.put("strCd", insertStrCd );								// 매장코드 배열
			
			rslt = MultOperMgntSvc.saveStrMapMgnt( params );
			LOGGER.error("[rslt2      ] ============ "+rslt+" ================");
		}
		
		return rslt;
	}

}
