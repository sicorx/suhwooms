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
import rems.system.model.GridVendorMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.VendorMgntSvc;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : VendorMgntCtrl.java
 * @Description : 시스템관리 > 마스터관리 > 유지보수업체
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 1. 26.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 1. 26. 오후 3:06:23
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class VendorMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(VendorMgntCtrl.class);

	@Autowired
	private VendorMgntSvc VendorMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;
		
	/**
	 * 시스템관리 > 마스터관리 > 유지보수업체 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return vendorMgntMst : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4207", method = {RequestMethod.GET, RequestMethod.POST})
	public String showVendorMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.error("showVendorMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		return "system/vendorMgntMst";
	}

	/**
	 * 유지보수업체 목록
	 * 
	 * @author 유승만
	 * @param scrVendorNm : 유지보수업체명/코드
	 * @param scrCompanyCd : 회사 코드
	 * @param scrUseYn : 사용여부
	 * @param page : 요청한 페이지
	 * @param rows : 페이지 당 보여줄 행의 개수
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return gridVo
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveVendorMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridVendorMgntVo> retrieveVendorMgnt(
			@RequestParam(value = "scrVendorNm", required = false) String scrVendorNm,
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveVendorMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); 	// 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       	// 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "useYn", scrUseYn );					// 사용여부
		params.put( "vendorNm", scrVendorNm );				// 유지보수업체명/코드
		
		// 유지보수업체 목록
		List<GridVendorMgntVo> rslt = VendorMgntSvc.retrieveRemsVendorList( params );
		int records = rslt.size();
		
		GridVo<GridVendorMgntVo> gridVo = new GridVo<GridVendorMgntVo>();
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
	 * 업체코드 중복 확인
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @param vendorCd : 업체 코드
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/checkVendorCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean checkVendorCd(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "vendorCd", required = false) String vendorCd
			) {
		
		LOGGER.error("checkVendorCd" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );		// 회사 코드
		params.put( "vendorCd", vendorCd );			// 업체 코드
		
		// 업체코드 중복 확인
		boolean checkRslt = VendorMgntSvc.checkVendorCd( params );
		LOGGER.error("check VendorCd----------->" + vendorCd);
		
		return checkRslt;
	}
	
	/**
	 * 유지보수업체 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param GridVendorMgntVo : 유지보수업체Vo
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveVendorMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean saveVendorMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridVendorMgntVo gvmVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.error("saveVendorMgnt : "+sessionUserVo.getSessionUserId() );

		gvmVo.setRegiId(sessionUserVo.getSessionUserId());			// 등록 아이디
		gvmVo.setFinalModId(sessionUserVo.getSessionUserId());		// 최종 수정 아이디

		// 유지보수업체 저장
		boolean rslt = VendorMgntSvc.saveRemsVendorMgnt( gvmVo );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
}