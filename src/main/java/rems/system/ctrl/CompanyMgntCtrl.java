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
import rems.system.model.GridCompanyMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.model.UserVo;
import rems.system.service.CompanyMgntSvc;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class CompanyMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(CompanyMgntCtrl.class);

	@Autowired
	private CompanyMgntSvc companyMgntSvc;
	
	
	/**
	 * 회사 관리 매핑
	 * @param userVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/4101", method = {RequestMethod.GET, RequestMethod.POST})
	public String showCompanyrMgnt(
			@ModelAttribute UserVo userVo,
			ModelMap model) {

		LOGGER.info("retrieveCompanyMgnt" );
		
		model.addAttribute( userVo );
		
		return "system/companyMgntMst";
	}

	@RequestMapping(value = "/retrieveCompanyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridCompanyMgntVo> retrieveCompnayMgnt(
			@ModelAttribute UserVo vo,
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveCompanyMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "useYn", scrUseYn );
		// params.put( "strCd", vo.getStrCd() );
		
		List<GridCompanyMgntVo> rslt = companyMgntSvc.retrieveRemsCompanyList( params );
		int records = rslt.size();
		
		GridVo<GridCompanyMgntVo> gridVo = new GridVo<GridCompanyMgntVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		//gridVo.setRecords( String.valueOf( records ) ); // 총 행의 개수
		//gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( records / rows ) : 0 ) ); // 총 페이지의 개수
		
		return gridVo;
	}
	
	@RequestMapping(value = "/retrieveCompanyMgntDtl", method = {RequestMethod.GET, RequestMethod.POST})
	public String showCompanyMgntDtl(
			@ModelAttribute UserVo vo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );
		LOGGER.info("companyCd : "+ companyCd);
		
		GridCompanyMgntVo rslt = companyMgntSvc.retrieveRemsCompanyMgntDtl( params );
		List<SelectVo> rslt2 = companyMgntSvc.retrieveCountryList();
		
		model.addAttribute("companyMgntDtl", rslt);
		model.addAttribute("selectVoList", rslt2);
		
		return "system/companyMgntDtl";
	}

	@RequestMapping(value = "/companyMgntNew", method = {RequestMethod.GET, RequestMethod.POST})
	public String showCompanyMgntNew(
			ModelMap model) {
		
		LOGGER.info("companyMgntNew" );
		
		List<SelectVo> rslt = companyMgntSvc.retrieveCountryList();
		
		model.addAttribute("selectVoList", rslt);
		
		return "system/companyMgntNew";
	}	
	
	@RequestMapping(value = "/checkCompanyCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean checkCompanyCd(
			@RequestParam(value = "companyCd", required = false) String companyCd
			) {
		
		LOGGER.info("checkCompanyCd" );
		boolean checkRslt = companyMgntSvc.checkCompanyCd( companyCd );
		
		return checkRslt;
	}
	
	@RequestMapping(value = "/checkCompanyStrCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean checkCompanyStrCd(
			@RequestParam(value = "countryStrCd", required = false) String countryStrCd
			) {
		
		LOGGER.info("checkCompanyStrCd" );
		boolean checkRslt = companyMgntSvc.checkCompanyStrCd( countryStrCd );
		
		return checkRslt;
	}

	@RequestMapping(value = "/saveCompanyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridCompanyMgntVo saveCompanyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridCompanyMgntVo gcmVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.info("saveCompanyMgnt : "+sessionUserVo.getSessionUserId() );

		gcmVo.setRegiId(sessionUserVo.getSessionUserId());
		gcmVo.setFinalModId(sessionUserVo.getSessionUserId());
		gcmVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		boolean rslt = companyMgntSvc.saveRemsCompanyMgnt( gcmVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return gcmVo;
	}
	
	@RequestMapping(value = "/deleteCompanyMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridCompanyMgntVo deleteCompanyMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridCompanyMgntVo gcmVo,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("deleteCompanyMgnt : "+sessionUserVo.getSessionUserId() );

		gcmVo.setRegiId(sessionUserVo.getSessionUserId());
		gcmVo.setFinalModId(sessionUserVo.getSessionUserId());
		gcmVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		boolean rslt = companyMgntSvc.deleteRemsCompanyMgnt( gcmVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return gcmVo;
	}
	
}