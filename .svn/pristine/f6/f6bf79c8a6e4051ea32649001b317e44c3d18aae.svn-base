package rems.system.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import rems.system.model.AuthVo;
import rems.system.model.ComCodeVo;
import rems.system.model.NoticeVo;
import rems.system.model.SessionUserVo;
import rems.system.service.NoticeSvc;
import rems.util.FancytreeData;
import rems.util.TreeUtil;


@Controller
@SessionAttributes("sessionUserVo")
public class NoticeCtrl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(NoticeCtrl.class);
	
	@Autowired
	private NoticeSvc noticeSvc;
	
	@Autowired
	private CommonSvc commonSvc;
	
	
	@RequestMapping(value = "/retrieveNoticeList", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveNoticeList(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "noticeTypeCd", required = false) String noticeTypeCd,
			@RequestParam(value = "authId", required = false) String authId,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,
			ModelMap model) {
		
		LOGGER.info("noticeList" );
		
		LOGGER.info("userId", sessionUserVo.getSessionUserId());			// 세션 사용자 아이디
		LOGGER.info("companyCd", sessionUserVo.getSessionCompanyCd());		// 세션 회사 코드

		ComCodeVo cond = new ComCodeVo();
		cond.setCommGrpCd("VIEW12");
		List<ComCodeVo> selectVoList = commonSvc.retrieveComCodeList(cond);
		
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd() );	

		List<AuthVo> authNmList = commonSvc.retrieveAuthNmList(params);
		
		HashMap<String,Object> scr_params = new HashMap<String,Object>();
		scr_params.put("title", title);			
		scr_params.put("noticeTypeCd", noticeTypeCd);	
		
		if("".equals(authId) || null == authId){
			scr_params.put("authId", sessionUserVo.getSessionAuthId());
			scr_params.put("ssAuthId", sessionUserVo.getSessionAuthId());
		}else{
			scr_params.put("authId", authId);
			scr_params.put("ssAuthId", sessionUserVo.getSessionAuthId());
		}
				
		scr_params.put("scrDateFrom", scrDateFrom);		
		scr_params.put("scrDateTo", scrDateTo);
		
		model.addAttribute("scrValue", scr_params);
		
		model.addAttribute("selectVoList", selectVoList);
		model.addAttribute("authNmList", authNmList);
		model.addAttribute("authId", sessionUserVo.getSessionAuthId());

		return "system/noticeList";
	}	
	
	
	@RequestMapping(value = "/retrieveNotice", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public @ResponseBody GridVo<NoticeVo> retrieveNotice(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "noticeTypeCd", required = false) String noticeTypeCd,
			@RequestParam(value = "authId", required = false) String authId,
			@RequestParam(value = "scrDateFrom", required = false) String scrDateFrom,
			@RequestParam(value = "scrDateTo", required = false) String scrDateTo,			
			@RequestParam(value = "page", required = false) int page,
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord) {
		
		LOGGER.info("retrieveStoreMgnt : " + page + ", " + rows + ", " + sidx + ", " + sord);

		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", ( ( rows * page ) - rows ) ); // 요청한 페이지 시작 행 번호
		params.put("limit", rows );                       // 페이지 당 보여줄 행의 개수
		params.put("sidx", sidx );                        // 정렬 기준 컬럼
		params.put("sord", sord );                        // 정렬 기준(오름차순, 내림차순)
		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());
		params.put("title", title );
		params.put("noticeTypeCd", noticeTypeCd);
		
		if("".equals(authId) || null == authId){
			params.put("authId", sessionUserVo.getSessionAuthId());
		}else{
			params.put("authId", authId);
		}
		
		params.put("pubStartDt", scrDateFrom.replace("-", "") );
		params.put("pubEndDt", scrDateTo.replace("-", "") );	
		params.put("userId", sessionUserVo.getSessionUserId());
				
		List<NoticeVo> rslt = noticeSvc.retrieveNotice(params);
		
		int records = rslt.size();
		
		GridVo<NoticeVo> gridVo = new GridVo<NoticeVo>();
		gridVo.setRows( rslt );                         // 결과값
		gridVo.setPage( String.valueOf( page ) );       // 현재 페이지
		gridVo.setRecords( String.valueOf( records > 0 ? Integer.parseInt(rslt.get(0).getTotal()) : 0 ) ); // 총 행의 개수
		gridVo.setTotal( String.valueOf( records > 0 ? (int)Math.ceil( Integer.parseInt(rslt.get(0).getTotal()) / rows ) : 0 ) ); // 총 페이지의 개수
		if(Integer.parseInt(gridVo.getRecords()) > (Integer.parseInt(gridVo.getTotal())*rows)){
			gridVo.setTotal(Integer.toString(Integer.parseInt(gridVo.getTotal())+1));
		}
		
		return gridVo;
	}
	
	
	@RequestMapping(value = "/retrieveNoticePopup", method = {RequestMethod.GET, RequestMethod.POST})
	public String retrieveNoticePopup(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "noticeId", required = false) String noticeId,
			ModelMap model) {
		
		LOGGER.info("retrieveNoticePopup" );
		
		LOGGER.info("userId", sessionUserVo.getSessionUserId());			// 세션 사용자 아이디
		LOGGER.info("companyCd", sessionUserVo.getSessionCompanyCd());		// 세션 회사 코드

		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());	
		params.put("noticeId", noticeId);
		
		NoticeVo noticeVo = new NoticeVo();
		noticeVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		noticeVo.setNoticeId(noticeId);
		noticeVo.setPubDttm("now");
		
		int viewCnt = noticeSvc.retrieveNoticeViewCnt(noticeVo);
		viewCnt = viewCnt+1;
		
		noticeVo.setViewCnt(Integer.toString(viewCnt));
		noticeVo.setFinalModId(sessionUserVo.getSessionUserId());
		noticeSvc.saveNoticeUpdate(noticeVo);
		
		NoticeVo NoticeInfo_rslt = noticeSvc.retrieveNoticeDtl(params);

		model.addAttribute("noticeDtl", NoticeInfo_rslt);

		return "system/noticePopup";
	}	
	
	
	
	@RequestMapping(value = "/noticeNew", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeNew(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "noticeId", required = false) String noticeId,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "noticeTypeCd", required = false) String noticeTypeCd,
			@RequestParam(value = "authId", required = false) String authId,
			@RequestParam(value = "pubStartDt", required = false) String pubStartDt,
			@RequestParam(value = "pubEndDt", required = false) String pubEndDt,	
			ModelMap model) {
		
		LOGGER.info("noticeNew" );
		
		HashMap<String,Object> history = new HashMap<String,Object>();
		history.put( "title", 		title );
		history.put( "noticeTypeCd", noticeTypeCd );
		history.put( "authId", 		authId );
		history.put( "pubStartDt", 	pubStartDt );
		history.put( "pubEndDt", 	pubEndDt );
		model.addAttribute("history", 	history);		
		
		List<NoticeVo> rslt = new ArrayList<NoticeVo>();
		List<NoticeVo> rslt2 = new ArrayList<NoticeVo>();
		NoticeVo NoticeInfo_rslt = new NoticeVo();

		ComCodeVo cond = new ComCodeVo();
		cond.setCommGrpCd("VIEW12");
		List<ComCodeVo> selectVoList = commonSvc.retrieveComCodeList(cond);
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("companyCd", sessionUserVo.getSessionCompanyCd());	

		List<AuthVo> authNmList = commonSvc.retrieveAuthNmList(params);
		
		if("MODIFY".equals(mode)){
			params.put("noticeId", noticeId);
			NoticeInfo_rslt = noticeSvc.retrieveNoticeDtl(params);
			
			rslt = noticeSvc.retrieveNoticeTargetDtl(params);
			
			for(int i=0; i<rslt.size() ; i++){
				
				if("4".equals(rslt.get(i).getAuthId())){
					params.put("authId", rslt.get(i).getAuthId());
					rslt2 = noticeSvc.retrieveNoticeTargetOrgDtl(params);
				}
			}
		}
		
		model.addAttribute("mode", mode);
		model.addAttribute("companyCd", sessionUserVo.getSessionCompanyCd());
		model.addAttribute("selectVoList", selectVoList);
		model.addAttribute("authNmList", authNmList);

		model.addAttribute("noticeDtl", NoticeInfo_rslt);	
		model.addAttribute("noticeTargetList", rslt);
		model.addAttribute("noticeTargetOrgList", rslt2);
		
		return "system/noticeNew";
	}
	
	
    @RequestMapping(value = "/retrieveOrgCdList", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public @ResponseBody Map<String , Object> retrieveMenuAuthList(
            @ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
            @RequestParam(value = "noticeId", required = false) String noticeId) {

    	HashMap<String,Object> params = new HashMap<String,Object>();
    	
        params.put("companyCd", sessionUserVo.getSessionCompanyCd());
        params.put("noticeId", noticeId);

        List<Map<String, Object>> orgList = new ArrayList<Map<String, Object>>();
        
        if(noticeId == null || noticeId == "") {
        	orgList = commonSvc.retrieveOrgCd(params);
        }else {
        	orgList = commonSvc.retrieveOrgCdNoticeId(params);
        }

        Map<String, String> optionAttrMap = new LinkedHashMap<>();
        optionAttrMap.put("selected", "selected");

        String json = TreeUtil.makeJson(new FancytreeData(orgList, "orgCd", "orgNm", "indexHier", optionAttrMap) {
            @Override
            public boolean isFolder(Map<String, Object> map) {
                return "P".equals(map.get("orgType"));
            }
        });

        Map<String, Object> jsonObject = new HashMap<>();
        jsonObject.put("success", true);
        jsonObject.put("json", json);

        return jsonObject;
    }	
	
	
	@RequestMapping(value = "/saveNotice ", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String , Object> saveNotice(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "title", required = false) String title,	
			@RequestParam(value = "pubYn", required = false) String pubYn,
			@RequestParam(value = "noticeTypeCd", required = false) String noticeTypeCd,
			@RequestParam(value = "pubStartDt", required = false) String pubStartDt,
			@RequestParam(value = "pubEndDt", required = false) String pubEndDt,
			@RequestParam(value = "authId", required = false) List<String> authIdList,
			@RequestParam(value = "contents", required = false) String contents,
			@RequestParam(value = "orgCdArray", required = false) String orgCdArray,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		LOGGER.info("saveNotice : "+sessionUserVo.getSessionStrCd());
		
		NoticeVo noticeVo = new NoticeVo();
		noticeVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		noticeVo.setTitle(title);
		noticeVo.setContents(contents);
		noticeVo.setPubYn(pubYn);
		noticeVo.setPubId(sessionUserVo.getSessionUserId());
		noticeVo.setNoticeTypeCd(noticeTypeCd);
		noticeVo.setPubStartDt(pubStartDt.replace("-", ""));
		noticeVo.setPubEndDt(pubEndDt.replace("-", ""));
		noticeVo.setRegiId(sessionUserVo.getSessionUserId());		
		noticeVo.setFinalModId(sessionUserVo.getSessionUserId());
		
		try {
		
			if("NEW".equals(mode)){
				
				noticeSvc.saveNotice(noticeVo);
				
				String noticeId = noticeSvc.selectNoticeId(noticeVo);
				noticeVo.setNoticeId(noticeId);
				
				for(int i=0; i<authIdList.size() ; i++){
					noticeVo.setAuthId(authIdList.get(i));
					noticeSvc.saveNoticeTarget(noticeVo);
					
					if("4".equals(authIdList.get(i))){
						String[] orgList = orgCdArray.split(",");
						for(int j=0; j < orgList.length ; j++){
							noticeVo.setOrgCd(orgList[j]);
							noticeSvc.saveNoticeTargetOrgCd(noticeVo);
						}
					}
				}
			}
			
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
	
	@RequestMapping(value = "/saveNotice2 ", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String , Object> saveNotice2(
			@ModelAttribute("sessionUserVo") SessionUserVo sessionUserVo,
			@RequestParam(value = "noticeId", required = false) String noticeId,
			@RequestParam(value = "title", required = false) String title,	
			@RequestParam(value = "pubYn", required = false) String pubYn,
			@RequestParam(value = "noticeTypeCd", required = false) String noticeTypeCd,
			@RequestParam(value = "pubStartDt", required = false) String pubStartDt,
			@RequestParam(value = "pubEndDt", required = false) String pubEndDt,
			@RequestParam(value = "authId", required = false) List<String> authIdList,
			@RequestParam(value = "orgCdArray", required = false) String orgCdArray,
			@RequestParam(value = "contents", required = false) String contents,
			ModelMap model,			
			HttpSession session) throws Exception {
		
		NoticeVo noticeVo = new NoticeVo();
		noticeVo.setCompanyCd(sessionUserVo.getSessionCompanyCd());
		noticeVo.setNoticeId(noticeId);
		noticeVo.setTitle(title);
		noticeVo.setContents(contents);
		noticeVo.setPubId(sessionUserVo.getSessionUserId());
		noticeVo.setPubYn(pubYn);
		noticeVo.setPubStartDt(pubStartDt.replace("-", ""));
		noticeVo.setPubEndDt(pubEndDt.replace("-", ""));
		noticeVo.setRegiId(sessionUserVo.getSessionUserId());		
		noticeVo.setFinalModId(sessionUserVo.getSessionUserId());
		
		try {
		
			noticeSvc.saveNoticeUpdate(noticeVo);
			
			noticeSvc.deleteNoticeTarget(noticeVo);
			for(int i=0; i<authIdList.size() ; i++){
				noticeVo.setAuthId(authIdList.get(i));
				noticeSvc.saveNoticeTarget(noticeVo);
				
				noticeSvc.deleteNoticeTargetOrg(noticeVo);
				if("4".equals(authIdList.get(i))){
					String[] orgList = orgCdArray.split(",");
					for(int j=0; j < orgList.length ; j++){
						noticeVo.setOrgCd(orgList[j]);
						noticeSvc.saveNoticeTargetOrgCd(noticeVo);
					}
				}
			}
			
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

}
