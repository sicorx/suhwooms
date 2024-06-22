package rems.common.ctrl;

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
import rems.common.service.CommonSvc;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.SessionUserVo;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.common.ctrl
 * @Class Name : StoreSrchCtrl.java
 * @Description : 공통 > 매장 조회 팝업
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 13.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 13. 오전 10:37:55
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class StoreSrchCtrl {
 
	private static final Logger LOGGER = LoggerFactory.getLogger(StoreSrchCtrl.class);
	
	@Autowired
	private CommonSvc svc;
	
	/**
	 * 매장 조회 카운트
	 * 
	 * @author 정주영
	 * @param companyCd : 회사 코드
	 * @param strNm : 매장명/코드
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStoreCnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreMgntVo> retrieveStoreCnt(
			@RequestParam(value = "companyCd", required = false) 	String companyCd,
			@RequestParam(value = "strNm", required = false) 		String strNm
			) {
		
		LOGGER.error("retrieveStoreCnt : " + companyCd + ", " + strNm);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );		// 회사 코드
		params.put( "strNm", strNm );				// 조직명/코드
		
		// 조직 조회 카운트
		GridStoreMgntVo rslt = svc.retrieveStoreCnt( params );
		
		return rslt;
	}

	@Autowired
	private CommonSvc commonSvc;
	
	/**
	 * 매장 조회 팝업 페이지
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @param strNm : 매장명/코드
	 * @param orgCd : 조직 코드
	 * @param searchType : 검색 타입(org=조직관리에서 호출)
	 * @return view : storeSrch
	 * @exception Exception
	 */
	@RequestMapping(value = "/storeMngSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String storeMngSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "strNm", required = false) String strNm,
			@RequestParam(value = "orgCd", required = false) String orgCd,
			@RequestParam(value = "searchType", required = false) String searchType,
			ModelMap model) {

		LOGGER.error("storeMngSrch");
		
		model.addAttribute("companyCd", companyCd);		// 회사 코드
		model.addAttribute("strNm", strNm);				// 매장명/코드						
		model.addAttribute("orgCd", orgCd);				// 조직 코드(조직관리에서 호출)
		model.addAttribute("searchType", searchType);	// 검색 타입(org=조직관리에서 호출)
		
		return "common/storeSrch";
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
	@RequestMapping(value = "/retrieveStoreSrch", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreMgntVo> retrieveStoreSrch(
			@ModelAttribute("sessionUserVo") SessionUserVo vo,
			@RequestParam(value = "srcCompanyCd", required = false) String srcCompanyCd,
			@RequestParam(value = "srcOrgCd", required = false) String srcOrgCd,
			@RequestParam(value = "srcSearchType", required = false) String srcSearchType,
			@RequestParam(value = "srcStrNm", required = false) String srcStrNm,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveStoreSrch : " + page + ", " + rows + ", " + sidx + ", " + sord + ", " + srcStrNm + ", " + srcOrgCd + ", " + srcSearchType);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", srcCompanyCd );			// 회사 코드
		params.put( "orgCd", srcOrgCd );					// 조직 코드
		params.put( "searchType", srcSearchType );			// 검색 타입(org=조직관리에서 호출)
		params.put( "strNm", srcStrNm );					// 매장명/코드
		
		// 매장 조회 목록
		List<GridStoreMgntVo> rslt = commonSvc.retrieveStrCd( params );
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
	
	
	@RequestMapping(value = "/storeMngSrch2depth", method = {RequestMethod.GET, RequestMethod.POST})
	public String storeMngSrch2depth(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			ModelMap model) {

		LOGGER.info("storeMngSrch2depth ???????? : "+companyCd);
		
		model.addAttribute( "companyCd", companyCd );
		
		return "common/storeSrch2depth";
	}	
	
}
