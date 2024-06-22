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
import rems.system.model.GridStoreFcltyMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.StoreFcltyMgntSvc;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class StoreFcltyMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(StoreMgntCtrl.class);

	@Autowired
	private StoreFcltyMgntSvc StoreFcltyMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;

	/**
	 * 시스템관리 - 솔루션관리 - 온도수집모듈 
	 * 
	 * @author JooYoung
	 * @param seesionUserVo : 세션관련변수
	 * @param userVO : 사용자관련변수 
	 * @param scrStrNm : 조회조건(매장명)
	 * @param scrOrgCd : 조회조건(조직코드) 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/4204", method = {RequestMethod.GET, RequestMethod.POST})
	public String showStoreFcltyMgnt(
			@ModelAttribute("sessionUserVo") 						SessionUserVo sessionUserVo,
			@ModelAttribute 										UserVo userVo,
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			ModelMap model) {

		LOGGER.info("showStoreFcltyMgnt" );
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);	
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoListCnt", selectVoListCnt);
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params );
		
		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put( "scrStrNm", 	scrStrNm );			// 매장명/코드 
		scr_params.put( "scrOrgCd", 	scrOrgCd );			// 사용유무
		model.addAttribute("scrValue",	scr_params );
		
		return "system/storeFcltyMgnt";
	}	

	@RequestMapping(value = "/retrieveStoreFcltyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreFcltyMgntVo> retrieveStoreFcltyMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveStoreFcltyMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );
		params.put( "orgCd", scrOrgCd );
		params.put( "useYn", scrUseYn );
		params.put( "strNm", scrStrNm );
		// params.put( "strCd", vo.getStrCd() );
		
		List<GridStoreFcltyMgntVo> rslt = StoreFcltyMgntSvc.retrieveStoreFcltyMgnt( params );
		
		int records = rslt.size();
		
		GridVo<GridStoreFcltyMgntVo> gridVo = new GridVo<GridStoreFcltyMgntVo>();
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
	 * 온도수집모듈 수정 페이지 이동
	 * 
	 * @author JooYoung
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStoreFcltyMgntPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveStoreFcltyMgntModify(
			@ModelAttribute("sessionUserVo") 							SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) 			String strCd,
			@RequestParam(value = "viewStrCd", required = false) 		String viewStrCd,
			@RequestParam(value = "strNm", required = false) 			String strNm,
			@RequestParam(value = "orgCd", required = false) 			String orgCd,
			@RequestParam(value = "orgNm", required = false) 			String orgNm,
			@RequestParam(value = "temon", required = false) 			String temon,
			@RequestParam(value = "almon", required = false) 			String almon,
			@RequestParam(value = "zigbee", required = false) 			String zigbee,			
			@RequestParam(value = "companyCd", required = false) 		String companyCd,
			@RequestParam(value = "companyNm", required = false) 		String companyNm,						
			@RequestParam(value = "scrStrNm", required = false) 		String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) 		String scrOrgCd,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", 		strCd );
		params.put( "viewStrCd", 	viewStrCd );
		params.put( "strNm", 		strNm );
		params.put( "companyCd", 	companyCd );
		params.put( "companyNm", 	companyNm );		
		
		model.addAttribute("userVo", params );
		
		HashMap<String,Object> cntParams = new HashMap<String,Object>();
		cntParams.put( "temon", 		temon );
		cntParams.put( "almon", 		almon );
		cntParams.put( "zigbee", 		zigbee );
		
		model.addAttribute("cnt",	cntParams);
		
		// 뒤로가기 History 변수
		HashMap<String,Object> history = new HashMap<String,Object>();
		history.put( "scrStrNm", 			scrStrNm );		
		history.put( "scrOrgCd", 			scrOrgCd );
		model.addAttribute("history", 	history);		
		
		List<SelectVo> rslt = commonSvc.retrieveEquipmentTypeList(params);		
		model.addAttribute("selectVoList", rslt);
		
		
		
		return "system/storeFcltyMgntPop";
	}
	
	@RequestMapping(value = "/retrieveStoreFcltyDtl", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridStoreFcltyMgntVo retrieveStoreFcltyDtl(
			@RequestParam(value = "strCd", required = false) String strCd,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		
		LOGGER.info("strCd : "+ strCd);
		
		GridStoreFcltyMgntVo rslt = StoreFcltyMgntSvc.retrieveStoreFcltyMgntDtl( params );
		
		return rslt;
	}
	
	@RequestMapping(value = "/retrieveStoreFcltyMgntDtl", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveStoreFcltyMgntDtl(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "viewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "strNm", required = false) String strNm,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "viewStrCd", viewStrCd );
		params.put( "strNm", strNm );
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		
		LOGGER.info("strCd : "+ strCd);
		
		GridStoreFcltyMgntVo rslt = StoreFcltyMgntSvc.retrieveStoreFcltyMgntDtl( params );
		List<SelectVo> rslt2 = commonSvc.retrieveEquipmentTypeList(params);
		
		model.addAttribute("storeFcltyMgntDtl", rslt);
		model.addAttribute("selectVoList", rslt2);
		model.addAttribute("userVo", params );
		
		return "system/storeFcltyMgntPop";
	}
	
	// TODO 매장 시설물 상세(장치별 세부 포트 정보) 조회	
	@RequestMapping(value = "/retrieveStoreFcltyMgntListDtl", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<GridStoreFcltyMgntVo> retrieveStoreFcltyMgntListDtl(
			@RequestParam(value = "strCd", required = true) String strCd,
			@RequestParam(value = "temonId", required = true) String temonId,
			@RequestParam(value = "temonType", required = true) String temonType,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "temonId", temonId );	
		params.put( "temonType", temonType );
		
		List<GridStoreFcltyMgntVo> rsltList = StoreFcltyMgntSvc.retrieveStoreFcltyMgntDtlList( params );
		
		model.addAttribute("userVo", params);
		
		return rsltList;
	}
	
	@RequestMapping(value = "/saveStoreFcltyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveStoreFcltyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "mode", required = false) String mode,
			@ModelAttribute GridStoreFcltyMgntVo gsfVo,
			BindingResult bindingResult, 
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.info("saveStoreFcltyMgnt : mode :"+mode );
		
		gsfVo.setRegiId(sessionUserVo.getSessionUserId());
		gsfVo.setFinalModId(sessionUserVo.getSessionUserId());
		gsfVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		
		boolean rslt = false;
    	//신규
    	if(mode.equals("new")){
    		//장치수량 등록
    		rslt = StoreFcltyMgntSvc.saveStoreFcltyMgnt(gsfVo);
    	}else{
    		//장치별 세부 포트 정보 등록/수정
    		rslt = StoreFcltyMgntSvc.saveStoreFcltyMgntList(gsfVo);
    	}

		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return false;
	}
}
