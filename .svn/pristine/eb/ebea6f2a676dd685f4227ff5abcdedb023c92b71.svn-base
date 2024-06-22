package rems.eqmt.ctrl;

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
import rems.eqmt.model.SystemVo;
import rems.eqmt.service.EqmtElectricMgntSvc;
import rems.system.model.SessionUserVo;

@Controller
@SessionAttributes("sessionUserVo")
public class EqmtElectricMgntCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EqmtElectricMgntCtrl.class);
	
	@Autowired
	private EqmtElectricMgntSvc eqmtElectricMgntSvc;
	
	@RequestMapping(value = "/retrieveElecMgnt", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveElecMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("retrieveElecMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userId", sessionUserVo.getSessionUserId());			// 세션 사용자 아이디
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());	// 세션 회사 코드
		params.put("companyNm", sessionUserVo.getSessionCompanyNm());	// 세션 회사 명
		
		model.addAttribute("userVo", params);
		
		return "eqmt/eqmtElecMgnt";
	}
	
	
	@RequestMapping(value = "/retrieveElecMgnt2", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<SystemVo> retrieveElecMgnt2(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveElecMgnt2 : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );			// 회사 코드
		params.put( "useYn", scrUseYn );					// 사용여부

		
		// 유지보수업체 목록
		List<SystemVo> rslt = eqmtElectricMgntSvc.retrieveElecMgntList( params );
		int records = rslt.size();
		
		GridVo<SystemVo> gridVo = new GridVo<SystemVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}	
	
	
	@RequestMapping(value = "/checkElecCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean checkElecCd(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "electricentCd", required = false) String electricentCd
			) {
		
		LOGGER.error("checkElecCd" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );	
		params.put( "electricentCd", electricentCd );			// 업체 코드
		
		// 업체코드 중복 확인
		boolean checkRslt = eqmtElectricMgntSvc.checkElecCd( params );
		LOGGER.error("check electricentCd----------->" + electricentCd);
		
		return checkRslt;
	}	
	
	
	@RequestMapping(value = "/saveElectricMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveElectricMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute SystemVo gvmVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveElectricMgnt : "+sessionUserVo.getSessionUserId() );

		gvmVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		gvmVo.setRegiId(sessionUserVo.getSessionUserId());			// 등록 아이디
		gvmVo.setFinalModId(sessionUserVo.getSessionUserId());		// 최종 수정 아이디

		boolean rslt = eqmtElectricMgntSvc.saveElectricMgnt( gvmVo );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}	
	
}
