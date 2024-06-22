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
import rems.system.model.GridUserMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.UserMgntSvc;
import rems.util.TimezoneUtils;

@Controller
@SessionAttributes("sessionUserVo")
public class UserMgntCtrl_original {

/*	private static final Logger LOGGER = LoggerFactory.getLogger(UserMgntCtrl_original.class);

	@Autowired
	private UserMgntSvc userMgntSvc;
	
	@Autowired
	private CommonSvc commonSvc;


	*//**
	 * 사용자 관리 매핑
	 * @param sessionUserVo
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value = "/4301", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUserMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {

		LOGGER.info("selectVoList" );
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );
		//회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);
		int selectVoListCnt = rslt.size();
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		return "system/userMgntMst";
	}


	*//**
	 * 사용자 정보 조회
	 * @param scrCompanyCd
	 * @param scrOrgCd
	 * @param scrUserId
	 * @param scrUserNm
	 * @param scrUseYn
	 * @param page
	 * @param rows
	 * @param sidx
	 * @param sord
	 * @return
	 *//*
	@RequestMapping(value = "/retrieveUserMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridUserMgntVo> retrieveUserMgnt(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrUserId", required = false) String scrUserId,
			@RequestParam(value = "scrUserNm", required = false) String scrUserNm,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			@RequestParam(value = "scrAuthSp", required = false) String scrAuthSp,
			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveUserMgnt : " + scrCompanyCd + ", " + scrOrgCd + ", " + scrUserId + ", " + scrUserNm +  ", " + scrUseYn + ", "+ scrAuthSp);
		LOGGER.info("retrieveUserMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );
		params.put( "orgCd", scrOrgCd );
		params.put( "userId", scrUserId );
		params.put( "userNm", scrUserNm );
		params.put( "useYn", scrUseYn );
		params.put( "authSp", scrAuthSp );
		
		List<GridUserMgntVo> rslt = userMgntSvc.retrieveRemsUserList( params );
		
		int records = rslt.size();
		
		GridVo<GridUserMgntVo> gridVo = new GridVo<GridUserMgntVo>();
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
	
	
	*//**
	 * 사용자 정보 상세 조회
	 * @param userId
	 * @param companyCd
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value = "/retrieveUserMgntDtl", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveUserMgntDtl(
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", userId );
		params.put( "companyCd", companyCd );
		LOGGER.info("retrieveUserMgntDtl : "+ userId +", companyCd : "+ companyCd +", companyNm : "+ companyNm);
		
		GridUserMgntVo rslt = userMgntSvc.retrieveRemsUserMgntDtl( params );
		List<SelectVo> rslt2 = userMgntSvc.retrieveAuthHList( companyCd );
		List<SelectVo> rslt3 = userMgntSvc.retrieveAuthMList( companyCd );
		List<SelectVo> rslt4 = userMgntSvc.retrieveAuthSList( companyCd );
		List<SelectVo> rslt5 = userMgntSvc.retrieveVendorList(params);
		
		model.addAttribute("companyCd", companyCd);
		model.addAttribute("companyNm", companyNm);
		model.addAttribute("userMgntDtl", rslt);
		model.addAttribute("selectVoList", rslt2);
		model.addAttribute("selectVoList2", rslt3);
		model.addAttribute("selectVoList3", rslt4);
		model.addAttribute("selectVoList4", rslt5);
		model.addAttribute("newYn", "N");
		
		return "system/userMgntPop";
	}
	
	*//**
	 * 사용자 신규 생성 팝업
	 * @param companyCd
	 * @param companyNm
	 * @param model
	 * @return
	 *//*
	@RequestMapping(value = "/userMgntNew", method = {RequestMethod.GET, RequestMethod.POST})
	public String showUserMgntNew(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			ModelMap model) {
		
		LOGGER.info("userMgntNew" );
		HashMap<String,Object> params = new HashMap<String,Object>();		
		params.put( "companyCd", companyCd );
		
		List<SelectVo> rslt = userMgntSvc.retrieveAuthHList( companyCd );
		List<SelectVo> rslt2 = userMgntSvc.retrieveAuthMList( companyCd );
		List<SelectVo> rslt3 = userMgntSvc.retrieveAuthSList( companyCd );
		List<SelectVo> rslt4 = userMgntSvc.retrieveVendorList(params);
		
		model.addAttribute("companyCd", companyCd);
		model.addAttribute("companyNm", companyNm);

		model.addAttribute("selectVoList", rslt);
		model.addAttribute("selectVoList2", rslt2);
		model.addAttribute("selectVoList3", rslt3);
		model.addAttribute("selectVoList4", rslt4);
		model.addAttribute("newYn", "Y");
		
		return "system/userMgntPop";
	}
	
	*//**
	 * 사용자 ID 중복 확인
	 * @param userId
	 * @return
	 *//*
	@RequestMapping(value = "/checkUserId", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean checkUserId(
			@RequestParam(value = "userId", required = false) String userId
			) {
		
		LOGGER.info("checkUserId" );
		boolean checkRslt = userMgntSvc.checkUserId( userId );
		
		return checkRslt;
	}

	
	*//**
	 * 사용자 저장
	 * @param sessionUserVo
	 * @param gumVo
	 * @param bindingResult
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value = "/saveUserMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridUserMgntVo saveUserMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridUserMgntVo gumVo,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("saveUserMgnt : "+sessionUserVo.getSessionUserId() );

		gumVo.setRegiId(sessionUserVo.getSessionUserId());
		gumVo.setFinalModId(sessionUserVo.getSessionUserId());
		gumVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));
		
		boolean	rslt = userMgntSvc.saveRemsUserMgnt( gumVo );

		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return gumVo;
	}
	
	
	*//**
	 * 사용자 삭제
	 * @param sessionUserVo
	 * @param gumVo
	 * @param bindingResult
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value = "/deleteUserMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridUserMgntVo deleteUserMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridUserMgntVo gumVo,
			BindingResult bindingResult,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.info("deleteUserMgnt : "+sessionUserVo.getSessionUserId() );

		gumVo.setRegiId(sessionUserVo.getSessionUserId());
		gumVo.setFinalModId(sessionUserVo.getSessionUserId());
		gumVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		boolean rslt = userMgntSvc.deleteRemsUserMgnt( gumVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return gumVo;
	}*/
	
}