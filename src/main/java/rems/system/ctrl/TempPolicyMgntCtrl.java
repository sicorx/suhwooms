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
import rems.system.model.GridTempPolicyMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.TempPolicyMgntSvc;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : TempPolicyMgntCtrl.java
 * @Description : 시스템관리 > 정책관리 > 권고온도
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 24.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 24. 오후 1:20:11
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class TempPolicyMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(TempPolicyMgntCtrl.class);

	@Autowired
	private TempPolicyMgntSvc tempPolicyMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	/**
	 * 시스템관리 > 정책관리 > 권고온도 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return tempPolicyMgntMst : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4103", method = {RequestMethod.GET, RequestMethod.POST})
	public String showTempPolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("showTempPolicyMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();				
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		// 금년, 차년 select
		List<SelectVo> rslt2 = tempPolicyMgntSvc.retrieveYearList();
		
		model.addAttribute("selectVoListCnt", selectVoListCnt);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("userVo", params );
		
		return "system/tempPolicyMgntMst";
	}

	/**
	 * 권고온도 내역
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveTempPolicyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridTempPolicyMgntVo> retrieveTempPolicyMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveTempPolicyMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		
		// 권고온도 내역
		List<GridTempPolicyMgntVo> rslt = tempPolicyMgntSvc.retrieveRemsTempPolicyList( params );		
		int records = rslt.size();
		
		GridVo<GridTempPolicyMgntVo> gridVo = new GridVo<GridTempPolicyMgntVo>();
		gridVo.setRows( rslt );                         	// 결과값
		gridVo.setPage( String.valueOf( page ) );       	// 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	/**
	 * 권고온도 상세내역
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrYyyy : 검색 년도
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveTempPolicy", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridTempPolicyMgntVo> retrieveTempPolicy(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrYyyy", required = false) String scrYyyy
			) {
		
		LOGGER.error("retrieveTempPolicy : " + scrCompanyCd + ", " + scrYyyy);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "yyyy", scrYyyy );				// 검색 년도
		params.put( "companyCd", scrCompanyCd );	// 회사 코드
		
		// 권고온도 상세내역
		GridTempPolicyMgntVo rslt = tempPolicyMgntSvc.retrieveRemsTempPolicy( params );
		
		return rslt;
	}

	/**
	 * 권고온도 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param GridTempPolicyMgntVo : 권고온도Vo
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveTempPolicyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveTempPolicyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridTempPolicyMgntVo gtpmVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveTempPolicyMgnt : "+ gtpmVo.getCompanyCd() +", "+gtpmVo.getYyyy()  );

		gtpmVo.setRegiId(sessionUserVo.getSessionUserId());			// 등록 아이디
		gtpmVo.setFinalModId(sessionUserVo.getSessionUserId());		// 최종 수정 아이디

		// 권고온도 저장
		boolean rslt = tempPolicyMgntSvc.saveTempPolicyMgnt( gtpmVo );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
}