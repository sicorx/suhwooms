package rems.system.ctrl;

import java.util.ArrayList;
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
import rems.system.model.GridStoreInverterMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.model.StoreInverterDataVo;
import rems.system.model.UserVo;
import rems.system.service.StoreInverterMgntSvc;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class StoreInverterMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(StoreInverterMgntCtrl.class);

	@Autowired
	private StoreInverterMgntSvc storeInverterMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;

	/**
	 * 시스템관리->솔루션관리->인버터 
	 * 
	 * @author JooYoung
	 * @param seesionUserVo : 세션관련변수
	 * @param userVO : 사용자관련변수 
	 * @param scrStrNm : 조회조건(매장명)
	 * @param scrOrgCd : 조회조건(조직코드) 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/4205", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveInverterMgnt(
			@ModelAttribute("sessionUserVo") 						SessionUserVo sessionUserVo,
			@RequestParam(value = "scrStrNm", required = false) 	String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) 	String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 	String scrOrgNm,
			@ModelAttribute UserVo userVo,
			ModelMap model) {

		LOGGER.info("storeInverterMgnt" );
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
		scr_params.put( "scrOrgCd", 	scrOrgCd );			// 조직코드
		scr_params.put( "scrOrgNm", 	scrOrgNm );			// 조직명
		model.addAttribute("scrValue", scr_params );

		return "system/storeInverterMgnt";
	}
		
	@RequestMapping(value = "/retrieveInverterMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridStoreInverterMgntVo> retrieveInverterMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrStrCd", required = false) String scrStrCd,
			@RequestParam(value = "scrStrNm", required = false) String scrStrNm,			
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveInverterMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "strCd", scrStrCd );
		params.put( "orgCd", scrOrgCd );
		params.put( "strNm", scrStrNm );
		
		
		
		List<GridStoreInverterMgntVo> rslt = storeInverterMgntSvc.retrieveInverterMgnt( params );
		
		int records = rslt.size();
		
		GridVo<GridStoreInverterMgntVo> gridVo = new GridVo<GridStoreInverterMgntVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	@RequestMapping(value = "/retrieveStoreInverterMgntPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String storeInverterMgntNew(
			@RequestParam(value = "strCd", required = false) 			String strCd,
			@RequestParam(value = "viewStrCd", required = false) 		String viewStrCd,
			@RequestParam(value = "strNm", required = false) 			String strNm,
			@RequestParam(value = "orgCd", required = false) 			String orgCd,
			@RequestParam(value = "orgNm", required = false) 			String orgNm,			
			@RequestParam(value = "companyCd", required = false) 		String companyCd,
			@RequestParam(value = "companyNm", required = false) 		String companyNm,						
			@RequestParam(value = "scrStrNm", required = false) 		String scrStrNm,
			@RequestParam(value = "scrOrgCd", required = false) 		String scrOrgCd,
			@RequestParam(value = "scrOrgNm", required = false) 		String scrOrgNm,
			ModelMap model) {

		LOGGER.info("retrieveStoreInverterMgntPop :"+ companyNm +", "+ companyCd);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "viewStrCd", viewStrCd );
		params.put( "strNm", strNm );
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		
		// 뒤로가기 History 변수
		HashMap<String,Object> history = new HashMap<String,Object>();
		history.put( "scrStrNm", 			scrStrNm );		
		history.put( "scrOrgCd", 			scrOrgCd );
		history.put( "scrOrgNm", 			scrOrgNm );
		model.addAttribute("history", 		history);		
		
		List<SelectVo> rslt = commonSvc.retrieveEquipmentTypeList(params);
		List<GridStoreInverterMgntVo> gsimVo = storeInverterMgntSvc.retrieveStoreInverterMgntDtl( params );
		
		
		List<GridStoreInverterMgntVo> gsimVo_rslt = new ArrayList<GridStoreInverterMgntVo>(); 
		
		GridStoreInverterMgntVo initVal = new GridStoreInverterMgntVo();
		initVal.setStrCd(strCd);
		initVal.setDeviceLoc("");
		initVal.setDeviceType("");
		initVal.setHubId("1");
		initVal.setOrgCd(orgCd);
		initVal.setPortNo("1");
		initVal.setUseYn("N");
			
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		gsimVo_rslt.add(initVal);
		
		gsimVo_rslt.get(0).setPortNo("1");
		gsimVo_rslt.get(1).setPortNo("2");
		gsimVo_rslt.get(2).setPortNo("3");
		gsimVo_rslt.get(3).setPortNo("4");
		gsimVo_rslt.get(4).setPortNo("5");
		gsimVo_rslt.get(5).setPortNo("6");
		gsimVo_rslt.get(6).setPortNo("7");
		gsimVo_rslt.get(7).setPortNo("8");
		
		for(int i=0; i<gsimVo.size(); i++)
		{
			LOGGER.info( "2ee : " + gsimVo.size() );
			gsimVo_rslt.set(i, gsimVo.get(i) );			
		}
		
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("gsimVo", gsimVo_rslt);
		model.addAttribute("newYn", "N" );			
		
		return "system/storeInverterMgntPop";
	}	

	@RequestMapping(value = "/storeInverterMgntDtl", method = {RequestMethod.GET, RequestMethod.POST})
	public String storeInverterMgntDtl(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "viewStrCd", required = false) String viewStrCd,
			@RequestParam(value = "strNm", required = false) String strNm,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put( "strNm", strNm );
		params.put( "viewStrCd", viewStrCd );
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		

		List<SelectVo> rslt = commonSvc.retrieveEquipmentTypeList(params);
		
		List<GridStoreInverterMgntVo> gsimVo = storeInverterMgntSvc.retrieveStoreInverterMgntDtl( params );
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("gsimVo", gsimVo);
		model.addAttribute("userVo", params);		
		
		return "system/storeInverterMgntPop";
	}
	
	@RequestMapping(value = "/saveStoreInverterMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveStoreInverterMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			//@RequestParam(value = "strCd", required = false) String strCd,
			@ModelAttribute StoreInverterDataVo sidVo,
			BindingResult bindingResult, 
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("saveStoreInverterMgnt : " );

		//sidVo.setStrCd(strCd);
		sidVo.setRegiId(sessionUserVo.getSessionUserId());
		sidVo.setFinalModId(sessionUserVo.getSessionUserId());
		sidVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		
		
		
		LOGGER.info( sidVo.getUseYnList() );
		
		
		boolean rslt = storeInverterMgntSvc.saveStoreInverterMgnt( sidVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
	@RequestMapping(value = "/deleteStoreInverterMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean deleteStoreInverterMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "strCd", required = false) String strCd,
			BindingResult bindingResult,
			ModelMap model,		
			HttpSession session) throws Exception {
		
		LOGGER.info("deleteStoreRemsMgnt : "+sessionUserVo.getSessionStrCd() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "strCd", strCd );
		params.put("regiId", sessionUserVo.getSessionUserId());
		params.put("finalModId", sessionUserVo.getSessionUserId());
		params.put("now", TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));
		
		boolean rslt = storeInverterMgntSvc.deleteStoreInverterMgnt( params );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
}