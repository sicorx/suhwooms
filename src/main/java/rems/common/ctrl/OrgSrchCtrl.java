package rems.common.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import rems.system.model.GridOrgMgntVo;
import rems.system.model.UserVo;
import rems.util.FancytreeData;
import rems.util.TreeUtil;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.common.ctrl
 * @Class Name : OrgSrchCtrl.java
 * @Description : 공통 > 조직 조회 팝업
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 13.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 13. 오후 5:07:01
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class OrgSrchCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(OrgSrchCtrl.class);

	@Autowired
	private CommonSvc svc;
	
	/**
	 * 조직 조회 카운트
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @param orgNm : 조직명/코드
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveOrgCdCnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridOrgMgntVo> retrieveOrgCdCnt(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "orgNm", required = false) String orgNm
			) {
		
		LOGGER.error("retrieveOrgCdCnt : " + companyCd + ", " + orgNm);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );		// 회사 코드
		params.put( "orgNm", orgNm );				// 조직명/코드
		
		// 조직 조회 카운트
		GridOrgMgntVo rslt = svc.retrieveOrgCdCnt( params );
		
		return rslt;
	}
	
	/**
	 * 조직 조회 팝업 페이지
	 * 
	 * @author 유승만
	 * @param companyCd : 회사 코드
	 * @param orgNm : 조직명/코드
	 * @return view : orgSrch
	 * @exception Exception
	 */
	@RequestMapping(value = "/showOrgSrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String showOrgSrch(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "orgNm", required = false) String orgNm,
			ModelMap model) {

		LOGGER.error("showOrgSrch");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );			// 회사 코드
		
		// 조직 목록
		List<Map<String, Object>> orgList = svc.retrieveOrgCd(params);
		String orgJson = TreeUtil.makeJson(new FancytreeData(orgList, "orgCd", "orgNm", "indexHier", "새메뉴") {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "P".equals(map.get("orgType"));
            }
        });
		
		model.addAttribute("companyCd", companyCd);		// 회사 코드
		model.addAttribute("orgNm", orgNm);				// 조직명/코드

        model.addAttribute("orgJson", orgJson);
        
		return "common/orgSrch";
	}
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/orgSrch2depth", method = {RequestMethod.GET, RequestMethod.POST})
	public String orgSrch2depth(
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			ModelMap model) {

		LOGGER.info( "orgSrch2depth" );
		
		model.addAttribute("companyCd",companyCd);
		model.addAttribute("userVo",userVo);

		return "common/orgSrch2depth";
	}
	
	/**
	 * 조직도 내용 조회
	 * @return 비계층적인 JSON 데이터
	 */
	@RequestMapping(value = "/retrieveOrg", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody List<Map<String, Object>> retrieveOrg(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "orgCd", required = false) String orgCd) {
		
		LOGGER.info( "retrieveOrg : " + companyCd +","+ orgCd );

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put( "companyCd", companyCd );
		param.put( "orgCd", orgCd == null ? "0" : orgCd );
		
		return svc.retrieveOrg( param );
	}	
	
	
	/**
	 * 조직도 팝업 ( 수정용 )
	 * 
	 * @author JooYoung
	 * @param companyCd 회사코드
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/showOrgModifySrch", method = {RequestMethod.GET, RequestMethod.POST})
	public String showOrgModifySrch(
			@ModelAttribute UserVo userVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			ModelMap model) {

		LOGGER.info( "showOrgModifySrch : "+companyCd );
		
		model.addAttribute("companyCd",companyCd);
		model.addAttribute("userVo",userVo);

		return "common/orgModifySrch";
	}
	
	
}
