package rems.system.ctrl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import rems.system.model.GridOrgMgntVo;
import rems.system.model.GridStoreMgntVo;
import rems.system.model.SessionUserVo;
import rems.system.service.OrgMgntSvc;
import rems.util.FancytreeData;
import rems.util.TimezoneUtils;
import rems.util.TreeUtil;

/**  
 * @Project Name : REMS 관제 웹
 * @Package Name : rems.system.ctrl
 * @Class Name : OrgMgntCtrl.java
 * @Description : 시스템관리 > 마스터관리 > 조직
 * 
 * @Modification
 * @ 수정일           수정자      수정내용
 * @ -------------   ---------   -------------------------------
 * @ 2017. 2. 9.     유승만      최초생성
 * 
 * @author 유승만
 * @since 2017. 2. 9. 오후 1:57:53
 * @version 2.0
 * 
 */
@Controller
@SessionAttributes("sessionUserVo")
public class OrgMgntCtrl {

	private static final Logger LOGGER = LoggerFactory.getLogger(OrgMgntCtrl.class);
	
	@Autowired
	private OrgMgntSvc svc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	/**
	 * 시스템관리 > 마스터관리 > 조직 페이지
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @return orgMgntMst : view
	 * @exception Exception
	 */
	@RequestMapping(value = "/4102", method = {RequestMethod.GET, RequestMethod.POST})
	public String showOrganMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			ModelMap model) {
		LOGGER.error("showOrganMgnt" );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "userId", sessionUserVo.getSessionUserId() );			// 세션 사용자 아이디
		params.put( "companyCd", sessionUserVo.getSessionCompanyCd() );		// 세션 회사 코드
		params.put( "companyNm", sessionUserVo.getSessionCompanyNm() );		// 세션 회사 명
		
		// 회사 select
		List<SelectVo> rslt = commonSvc.retrieveCompanyCd(params);		
		int selectVoListCnt = rslt.size();
		
		// 조직 목록
		List<Map<String, Object>> orgList = svc.retrieveOrgList(params);
		String orgJson = TreeUtil.makeJson(new FancytreeData(orgList, "orgCd", "orgNm", "indexHier", "새메뉴") {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "P".equals(map.get("orgType"));
            }
        });
		
		model.addAttribute("selectVoList", rslt);
		model.addAttribute("userVo", params);
		model.addAttribute("selectVoListCnt", selectVoListCnt );
		
		model.addAttribute("orgList", orgList);
        model.addAttribute("orgJson", orgJson);
        
		return "system/orgMgntMst";
	}
	
    /**
     * 조직목록 저장
     * 
     * @author 유승만
     * @param orgCd : 조직 코드 목록
     * @param orgNm : 조직 명 목록
     * @param orgType : 조직 타입 목록
     * @param indexHier : indexHier 목록
     * @param useYn : 사용여부 목록
     * @param deleteOrgCds : 삭제 조직 코드 목록
     * @return 
     * @exception Exception
     */
    @RequestMapping(value = "/saveOrgList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public @ResponseBody Map<String , Object> saveOrgList(
            @ModelAttribute("sessionUserVo")    SessionUserVo   sessionUserVo,
            @RequestParam(value = "orgCd",         required = false)   List<String>    orgCdList,
            @RequestParam(value = "orgNm",         required = false)   List<String>    orgNmList,
            @RequestParam(value = "orgType",       required = false)   List<String>    orgTypeList,
            @RequestParam(value = "indexHier",      required = false)   List<String>    indexHierList,
            @RequestParam(value = "useYn",          required = false)   List<String>    useYnList,
            @RequestParam(value = "deleteOrgCds",  required = false)   String          deleteOrgCds
    ) {
        LOGGER.error("saveOrgList\norgCdList:{}\norgNmList:{}\norgTypeList:{}\nindexHierList:{}\nuseYnList:{}\ndeleteOrgCds:{}",
                new Object[]{orgCdList, orgNmList, orgTypeList, indexHierList, useYnList, deleteOrgCds});

        try {
            String companyCd = sessionUserVo.getSessionCompanyCd();
            String userId = sessionUserVo.getSessionUserId();

            // 등록
            HashMap<String, Object> insertMap = new HashMap<>();
            List<Map<String, String>> insertList = new ArrayList<>();
            insertMap.put("companyCd",  companyCd);		// 회사 코드
            insertMap.put("regiId",     userId);		// 등록 아이디
            insertMap.put("finalModId", userId);		// 최종 수정 아이디
            insertMap.put("list",       insertList);	// 등록 목록

            // 수정
            HashMap<String, Object> updateMap = new HashMap<>();
            List<Map<String, String>> updateList = new ArrayList<>();
            updateMap.put("companyCd",  companyCd);		// 회사 코드
            updateMap.put("finalModId", userId);		// 최종 수정 아이디
            updateMap.put("list",       updateList);	// 수정 목록

            if (orgCdList != null) {
                for (int i = 0, size = orgCdList.size(); i < size; i++) {
                    String orgCd = orgCdList.get(i);

                    Map<String, String> map = new HashMap<>();
                    map.put("orgNm",       	orgNmList.get(i));
                    map.put("orgType",     	orgTypeList.get(i));
                    map.put("indexHier",    indexHierList.get(i));
                    map.put("useYn",        useYnList.get(i));
                    
                    if (orgCd.startsWith("N")) {
                        insertList.add(map);
                    } else {
                        map.put("orgCd",   orgCd);
                        updateList.add(map);
                    }
                }
            }

            // 삭제
            HashMap<String, Object> deleteMap = new HashMap<>();
            deleteMap.put("companyCd",  companyCd);
            deleteMap.put("finalModId", userId);		// 최종 수정 아이디
            deleteMap.put("list",       (deleteOrgCds != null && deleteOrgCds.trim().length() > 0) ? Arrays.asList(deleteOrgCds.split(",")) : null);

            LOGGER.error("insertMap\n{}", insertMap);
            LOGGER.error("\nupdateMap\n{}", updateMap);
            LOGGER.error("\ndeleteMap\n{}", deleteMap);
            
            // 조직 저장
            svc.saveOrgBatch(insertMap, updateMap, deleteMap);

            Map<String, Object> jsonObject = new HashMap<>();
            jsonObject.put("success", true);

            return jsonObject;
        } catch(Exception e) {
            LOGGER.error(e.getMessage());
            e.printStackTrace();

            Map<String, Object> jsonObject = new HashMap<>();
            jsonObject.put("success", false);
            jsonObject.put("errMsg", e.getMessage());

            return jsonObject;
        }
    }
	
	/**
	 * 매장 목록
	 * 
	 * @author 유승만
	 * @param scrCompanyCd : 회사 코드
	 * @param scrOrgCd : 조직 코드
	 * @param sidx : 정렬 기준 컬럼
	 * @param sord : 정렬 기준(오름차순, 내림차순)
	 * @return rslt
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveStrList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<GridStoreMgntVo> retrieveStrList(
			@RequestParam(value = "scrCompanyCd", required = false) String scrCompanyCd,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.error("retrieveStrList");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "sidx", sidx );                        	// 정렬 기준 컬럼
		params.put( "sord", sord );                        	// 정렬 기준(오름차순, 내림차순)
		params.put( "companyCd", scrCompanyCd );			// 회사 코드
		params.put( "orgCd", scrOrgCd );					// 조직 코드
		
		// 매장 목록
		List<GridStoreMgntVo> rslt = svc.retrieveStrList( params );
		
		return rslt;
	}

	/**
	 * 매장에 조직코드 저장
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param companyCd : 회사 코드
	 * @param strCd : 매장 코드
	 * @param orgCd : 조직 코드
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/updateStrMgntOrgCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean  updateStrMgntOrgCd(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "strCd", required = false) String strCd,
			@RequestParam(value = "orgCd", required = false) String orgCd,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.error("updateStrMgntOrgCd : "+sessionUserVo.getSessionStrCd() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("strCd", strCd );								// 매장 코드
		params.put("orgCd", orgCd );								// 조직 코드
		params.put("companyCd", companyCd );						// 회사 코드
		params.put("finalModId", sessionUserVo.getSessionUserId());	// 최종 수정 아이디

		// 매장에 조직코드 저장
		boolean rslt = svc.updateStrMgntOrgCd( params );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
	/**
	 * 매장 삭제(매장에서 조직코드 null)
	 * 
	 * @author 유승만
	 * @param sessionUserVo : 세션 사용자 정보
	 * @param companyCd : 회사 코드
	 * @param strCds : 매장코드 배열(콤마를 구분자로)
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/updateStrMgntOrgCdNull", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody boolean  updateStrMgntOrgCdNull(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "strCds", required = false) String strCds,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.error("updateStrMgntOrgCdNull : "+sessionUserVo.getSessionStrCd() );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		String[] strCd =  strCds.split(",");
		params.put("strCd", strCd );								// 매장코드 배열
		params.put("companyCd", companyCd );						// 회사 코드
		params.put("finalModId", sessionUserVo.getSessionUserId());	// 최종 수정 아이디

		// 매장 삭제(매장에서 조직코드 null)
		boolean rslt = svc.updateStrMgntOrgCdNull( params );
		LOGGER.error("[rslt      ] ============ "+rslt+" ================");
		
		return rslt;
	}
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/searchOrgList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<GridOrgMgntVo> searchOrgList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrOrgCd", required = false) String scrOrgCd,
			@RequestParam(value = "scrDepth", required = false) String scrDepth,
			@RequestParam(value = "scrUseYn", required = false) String scrUseYn,
			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put( "limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put( "sidx", sidx );                        // 정렬 기준 컬럼
		params.put( "sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		params.put( "orgCd", scrOrgCd );
		params.put( "depth", scrDepth );
		params.put( "useYn", scrUseYn );
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		
		List<GridOrgMgntVo> rslt = svc.searchOrgList( params );
		
		int records = rslt.size();
		
		GridVo<GridOrgMgntVo> gridVo = new GridVo<GridOrgMgntVo>();
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
	 * 조직관리 depth별 조직 코드 조회 (select box)
	 * @return
	 */
/*	@RequestMapping(value = "/retrieveDepthCd", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody List<SelectVo> retrieveDepthCd2(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "scrDepthCd", required = false) String scrDepthCd
			) {
		
		LOGGER.info("retrieveDepthCd : " + scrDepthCd );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put( "scrDepthCd1", scrDepthCd );
		
		List<SelectVo> rslt = svc.retrieveOrgCdList( params );
		
		return rslt;
	}
	*/
	
	
	
	/**
	 * 조직관리 신규생성, 수정 화면
	 * @return
	 */
	@RequestMapping(value = "/orgMgntPop", method = {RequestMethod.GET, RequestMethod.POST})
	public String showOrgMgntPop(
			@RequestParam(value = "companyCd", required = false) String companyCd,
			@RequestParam(value = "companyNm", required = false) String companyNm,
			@RequestParam(value = "uperOrgCd", required = false) String uperOrgCd,
			@RequestParam(value = "uperOrgNm", required = false) String uperOrgNm,
			@RequestParam(value = "orgCd", required = false) String orgCd,
			@RequestParam(value = "depthLvl", required = false) String depthLvl,
			ModelMap model) {
		
		LOGGER.info("showOrgMgntPop : "+orgCd );
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", companyCd );
		params.put( "companyNm", companyNm );
		params.put( "orgCd", orgCd );
		
		model.addAttribute("userVo", params);
		model.addAttribute("uperOrgCd", uperOrgCd);
		model.addAttribute("uperOrgNm", uperOrgNm);
		model.addAttribute("depth", depthLvl);
		
		if(!orgCd.equals("")){
			
			GridOrgMgntVo rslt = svc.searchOrgCd( params );
			model.addAttribute("orgInfo", rslt);
			
		}
		
		return "system/orgMgntPop";
	}
	
	
	
	/**
	 * 조직관리 신규생성, 수정 저장
	 * @return
	 */
	@RequestMapping(value = "/saveOrgMgnt", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridOrgMgntVo saveOrgMgnt(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@ModelAttribute GridOrgMgntVo gomVo,
			BindingResult bindingResult,
			ModelMap model,
			HttpSession session) throws Exception {
		
		LOGGER.info("saveUserMgnt : "+sessionUserVo.getSessionUserId() );
		LOGGER.info("companyCd : "+gomVo.getCompanyCd());
		LOGGER.info("uperOrgCd : "+gomVo.getUperOrgCd());
		LOGGER.info("uperOrgCd : "+gomVo.getUseYn());
		gomVo.setRegiId(sessionUserVo.getSessionUserId());
		gomVo.setFinalModId(sessionUserVo.getSessionUserId());
		gomVo.setNow(TimezoneUtils.retrieveNowByTimediff(sessionUserVo.getSessionTimeDiff()));

		boolean rslt = svc.retrieveSaveOrgMgnt( gomVo );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		
		return gomVo;
	}
	
	/**
	 * 조직관리 삭제
	 * @return
	 */
	@RequestMapping(value = "/deleteOrgMgnt", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody GridOrgMgntVo deleteOrgMgnt(
			@ModelAttribute GridOrgMgntVo gomVo,
			BindingResult bindingResult,
			ModelMap model) {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put( "companyCd", gomVo.getCompanyCd() );
		params.put( "orgCd", gomVo.getOrgCd() );
		boolean rslt = svc.deleteOrgMgnt( params );
		LOGGER.info("[rslt      ] ============ "+rslt+" ================");
		return gomVo;
	}
}